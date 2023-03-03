
target("linksdk")
    local LIB_DIR = "$(buildir)/linksdk/"
    set_kind("static")
    set_targetdir(LIB_DIR)
    -- link-speech需要cjson
    -- add_includedirs(SDK_TOP .. "/thirdparty/cJSON")
    -- add_files(SDK_TOP .. "/thirdparty/cJSON/**.c")
    --加入代码和头文件
    add_includedirs(SDK_TOP .. "thirdparty/mbedtls/include",{public = true})
    add_includedirs(SDK_TOP .. "thirdparty/mbedtls/include/mbedtls",{public = true})
    add_includedirs("./core",{public = true})
    add_includedirs("./core/utils",{public = true})
    add_includedirs("./core/sysdep",{public = true})
    add_includedirs("./components/data-model",{public = true})
    add_includedirs("./components/devinfoe",{public = true})
    add_includedirs("./components/logpost",{public = true})
    add_includedirs("./components/ntp",{public = true})
    add_includedirs("./components/ota",{public = true})
    add_includedirs("./components/shadow",{public = true})
    add_includedirs("./components/diag",{public = true})
    add_includedirs("./components/dynreg",{public = true})
    add_includedirs("./components/dynreg-mqtt",{public = true})
    -- add_includedirs("./components/link-speech",{public = true})
    add_files("./core/utils/*.c",{public = true})
    add_files("./core/*.c",{public = true})
    add_files("./core/sysdep/*.c",{public = true})
    add_files("./external/*.c",{public = true})
    add_files("./components/data-model/*.c",{public = true})
    add_files("./components/devinfo/*.c",{public = true})
    add_files("./components/logpost/*.c",{public = true})
    add_files("./components/ntp/*.c",{public = true})
    add_files("./components/ota/*.c",{public = true})
    add_files("./components/shadow/*.c",{public = true})
    add_files("./components/diag/*.c",{public = true})
    add_files("./components/dynreg/*.c",{public = true})
    add_files("./components/dynreg-mqtt/*.c",{public = true})
    add_files("./portfiles/aiot_port/*.c",{public = true})
    -- add_files("./components/link-speech/*.c",{public = true})

    
    --路径可以随便写,可以加任意路径的代码,下面代码等效上方代码
    -- add_includedirs(SDK_TOP .. "project/" .. TARGET_NAME .. "/inc",{public = true})
    -- add_files(SDK_TOP .. "project/" .. TARGET_NAME .. "/src/*.c",{public = true})
    
    --可以继续增加add_includedirs和add_files
    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "liblinksdk.a "
target_end()