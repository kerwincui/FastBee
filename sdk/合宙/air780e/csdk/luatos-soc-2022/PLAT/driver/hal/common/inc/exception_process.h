/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:exception_process.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/

#ifndef _EXCEPTION_PROCESS_H
#define _EXCEPTION_PROCESS_H
#include "cmsis_compiler.h"
#include "commontypedef.h"
#include "mem_map.h"


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/

#define EC_FUNC_CALL_ADDR_DEPTH         4
#define EC_ASSERT_FUNC_CALL_ADDR_DEPTH  4
#define EC_EXCEP_STACK_DEPTH            32
#define EC_EXCEP_SECTOR_SIZE            4096
#define EC_EXCEP_MAGIC_NUMBER           (0x00ec00ec)

#define EC_EXCEP_FLASH_SECTOR_BASE      EC_EXCEPTION_FLASH_BASE
#define EC_EXCEP_TASK_NAME_LEN          12

#define EC_SP_PSP_FLAG                  0x4

#define EC_REG_SYS_CTRL_STATE   (*(volatile unsigned int *) (0xE000ED24u))
#define EC_REG_MFSR             (*(volatile unsigned int *) (0xE000ED28u))
#define EC_REG_MMAR             (*(volatile unsigned int *) (0xE000ED34u))
#define EC_REG_BFSR             (*(volatile unsigned int *) (0xE000ED29u))
#define EC_REG_BFAR             (*(volatile unsigned int *) (0xE000ED38u))
#define EC_REG_UFSR             (*(volatile unsigned int *) (0xE000ED2Au))
#define EC_REG_HFSR             (*(volatile unsigned int *) (0xE000ED2Cu))
#define EC_REG_DFSR             (*(volatile unsigned int *) (0xE000ED30u))
#define EC_REG_AFSR             (*(volatile unsigned int *) (0xE000ED3Cu))

// magic number for fs assert indication "FS_Assert_sF", 12bytes/3 words 0x46535F41 0x73736572 0x745F7346
#define EC_FS_ASSERT_MAGIC_NUMBER0     (0x46535F41)
#define EC_FS_ASSERT_MAGIC_NUMBER1     (0x73736572)
#define EC_FS_ASSERT_MAGIC_NUMBER2     (0x745F7346)

#define EC_FS_ASSERT_REFORMAT_THRESHOLD     (10)

#define AT_PORT_UART_INSTANCE     (1)
#define RESET_REASON_MAGIC        (0xACD20E00)
#define RESET_REASON_MASK         (0xFFFFFF00)
#define ACTIVE_RESET_MAGIC        (0x5)
#define ACTIVE_RESET_MASK         (0xF)
#define FUNC_CALL_TRACE

#define EC_EXCEP_COMPRESS_SIZE            4096
#define EC_EXCEP_COMPRESS_HEAD_OFFSET     4

#define EC_AP_64K_RAM_START_ADDR                    0x000
#define EC_AP_64K_RAM_END_ADDR                      0x10000
#define EC_AP_64K_RAM_LEN                           (EC_AP_64K_RAM_END_ADDR - EC_AP_64K_RAM_START_ADDR)

#define EC_AP_125M_RAM_START_ADDR              0x400000
#define EC_AP_125M_RAM_END_ADDR                0x4B0000
#define EC_AP_125M_RAM_CODE_START_ADDR              0x400000
#define EC_AP_125M_RAM_CODE_END_ADDR                0x8000
#define EC_AP_125M_RAM_CODE_LEN                     (EC_AP_125M_RAM_CODE_END_ADDR - EC_AP_125M_RAM_CODE_START_ADDR)
#define EC_AP_125M_RAM_RW_START_ADDR           0x400000
#define EC_AP_125M_RAM_RW_END_ADDR             0x4B0000
#define EC_AP_125M_RAM_RW_LEN                  (EC_AP_125M_RAM_RW_END_ADDR - EC_AP_125M_RAM_RW_START_ADDR)

