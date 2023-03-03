
target("audio_decoder")
    local LIB_DIR = "$(buildir)/audio_decoder/"
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    --加入代码和头文件
    add_includedirs("./mp3/include",{public = true})
    add_files("./mp3/**.c",{public = true})
    
    add_includedirs("./amr/amr_common/dec/include",{public = true})
    add_includedirs("./amr/amr_nb/common/include",{public = true})
    add_includedirs("./amr/amr_nb/dec/include",{public = true})
    add_includedirs("./amr/amr_wb/dec/include",{public = true})
    add_includedirs("./amr/opencore-amrnb",{public = true})
    add_includedirs("./amr/opencore-amrwb",{public = true})
    add_includedirs("./amr/oscl",{public = true})
    add_includedirs("./amr/amr_nb/enc/src",{public = true})
    -- **.c会递归所有子文件夹下的文件
    add_files("./amr/**.c",{public = true})

    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "libaudio_decoder.a "
target_end()
