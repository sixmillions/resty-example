--
-- openresty 等待函数，sleep
-- @author six
-- @since  2023-03-04
--

ngx.header["Content-Type"] = "application/json"

-- 等待时间结束一起返回
ngx.say("5s等待开始：", ngx.localtime())

ngx.sleep(5)

ngx.say("5s等待结束：", ngx.localtime())
