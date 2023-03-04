--
-- 云剪切板后端接口--保存数据
-- curl -i -d '{"cnt": "clip content", "clip_id":"666", "expire": 1800}' 127.0.0.1:8080/clip/save
-- @author six
-- @since  2023-03-04
--

--ngx.say("save a clip")
local json = require("cjson")

ngx.req.read_body()
local body = ngx.req.get_body_data()
-- 定义响应数据，默认失败
local response = {status = ngx.HTTP_BAD_REQUEST, msg = "err"}

local default_expire = 30 * 60 --缓存默认过期时间

--不存在clip_id则返回400
if not body then
    --ngx.say会返回请求，所以不要在ngx.exit之前使用ngx.say
    --ngx.exit(ngx.HTTP_BAD_REQUEST)
    response.msg = "数据体不能为空"
    return ngx.say(json.encode(response))
end

--数据处理
local data = json.decode(body)
local cache_key = "clip:" .. data.clip_id
local expire = data.expire or default_expire
local now = ngx.localtime()
local c_time = data.c_time or now

-- 连接redis获取数据
local redis = require "redis_iresty"
local red = redis:new()

-- 测试body传参
-- ngx.say(type(data.pwd), data.pwd)
-- 不传pwd nil nil
-- 传 "pwd": null  userdata null
-- 传 "pwd": "" 空字符串 string

-- 保存数据
local res, err = red:hmset(cache_key, "cnt", data["cnt"], "c_time", c_time, "m_time", now)
-- 密码处理
if not data.pwd or data.pwd == ngx.null then
    -- 将nil和null转成 空字符串密码
    data.pwd = ""
end
red:hmset(cache_key, "pwd", data.pwd)

if not res then
    -- ngx.say("failed to get clip: ", err)
    response.msg = err
    return ngx.say(json.encode(response))
end

-- 过期时间
local res, err = red:expire(cache_key, expire)

if not res then
    -- ngx.say("failed to get clip: ", err)
    response.msg = err
    -- TODO: 给前端提示，重新保存
    return ngx.say(json.encode(response))
end

response.status = ngx.HTTP_OK
response.msg = "ok"
-- TOOD：返回剪切板链接
ngx.say(json.encode(response))
