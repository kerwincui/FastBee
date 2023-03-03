local TARGET_NAME = "luatos"
local LIB_DIR = "$(buildir)/".. TARGET_NAME .. "/"
local LIB_NAME = "lib" .. TARGET_NAME .. ".a "

local LUATOS_ROOT = SDK_TOP .. "/../LuatOS/"

target(TARGET_NAME)
    set_kind("static")
    set_targetdir(LIB_DIR)
    add_includedirs(SDK_TOP .. "/PLAT/core/tts/include/16k_lite_ver",{public = true})   --为了编译通过而已
    LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_16K.a "
    --8K版本用下面的库，注释掉16K的库
    -- LIB_USER = LIB_USER .. SDK_TOP .. "/PLAT/core/lib/libaisound50_8K.a "
    --加入代码和头文件
    add_includedirs("./inc",{public = true})
    -- add_includedirs(SDK_TOP .. "/interface/private_include", 
    --                 {public = true})
    add_files("./src/*.c",{public = true})
    add_files(SDK_TOP .. "interface/src/*.c",{public = true})
	
    add_includedirs(LUATOS_ROOT .. "lua/include")
    add_includedirs(LUATOS_ROOT .. "luat/include")
    add_includedirs(LUATOS_ROOT .. "components/cmux")
    add_includedirs(LUATOS_ROOT .. "components/cjson")
    add_includedirs(LUATOS_ROOT .. "components/fatfs")
    add_includedirs(LUATOS_ROOT .. "components/shell")


    add_files(LUATOS_ROOT .. "lua/src/*.c")
    add_files(LUATOS_ROOT .. "luat/modules/*.c")
    add_files(LUATOS_ROOT .. "luat/vfs/*.c")
    add_files(LUATOS_ROOT .. "components/cmux/*.c")
    add_files(LUATOS_ROOT .. "components/cjson/*.c")
    add_files(LUATOS_ROOT .. "components/crypto/*.c")

    -- gtfont
    add_includedirs(LUATOS_ROOT.."components/gtfont")
    add_files(LUATOS_ROOT.."components/gtfont/*.c")
    LIB_USER = LIB_USER .. SDK_TOP .. "/lib/libgt.a "

    -- coremark
    add_files(LUATOS_ROOT .. "components/coremark/*.c")
    add_includedirs(LUATOS_ROOT .. "components/coremark")

    -- lua-cjson
    add_files(LUATOS_ROOT .. "components/lua-cjson/*.c")
    add_includedirs(LUATOS_ROOT .. "components/lua-cjson")

    -- miniz
    add_files(LUATOS_ROOT .. "components/miniz/*.c")
    add_includedirs(LUATOS_ROOT .. "components/miniz")

    -- protobuf
    add_includedirs(LUATOS_ROOT.."components/serialization/protobuf")
    add_files(LUATOS_ROOT.."components/serialization/protobuf/*.c")

    -- fdb
    add_includedirs(SDK_TOP.."thirdparty/fal/inc")
    add_includedirs(SDK_TOP.."thirdparty/flashdb/inc")
    add_files(SDK_TOP.."thirdparty/fal/src/*.c")
    add_files(SDK_TOP.."thirdparty/flashdb/src/*.c")
    add_files(LUATOS_ROOT.."components/flashdb/src/luat_lib_fdb.c")

    -- rsa
    add_files(LUATOS_ROOT.."components/rsa/**.c")

    -- iotauth
    -- add_includedirs(LUATOS_ROOT.."components/iotauth")
    add_files(LUATOS_ROOT.."components/iotauth/**.c")

    -- sfud
    add_includedirs(LUATOS_ROOT.."components/sfud")
    add_files(LUATOS_ROOT.."components/sfud/**.c")

    -- fatfs
    add_includedirs(LUATOS_ROOT.."components/fatfs")
    add_files(LUATOS_ROOT.."components/fatfs/**.c")

    -- libgnss
    add_includedirs(LUATOS_ROOT .. "components/minmea")
    add_files(LUATOS_ROOT.."components/minmea/**.c")

    add_files(LUATOS_ROOT.."components/mlx90640-library/*.c")
    add_includedirs(LUATOS_ROOT.."components/mlx90640-library")

    --------------------------------------------------------------
    -- UI类的,能不能用另说, 先加上吧
    
    add_includedirs(LUATOS_ROOT.."lua/include")
    add_includedirs(LUATOS_ROOT.."luat/include")
    add_includedirs(LUATOS_ROOT.."components/lcd")
    add_includedirs(LUATOS_ROOT.."components/tjpgd")
    add_includedirs(LUATOS_ROOT.."components/eink")
    add_includedirs(LUATOS_ROOT.."components/epaper")
    add_includedirs(LUATOS_ROOT.."components/u8g2")
    add_includedirs(LUATOS_ROOT.."components/gtfont")
    add_includedirs(LUATOS_ROOT.."components/qrcode")

    add_includedirs(LUATOS_ROOT.."components/lvgl")
    add_includedirs(LUATOS_ROOT.."components/lvgl/binding")
    add_includedirs(LUATOS_ROOT.."components/lvgl/gen")
    add_includedirs(LUATOS_ROOT.."components/lvgl/src")
    add_includedirs(LUATOS_ROOT.."components/lvgl/font")
    add_includedirs(LUATOS_ROOT.."components/lvgl/src/lv_font")

    -- lvgl
    add_files(LUATOS_ROOT.."components/lvgl/**.c")
    -- 默认不编译lv的demos, 节省大量的编译时间
    remove_files(LUATOS_ROOT.."components/lvgl/lv_demos/**.c")

    -- eink
    add_files(LUATOS_ROOT.."components/eink/*.c")
    add_files(LUATOS_ROOT.."components/epaper/*.c")
    remove_files(LUATOS_ROOT.."components/epaper/GUI_Paint.c")

    -- u8g2
    add_files(LUATOS_ROOT.."components/u8g2/*.c")

    -- lcd
    add_files(LUATOS_ROOT.."components/lcd/*.c")
    add_files(LUATOS_ROOT.."components/tjpgd/*.c")
    add_files(LUATOS_ROOT.."components/qrcode/*.c")
    

    -- network
    add_includedirs(LUATOS_ROOT .. "components/ethernet/common")
    add_includedirs(LUATOS_ROOT .. "components/common")
    add_includedirs(LUATOS_ROOT .. "components/network/adapter")
    add_includedirs(LUATOS_ROOT .. "components/mbedtls/include", {public = true})
    add_includedirs(LUATOS_ROOT .. "components/mbedtls/library", {public = true})
    add_files(LUATOS_ROOT .. "components/ethernet/common/*.c")
    add_files(LUATOS_ROOT .. "components/network/adapter/*.c")
    add_files(LUATOS_ROOT .. "components/mbedtls/library/*.c")

    -- mqtt
    add_includedirs(LUATOS_ROOT.."components/network/libemqtt")
    add_files(LUATOS_ROOT.."components/network/libemqtt/*.c")

    -- http
    add_includedirs(LUATOS_ROOT.."components/network/libhttp")
    -- add_files(LUATOS_ROOT.."components/network/libhttp/luat_lib_http.c")
    add_files(LUATOS_ROOT.."components/network/libhttp/luat_http_client.c")

    -- http_parser
    add_includedirs(LUATOS_ROOT.."components/network/http_parser")
    add_files(LUATOS_ROOT.."components/network/http_parser/*.c")

    -- websocket
    add_includedirs(LUATOS_ROOT.."components/network/websocket")
    add_files(LUATOS_ROOT.."components/network/websocket/*.c")

    -- errdump
    add_includedirs(LUATOS_ROOT.."components/network/errdump")
    add_files(LUATOS_ROOT.."components/network/errdump/*.c")

    -- iotauth
    add_files(LUATOS_ROOT.."components/iotauth/luat_lib_iotauth.c")

    -- mobile
    add_includedirs(LUATOS_ROOT.."components/mobile")
    add_files(LUATOS_ROOT.."components/mobile/*.c")

    
    -- shell
    add_files(LUATOS_ROOT.."components/shell/*.c")

    -- i2c-tools
    add_includedirs(LUATOS_ROOT.."components/i2c-tools")
    add_files(LUATOS_ROOT.."components/i2c-tools/*.c")

    -- lora
    add_includedirs(LUATOS_ROOT.."components/lora/sx126x")
    add_files(LUATOS_ROOT.."components/lora/**.c")

    
    -- fonts
    add_includedirs(LUATOS_ROOT.."components/luatfonts")
    add_files(LUATOS_ROOT.."components/luatfonts/**.c")

    
    -- wlan
    add_includedirs(LUATOS_ROOT.."components/wlan")
    add_files(LUATOS_ROOT.."components/wlan/**.c")
    -- audio
    add_includedirs(LUATOS_ROOT.."components/multimedia/")
    add_includedirs(LUATOS_ROOT.."components/multimedia/mp3_decode")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/amr_common/dec/include")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/amr_nb/common/include")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/amr_nb/dec/include")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/amr_wb/dec/include")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/opencore-amrnb")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/opencore-amrwb")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/oscl")
    add_includedirs(LUATOS_ROOT.."components/multimedia/amr_decode/amr_nb/enc/src")
    add_files(LUATOS_ROOT.."components/multimedia/**.c")
    ------------------------------------------------------------
    ------------------------------------------------------------
    -- sms
    add_includedirs(LUATOS_ROOT.."components/sms")
    add_files(LUATOS_ROOT.."components/sms/*.c")

    -- hmeta
    add_includedirs(LUATOS_ROOT.."components/hmeta")
    add_files(LUATOS_ROOT.."components/hmeta/*.c")

    -- profiler
    add_includedirs(LUATOS_ROOT.."components/mempool/profiler/include")
    add_files(LUATOS_ROOT.."components/mempool/profiler/**.c")

    -- hmeta
    add_includedirs(LUATOS_ROOT.."components/fskv")
    add_files(LUATOS_ROOT.."components/fskv/*.c")

    -- sntp
    add_includedirs(LUATOS_ROOT.."components/network/libsntp")
    add_files(LUATOS_ROOT.."components/network/libsntp/*.c")

    -- libftp
    add_includedirs(LUATOS_ROOT.."components/network/libftp")
    add_files(LUATOS_ROOT.."components/network/libftp/*.c")

    -- sfd
    add_includedirs(LUATOS_ROOT.."components/sfd")
    add_files(LUATOS_ROOT.."components/sfd/*.c")


    -- 作为最后补充, 不然总是报主库没有的头文件
    add_includedirs(SDK_TOP .. "interface/include")

    --自动链接
    LIB_USER = LIB_USER .. SDK_TOP .. LIB_DIR .. LIB_NAME .. " "
    --甚至可以加入自己的库
target_end()