#define EC_CP_64K_RAM_START_ADDR                    0x200000
#define EC_CP_64K_RAM_END_ADDR                      0x210000
#define EC_CP_64K_RAM_LEN                           (EC_CP_64K_RAM_END_ADDR - EC_CP_64K_RAM_START_ADDR)
#define EC_CP_125M_RAM_START_ADDR              0x4B0000
#define EC_CP_125M_RAM_END_ADDR                0x4B0000
#define EC_CP_125M_RAM_CODE_START_ADDR              0x4B0000
#define EC_CP_125M_RAM_CODE_END_ADDR                0x4B0000
#define EC_CP_125M_RAM_CODE_LEN                     (EC_CP_125M_RAM_CODE_END_ADDR - EC_CP_125M_RAM_CODE_START_ADDR)
#define EC_CP_125M_RAM_RW_START_ADDR           0x4B0000
#define EC_CP_125M_RAM_RW_END_ADDR             0x4B0000
#define EC_CP_125M_RAM_RW_LEN                  (EC_CP_125M_RAM_RW_END_ADDR - EC_CP_125M_RAM_RW_START_ADDR)

#define EC_EXCEPTION_FLASH_BASE                   FLASH_EXCEP_DUMP_ADDR
#define EC_EXCEPTION_FLASH_BLOCK_NUMBS            FLASH_EXCEP_DUMP_SECTOR_NUM        // (420KB/105 sectors) 
#define EC_EXCEPTION_FLASH_MAX_LEN                (EC_EXCEPTION_FLASH_BLOCK_NUMBS*EC_EXCEP_COMPRESS_SIZE)        // (424KB) 

#define EC_EXCEPTION_AP_RAM_BASE            (0x00000)
#define EC_EXCEPTION_AP_RAM_END             (0x10000)
#define EC_EXCEPTION_AP_RAM_LEN             (EC_EXCEPTION_AP_RAM_END - EC_EXCEPTION_AP_RAM_BASE)

#define EC_EXCEPTION_CP_RAM_BASE            (0x200000)
#define EC_EXCEPTION_CP_RAM_END             (0x210000)
#define EC_EXCEPTION_CP_RAM_LEN             (EC_EXCEPTION_CP_RAM_END - EC_EXCEPTION_CP_RAM_BASE)

#define EC_EXCEPTION_APCP_RAM_BASE            (0x400000)
#define EC_EXCEPTION_APCP_RAM_END             (0x540000)
#define EC_EXCEPTION_APCP_RAM_LEN             (EC_EXCEPTION_APCP_RAM_END - EC_EXCEPTION_APCP_RAM_BASE)

#define EC_EXCEPTION_CP_SHARED_RAM_LEN        (0x14000)

#define EC_SHAREDINFO_RAM_END_ADDR            (0x53F000)

#define EC_ASSERT_PC_ADDR               (EC_SHAREDINFO_RAM_END_ADDR-0x20)         // 0x53EFE0
#define EC_ASSERT_LR_ADDR               (EC_SHAREDINFO_RAM_END_ADDR-0x18)         // 0x53EFE8
#define EC_EXCEPTION_MAGIC_AP_ADDR      (EC_SHAREDINFO_RAM_END_ADDR-0x10)         // 0x53EFF0
#define EC_EXCEPTION_MAGIC_CP_ADDR      (EC_SHAREDINFO_RAM_END_ADDR-0x0C)         // 0x53EFF4
#define EC_EXCEPTION_STORE_RAM_ADDR     (EC_SHAREDINFO_RAM_END_ADDR-0x8)          // 0x53EFF8

#define EC_COMPRESS_FLAG_AP_64K      "ec_comp_ap_64k"
#define EC_COMPRESS_FLAG_AP_125M     "ec_comp_ap_125m"
#define EC_COMPRESS_FLAG_CP_64K      "ec_comp_cp_64k"
#define EC_COMPRESS_FLAG_CP_125M     "ec_comp_cp_125m"

#define EC_COMPRESS_ADDR_AP_64K      "ec_comp_addr_ap:"
#define EC_COMPRESS_ADDR_CP_64K      "ec_comp_addr_cp:"
#define EC_COMPRESS_ADDR_125M        "ec_comp_addr_all:"
#define EC_COMPRESS_ADDR_AP_125M     "ec_comp_addr_share_ap:"
#define EC_COMPRESS_ADDR_CP_125M     "ec_comp_addr_share_cp:"

#define EC_AP_HARDFAULT_TASK_FLAG             0xAF012013
#define EC_AP_ASSERT_TASK_FLAG                0xAA012013
#define EC_AP_HARDFAULT_INT_FLAG              0xAF010129
#define EC_AP_ASSERT_INT_FLAG                 0xAA010129
#define EC_AP_HARDFAULT_SMALLIMAGE_FLAG       0xAF019527
#define EC_AP_ASSERT_SMALLIMAGE_FLAG          0xAA019527

