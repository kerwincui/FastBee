
#ifndef MEM_MAP_H
#define MEM_MAP_H


/*
AP flash layout, toatl 4MB
flash raw address: 0x00000000---0x00400000
flash xip address(from ap view): 0x00800000---0x00c00000


0x00000000          |---------------------------------|
                    |      header1 8KB                |
0x00002000          |---------------------------------|
                    |      header2 8KB                |
0x00004000          |---------------------------------|
                    |      bl part1 32KB              |
0x0000c000          |---------------------------------|
                    |      bl part2 96KB              |------OTA write
0x00024000          |---------------------------------|
                    |      app img 2.5MB              |------OTA write
0x002a4000          |---------------------------------|
                    |      resv1 384KB                |
0x00304000          |---------------------------------|
                    |      fota 512KB                 |-----OTA download write
0x00384000          |---------------------------------|
                    |      lfs 288KB                  |-----FS write
0x003cc000          |---------------------------------|
                    |      softsim 64KB               |-----SOFTSIM write
0x003dc000          |---------------------------------|
                    |      rel_ap(factory) 16KB       |-----factory write
0x003e0000          |---------------------------------|
                    |      rel_ap 16KB                |-----factory write
0x003e4000          |---------------------------------|
                    |      hib backup 96KB            |-----hib write
0x003fc000          |---------------------------------|
                    |      plat config 16KB           |-----similar as FS
0x00400000          |---------------------------------|





CP flash layout, toatl 1MB
flash raw address: 0x00000000---0x00100000
flash xip address(from cp view): 0x00800000---0x00900000
flash xip address(from ap view): 0x08800000---0x08900000

0x00000000          |---------------------------------|
                    |      cp img 512KB               |
0x00064000          |---------------------------------|
                    |      resv 308KB                 |
0x000cd000          |---------------------------------|
                    |      IP2  4KB                   |
0x000ce000          |---------------------------------|
                    |      rel_cp(default) 100KB      |
0x000e7000          |---------------------------------|
                    |      rel_ap 100KB               |
0x00100000          |---------------------------------|


*/

/* -------------------------------flash  address define-------------------------*/

#define AP_VIEW_CPFLASH_XIP_ADDR        (0x08800000)


#define AP_FLASH_XIP_ADDR               (0x00800000)

//bl addr and size
#define BOOTLOADER_FLASH_LOAD_ADDR      (0x00804000)
#ifdef __USER_CODE__
#define BOOTLOADER_FLASH_LOAD_SIZE      (0x1e000)//120kB
#else
#define BOOTLOADER_FLASH_LOAD_SIZE      (0x20000)//128kB
#endif
//ap image addr and size
#define AP_FLASH_LOAD_ADDR              (0x00824000)
#ifdef __USER_CODE__
#define AP_FLASH_LOAD_SIZE              (0x2E0000)//2.5MB + 384KB
#else
#define AP_FLASH_LOAD_SIZE              (0x280000)//2.5MB
#endif

/*0x002a4000 -----0x00304000 RESERVRD 384KB*/

//fota addr and size
#define FLASH_FOTA_REGION_START         (0x304000)
#define FLASH_FOTA_REGION_LEN           (0x80000)//512KB
#define FLASH_FOTA_REGION_END           (0x384000)

#ifdef __USER_CODE__

//fs addr and size
#define FLASH_FS_REGION_START           (0x384000)
#define FLASH_FS_REGION_END             (0x3cc000)
#define FLASH_FS_REGION_SIZE            (FLASH_FS_REGION_END-FLASH_FS_REGION_START) // 352KB
#define FLASH_FDB_REGION_START			(0x3cc000)	//FDB 64KB
#define FLASH_FDB_REGION_END            (0x3dc000)
//softsim addr and size
#define SOFTSIM_FLASH_PHYSICAL_BASEADDR (0xfcc000)
#define SOFTSIM_FLASH_MAX_SIZE          (0x00000)//0KB
#else
#define FLASH_FS_REGION_START           (0x384000)
#define FLASH_FS_REGION_END             (0x3cc000)
#define FLASH_FS_REGION_SIZE            (FLASH_FS_REGION_END-FLASH_FS_REGION_START) // 288KB

//softsim addr and size
#define SOFTSIM_FLASH_PHYSICAL_BASEADDR (0x3cc000)
#define SOFTSIM_FLASH_MAX_SIZE          (0x10000)//64KB
#endif

//ap reliable addr and size
#define NVRAM_FACTORY_PHYSICAL_BASE     (0x3dc000)
#define NVRAM_FACTORY_PHYSICAL_SIZE     (0x4000)//16KB
#define NVRAM_PHYSICAL_BASE             (0x3e0000)
#define NVRAM_PHYSICAL_SIZE             (0x4000)//16KB


//hib bakcup addr and size
#define FLASH_MEM_BACKUP_ADDR           (AP_FLASH_XIP_ADDR+0x3e4000)
#define FLASH_MEM_BACKUP_NONXIP_ADDR    (FLASH_MEM_BACKUP_ADDR-AP_FLASH_XIP_ADDR)
#define FLASH_MEM_BLOCK_SIZE            (0x6000)
#define FLASH_MEM_BLOCK_CNT             (0x4)
#define FLASH_MEM_BACKUP_SIZE           (0x18000)//96KB

//plat config addr and size
#define FLASH_MEM_PLAT_INFO_ADDR        (AP_FLASH_XIP_ADDR+0x3fc000)
#define FLASH_MEM_PLAT_INFO_SIZE        (0x1000)//4KB
#define FLASH_MEM_PLAT_INFO_NONXIP_ADDR (FLASH_MEM_PLAT_INFO_ADDR - AP_FLASH_XIP_ADDR)

