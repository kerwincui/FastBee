local TARGET_NAME = "example_audio_flash"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "
includes(SDK_TOP .. "/thirdparty/audio_decoder")
target(TARGET_NAME)
    set_kind("static")
    set_targetdir(LIB_DIR)
    add_deps("audio_decoder")

    includes(SDK_TOP .. "/thirdparty/miniz")
    add_deps("miniz")
    
    add_includedirs(SDK_TOP .. "/thirdparty/sfud",{public = true})
    add_files(SDK_TOP.."/thirdparty/sfud/*.c",{public = true})

    --加入代码和头文件
    add_includedirs("./include",{public = true})
    add_includedirs(SDK_TOP .. "/PLAT/core/tts/include/16k_lite_ver",{public = true})
    add_files("./src/*.c",{public = true})

    --路径可以随便写,可以加任意路径的代码,下面代码等效上方代码
    -- add_includedirs(SDK_TOP .. "project/" .. TARGET_NAME .. "/inc",{public = true})
    -- add_files(SDK_TOP .. "project/" .. TARGET_NAME .. "/src/*.c",{public = true})

    --可以继续增加add_includedirs和add_files
    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_16K.a "
    --8K版本用下面的库，注释掉16K的库
    -- LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_8K.a "
    --甚至可以加入自己的库
target_end()