#define EC_CP_HARDFAULT_TASK_FLAG             0xCF012013
#define EC_CP_ASSERT_TASK_FLAG                0xCA012013
#define EC_CP_HARDFAULT_INT_FLAG              0xCF010129
#define EC_CP_ASSERT_INT_FLAG                 0xCA010129
#define EC_CP_HARDFAULT_SMALLIMAGE_FLAG       0xCF019527
#define EC_CP_ASSERT_SMALLIMAGE_FLAG          0xCA019527

#define EC_EXCEP_TYPE_AP_TASK_HARDFAULT             EC_AP_HARDFAULT_TASK_FLAG
#define EC_EXCEP_TYPE_AP_TASK_ASSERT                EC_AP_ASSERT_TASK_FLAG
#define EC_EXCEP_TYPE_CP_TASK_HARDFAULT             EC_CP_HARDFAULT_TASK_FLAG
#define EC_EXCEP_TYPE_CP_TASK_ASSERT                EC_CP_ASSERT_TASK_FLAG
#define EC_EXCEP_TYPE_AP_INT_HARDFAULT              EC_AP_HARDFAULT_INT_FLAG
#define EC_EXCEP_TYPE_AP_INT_ASSERT                 EC_AP_ASSERT_INT_FLAG
#define EC_EXCEP_TYPE_CP_INT_HARDFAULT              EC_CP_HARDFAULT_INT_FLAG
#define EC_EXCEP_TYPE_CP_INT_ASSERT                 EC_CP_ASSERT_INT_FLAG
#define EC_EXCEP_TYPE_AP_SMALLIMAGE_HARDFAULT       EC_AP_HARDFAULT_SMALLIMAGE_FLAG
#define EC_EXCEP_TYPE_AP_SMALLIMAGE_ASSERT          EC_AP_ASSERT_SMALLIMAGE_FLAG
#define EC_EXCEP_TYPE_CP_SMALLIMAGE_HARDFAULT       EC_CP_HARDFAULT_SMALLIMAGE_FLAG
#define EC_EXCEP_TYPE_CP_SMALLIMAGE_ASSERT          EC_CP_ASSERT_SMALLIMAGE_FLAG

#define EC_EXCEPTION_START_FLAG      0xEC112013
#define EC_EXCEPTION_END_FLAG        0xEC990129

#define EC_EXCEP_ASSERT_BUFF_LEN        120

/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/

typedef struct ec_exception_comp_tag
{
    uint32_t needCompressAddr;
    uint32_t needCompressTotalLen;
    uint32_t needCompressOnceLen;
    uint32_t compressedBufAddr;
    uint32_t compressedBufLen;
    uint32_t writeFlashAddr;
    uint32_t compressType;
}ec_comp_input;

typedef struct ec_exception_data_tag
{
    UINT32 startAddr;
    UINT32 compressedLen;
}ec_exception_data;

typedef struct ec_exception_addr_tag
{
    uint32_t ap_ram_start_addr;
    uint32_t ap_ram_end_addr;
    uint32_t cp_ram_start_addr;
    uint32_t cp_ram_end_addr;
    uint32_t apcp_ram_start_addr;
    uint32_t apcp_ram_end_addr;
    
    uint32_t ec_stack_start_addr;
    uint32_t ec_stack_end_addr;
    uint32_t ec_code_start_addr;
    uint32_t ec_code_end_addr;
}ec_exception_addr;

