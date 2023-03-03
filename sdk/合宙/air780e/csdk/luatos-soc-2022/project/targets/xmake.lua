local TARGET_NAME = "targets"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "

target("target1")
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    --加入代码和头文件
    add_includedirs("/inc",{public = true})
    add_files("/target1/*.c",{public = true})

    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "libtarget1.a "
target_end()

target("target2")
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    --加入代码和头文件
    add_includedirs("/inc",{public = true})
    add_files("/target2/*.c",{public = true})

    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "libtarget2.a "
target_end()

target("target3")
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    --加入代码和头文件
    add_includedirs("/inc",{public = true})
    add_files("/target3/*.c",{public = true})

    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "libtarget3.a "
target_end()

target(TARGET_NAME)
    set_kind("phony")
    add_deps("target1", "target2", "target3")
    set_targetdir(LIB_DIR)
target_end()