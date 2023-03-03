target("minmea")
local LIB_DIR = "$(buildir)/minmea/"
set_kind("static")
set_targetdir(LIB_DIR)

-- add_defines("FEATURE_MQTT_TLS_ENABLE",{public = true})

-- 加入代码和头文件
add_includedirs("./",{public = true})
add_files("./*.c",{public = true})

-- 自动链接
LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "libminmea.a "
target_end()
