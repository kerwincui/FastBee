set_project("EC618")
set_xmakever("2.7.2")
set_version("0.0.2", {build = "%Y%m%d%H%M"})
add_rules("mode.debug", "mode.release")
set_defaultmode("debug")

local VM_64BIT = nil
SDK_TOP = "."
local SDK_PATH
local USER_PROJECT_NAME = "example"
local USER_PROJECT_NAME_VERSION
local USER_PROJECT_DIR  = ""

package("gnu_rm")
	set_kind("toolchain")
	set_homepage("https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm")
	set_description("GNU Arm Embedded Toolchain")
	local version_map = {
		["2021.10"] = "10.3-2021.10"
	}
	if is_host("windows") then
		set_urls("http://cdndownload.openluat.com/xmake/toolchains/gcc-arm/gcc-arm-none-eabi-$(version)-win32.zip", {version = function (version)
			return version_map[tostring(version)]
		end})
		add_versions("2021.10", "d287439b3090843f3f4e29c7c41f81d958a5323aecefcf705c203bfd8ae3f2e7")
	elseif is_host("linux") then
		set_urls("http://cdndownload.openluat.com/xmake/toolchains/gcc-arm/gcc-arm-none-eabi-$(version)-x86_64-linux.tar.bz2", {version = function (version)
			return version_map[tostring(version)]
		end})
		add_versions("2021.10", "97dbb4f019ad1650b732faffcc881689cedc14e2b7ee863d390e0a41ef16c9a3")
	end
	on_install("@windows", "@linux", function (package)
		os.vcp("*", package:installdir())
	end)
package_end()

if os.getenv("GCC_PATH") then
	toolchain("arm_toolchain")
	    set_kind("standalone")
	    set_sdkdir(os.getenv("GCC_PATH"))
	toolchain_end()
	set_toolchains("arm_toolchain")
else
	add_requires("gnu_rm 2021.10")
	set_toolchains("gnu-rm@gnu_rm")
end

if os.getenv("PROJECT_NAME") then
	USER_PROJECT_NAME = os.getenv("PROJECT_NAME")
end

if os.getenv("LSPD_MODE") == "enable" then
    add_defines("LOW_SPEED_SERVICE_ONLY")
end

if os.getenv("ROOT_PATH") then
	SDK_TOP = os.getenv("ROOT_PATH")
else
	SDK_TOP = os.curdir().."/"
end
SDK_PATH = SDK_TOP

if os.getenv("PROJECT_DIR") then
    USER_PROJECT_DIR = os.getenv("PROJECT_DIR")
else
    USER_PROJECT_DIR = SDK_TOP .. "/project/" .. USER_PROJECT_NAME
end

set_plat("cross")
set_arch("arm")
set_languages("gnu99", "cxx11")
set_warnings("everything")

-- ==============================
-- === defines =====
add_defines("__EC618",
            "CHIP_EC618",
            "CORE_IS_AP",
            "SDK_REL_BUILD",
            "EC_ASSERT_FLAG",
            "PM_FEATURE_ENABLE",
            "UINILOG_FEATURE_ENABLE",
            "FEATURE_OS_ENABLE",
            "configUSE_NEWLIB_REENTRANT=1",
            "ARM_MATH_CM3",
            "FEATURE_YRCOMPRESS_ENABLE",
            "FEATURE_CCIO_ENABLE",
            "DHCPD_ENABLE_DEFINE=1",
            "LWIP_CONFIG_FILE=\"lwip_config_ec6180h00.h\"",
            "FEATURE_MBEDTLS_ENABLE",
            "LFS_NAME_MAX=63",
            "LFS_DEBUG_TRACE",
            "WDT_FEATURE_ENABLE=1",
            "FEATURE_UART_HELP_DUMP_ENABLE",
            "DEBUG_LOG_HEADER_FILE=\"debug_log_ap.h\"",
            "TRACE_LEVEL=5",
            "SOFTPACK_VERSION=\"\"",
            "HAVE_STRUCT_TIMESPEC",
            "HTTPS_WITH_CA",
            "FEATURE_HTTPC_ENABLE",
            "LITE_FEATURE_MODE",
            "RTE_USB_EN=1",
            "RTE_RNDIS_EN=0",
            "RTE_ETHER_EN=0",
            "RTE_PPP_EN=0",
            "RTE_OPAQ_EN=0",
            "RTE_ONE_UART_AT=0",
            "RTE_TWO_UART_AT=0",
            "__USER_CODE__",
            "__PRINT_ALIGNED_32BIT__",
            "_REENT_SMALL",
            "_REENT_GLOBAL_ATEXIT"
)


