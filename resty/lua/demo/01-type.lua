--
-- 查看lua的数据类型
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "text/html"

ngx.say(type("hello world"), "<br/>") -->output:string
ngx.say(type(360.0), "<br/>") -->output:number
ngx.say(type(true), "<br/>") -->output:boolean
ngx.say(type(nil), "<br/>") -->output:nil
ngx.say(type({}), "<br/>") -->output:table
ngx.say(type(print), "<br/>") -->output:function

-- 特有的ngx.null，注意null也是“真”
if ngx.null then
    ngx.say("我是ngx.null: ", ngx.null, ", 我的类型是: ", type(ngx.null), "<br/>")
else
    ngx.say("1111111", "<br/>")
end
