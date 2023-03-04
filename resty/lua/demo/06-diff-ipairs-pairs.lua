--
-- openresty ipairs和pairs的不同点
-- https://www.runoob.com/note/11315
-- ipairs: 迭代数组，不能返回 nil,如果遇到 nil 则退出
-- pairs: 迭代 table，可以遍历表中所有的 key 可以返回 nil
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "text/html"

--数组定义
local t1 = {"AAA", "BBB", nil, "DDD", "EEE"}

ngx.say("ipairs迭代数组，遇到nil就会停止", "<br/>")
--迭代到BBB就停止了
for i, v in ipairs(t1) do
    ngx.say("ipairs迭代数组，遇到nil就会停止：", i, "  ", v, "<br/>")
end

ngx.say("pairs迭代数组，可以迭代nil", "<br/>")
--nil后面的会接着迭代
for k, v in pairs(t1) do
    ngx.say("pairs迭代数组，可以迭代nil：", k, "  ", v, "<br/>")
end

ngx.say("--------------------------------", "<br/>")

--ipairs: 迭代数组，也就是说，如果遇到key不是数字，或者第一个数字不是1就会停止
--pairs: 迭代 table，可以遍历表中所有的 key 可以返回 nil

local t2 = {[1] = "AAA", [2] = "BBB", ["3"] = "CCC", [4] = "DDD", [5] = "EEE"}

ngx.say("ipairs迭代Map", "<br/>")
--遇到string类型的下标3就停止迭代了
for i, v in ipairs(t2) do
    ngx.say("ipairs迭代Map， key需要是数字：", i, "  ", v, "<br/>")
end

ngx.say("pairs迭代Map", "<br/>")
for k, v in pairs(t2) do
    ngx.say("pairs迭代Map组：", k, "  ", v, "<br/>")
end

ngx.say("--------------------------------", "<br/>")

local t3 = {[2] = "BBB", [3] = "CCC", [4] = "DDD", [5] = "EEE"}

ngx.say("ipairs迭代Map", "<br/>")
ngx.say("下标不是从1开始，无法迭代", "<br/>")

--下标不是从1开始，无法迭代
for i, v in ipairs(t3) do
    ngx.say("ipairs迭代Map， key需要从1开始：", i, "  ", v, "<br/>")
end

ngx.say("pairs迭代Map", "<br/>")
for k, v in pairs(t3) do
    ngx.say("pairs迭代Map组：", k, "  ", v, "<br/>")
end
