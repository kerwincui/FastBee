local TARGET_NAME = "web_audio"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "
includes(SDK_TOP .. "/thirdparty/audio_decoder")
target(TARGET_NAME)
    set_kind("static")
    set_targetdir(LIB_DIR)
    add_defines("MQTT_TASK",{public = true})
    includes(SDK_TOP .. "/thirdparty/mqtt")
    add_deps("mqtt")
    add_includedirs(SDK_TOP .. "/thirdparty/mqtt/MQTTClient-C/src",{public = true})
    add_files(SDK_TOP .. "/thirdparty/mqtt/MQTTClient-C/src/*.c",{public = true})
 
    includes(SDK_TOP .. "/thirdparty/httpclient")
    add_deps("httpclient")
 
    add_deps("audio_decoder")
    includes(SDK_TOP .. "/thirdparty/miniz")
    add_deps("miniz")
    add_includedirs(SDK_TOP .. "/PLAT/core/tts/include/16k_lite_ver",{public = true})

    add_includedirs("/inc",{public = true})
    add_files("/src/*.c",{public = true})
   

    --可以继续增加add_includedirs和add_files
    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_16K.a "
    --甚至可以加入自己的库
target_end()