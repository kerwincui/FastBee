local TARGET_NAME = "web_led"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "

target(TARGET_NAME)
    local LIB_DIR = "$(buildir)/mqttclient/"
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    add_defines("MQTT_TASK",{public = true})

    includes(SDK_TOP .. "/thirdparty/mqtt")
    add_deps("mqtt")
    
    -- --加入代码和头文件
    add_includedirs(SDK_TOP .. "/thirdparty/mqtt/MQTTClient-C/src",{public = true})
    add_files(SDK_TOP .. "/thirdparty/mqtt/MQTTClient-C/src/*.c",{public = true})
    add_includedirs(SDK_TOP .. "thirdparty/cjson")
    add_files(SDK_TOP .. "/thirdparty/cJSON/*.c",{public = true})

    --加入自己代码和头文件
    add_includedirs("/inc",{public = true})
    add_files("/src/*.c",{public = true})

    --可以继续增加add_includedirs和add_files

    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    
    --甚至可以加入自己的库
target_end()
