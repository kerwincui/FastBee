local TARGET_NAME = "example_luatos_socket"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "

local LUATOS_ROOT = SDK_TOP .. "/../LuatOS/"
includes(SDK_TOP.."/luatos_lwip_socket")
target(TARGET_NAME)
    set_kind("static")
    add_deps("luatos_lwip_socket")
    set_targetdir(LIB_DIR)
    --8K版本用下面的库，注释掉16K的库
    -- LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_8K.a "
    --加入代码和头文件
    add_includedirs("./inc",{public = true})
    -- add_includedirs(SDK_TOP .. "/interface/private_include", 
    --                 {public = true})
    add_files("./src/*.c",{public = true})
    

    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    --甚至可以加入自己的库
target_end()