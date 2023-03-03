local TARGET_NAME = "example_yunlabayashi"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "
includes(SDK_TOP .. "/thirdparty/audio_decoder")
target(TARGET_NAME)
    set_kind("static")
    set_targetdir(LIB_DIR)
    add_defines("MQTT_TASK",{public = true})

    includes(SDK_TOP .. "/thirdparty/mqtt")
    add_deps("mqtt")
    
    -- --加入代码和头文件
    add_includedirs(SDK_TOP .. "/thirdparty/mqtt/MQTTClient-C/src",{public = true})
    add_files(SDK_TOP .. "/thirdparty/mqtt/MQTTClient-C/src/*.c",{public = true})
    --加入代码和头文件
     includes(SDK_TOP .. "/thirdparty/httpclient")
    add_deps("httpclient")
    add_includedirs("/inc",{public = true})
    add_files("/src/*.c",{public = true})
    add_deps("audio_decoder")
    --加入代码和头文件
    add_includedirs("/include",{public = true})
    add_includedirs(SDK_TOP .. "/PLAT/core/tts/include/16k_lite_ver",{public = true})
    --路径可以随便写,可以加任意路径的代码,下面代码等效上方代码
    -- add_includedirs(SDK_TOP .. "project/" .. TARGET_NAME .. "/inc",{public = true})
    -- add_files(SDK_TOP .. "project/" .. TARGET_NAME .. "/src/*.c",{public = true})

    --可以继续增加add_includedirs和add_files
    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_16K_lite_beta.a "
    --甚至可以加入自己的库
target_end()