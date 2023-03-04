--
--openresty模块引用
--@author six
--@since 2023-03-04
--

ngx.header["Content-Type"] = "text/html"
local ngx_re = require "ngx.re"

--查看所有Lua模块扫描路径
local path_list, err = ngx_re.split(package.path, ";")
for _, v in ipairs(path_list) do
    ngx.say(v, "<br/>")
end

ngx.say("-------------------------", "<br/>")

--可以使用上面路径下的模块
--/usr/local/openresty/lualib/resty/string.lua
--使用resty目录下的模块
local str = require "resty.string"
ngx.say(string.sub("123456", 1, 5), "<br/>")

ngx.say("-------------------------", "<br/>")

--可以自己在nginx的http上下文配置扫描路径
--lua_package_path "/usr/local/openresty/nginx/lua/base/?.lua;;";
local demo01 = require("module-demo-01")
ngx.say(demo01.name, "<br/>")

ngx.say("-------------------------", "<br/>")

--自己手动添加（好像是当前lua文件有效）
package.path = ";/usr/local/openresty/nginx/lua/?.lua;" .. package.path
require("hello")