add_cxflags("-g3",
            "-mcpu=cortex-m3",
            "-mthumb",
            "-std=gnu99",
            "-nostartfiles",
            "-mapcs-frame",
            "-Os",
            "-ffunction-sections",
            "-fdata-sections",
            "-fno-isolate-erroneous-paths-dereference",
            "-freorder-blocks-algorithm=stc",
            "-Wall",
            "-Wno-format",
            "-gdwarf-2",
            "-fno-inline",
            "-mslow-flash-data",
            "-fstack-usage",
            "-Wstack-usage=4096",
            "-fcallgraph-info",
{force=true})

add_ldflags(" -Wl,--wrap=clock ",{force = true})
add_ldflags(" -Wl,--wrap=localtime ",{force = true})
add_ldflags(" -Wl,--wrap=gmtime ",{force = true})
add_ldflags(" -Wl,--wrap=time ",{force = true})
add_ldflags(" -Wl,--wrap=SetUnilogUart", {force=true})

add_ldflags("--specs=nano.specs", {force=true})
add_asflags("-Wl,--cref -Wl,--check-sections -Wl,--gc-sections -lm -Wl,--print-memory-usage -Wl,--wrap=_malloc_r -Wl,--wrap=_free_r -Wl,--wrap=_realloc_r  -mcpu=cortex-m3 -mthumb -DTRACE_LEVEL=5 -DSOFTPACK_VERSION=\"\" -DHAVE_STRUCT_TIMESPEC")

add_defines("sprintf=sprintf_")
add_defines("snprintf=snprintf_")
add_defines("vsnprintf=vsnprintf_")

-- ==============================
-- === includes =====

