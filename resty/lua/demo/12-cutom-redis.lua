--
-- openresty redis操作封装
-- https://moonbingbing.gitbooks.io/openresty-best-practices/content/redis/out_package.html
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "application/json"

local redis = require "redis_iresty"

local red = redis:new()
local ok, err = red:set("dog", "an animal")
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end

ngx.say("set result: ", ok)

local res, err = red:get("dog")
if not res then
    ngx.say("failed to get dog: ", err)
    return
end

if res == ngx.null then
    ngx.say("dog not found.")
    return
end

ngx.say("dog: ", res)
