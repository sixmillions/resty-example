--
--看一下ngx这个table中都存了什么
--@author six
--@since 2023-03-04
--

ngx.header["Content-Type"] = "text/html"

ngx.say("ngx这个全局变量的类型: ", type(ngx), "<br/>")
ngx.say("--------------------------------------------", "<br/>")
--迭代一下
ngx.say("ngx里面有的内容", "<br/>")
ngx.say('<table border="1"><thead><td>num</td><td>key</td><td>key-type</td></thead>')
local i = 1
for k, v in pairs(ngx) do
    ngx.say("<tr>")
    ngx.say("<td>", i, "</td><td>", k, "</td><td>", type(v), "</td>")
    ngx.say("</tr>")
    i = i + 1
end
ngx.say("</table>")