add_includedirs(
                SDK_TOP .. "/PLAT/device/target/board/common/ARMCM3/inc",
                SDK_TOP .. "/PLAT/device/target/board/ec618_0h00/common/inc",
                SDK_TOP .. "/PLAT/device/target/board/ec618_0h00/ap/gcc",
                SDK_TOP .. "/PLAT/device/target/board/ec618_0h00/ap/inc",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/audio",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera/bf30a2",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera/gc6153",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera/gc032A",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera/gc6123",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera/sp0A39",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/camera/sp0821",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/eeprom",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/lcd",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/lcd/ST7571",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/lcd/ST7789V2",
                SDK_TOP .. "/PLAT/driver/board/ec618_0h00/inc/ntc",
                SDK_TOP .. "/PLAT/driver/chip/ec618/ap/inc",
                SDK_TOP .. "/PLAT/driver/chip/ec618/ap/inc_cmsis",
                SDK_TOP .. "/PLAT/driver/hal/common/inc",
                SDK_TOP .. "/PLAT/driver/hal/ec618/ap/inc",
                SDK_TOP .. "/PLAT/os/freertos/inc",
                SDK_TOP .. "/PLAT/os/freertos/CMSIS/common/inc",
                SDK_TOP .. "/PLAT/os/freertos/CMSIS/ap/inc",
                SDK_TOP .. "/PLAT/os/freertos/portable/mem/tlsf",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/PLAT/middleware/developed/debug/inc",
                SDK_TOP .. "/PLAT/middleware/developed/nvram/inc",
                SDK_TOP .. "/PLAT/middleware/developed/cms/psdial/inc",
                SDK_TOP .. "/PLAT/middleware/developed/cms/cms/inc",
                SDK_TOP .. "/PLAT/middleware/developed/cms/psil/inc",
                SDK_TOP .. "/PLAT/middleware/developed/cms/psstk/inc",
                SDK_TOP .. "/PLAT/middleware/developed/cms/sockmgr/inc",
                SDK_TOP .. "/PLAT/middleware/developed/cms/cmsnetlight/inc",
                SDK_TOP .. "/PLAT/middleware/developed/ecapi/appmwapi/inc",
                SDK_TOP .. "/PLAT/middleware/developed/ecapi/psapi/inc",
                SDK_TOP .. "/PLAT/middleware/developed/common/inc",
                SDK_TOP .. "/PLAT/middleware/developed/psnv/inc",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/PLAT/middleware/developed/tcpipmgr/app/inc",
                SDK_TOP .. "/PLAT/middleware/developed/tcpipmgr/common/inc",
                SDK_TOP .. "/PLAT/os/freertos/inc",
                SDK_TOP .. "/PLAT/middleware/developed/yrcompress",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/PLAT/prebuild/PS/inc",
                SDK_TOP .. "/PLAT/middleware/thirdparty/lwip/src/include",
                SDK_TOP .. "/PLAT/middleware/thirdparty/lwip/src/include/lwip",
                SDK_TOP .. "/PLAT/middleware/developed/ccio/pub",
                SDK_TOP .. "/PLAT/middleware/developed/ccio/device/inc",
                SDK_TOP .. "/PLAT/middleware/developed/ccio/service/inc",
                SDK_TOP .. "/PLAT/middleware/developed/ccio/custom/inc",
                SDK_TOP .. "/PLAT/middleware/developed/fota/pub",
                SDK_TOP .. "/PLAT/middleware/developed/fota/custom/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atdecoder/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atps/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atps/inc/cnfind",
                SDK_TOP .. "/PLAT/middleware/developed/at/atcust/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atcust/inc/cnfind",
                SDK_TOP .. "/PLAT/middleware/developed/at/atentity/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atreply/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atref/inc",
                SDK_TOP .. "/PLAT/middleware/developed/at/atref/inc/cnfind",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/thirdparty/httpclient",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/PLAT/middleware/thirdparty/lwip/src/include",
                SDK_TOP .. "/PLAT/middleware/thirdparty/lwip/src/include/posix",
                SDK_TOP .. "/PLAT/os/freertos/inc",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/thirdparty/littlefs",
                SDK_TOP .. "/thirdparty/littlefs/port",
                SDK_TOP .. "/PLAT/os/freertos/portable/gcc",
                SDK_TOP .. "/PLAT/prebuild/PS/inc",
                SDK_TOP .. "/PLAT/prebuild/PLAT/inc",
                SDK_TOP .. "/PLAT/core/common/include",
                SDK_TOP .. "/PLAT/core/tts/include",
                SDK_TOP .. "/PLAT/core/multimedia/include",
                SDK_TOP .. "/PLAT/core/driver/include",
                SDK_TOP .. "/thirdparty/linksdk",
                SDK_TOP .. "/thirdparty/printf",
{public = true})

if USER_PROJECT_NAME ~= 'luatos' then
    add_defines("MBEDTLS_CONFIG_FILE=\"config_user_ssl.h\"")
    add_includedirs(SDK_TOP .. "/interface/include", 
                    SDK_TOP .. "/interface/base_include", 
                    SDK_TOP .. "/interface/private_include", 
                    SDK_TOP .. "/thirdparty/mbedtls/include",
                    SDK_TOP .. "/thirdparty/mbedtls/include/mbedtls",
                    SDK_TOP .. "/thirdparty/mbedtls/configs",
                    SDK_TOP .. "/thirdparty/fal/inc",
                    SDK_TOP .. "/thirdparty/flashdb/inc",
                    {public = true})
