target("luatos_lwip_socket")
    local LIB_DIR = "$(buildir)/luatos_lwip_socket/"
    set_kind("static")
    set_targetdir(LIB_DIR)
    
    --加入代码和头文件
    add_includedirs("./include",{public = true})
    add_files("./**.c",{public = true})
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. "libluatos_lwip_socket.a "
target_end()