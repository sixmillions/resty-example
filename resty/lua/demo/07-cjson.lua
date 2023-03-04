--
-- openresty json demo
-- 用到的库是 cjson
-- 其他情况demo，参照当前文件夹的08-cjson.lua文件
-- @author six
-- @since  2023-03-04
--

--定义相应内容格式，如果nginx配置中定义了，这里可省略
ngx.header["Content-type"] = "application/json"
--库引入
local tool = require("sixtool")
local json = require("cjson")

ngx.say("demo01：将一个对象table转换为String")
local user = {name = "six", age = 18, isMan = true, birthday = ngx.localtime()}
ngx.say(json.encode(user))

ngx.say("---------------------------------------------------------------")

ngx.say("demo02：将一个数组table转换为String")
local days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
ngx.say(json.encode(days))

ngx.say("---------------------------------------------------------------")

ngx.say("demo03：将一个复杂一些的对象类型table转换为String")
local response = {
    clientIp = ngx.var.remote_addr,
    --user_agent = ngx.req.get_headers()["user-agent"] or "",
    name = "sixmillions",
    age = 18,
    books = {"AA", "BB", "CC"},
    isMan = true,
    address = {province = "sd", city = "yt", detail = {"xxx区", "xxx街道", "xxx小区"}}
}
ngx.say(json.encode(response))

ngx.say("---------------------------------------------------------------")

ngx.say("demo04：将一个对象类型String转化为table，打印输出")
local s1 = '{"birthday":"2023-03-04 07:25:48","age":18,"name":"lucy","isMan":false}'
local obj1_table = json.decode(s1)
ngx.say(tool.format_table(obj1_table))

ngx.say("---------------------------------------------------------------")

ngx.say("demo05：将一个数组类型String转化为table，打印输出")
local s2 = '["AAA","BBB","CCC","DDD"]'
local arr1_table = json.decode(s2)
ngx.say(tool.format_table(arr1_table))

ngx.say("---------------------------------------------------------------")

ngx.say("demo06：将一个复杂对象String转化为table，打印输出")
local s3 = [[{"name":"sixmillions","clientIp":"192.168.61.74","isMan":true,"age":18,
    "address":{"province":"sd","city":"yt","detail":["xxx区","xxx街道","xxx小区"]},"books":["AA","BB","CC"]}
]]
local t3 = json.decode(s3)
ngx.say(tool.format_table(t3))