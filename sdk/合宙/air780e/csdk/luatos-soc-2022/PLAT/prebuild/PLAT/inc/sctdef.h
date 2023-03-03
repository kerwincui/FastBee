
#ifndef SCT_DEF_H
#define SCT_DEF_H


#ifndef RAM_BOOT_AP
#define RAM_BOOT_AP
#define RAM_BOOT_CODE      __attribute__((__section__(".ramBootCode")))
#endif


//boost power up speed clk init code
#define QSPI_XIPSTART_IN_AP_RAM        __attribute__((__section__(".XIPStartRamCode")))
// for plat use only, only used in bootloader for HW SHA256, since SCT could only access MSMB
// But this area should init by user
#define PLAT_BL_SCT_ZI __attribute__((__section__(".platBlSctZIData")))


// ap section define

// for ps use only, load before paging image, placed in asmb
#define PS_PA_RAMCODE __attribute__((__section__(".psPARamcode")))
// for ps use only, load before paging image, placed in msmb
#define PS_PM_RAMCODE __attribute__((__section__(".psPMRamcode")))
// for ps use only, load before full image, placed in asmb
#define PS_FA_RAMCODE __attribute__((__section__(".psFARamcode")))
// for ps use only, load before full image, placed in msmb
#define PS_FM_RAMCODE __attribute__((__section__(".psFMRamcode")))

// for plat use only, load before paging image, placed in asmb
#define PLAT_BOOT_RAMCODE_FLASHCLK __attribute__((__section__(".platBootRamcodeFCLK")))

// for plat use only, load before paging image, placed in asmb
#define PLAT_PA_RAMCODE __attribute__((__section__(".platPARamcode")))
// for plat use only, load before paging image, placed in msmb
#define PLAT_PM_RAMCODE __attribute__((__section__(".platPMRamcode")))
// for plat use only, load before full image, placed in asmb
#define PLAT_FA_RAMCODE __attribute__((__section__(".platFARamcode")))
// for plat use only, load before full image, placed in msmb
#define PLAT_FM_RAMCODE __attribute__((__section__(".platFMRamcode")))
// ram code to set flash clock
#define PLAT_PM_RAMCODE_FLASHCLK __attribute__((__section__(".platPMRamcodeFCLK")))

// data placed in asmb
#define PLAT_FA_ZI __attribute__((__section__(".platFAZIData")))
#define PLAT_FA_DATA __attribute__((__section__(".platFARWData")))

// rw and zi for ps use, init when fullimage start(only from hibernate and power on)
// never re-init if asmb not power off
#define PS_FA_ZI __attribute__((__section__(".psFAZIData")))
#define PS_FA_DATA __attribute__((__section__(".psFARWData")))

// up and down buffer
#define CAT_PSPHY_SHAREDATA __attribute__((__section__(".catShareBuf")))

// cp section define

// Most timing critical code, both used in paging&full image
// so need to copy from FLASH when wakeup from HIB
// NOTE: Paging&PreSync related CODE should only allocated to PHY_CODE_IN_CSMB0 or FLASH
#define CP_PLAT_CODE_IN_CSMB       __attribute__((__section__(".cpPlatCodeCsmb")))
// Most timing critical code, only used in full image
// TX/RA/CSI/ConnMeas/CDRX should be allocate to CSMB1 or MSMB1
// so NO need to copy from FLASH when wakeup from HIB(these code do not used in paging image)
#define CP_PLAT_CODE_IN_MSMB       __attribute__((__section__(".cpPlatCodeMsmb")))
#define CP_PLAT_CODE_IN_FLASH       __attribute__((__section__(".cpPlatCodeFlash")))


// OS related, all dynamic allocated data, other static global data
#define CP_PLAT_DATA_IN_MSMB        __attribute__((__section__(".cpPlatDataMsmb")))

#define CP_PLAT_DATA_IN_FLASH       __attribute__((__section__(".cpPlatDataFlash")))



#ifndef USED
#define USED      __attribute__((used))
#endif



#endif

