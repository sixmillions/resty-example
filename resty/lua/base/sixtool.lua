--
-- 自定义工具类
-- @author six
-- @since  2023-03-04
--
local _M = {}

local json = require("cjson")

--输出table为字符串
--用来debugger用的，pairs无法被JIT，不要用
function _M.format_table(t)
    if not t then
        return "输入的是nil"
    end
    local str = ""
    for k, v in pairs(t) do
        local v_str = ""
        if type(v) == "boolean" then
            v_str = v and "true" or "false"
        elseif type(v) == "function" then
            v_str = "funcaton"
        elseif type(v) == "table" then
            v_str = _M.format_table(v)
        else
            v_str = v
        end
        str = str .. k .. "--" .. v_str .. "\n"
    end
    return str
end

--字符串转table封装，防止出错
--local t = tool.json_decode('["aaa","bbb"]')
--ngx.say(tool.format_table(t))
function _M.json_decode(str, empty_table_as_object)
    json.encode_empty_table_as_object(empty_table_as_object or false) -- 空的table默认为array
    local ok, json_value =
        pcall(
        function(str)
            return json.decode(str)
        end,
        str
    )
    if not ok then
        --ngx.say("ok:", ok)
        return nil
    end
    --ngx.say("return type: ", type(json_value))
    return json_value
end

return _M
