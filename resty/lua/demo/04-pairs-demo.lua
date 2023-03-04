--
-- openresty 迭代器简单使用
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "text/html"

--ipairs通常用来迭代数组
local days = {
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
}

for k, v in ipairs(days) do
    ngx.say(k, " ", v, "<br/>")
end

ngx.say("-------------", "<br/>")

--pairs可以迭代Map和数组
local revDays = {}
for k, v in pairs(days) do
    revDays[v] = k
end

ngx.say('revDays["Friday"]: ', revDays["Friday"], "<br/>")

ngx.say("-------------", "<br/>")

--pairs通常用来迭代Map
for k, v in pairs(revDays) do
    ngx.say(k, "--", v, "<br/>")
end

ngx.say("pairs迭代map类型table，不能被JIT编译，少用")
