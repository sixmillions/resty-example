--
-- openresty 连接mysql数据库测试
-- https://github.com/openresty/lua-resty-mysql
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "text/html"
local mysql = require("resty.mysql")

local db, err = mysql:new()
if not db then
    ngx.say("mysql实例化失败：", err, "<br/>")
    return
end

db:set_timeout(1000) --1s

--连接参数配置
local ok, err, errno, sqlstate =
    db:connect {
    host = "172.20.0.2",
    port = "3306",
    database = "ngxdb",
    user = "root",
    password = "11xxOOxx",
    max_packet_size = 1024 * 1024
}

if not ok then
    ngx.say("连接mysql失败：", err, ":", errno, " ", sqlstate, "<br/>")
    return
end

ngx.say("连接mysql成功", "<br/>")