#define FLASH_MEM_RESET_INFO_ADDR        (AP_FLASH_XIP_ADDR+0x3fd000)
#define FLASH_MEM_RESET_INFO_SIZE        (0x1000)//4KB
#define FLASH_MEM_RESET_INFO_NONXIP_ADDR (FLASH_MEM_RESET_INFO_ADDR - AP_FLASH_XIP_ADDR)


#define CP_FLASH_XIP_ADDR               (0x00800000)

//cp img
#define CP_FLASH_LOAD_ADDR              (0x00800000)
#define CP_FLASH_LOAD_SIZE              (0x80000)//512KB

//for ramdump
#define CP_FLASH_RESV_ADDR              (0x00880000)
//#define CP_FLASH_RESV_PHYSICAL_ADDR     (0x80000)
#define CP_FLASH_RESV_SIZE              (0x4d000)//308KB
//#define CP_FLASH_RESV_NUM_SECTOR        (77)

#define FLASH_EXCEP_DUMP_ADDR           (0x80000)
#define FLASH_EXCEP_DUMP_SECTOR_NUM     (77)



#define CP_FLASH_IP2_ADDR               (0x008cd000)
#define CP_FLASH_IP2_SIZE               (0x1000)//4KB

//cp reliable addr and size, cp nvm write by ap
#define CP_NVRAM_FACTORY_PHYSICAL_BASE  (0xce000)
#define CP_NVRAM_FACTORY_PHYSICAL_SIZE  (0x19000)//100KB
#define CP_NVRAM_PHYSICAL_BASE          (0xe7000)
#define CP_NVRAM_PHYSICAL_SIZE          (0x19000)//100KB



//add for img merge tool,should fix as AP_xx/CP_xx/BL_xx, tool will extract img type from it
#define AP_IMG_MERGE_ADDR               (0x00024000)
#define CP_IMG_MERGE_ADDR               (0x00000000)
#define BL_IMG_MERGE_ADDR               (0x00004000)

#define BLS_SEC_HAED_ADDR               (0x0)
#define BLS_FLASH_LOAD_SIZE             (0x2000)
#define SYS_SEC_HAED_ADDR               (0x2000)
#define SYS_FLASH_LOAD_SIZE             (0x2000)




/* -----------ram address define, TODO: need modify according to ram lauout-------------*/

//csmb start
#define CSMB_START_ADDR                 (0x0)
#define CSMB_END_ADDR                   (0x10000)
#define CSMB_PHY_AONMEM_ADDR            (0xf000)
//csmb end


//msmb start

/*
0x00400000          |---------------------------------|
                    |      LOAD_AP_FIRAM_MSMB         |
                    |---------------------------------|
                    |      LOAD_APOS                  |
                    |---------------------------------|
                    |      LOAD_DRAM_BSP              |
                    |---------------------------------|
                    |      UNLOAD_SLPMEM              |
                    |---------------------------------|
                    |      LOAD_DRAM_SHARED           |
0x00500000          |---------------------------------|   <---MSMB_APMEM_END_ADDR   
                    |      LOAD_CP_FIRAM_MSMB         |
                    |---------------------------------|
                    |      LOAD_CPOS_IRAM             |
                    |---------------------------------|
                    |      UNLOAD_SLPMEM              |
                    |---------------------------------|
                    |      LOAD_CPDRAM_SHARED         |
                    |---------------------------------|
                    |      LOAD_CPDRAM_BSP            |
0x0053D000          |---------------------------------|   <---CP_AONMEMBACKUP_START_ADDR
                    |      UNLOAD_CPAON               |
0x0053E000          |---------------------------------|   <---XP_SHAREINFO_BASE_ADDR
                    |      LOAD_XP_SHAREDINFO         |
0x0053F000          |---------------------------------|   <---IPC_SHAREDMEM_START_ADDR
                    |      LOAD_XP_IPCMEM             |
0x00540000          |                                 |   <---MSMB_END_ADDR

*/

#define MSMB_START_ADDR                 (0x00400000)
#define MSMB_END_ADDR                   (0x00540000)
#define MSMB_APMEM_END_ADDR             (0x00500000)
#define MSMB_CPMEM_START_ADDR           (0x00500000)
#define MSMB_CPDATA_START_ADDR          (0x0052C000)
#define CP_AONMEMBACKUP_START_ADDR      (0x0053D000)
#define XP_SHAREINFO_BASE_ADDR          (0x0053E000)
#define XP_DBGRESERVED_BASE_ADDR        (0x0053EF00)
#define IPC_SHAREDMEM_START_ADDR        (0x0053F000)


//msmb end


//asmb start
/*
0x00000000          |---------------------------------|
                    |      bootcode                   |
0x00001000          |---------------------------------|
                    |      LOAD_AP_PIRAM_ASMB         |
                    |---------------------------------|
                    |      LOAD_AP_FIRAM_ASMB         |
0x0000C000          |---------------------------------|
                    |      LOAD_RRCMEM                |
0x0000D000          |---------------------------------|
                    |      LOAD_FLASHMEM              |
0x00010000          |---------------------------------|
*/
#define ASMB_START_ADDR                 (0x00000000)
#define ASMB_END_ADDR                   (0x00010000)
#define ASMB_IRAM_START_ADDR            (0x00001000)
#define ASMB_RRCMEM_START_ADDR          (0x0000C000)
#define ASMB_FLASHMEM_START_ADDR        (0x0000D000)
//asmb end

#ifdef LOW_SPEED_SERVICE_ONLY
#define min_heap_size_threshold 0x19000
#define up_buf_start 0x4c3500
#else
#define min_heap_size_threshold 0x20000
#define up_buf_start 0x499000
#endif

// TODO: need re-design excption dump



#endif