else
    add_defines("__LUATOS__","LWIP_NUM_SOCKETS=8")
    add_defines("MBEDTLS_CONFIG_FILE=\"mbedtls_ec618_config.h\"")
end
--linkflags
local LD_BASE_FLAGS = "-Wl,--cref -Wl,--check-sections -Wl,--gc-sections -lm -Wl,--print-memory-usage"
LD_BASE_FLAGS = LD_BASE_FLAGS .. " -L" .. SDK_TOP .. "/PLAT/device/target/board/ec618_0h00/ap/gcc/"
--LD_BASE_FLAGS = LD_BASE_FLAGS .. " -T" .. SDK_TOP .. "/PLAT/device/target/board/ec618_0h00/ap/gcc/ec618_0h00_flash.ld -Wl,-Map,$(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME.."_$(mode).map "
LD_BASE_FLAGS = LD_BASE_FLAGS .. " -T" .. SDK_TOP .. "/PLAT/core/ld/ec618_0h00_flash.ld -Wl,-Map,$(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME.."_$(mode).map "
LD_BASE_FLAGS = LD_BASE_FLAGS .. " -Wl,--wrap=_malloc_r -Wl,--wrap=_free_r -Wl,--wrap=_realloc_r  -mcpu=cortex-m3 -mthumb -DTRACE_LEVEL=5 -DSOFTPACK_VERSION=\"\" -DHAVE_STRUCT_TIMESPEC"
local LIB_BASE = SDK_TOP .. "/PLAT/libs/libstartup.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libcore_airm2m.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libfreertos.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libpsnv.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libtcpipmgr.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libyrcompress.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libmiddleware_ec.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/liblwip.a "
-- LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/libmbedtls.a "
-- LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/libs/liblfs.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PS/lib/gcc/lite/libps.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PS/lib/gcc/lite/libpsl1.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PS/lib/gcc/lite/libpsif.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libosa.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libmiddleware_ec_private.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libccio.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libdeltapatch.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libfota.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libdriver_private.a "
LIB_BASE = LIB_BASE .. SDK_TOP .. "/PLAT/prebuild/PLAT/lib/gcc/lite/libusb_private.a "
LIB_USER = ""

after_load(function (target)
    for _, sourcebatch in pairs(target:sourcebatches()) do
        if sourcebatch.sourcekind == "as" then -- only asm files
            for idx, objectfile in ipairs(sourcebatch.objectfiles) do
                sourcebatch.objectfiles[idx] = objectfile:gsub("%.S%.o", ".o")
            end
        end
        if sourcebatch.sourcekind == "cc" then -- only c files
            for idx, objectfile in ipairs(sourcebatch.objectfiles) do
                sourcebatch.objectfiles[idx] = objectfile:gsub("%.c%.o", ".o")
            end
        end
    end
end)

target("driver")
    set_kind("static")
    add_deps(USER_PROJECT_NAME)
	--driver
	add_files(SDK_TOP .. "/PLAT/driver/board/ec618_0h00/src/**.c",
                SDK_TOP .. "/PLAT/driver/chip/ec618/ap/**.c",
                SDK_TOP .. "/PLAT/driver/chip/ec618/common/gcc/memcpy-armv7m.S",
                SDK_TOP .. "/PLAT/driver/hal/**.c",
                SDK_TOP .. "/PLAT/core/speed/*.c"
    )
	
	remove_files(SDK_TOP .. "/PLAT/driver/board/ec618_0h00/src/camera/camAT.c",
				SDK_TOP.."/PLAT/driver/chip/ec618/ap/src/usb/usb_device/usb_bl_test.c",
				SDK_TOP.."/PLAT/driver/chip/ec618/ap/src_cmsis/bsp_lpusart_stub.c",
				SDK_TOP.."/PLAT/driver/chip/ec618/ap/src/tls.c",
                SDK_TOP.."/PLAT/driver/chip/ec618/ap/src_cmsis/bsp_spi.c"
	)

    set_targetdir("$(buildir)/libdriver_" .. USER_PROJECT_NAME)
