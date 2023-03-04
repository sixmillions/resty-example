--
-- openresty mysql增删改查操作
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

local res, err, errcode, sqlstate = db:query("drop table if exists cats")
if not res then
    ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".", "<br/>")
    return
end

res, err, errcode, sqlstate = db:query("create table cats " .. "(id serial primary key, " .. "name varchar(5))")
if not res then
    ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".", "<br/>")
    return
end

ngx.say("table cats created.", "<br/>")

res, err, errcode, sqlstate = db:query("insert into cats (name) " .. "values ('Bob'),(''),(null)")
if not res then
    ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".", "<br/>")
    return
end

ngx.say(res.affected_rows, " rows inserted into table cats ", "(last insert id: ", res.insert_id, ")", "<br/>")

-- run a select query, expected about 10 rows in
-- the result set:
res, err, errcode, sqlstate = db:query("select * from cats order by id asc", 10)
if not res then
    ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".", "<br/>")
    return
end

local cjson = require "cjson"
ngx.say("result: ", cjson.encode(res), "<br/>")

-- put it into the connection pool of size 100,
-- with 10 seconds max idle timeout
local ok, err = db:set_keepalive(10000, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err, "<br/>")
    return
end
