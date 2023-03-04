--
-- openresty lua_shared_dict 使用
-- https://github.com/openresty/lua-nginx-module#ngxshareddict
-- 测试从redis直接读取和从shared_dict获取的吞吐量测试
-- 特别是redis服务器不是本机部署，而是内网中的缓存服务器，差异就很明显了
-- ab -n 100000 -c 100 127.0.0.1:8080/demo/17-shared-dict
-- @author six
-- @since  2023-03-04
--

local redis = require("redis_iresty")
local red = redis:new()

local function set_to_cache(key, value, exptime)
    if not exptime then
        exptime = 0
    end
    local six_cache = ngx.shared.six_cache
    local succ, err, forcible = six_cache:set(key, value, exptime)
    return succ
end

local function get_from_redis(key)
    local res, err = red:get("dog")
    if res then
        return "yes"
    else
        return "no"
    end
end

local function get_from_cache(key)
    local six_cache = ngx.shared.six_cache
    local value = six_cache:get(key)
    --ngx.say("value: ", value, type(value))
    if not value then
        value = get_from_redis(key)
        set_to_cache(key, value)
    end
    return value
end

-- 情况1：单纯从redis获取数据步骤
-- 1. lua_code_cache on;
-- 2. 重启openresty
-- 3. ab -n 100000 -c 100 127.0.0.1:8080/demo/17-shared-dict
-- local res = get_from_redis("dog")
-- ngx.say(res)

-- 情况二：加上lua_shared_dict测试步骤
-- 1. http级别范围配置 lua_shared_dict six_cache 128m;
-- 2. lua_code_cache on;
-- 3. 重启openresty
-- 4. ab -n 100000 -c 100 127.0.0.1:8080/demo/17-shared-dict
local res = get_from_cache("dog")
ngx.say(res)