typedef struct _ec_m3_exception_regs
{
    struct
    {
        uint32_t r0;
        uint32_t r1;
        uint32_t r2;
        uint32_t r3;
        uint32_t r4;
        uint32_t r5;
        uint32_t r6;
        uint32_t r7;
        uint32_t r8;
        uint32_t r9;
        uint32_t r10;
        uint32_t r11;
        uint32_t r12;
        uint32_t sp;
        uint32_t lr;
        uint32_t pc;
        union
        {
            uint32_t value;
            struct
            {
                uint32_t IPSR : 8;
                uint32_t EPSR : 8;
                uint32_t APSR : 8;
            }bits;
        }psr;
        uint32_t exc_return;
        uint32_t msp;
        uint32_t psp;
        uint32_t CONTROL;
        uint32_t BASEPRI;
        uint32_t PRIMASK;
        uint32_t FAULTMASK;
    }stack_frame;

    union
    {
        uint32_t value;
        struct
        {
            uint32_t MEM_FAULT_ACT      : 1;
            uint32_t BUS_FAULT_ACT      : 1;
            uint32_t UNUSED_BITS1       : 1;
            uint32_t USAGE_FAULT_ACT    : 1;
            uint32_t UNUSED_BITS2       : 3;
            uint32_t SVCALLACT          : 1;
            uint32_t MONITORACT         : 1;
            uint32_t UNUSED_BITS3       : 1;
            uint32_t PENDSVACT          : 1;
            uint32_t SYSTICKACT         : 1;
            uint32_t USAGEFAULTPENDED   : 1;
            uint32_t MEMFAULTPENDED     : 1;
            uint32_t BUSFAULTPENDED     : 1;
            uint32_t SVCALLPENDED       : 1;
            uint32_t MEMFAULT_EN        : 1;
            uint32_t BUSFAULT_EN        : 1;
            uint32_t USAGEFAULT_EN      : 1;
        }bits;
    }sys_ctrl_stat;

    union
    {
        uint8_t value;
        struct
        {
            uint8_t IACCVIOL    : 1;
            uint8_t DACCVIOL    : 1;
            uint8_t UNUSED_BIT  : 1;
            uint8_t MUNSTKERR   : 1;
            uint8_t MSTKERR     : 1;
            uint8_t MLSPERR     : 1;
            uint8_t UNUSED_BIT2 : 1;
            uint8_t MMARVALID   : 1;
        }bits;
    }mfsr;

    union
    {
        uint8_t value;
        struct
        {
            uint8_t IBUSERR     : 1;
            uint8_t PRECISEER   : 1;
            uint8_t IMPREISEER  : 1;
            uint8_t UNSTKERR    : 1;
            uint8_t STKERR      : 1;
            uint8_t LSPERR      : 1;
            uint8_t UNUSED_BIT  : 1;
            uint8_t BFARVALID   : 1;
        }bits;
    }bfsr;

    union
    {
        unsigned short value;
        struct
        {
            unsigned short UNDEFINSTR   : 1;
            unsigned short INVSTATE     : 1;
            unsigned short INVPC        : 1;
            unsigned short NOCP         : 1;
            unsigned short UNUSED_BITS  : 4;
            unsigned short UNALIGNED    : 1;
            unsigned short DIVBYZERO    : 1;
        }bits;
    }ufsr;

    union
    {
        uint32_t value;
        struct
        {
            uint32_t UNUSED_BIT1    : 1;
            uint32_t VECTBL         : 1;
            uint32_t UNUSED_BIT2    : 28;
            uint32_t FORCED         : 1;
            uint32_t DEBUGEVT       : 1;
        }bits;
    }hfsr;

    union
    {
        uint32_t value;
        struct
        {
            uint32_t HALTED     : 1;
            uint32_t BKPT       : 1;
            uint32_t DWTTRAP    : 1;
            uint32_t VCATCH     : 1;
            uint32_t EXTERNAL   : 1;
        }bits;
    }dfsr;

    uint32_t mmfar;
    uint32_t bfar;
    uint32_t afar;
}ec_m3_exception_regs;

typedef struct _ec_exception_store
{
    uint32_t ec_start_flag;
    uint32_t ec_exception_flag;
    uint32_t ec_exception_count;
    ec_m3_exception_regs excep_regs;
    ec_exception_addr excep_addr;
    uint32_t func_call_stack[EC_FUNC_CALL_ADDR_DEPTH];
    uint32_t curr_time;
    uint32_t excep_step;
    uint8_t curr_task_name[EC_EXCEP_TASK_NAME_LEN];
    uint8_t ec_assert_buff[EC_EXCEP_ASSERT_BUFF_LEN];
    uint32_t ec_end_flag;
}ec_exception_store;

enum
{
    excep_r0   = 0,
    excep_r1   = 1,
    excep_r2   = 2,
    excep_r3   = 3,
    excep_r12  = 4,
    excep_lr   = 5,
    excep_pc   = 6,
    excep_psr  = 7,
};

typedef enum EXCEPTION_CONFIG_OPTION
{ 
    EXCEP_OPTION_DUMP_FLASH_EPAT_LOOP,      /*0 -- dump full exception info to flash and EPAT tool then trapped in endless loop(while(1))*/
    EXCEP_OPTION_PRINT_RESET,               /*print necessary exception info, and then reset*/   
    EXCEP_OPTION_DUMP_FLASH_RESET,          /*dump full exception info to flash, and then reset*/
    EXCEP_OPTION_DUMP_FLASH_EPAT_RESET,     /*dump full exception info to flash and EPAT tool, and then reset*/  
    EXCEP_OPTION_SILENT_RESET,              /*reset directly*/ 
    EXCEP_OPTION_DUMP_FLASH_EPAT_LOOP_AND_UART_HELP_DUMP = 10,      /*10 -- enable uart help dump and dump full exception info to flash and EPAT tool then trapped in endless loop(while(1))*/
    EXCEP_OPTION_DUMP_FLASH_EPAT_RESET_AND_UART_HELP_DUMP = 13,     /*13 -- enable uart help dump and dump full exception info to flash and EPAT tool, and then reset*/  
 
    EXCEP_OPTION_MAX

}ExcepConfigOp;

