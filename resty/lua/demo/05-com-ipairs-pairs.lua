--
-- openresty ipairs和pairs的共同点
-- 参考：https://www.runoob.com/note/11315
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "text/html"

--都是能遍历集合（表、数组）
local t1 = {"AAA", "BBB", "CCC", "DDD", "EEE"}

ngx.say("ipairs迭代数组", "<br/>")

for i, v in ipairs(t1) do
    ngx.say("ipairs迭代数组：", i, "  ", v, "<br/>")
end

ngx.say("pairs迭代数组", "<br/>")

for k, v in pairs(t1) do
    ngx.say("pairs迭代数组：", k, "  ", v, "<br/>")
end

ngx.say("--------------------------------", "<br/>")

local t2 = {[1] = "AAA", [2] = "BBB", [3] = "CCC", [4] = "DDD", [5] = "EEE"}

ngx.say("ipairs迭代Map", "<br/>")

for i, v in ipairs(t2) do
    ngx.say("ipairs迭代Map：", i, "  ", v, "<br/>")
end

ngx.say("pairs迭代Map", "<br/>")

for k, v in pairs(t2) do
    ngx.say("pairs迭代Map组：", k, "  ", v, "<br/>")
end
