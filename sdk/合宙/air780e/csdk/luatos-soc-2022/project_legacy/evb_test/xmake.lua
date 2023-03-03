local TARGET_NAME = "evb_test"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "
includes(SDK_TOP .. "/thirdparty/audio_decoder")
target(TARGET_NAME)
    set_kind("static")
    set_targetdir(LIB_DIR)
    add_deps("audio_decoder")
    -- --加入代码和头文件
    add_includedirs(SDK_TOP .. "/PLAT/core/tts/include/16k_lite_ver",{public = true})
    --加入自己代码和头文件
    add_includedirs("/inc",{public = true})
    add_files("/src/*.c",{public = true})
    
    add_defines("EVB_AIR780E_CLOUD_SPEAK",{public = true})
    -- add_defines("EVB_AIR600E_CLOUD_SPEAK",{public = true})
    -- add_defines("EVB_AIR600EAC_CLOUD_SPEAK",{public = true})
    --可以继续增加add_includedirs和add_files
    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_16K_lite_beta.a "
    --甚至可以加入自己的库
target_end()