target_end()

includes(USER_PROJECT_DIR)

target(USER_PROJECT_NAME..".elf")
	set_kind("binary")
    -- add_deps(USER_PROJECT_NAME)
    set_targetdir("$(buildir)/"..USER_PROJECT_NAME)
    add_deps("driver")
	-- if os.getenv("GCC_PATH") then
	-- 	LD_BASE_FLAGS = " --specs=nano.specs " .. LD_BASE_FLAGS
	-- end
    if USER_PROJECT_NAME ~= 'luatos' then
        add_files(SDK_TOP .. "interface/src/*.c",{public = true})
        add_files(SDK_TOP .. "interface/private_src/*.c",{public = true})
        add_files(SDK_TOP .. "thirdparty/mbedtls/library/*.c",{public = true})
        add_files(SDK_TOP .. "thirdparty/printf/*.c",{public = true})
    end

    if USER_PROJECT_NAME ~= 'luatos' then
        add_files(SDK_TOP.."/thirdparty/fal/src/*.c",{public = true})
        add_files(SDK_TOP.."/thirdparty/flashdb/src/*.c",{public = true})
    else
        remove_files(SDK_TOP .. "/interface/src/luat_kv_ec618.c"
	)
    end
    add_files(SDK_TOP .. "/thirdparty/littlefs/**.c",{public = true})

	add_ldflags(LD_BASE_FLAGS .. " -Wl,--whole-archive -Wl,--start-group " .. LIB_BASE .. LIB_USER .. " -Wl,--end-group -Wl,--no-whole-archive -Wl,--no-undefined -Wl,--no-print-map-discarded  -ldriver", {force=true})
	
    on_load(function (target)
        if USER_PROJECT_NAME == 'luatos' then
            local conf_data = io.readfile("$(projectdir)/project/luatos/inc/luat_conf_bsp.h")
            USER_PROJECT_NAME_VERSION = conf_data:match("#define LUAT_BSP_VERSION \"(%w+)\"")
            VM_64BIT = conf_data:find("\r#define LUAT_CONF_VM_64bit") or conf_data:find("\n#define LUAT_CONF_VM_64bit")
        end
    end)
    before_build(function(target)
        if os.getenv("GCC_PATH") then
            GCC_DIR = os.getenv("GCC_PATH").."/"
        else
            GCC_DIR = target:toolchains()[1]:sdkdir().."/"
        end
        if os.getenv("LSPD_MODE") == "enable" then
            FLAGS = "-DLOW_SPEED_SERVICE_ONLY"
        else
            FLAGS = ""
        end
        if USER_PROJECT_NAME == "luatos" then
            FLAGS = FLAGS .. " -D__LUATOS__"
        end
        os.exec(GCC_DIR .. "bin/arm-none-eabi-gcc -E " .. FLAGS .. " -I " .. SDK_PATH .. "/PLAT/device/target/board/ec618_0h00/common/inc" .. " -P " .. SDK_PATH .. "/PLAT/core/ld/ec618_0h00_flash.c" ..  " -o " .. SDK_PATH .. "/PLAT/core/ld/ec618_0h00_flash.ld")
    end)
	after_build(function(target)
		if os.getenv("GCC_PATH") then
			GCC_DIR = os.getenv("GCC_PATH").."/"
		else
			GCC_DIR = target:toolchains()[1]:sdkdir().."/"
		end
		OUT_PATH = SDK_PATH .. "/out/" ..USER_PROJECT_NAME
		if not os.exists(OUT_PATH) then
			os.mkdir(OUT_PATH)
		end
		os.exec(GCC_DIR .. "bin/arm-none-eabi-objcopy -O binary $(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".elf $(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".bin")
		-- io.writefile("$(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".list", os.iorun(GCC_DIR .. "bin/arm-none-eabi-objdump -h -S $(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".elf"))
		io.writefile("$(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".size", os.iorun(GCC_DIR .. "bin/arm-none-eabi-size $(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".elf"))
		-- io.cat("$(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".size")
		os.exec(GCC_DIR .. "bin/arm-none-eabi-objcopy -O binary $(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".elf $(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".bin")
		os.cp("$(buildir)/"..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".bin", "$(buildir)/"..USER_PROJECT_NAME.."/ap.bin")
        
        os.cp("$(buildir)/"..USER_PROJECT_NAME.."/*.bin", OUT_PATH)
		os.cp("$(buildir)/"..USER_PROJECT_NAME.."/*.map", OUT_PATH)
		os.cp("$(buildir)/"..USER_PROJECT_NAME.."/*.elf", OUT_PATH)
		os.cp("./PLAT/comdb.txt", OUT_PATH)

        ---------------------------------------------------------
        -------------- 这部分尚不能跨平台
        local cmd = "-M -input ./PLAT/tools/ap_bootloader.bin -addrname  BL_IMG_MERGE_ADDR -flashsize BOOTLOADER_FLASH_LOAD_SIZE -input $(buildir)/"..USER_PROJECT_NAME.."/ap.bin -addrname  AP_IMG_MERGE_ADDR -flashsize AP_FLASH_LOAD_SIZE -input ./PLAT/prebuild/FW/lib/cp-demo-flash.bin -addrname CP_IMG_MERGE_ADDR -flashsize CP_FLASH_LOAD_SIZE -def ./PLAT/device/target/board/ec618_0h00/common/inc/mem_map.h "
        if os.getenv("BINPKG_CROSS") then
            -- 准备自定义打包程序
            cmd = os.getenv("BINPKG_CROSS") .. cmd
        else
            cmd = "./PLAT/tools/fcelf.exe " .. cmd
		end
        cmd = cmd .. " -outfile " .. "./out/" ..USER_PROJECT_NAME.."/"..USER_PROJECT_NAME..".binpkg"
        -- 如果所在平台没有fcelf, 可注释掉下面的行, 没有binpkg生成. 
        -- 仍可使用其他工具继续刷机
        print("fcelf CMD --> ", cmd)
        os.exec(cmd)
        ---------------------------------------------------------

        if USER_PROJECT_NAME == 'luatos' then
            import("lib.detect.find_file")
            local path7z = nil
            if is_plat("windows") then
                path7z = "\"$(programdir)/winenv/bin/7z.exe\""
            elseif is_plat("linux") then
                path7z = find_file("7z", { "/usr/bin/"})
                if not path7z then
                    path7z = find_file("7zr", { "/usr/bin/"})
                end
            end
            if path7z then
                os.cp("$(projectdir)/project/luatos/pack", OUT_PATH)
                if VM_64BIT then
                    import("core.base.json")
                    local info_table = json.loadfile(OUT_PATH.."/pack/info.json")
                    info_table["script"]["bitw"] = 64
                    json.savefile(OUT_PATH.."/pack/info.json", info_table)
                end
                os.cp(OUT_PATH.."/luatos.binpkg", OUT_PATH.."/pack")
                os.cp(OUT_PATH.."/luatos.elf", OUT_PATH.."/pack")
                os.cp("./PLAT/comdb.txt", OUT_PATH.."/pack")
                os.cp("$(projectdir)/project/luatos/inc/luat_conf_bsp.h", OUT_PATH.."/pack")
                os.exec(path7z.." a -mx9 LuatOS-SoC_"..USER_PROJECT_NAME_VERSION.."_EC618.7z "..OUT_PATH.."/pack/* -r")
                os.mv("LuatOS-SoC_"..USER_PROJECT_NAME_VERSION.."_EC618.7z", OUT_PATH.."/LuatOS-SoC_"..USER_PROJECT_NAME_VERSION.."_EC618.soc")
                os.rm(OUT_PATH.."/pack")
            else
                print("7z not find")
                return
            end
        end
	end)
target_end()
