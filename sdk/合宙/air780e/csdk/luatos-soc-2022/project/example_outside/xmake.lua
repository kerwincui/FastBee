--[[
本example演示在SDK目录之外存放项目代码

目录结构演示如下:

其中: 

SDK所在目录 D:\github\luatos-soc-ec618
项目代码所在目录 D:\github\ec618-webabc

D:\github
    - luatos-soc-ec618
        - build.bat
        - PLAT
        - ...
    - ec618-webabc
        - code
            - xmake.lua
            - src
                app_main.c
                task_mqtt.c
            - inc
                app_main.h
                RTE_Device.h
        - doc
            - README.md

]]

-- 相对路径,绝对路径均可
local PROJECT_DIR = "D:/github/ec618-webabc"
-- local PROJECT_DIR = "../../ec618-webabc"

-- 给出项目代码xmake.lua的路径即可
includes(PROJECT_DIR .. "/code/xmake.lua")

-- 项目代码中xmake.lua, 要求 TARGET_NAME 能对得上
-- 例如本例子在SDK中的路径是 project/example_outside , 那么项目中TARGET_NAME为 example_outside

--[[
local TARGET_NAME = "example_outside"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "

target(TARGET_NAME)
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    --加入代码和头文件
    add_includedirs("./inc",{public = true})
    add_files("./src/*.c",{public = true})

    --add_files("../../thirdparty/fal/src/*.c",{public = true})
    --add_files("../../thirdparty/flashdb/src/*.c",{public = true})

    --可以继续增加add_includedirs和add_files
    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    --甚至可以加入自己的库
target_end()
]]

--[[
为了防止误提交到主库, 可在当前目录添加.gitignore, 忽略全部文件, 然后强制添加xmake.lua
git add -f project/example_outside/xmake.lua

.gitignore文件的内容, 本目录有参考, 就一个字符 "*"
]]
