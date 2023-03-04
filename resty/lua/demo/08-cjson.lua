--
-- openresty json demo
-- cjson输出空对象、空数组、稀疏数组、转义出错等问题的解决
-- https://moonbingbing.gitbooks.io/openresty-best-practices/content/json/array_or_object.html
-- https://github.com/openresty/lua-cjson
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-type"] = "application/json"
--库引入
local json = require("cjson")
local tool = require("sixtool")

ngx.say("demo01：空table转换为string默认是 {}，如果想转化为[]，需要配置参数 json.encode_empty_table_as_object(false)")
local t2 = {}
ngx.say("空对象", json.encode(t2))
json.encode_empty_table_as_object(false)
ngx.say("空数组", json.encode(t2))
json.encode_empty_table_as_object(true)
local t3 = {books = {}, user = {}}
ngx.say("修改后所有的空table，都是空数组，如果想该回去，需要再设置为true   ", json.encode(t3))

ngx.say("---------------------------------------------------------------")

ngx.say("demo02：稀疏table转换为string会报错，我们可以设置 json.encode_sparse_array(true)，但是出来的是对象不是数组")
local t4 = {"AAA", "BBB"}
t4[666] = "CCC"
json.encode_sparse_array(true) -- 不设置会出错
ngx.say("稀疏数组table", json.encode(t4)) --{"1":"AAA","2":"BBB","666":"CCC"}

ngx.say("---------------------------------------------------------------")

ngx.say("demo03：decode出错，openresty会报错误，所以我们需要自己封装一下")
local err_str = [[ {"key":"value", } ]] --错误json串，多了一个逗号
--json.decode(err_str) --会报错

local function json_decode(str)
    local ok, json_value =
        pcall(
        function(str)
            return json.decode(str)
        end,
        str
    )
    if not ok then
        ngx.say(ok)
        return nil
    end
    ngx.say(type(json_value))
    return json_value
end

local res1 = json_decode(err_str);
ngx.say(tool.format_table(res1))

local ok_str = [[ {"key":"value"} ]]
local res2 = json_decode(ok_str);
ngx.say(tool.format_table(res2))