--
-- 字符串分割为table
-- https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md
-- @author six
-- @since 2023-03-04
--

ngx.header["Content-Type"] = "application/json"

--这个引入的和全局变量中的ngx.re不一样
local ngx_re = require("ngx.re")

local res, err = ngx_re.split("a,b,c,d", ",")

for _, v in ipairs(res) do
    ngx.say(v)
end