enum
{
    reg_r0   = 0,
    reg_r1,
    reg_r2,
    reg_r3,
    reg_r4,
    reg_r5,
    reg_r6,
    reg_r7,
    reg_r8,
    reg_r9,
    reg_r10,
    reg_r11,
    reg_r12,
    reg_sp,
    reg_lr,
    reg_pc,
};

typedef enum
{
    EC_RAM_COMP_NORMAL      = 0,
    EC_AP_64K_RAM_COMP      = 1,
    EC_AP_125M_RAM_COMP,
    EC_CP_64K_RAM_COMP,
    EC_CP_125M_RAM_COMP,
}ecRamCompType;

typedef enum
{
    EC_CORE_TYPE_AP      = 1,
    EC_CORE_TYPE_CP      = 2,
}ecCoreType;

typedef enum
{
    EC_CHIP_TYPE_EC616      = 0x616,
    EC_CHIP_TYPE_EC618      = 0x618,
}ecChipType;


/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
#if defined ( __CC_ARM )
extern unsigned int __current_pc(void);   // arm_cc used to get pc, it cannot get pc directly
extern unsigned int __current_sp(void);   // arm_cc used to get sp

#elif defined(__GNUC__)
void *__current_pc(void);
#endif

void ecRecordNodeInit(void);

void excepCheckFaultType(ec_m3_exception_regs *excep_regs);
void excepShowStackFrame(ec_m3_exception_regs *excep_regs);

extern void excepEcAssert(const char *func, uint32_t line, uint32_t v1, uint32_t v2, uint32_t v3);
void excepGetTaskInfo(void);
void excepCleanInExcephandler(void);
BOOL excepIsInExcephandler(void);
BOOL excepIsFsAssert(void);
BOOL excepDumpCheckPoint(uint8_t id);



#if defined ( __CC_ARM )
//extern __inline void ec_assert_regs(void);
extern  __INLINE __asm void ec_assert_regs(void);
extern void excepPrintAssertInfo(const char *func, uint32_t line, const char *file, uint32_t v1, uint32_t v2, uint32_t v3);
    #ifdef EC_ASSERT_FLAG
        #define EC_ASSERT(x,v1,v2,v3)    \
                            do {  \
                                    { \
                                        if((x) == 0) \
                                        { \
                                            ec_assert_regs(); \
                                            *((unsigned int *)EC_ASSERT_PC_ADDR) = __current_pc(); \
                                            *((unsigned int *)EC_ASSERT_LR_ADDR) = __GET_RETURN_ADDRESS(); \
                                            excepEcAssert(__FUNCTION__, __LINE__, (uint32_t)(v1),(uint32_t)(v2),(uint32_t)(v3)); \
                                            while(1); \
                                        }\
                                    } \
                            } while(0)
    #else
        #define EC_ASSERT(x,v1,v2,v3)    \
                            do {  \
                                    { \
                                        if((x) == 0) \
                                        { \
                                            printf("Assert, func:%s, file: %s, line: %d, val: 0x%x,0x%x,0x%x \r\n", __FUNCTION__, __FILE__, __LINE__, (uint32_t)(v1),(uint32_t)(v2),(uint32_t)(v3)); \
                                            __disable_irq();\
                                            while(1);\
                                        }\
                                    } \
                            } while(0)
    #endif

#elif defined(__GNUC__)
extern void ec_assert_regs(void);
#define EC_ASSERT(x,v1,v2,v3)    \
                                 do {  \
                                    { \
                                        if((x) == 0) \
                                        { \
                                            ec_assert_regs(); \
                                            excepEcAssert(__FUNCTION__, __LINE__, (uint32_t)(v1),(uint32_t)(v2),(uint32_t)(v3)); \
                                            while(1); \
                                        }\
                                    } \
                            } while(0)
#endif

#ifdef FEATURE_DUMP_CHECK
#define EXCEP_CHECK_POINT(ID)  excepDumpCheckPoint(ID)
#endif

#endif  /* _EXCEPTION_H */
