--
-- openresty 时间
-- https://github.com/openresty/lua-nginx-module#ngxtime
-- update_time：https://xie.infoq.cn/article/5f39aea9036e08054d3d94dfc
-- @author six
-- @since  2023-03-04
--
ngx.header["Content-Type"] = "application/json"

ngx.say("ngx.today: ", ngx.today()) --2023-03-04
ngx.say("ngx.time: ", ngx.time()) --1677922366   时间戳（秒）
ngx.say("ngx.now: ", ngx.now()) --1677922402.545
ngx.say("ngx.update_time: ", ngx.update_time()) --openresty会对时间缓存，其他api调用的都是缓存的时间，这个update_time就是为了更新缓存
ngx.say("ngx.localtime: ", ngx.localtime()) --2023-03-04 09:36:06 和utc不在一个时区就能看出来了
ngx.say("ngx.utctime: ", ngx.utctime()) --2023-03-04 09:36:06

--返回一个字符串可以用来给cookie设置过期时间
ngx.say("ngx.cookie_time: ", ngx.cookie_time(1677922366)) --Sat, 04-Mar-23 09:32:46 GMT

--返回一个字符串可以用来给header设置时间
ngx.say("ngx.http_time: ", ngx.http_time(1677922366)) --Sat, 04 Mar 2023 09:32:46 GMT