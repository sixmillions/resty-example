--
-- 云剪切板后端接口--获取数据
-- curl -i 127.0.0.1:8080/clip/read?clip_id=666
-- @author six
-- @since  2023-03-04
--

-- ngx.say("read a clip")
local json = require("cjson")
local args = ngx.req.get_uri_args()
local clip_id = args.clip_id
-- 定义响应数据，默认失败
local response = {status = ngx.HTTP_BAD_REQUEST, msg = "err"}

-- clip_id校验
if type(clip_id) ~= "string" then
    -- ngx.say会返回请求，所以不要在ngx.exit之前使用ngx.say
    -- ngx.exit(ngx.HTTP_BAD_REQUEST)
    response.msg = "剪切空间名称错误"
    return ngx.say(json.encode(response))
end

-- 正则校验clip_id
local m = ngx.re.find(clip_id, [[^[a-z0-9A-Z]{3,6}$]], "jo")
if not m then
    response.msg = "请使用3到6位字母数字命名你的剪切空间"
    return ngx.say(json.encode(response))
end

-- ngx.say("clip_id: "..clip_id)
local data = {}
data.clip_id = clip_id
response.data = data
-- 缓存数据key
local cache_key = "clip:" .. clip_id

-- 连接redis获取剪切板数据
local redis = require "redis_iresty"
local red = redis:new()

local res_cache, err = red:hmget(cache_key, "cnt", "c_time", "pwd", "v_count")

-- TODO: 加密码判断

if not res_cache then
    -- res_cache是nil，没有缓存数据
    response.msg = "未找到剪切板数据"
    return ngx.say(json.encode(response))
end

data.cnt = res_cache[1]
data.c_time = res_cache[2]
data.pwd = res_cache[3]
data.v_count = res_cache[4]

-- 预览次数 +1
if not data.v_count or data.v_count == ngx.null then
    -- 如果该字段没有值，则为null（ngx.null），展示出来是 {"clip_id":"111","v_count":null,"cnt":"uuuuu"}
    data.v_count = 0
end
red:hmset(cache_key, "v_count", data.v_count + 1)

response.data = data
response.status = ngx.HTTP_OK
response.msg = "ok"
ngx.say(json.encode(response))
