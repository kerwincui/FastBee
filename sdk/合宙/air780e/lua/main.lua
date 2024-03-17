--- 模块功能：lvgldemo
-- @module main
-- @author 杜兴杰
-- @release 2023.03.15

-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "wumeiAir780"
VERSION = "0.0.1"

log.info("main", PROJECT, VERSION)

-- sys库是标配
_G.sys = require("sys")



--添加硬狗防止程序卡死
if wdt then
    wdt.init(9000)--初始化watchdog设置为9s
    sys.timerLoopStart(wdt.feed, 3000)--3s喂一次狗
end


require "WuMeiTest"

-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!


