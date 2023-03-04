--
-- openresty 获取url参数测试
-- https://github.com/openresty/lua-nginx-module#ngxrefind
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "application/json"

local args = ngx.req.get_uri_args()

ngx.say(args.clip_id, " ", type(args.clip_id), " ", not args.clip_id)
-- 请求url                          收到的值  值的类型  not值    备注
-- /15-url-args-check               nil       nil      true
-- /15-url-args-check?ww            nil       nil      true
-- /15-url-args-check?clip_id       true      boolean  false   接受到的是boolean类型的true
-- /15-url-args-check?clip_id=      空字符串   string   false   接受到的是空字符串
-- /15-url-args-check?clip_id=22    22        string   false
-- /15-url-args-check?clip_id=ee    ee        string   false
-- /15-url-args-check?clip_id=nil   nil       string   false
-- /15-url-args-check?clip_id=true  true      string   false
-- /15-url-args-check?clip_id=false false     string   false

-- 参数校验测试
-- if type(args.clip_id) == "nil" or type(args.clip_id) == "boolean" then
--     ngx.say("收到的参数是 nill boolean")
-- elseif type(args.clip_id) == "string" and #args.clip_id == 0 then
--     ngx.say("收到的参数是空字符串")
-- else
--     ngx.say("收到的参数是字符串", args.clip_id)    
-- end

-- 简单写法
if type(args.clip_id) ~= "string" then
    ngx.say("收到的clip_id参数不是字符串，而是：", args.clip_id)
    return
end

-- 正则校验，匹配就返回1，不匹配返回nil
-- https://github.com/openresty/lua-nginx-module#ngxrefind
local m = ngx.re.find(args.clip_id, [[^[a-z0-9A-Z]{3,6}$]], "jo") -- jo 是启动JIT编译，加快运行速度
ngx.say(type(m), " ", m)
if not m then
    ngx.say("确保参数是字母数字组成的3到6位字符串")
    return
end

ngx.say("继续其他逻辑.....")