/**
 *****************************************************************************
 * @brief   Device Peripheral Access Layer Header File.
 *          This file contains all the peripheral register's definitions, bits
 *          definitions and memory mapping for EC618 chip.
 *
 * @file   ec618.h
 * @author
 * @date   12/Nov/2018
 *****************************************************************************
 *
 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
 * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
 * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
 * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
 * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
 *
 * <b>&copy; COPYRIGHT 2018 AirM2M Technologies Ltd.</b>
 *
 *****************************************************************************
 */

#ifndef EC618_H
#define EC618_H

#ifdef __cplusplus
 extern "C" {
#endif
#include "commontypedef.h"
//#include "ec618_addrComm.h"



/* Start of section using anonymous unions and disabling warnings  */
#if   defined (__CC_ARM)
  #pragma push
  #pragma anon_unions
#elif defined (__ICCARM__)
  #pragma language=extended
#elif defined(__ARMCC_VERSION) && (__ARMCC_VERSION >= 6010050)
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Wc11-extensions"
  #pragma clang diagnostic ignored "-Wreserved-id-macro"
#elif defined (__GNUC__)
  /* anonymous unions are enabled by default */
#elif defined (__TMS470__)
  /* anonymous unions are enabled by default */
#elif defined (__TASKING__)
  #pragma warning 586
#elif defined (__CSMC__)
  /* anonymous unions are enabled by default */
#else
  #warning Not supported compiler type
#endif

//#include "AP_Arm_Common.h"
/** @addtogroup Interrupt_number_definiton Interrupt Number Definition
  * @{
  */

#ifndef APIRQ_NUMBER_DEFINED
#define APIRQ_NUMBER_DEFINED

typedef enum IRQn
{
    /*  Cortex-M3 Processor Exceptions Numbers */
    NonMaskableInt_IRQn             = -14,      /**<  2 Non Maskable Interrupt */
    HardFault_IRQn                  = -13,      /**<  3 HardFault Interrupt */
    MemoryManagement_IRQn           = -12,      /**<  4 Memory Management Interrupt */
    BusFault_IRQn                   = -11,      /**<  5 Bus Fault Interrupt */
    UsageFault_IRQn                 = -10,      /**<  6 Usage Fault Interrupt */
    SVCall_IRQn                     =  -5,      /**< 11 SV Call Interrupt */
    DebugMonitor_IRQn               =  -4,      /**< 12 Debug Monitor Interrupt */
    PendSV_IRQn                     =  -2,      /**< 14 Pend SV Interrupt */
    SysTick_IRQn                    =  -1,      /**< 15 System Tick Interrupt */

    /* ARMCM3 Specific Interrupt Numbers  */
    PadWakeup0_IRQn                 =   0,      /**< Pad Wakeup0 Interrupt */
    PadWakeup1_IRQn                 =   1,      /**< Pad Wakeup1 Interrupt */
    PadWakeup2_IRQn                 =   2,      /**< Pad Wakeup2 Interrupt */
    PadWakeup3_IRQn                 =   3,      /**< Pad Wakeup3 Interrupt */
    PadWakeup4_IRQn                 =   4,      /**< Pad Wakeup4 Interrupt */
    PadWakeup5_IRQn                 =   5,      /**< Pad Wakeup5 Interrupt */
    LpuartWakeup_IRQn               =   6,      /**< Lpuart Wakeup Interrupt */
    LpusbWakeup_IRQn                =   7,      /**< Lpusb Wakeup Interrupt */
    PwrkeyWakeup_IRQn               =   8,      /**< Power Key Wakeup Interrupt */
    ChrgpadWakeup_IRQn              =   9,      /**< Charge Pad Wakeup Interrupt */
    RtcWakeup_IRQn                  =   10,     /**< RTC Wakeup Interrupt */
    Usb_IRQn                        =   11,     /**< USB Interrupt */
    APXIC0_Normal_IRQn              =   12,     /**< AP XIC0 Interrupt */
    APXIC1_Normal_IRQn              =   13,     /**< AP XIC1 Interrupt */
    APXIC2_Normal_IRQn              =   14,     /**< AP XIC2 Interrupt */
    APXIC3_Normal_IRQn              =   15,     /**< AP XIC3 Interrupt */

    /* AP XIC0 for IPC/APB  */
    PXIC0_OVF_IRQn                  =   32,     /**< SW or HW Error Interrupt */
    PXIC0_PM_VBAT_LOW_IRQn          =   33,     /**< SW or HW Error Interrupt */
    PXIC0_I2S1_IRQn                 =   34,     /**< I2S1 Interrupt */
    PXIC0_I2S0_IRQn                 =   35,     /**< I2S0 Interrupt */
    PXIC0_SSP1_IRQn                 =   36,     /**< SSP1 Interrupt */
    PXIC0_SSP0_IRQn                 =   37,     /**< SSP0 Interrupt */
    PXIC0_UART2_IRQn                =   38,     /**< UART2 Interrupt */
    PXIC0_UART1_IRQn                =   39,     /**< UART1 Interrupt */
    PXIC0_UART0_IRQn                =   40,     /**< UART0 Interrupt */
    PXIC0_LPUC_IRQn                 =   41,     /**< LPUC Interrupt */
    PXIC0_TIMER5_IRQn               =   42,     /**< TIMER5 Interrupt */
    PXIC0_TIMER4_IRQn               =   43,     /**< TIMER4 Interrupt */
    PXIC0_TIMER3_IRQn               =   44,     /**< TIMER3 Interrupt */
    PXIC0_TIMER2_IRQn               =   45,     /**< TIMER2 Interrupt */
    PXIC0_TIMER1_IRQn               =   46,     /**< TIMER1 Interrupt */
    PXIC0_TIMER0_IRQn               =   47,     /**< TIMER0 Interrupt */
    PXIC0_KPC_DIRECT_IRQn           =   48,     /**< KPC DIRECT Interrupt */
    PXIC0_KPC_KEYPAD_IRQn           =   49,     /**< KPC KEYPAD Interrupt */
    PXIC0_ONEW_IRQn                 =   50,     /**< ONEW Interrupt */
    PXIC0_I2C1_IRQn                 =   51,     /**< I2C1 Interrupt */
    PXIC0_I2C0_IRQn                 =   52,     /**< I2C0 Interrupt */
    PXIC0_USIM1_IRQn                =   53,     /**< USIM1 Interrupt */
    PXIC0_USIM0_IRQn                =   54,     /**< USIM0 Interrupt */
    PXIC0_UTFC_ERR_IRQn             =   55,     /**< UTFC ERR Interrupt */
    PXIC0_RESV1_IRQn                =   56,     /**< RESV Interrupt */
    PXIC0_RESV2_IRQn                =   57,     /**< RESV Interrupt */
    PXIC0_RESV3_IRQn                =   58,     /**< RESV Interrupt */
    PXIC0_USB_IRQn                  =   59,     /**< USB Interrupt */
    PXIC0_IPC_Merge_IRQn            =   60,     /**< IPC MERGE Interrupt */
    PXIC0_IPC_Alone1_IRQn           =   61,     /**< IPC ALONE1 Interrupt */
    PXIC0_IPC_Alone0_IRQn           =   62,     /**< IPC ALONE0 Interrupt */
    PXIC0_Sipc_IRQn                 =   63,     /**< IPC SIPC Interrupt */


    /* AP XIC1 for APB/AHB  */
    PXIC1_OVF_IRQn                  =   64,     /**< SW or HW Error Interrupt */
    PXIC1_CPMU_SLEEP_END_IRQn       =   65,     /**< CPMU SLEEP END Interrupt */
    PXIC1_CPMU_WAKEUP_END_IRQn      =   66,     /**< CPMU WAKEUP END Interrupt */
    PXIC1_CPMU_ASSIST_REQ_IRQn      =   67,     /**< CPMU ASSIST REQ Interrupt */
    PXIC1_CP_CPU_RST_REQ_IRQn       =   68,     /**< CP CPU RST REQ Interrupt */
    PXIC1_SCT_CH0_IRQn              =   69,     /**< SCT CH0 Interrupt */
    PXIC1_SCT_CH1_IRQn              =   70,     /**< SCT CH1 Interrupt */
    PXIC1_SCT_CH2_IRQn              =   71,     /**< SCT CH2 Interrupt */
    PXIC1_SCT_CH3_IRQn              =   72,     /**< SCT CH3 Interrupt */
    PXIC1_SCT_CH4_IRQn              =   73,     /**< SCT CH4 Interrupt */
    PXIC1_SCT_CH5_IRQn              =   74,     /**< SCT CH5 Interrupt */
    PXIC1_SCT_ERR_IRQn              =   75,     /**< SCT ERR Interrupt */
    PXIC1_TMU_BASECNT_CP_RT_IRQn    =   76,     /**< TMU BASECNT CP RT Interrupt */
    PXIC1_TMU_BASECNT_CP_BC_IRQn    =   77,     /**< TMU BASECNT CP BC Interrupt */
    PXIC1_TMU_BASECNT_AP_BC_IRQn    =   78,     /**< TMU BASECNT AP BC Interrupt */
    PXIC1_TMU_BASECNT_BC_LD_IRQn    =   79,     /**< TMU BASECNT BC LD Interrupt */
    PXIC1_TMU_CALCAL_LTCH_IRQn      =   80,     /**< TMU CALCAL LTCH Interrupt */
    PXIC1_RFFE_CP_IRQn              =   81,     /**< RFFE CP Interrupt */
    PXIC1_FUSE_FAIL_IRQn            =   82,     /**< FUSE FAIL Interrupt */
    PXIC1_FUSE_BURN_IRQn            =   83,     /**< FUSE BURN Interrupt */
    PXIC1_FUSE_READ_IRQn            =   84,     /**< FUSE READ Interrupt */
    PXIC1_DMA_AP_IRQn               =   85,     /**< DMA AP Interrupt */
    PXIC1_DMA_CP_IRQn               =   86,     /**< DMA CP Interrupt */
    PXIC1_DMA_MP_IRQn               =   87,     /**< DMA MP Interrupt */
    PXIC1_GPIO_IRQn                 =   88,     /**< GPIO Interrupt */
    PXIC1_TRNG_IRQn                 =   89,     /**< TRNG Interrupt */
    PXIC1_PSRAM_IRQn                =   90,     /**< PSRAM Interrupt */
    PXIC1_FLASH_IRQn                =   91,     /**< FLASH Interrupt */
    PXIC1_ULOG_ERR_IRQn             =   92,     /**< ULOG ERR Interrupt */
    PXIC1_ULOG_IRQn                 =   93,     /**< ULOG Interrupt */
    PXIC1_THM_HI_IRQn               =   94,     /**< THM HI Interrupt */
    PXIC1_AUXADC_IRQn               =   95,     /**< AUXADC Interrupt */

} IRQn_Type;

#endif

/**
  * @}
  */ /* end of group Interrupt_number_definiton */

/** @addtogroup Cortex_core_configuration Processor and Core Peripherals configuration
  * @{
  */

#define __CM3_REV                                0x0201U                        /**< Core revision r2p1 */
#define __MPU_PRESENT                            1U                             /**< MPU present */
#define __VTOR_PRESENT                           1U                             /**< VTOR present or not */
#define __NVIC_PRIO_BITS                         3U                             /**< Number of Bits used for Priority Levels */
#define __Vendor_SysTickConfig                   0U                             /**< Set to 1 if different SysTick Config is used */


#include "core_cm3.h"

#include "system_ec618.h"

/**
  * @}
  */ /* end of group Cortex_core_configuration */

/** @addtogroup Device_peripheral_access Device Peripheral Access
  * @{
  */


/** @addtogroup BASE_ADDR Peripheral instance base addresses
  * @{
  */

/**
  * @brief AP XIC base address
  *
  */
#define APXIC_BASE_ADDR                          ((unsigned int)0x40020000)

#define APXIC0_BASE_ADDR                         (APXIC_BASE_ADDR+0x0000)           /**< APXIC0(manage APB/IPC interrupt) base address */
#define APXIC1_BASE_ADDR                         (APXIC_BASE_ADDR+0x1000)           /**< APXIC1(manage AHB/APB interupt) base address */
#define APXIC2_BASE_ADDR                         (APXIC_BASE_ADDR+0x2000)           /**< APXIC2(manage ULDP interupt) base address */
#define APXIC3_BASE_ADDR                         (APXIC_BASE_ADDR+0x3000)           /**< APXIC3(manage USB interupt) base address */

/**
  * @brief AP APB base address
  *
  */
#define APB_AP_PERIPH_BASE                       ((unsigned int)0x4C000000)         /**< APB AP peripheral base address */
#define RMI_AP_PERIPH_BASE                       ((unsigned int)0x40000000)         /**< RMI AP peripheral base address */

/**
  * @brief CP APB base address
  *
  */
#define APB_CP_PERIPH_BASE                       ((unsigned int)0x5C000000)         /**< APB CP peripheral base address */
#define RMI_CP_PERIPH_BASE                       ((unsigned int)0x50000000)         /**< RMI CP peripheral base address */

/**
  * @brief MP APB base address
  *
  */
#define APB_MP_PERIPH_BASE                       ((unsigned int)0x4D000000)         /**< APB MP peripheral base address */



/**
  * @brief APB AP Address
  *
  */
#define AP_WDG_BASE_ADDR                         (APB_AP_PERIPH_BASE + 0x010000)    /**< AP WDG base address */
#define AP_TIMER0_BASE_ADDR                      (APB_AP_PERIPH_BASE + 0x020000)    /**< AP TIMER0 base address */
#define AP_TIMER1_BASE_ADDR                      (APB_AP_PERIPH_BASE + 0x021000)    /**< AP TIMER1 base address */
#define AP_TIMER2_BASE_ADDR                      (APB_AP_PERIPH_BASE + 0x022000)    /**< AP TIMER2 base address */
#define AP_TIMER3_BASE_ADDR                      (APB_AP_PERIPH_BASE + 0x023000)    /**< AP TIMER3 base address */
#define AP_TIMER4_BASE_ADDR                      (APB_AP_PERIPH_BASE + 0x024000)    /**< AP TIMER4 base address */
#define AP_TIMER5_BASE_ADDR                      (APB_AP_PERIPH_BASE + 0x025000)    /**< AP TIMER5 base address */
#define AP_IPC_BASE_ADDR                         (APB_AP_PERIPH_BASE + 0x030000)    /**< AP IPC base address */
#define AP_I2C0_BASE_ADDR                        (APB_AP_PERIPH_BASE + 0x060000)    /**< AP I2C0 base address */
#define AP_I2C1_BASE_ADDR                        (APB_AP_PERIPH_BASE + 0x061000)    /**< AP I2C1 base address */
#define AP_USIM0_BASE_ADDR                       (APB_AP_PERIPH_BASE + 0x070000)    /**< AP USIM0 base address */
#define AP_USIM1_BASE_ADDR                       (APB_AP_PERIPH_BASE + 0x071000)    /**< AP USIM1 base address */
#define AP_KPC_BASE_ADDR                         (APB_AP_PERIPH_BASE + 0x080000)    /**< AP KPC base address */
#define AP_ONEWIRE_BASE_ADDR                     (APB_AP_PERIPH_BASE + 0x090000)    /**< AP ONEWIRE base address */



/**
  * @brief APB MP Address
  *
  */
#define MP_GPR_BASE_ADDR                         (APB_MP_PERIPH_BASE + 0x000000)    /**< MP GPR base address */
#define MP_GPR_SC_BASE_ADDR                      (APB_MP_PERIPH_BASE + 0x000100)    /**< MP GPR SC base address */
#define MP_SIPC_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x010000)    /**< MP SIPC base address */
#define MP_AON_BASE_ADDR                         (APB_MP_PERIPH_BASE + 0x020000)    /**< MP AON base address */
#define MP_CPMU_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x030000)    /**< MP CPMU base address */
#define MP_PMDIG_BASE_ADDR                       (APB_MP_PERIPH_BASE + 0x040000)    /**< MP RFDIG base address */
#define MP_RFDIG_BASE_ADDR                       (APB_MP_PERIPH_BASE + 0x050000)    /**< MP RFDIG base address */
#define MP_PAD_BASE_ADDR                         (APB_MP_PERIPH_BASE + 0x060000)    /**< MP PAD base address */
#define MP_GPIO_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x070000)    /**< MP GPIO base address */
#define MP_FUSE_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x090000)    /**< MP FUSE base address */
#define MP_TRNG_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x0A0000)    /**< MP TRNG base address */
#define MP_USB_BASE_ADDR                         (APB_MP_PERIPH_BASE + 0x0B0000)    /**< MP USB base address */
#define MP_LPUART_BASE_ADDR                      (APB_MP_PERIPH_BASE + 0x100040)    /**< MP LPUART base address */
#define MP_UART0_BASE_ADDR                       (APB_MP_PERIPH_BASE + 0x110000)    /**< MP UART0 base address */
#define MP_UART1_BASE_ADDR                       (APB_MP_PERIPH_BASE + 0x111000)    /**< MP UART1 base address */
#define MP_UART2_BASE_ADDR                       (APB_MP_PERIPH_BASE + 0x112000)    /**< MP UART2 base address */
#define MP_SSP0_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x120000)    /**< MP SSP0 base address */
#define MP_SSP1_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x121000)    /**< MP SSP1 base address */
#define MP_I2S0_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x130000)    /**< MP I2S0 base address */
#define MP_I2S1_BASE_ADDR                        (APB_MP_PERIPH_BASE + 0x131000)    /**< MP I2S1 base address */
#define MP_DMA_BASE_ADDR                         (APB_MP_PERIPH_BASE + 0x1F0000)    /**< MP DMA base address */

#define LPUSARTAON_BASE_ADDR                     (MP_AON_BASE_ADDR + 0x000154)      /**< LPUSART AON base address */

/**
  * @}
  */ /* end of group BASE_ADDR */


/** @addtogroup ADC ADC(Analog-to-Digital converter)
  * @{
  */

/**
  * @brief ADC register layout typedef
  *
  */
typedef struct {
    __IO uint32_t CTRL;                          /**< ADC control Register,                         offset: 0x0 */
    __IO uint32_t CFG;                           /**< ADC configuration Register,                   offset: 0x4 */
    __IO uint32_t AIOCFG;                        /**< AIO configuration Register,                   offset: 0x8 */
    __I  uint32_t STATUS;                        /**< ADC status Register,                          offset: 0xC */
    __I  uint32_t RESULT;                        /**< ADC data result Register,                     offset: 0x10 */
} ADC_TypeDef;

/** @name CTRL - ADC_CTRL register */
/** @{ */
#define ADC_CTRL_RSTN_Pos                        (0)
#define ADC_CTRL_RSTN_Msk                        (0x1UL << ADC_CTRL_RSTN_Pos)

#define ADC_CTRL_EN_Pos                          (1)
#define ADC_CTRL_EN_Msk                          (0x1UL << ADC_CTRL_EN_Pos)

#define ADC_CTRL_LDO_EN_Pos                      (2)
#define ADC_CTRL_LDO_EN_Msk                      (0x1UL << ADC_CTRL_LDO_EN_Pos)
/** @} */

/** @name CFG - ADC_CFG register */
/** @{ */
#define ADC_CFG_WAIT_CTRL_Pos                    (1)
#define ADC_CFG_WAIT_CTRL_Msk                    (0x3UL << ADC_CFG_WAIT_CTRL_Pos)

#define ADC_CFG_OFFSET_CTRL_Pos                  (3)
#define ADC_CFG_OFFSET_CTRL_Msk                  (0x7UL << ADC_CFG_OFFSET_CTRL_Pos)

#define ADC_CFG_SAMPLE_AVG_Pos                   (6)
#define ADC_CFG_SAMPLE_AVG_Msk                   (0x1UL << ADC_CFG_SAMPLE_AVG_Pos)

#define ADC_CFG_CLKIN_DIV_Pos                    (7)
#define ADC_CFG_CLKIN_DIV_Msk                    (0x3UL << ADC_CFG_CLKIN_DIV_Pos)

#define ADC_CFG_VREF_BS_Pos                      (9)
#define ADC_CFG_VREF_BS_Msk                      (0x1UL << ADC_CFG_VREF_BS_Pos)

#define ADC_CFG_VREF_SEL_Pos                     (10)
#define ADC_CFG_VREF_SEL_Msk                     (0x7UL << ADC_CFG_VREF_SEL_Pos)

#define ADC_CFG_LDO_SEL_Pos                      (13)
#define ADC_CFG_LDO_SEL_Msk                      (0x7UL << ADC_CFG_LDO_SEL_Pos)

#define ADC_CFG_IBIAS_SEL_Pos                    (16)
#define ADC_CFG_IBIAS_SEL_Msk                    (0x3UL << ADC_CFG_IBIAS_SEL_Pos)
/** @} */

/** @name AIOCFG - ADC_AIOCFG register */
/** @{ */
#define ADC_AIOCFG_THM_SEL_Pos                   (0)
#define ADC_AIOCFG_THM_SEL_Msk                   (0x3UL << ADC_AIOCFG_THM_SEL_Pos)

#define ADC_AIOCFG_VBATSEN_RDIV_Pos              (2)
#define ADC_AIOCFG_VBATSEN_RDIV_Msk              (0x7UL << ADC_AIOCFG_VBATSEN_RDIV_Pos)

#define ADC_AIOCFG_RDIV_Pos                      (5)
#define ADC_AIOCFG_RDIV_Msk                      (0x7UL << ADC_AIOCFG_RDIV_Pos)

#define ADC_AIOCFG_RDIV_BYP_Pos                  (8)
#define ADC_AIOCFG_RDIV_BYP_Msk                  (0x1UL << ADC_AIOCFG_RDIV_BYP_Pos)

#define ADC_AIOCFG_THM_EN_Pos                    (9)
#define ADC_AIOCFG_THM_EN_Msk                    (0x1UL << ADC_AIOCFG_THM_EN_Pos)

#define ADC_AIOCFG_BATSENS_EN_Pos                (10)
#define ADC_AIOCFG_BATSENS_EN_Msk                (0x1UL << ADC_AIOCFG_BATSENS_EN_Pos)

#define ADC_AIOCFG_AIO4_EN_Pos                   (11)
#define ADC_AIOCFG_AIO4_EN_Msk                   (0x1UL << ADC_AIOCFG_AIO4_EN_Pos)

#define ADC_AIOCFG_AIO3_EN_Pos                   (12)
#define ADC_AIOCFG_AIO3_EN_Msk                   (0x1UL << ADC_AIOCFG_AIO3_EN_Pos)

#define ADC_AIOCFG_AIO2_EN_Pos                   (13)
#define ADC_AIOCFG_AIO2_EN_Msk                   (0x1UL << ADC_AIOCFG_AIO2_EN_Pos)

#define ADC_AIOCFG_AIO1_EN_Pos                   (14)
#define ADC_AIOCFG_AIO1_EN_Msk                   (0x1UL << ADC_AIOCFG_AIO1_EN_Pos)

#define ADC_AIOCFG_AIO4_NO_DIVR_EN_Pos           (15)
#define ADC_AIOCFG_AIO4_NO_DIVR_EN_Msk           (0x1UL << ADC_AIOCFG_AIO4_NO_DIVR_EN_Pos)

#define ADC_AIOCFG_AIO3_NO_DIVR_EN_Pos           (16)
#define ADC_AIOCFG_AIO3_NO_DIVR_EN_Msk           (0x1UL << ADC_AIOCFG_AIO3_NO_DIVR_EN_Pos)

#define ADC_AIOCFG_AIO2_NO_DIVR_EN_Pos           (17)
#define ADC_AIOCFG_AIO2_NO_DIVR_EN_Msk           (0x1UL << ADC_AIOCFG_AIO2_NO_DIVR_EN_Pos)

#define ADC_AIOCFG_AIO1_NO_DIVR_EN_Pos           (18)
#define ADC_AIOCFG_AIO1_NO_DIVR_EN_Msk           (0x1UL << ADC_AIOCFG_AIO1_NO_DIVR_EN_Pos)

#define ADC_AIOCFG_VREF2AIO1_EN_Pos              (19)
#define ADC_AIOCFG_VREF2AIO1_EN_Msk              (0x1UL << ADC_AIOCFG_VREF2AIO1_EN_Pos)
/** @} */

/** @name STATUS - ADC_STATUS register */
/** @{ */
#define ADC_STATUS_DATA_VALID_Pos                (0)
#define ADC_STATUS_DATA_VALID_Msk                (0x1UL << ADC_STATUS_DATA_VALID_Pos)
/** @} */

/** @name RESULT - ADC_RESULT register */
/** @{ */
#define ADC_RESULT_DATA_Pos                      (0)
#define ADC_RESULT_DATA_Msk                      (0xFFFUL << ADC_RESULT_DATA_Pos)
/** @} */

/** Peripheral ADC base pointer */
#define ADC_BASE_ADDR                            (MP_RFDIG_BASE_ADDR + 0x600)
#define ADC                                      ((ADC_TypeDef *)ADC_BASE_ADDR)

/**
  * @}
  */ /* end of group ADC */


/** @addtogroup GPIO GPIO
  * @{
  */

/**
  * @brief GPIO register layout typedef
  *
  */
typedef struct {
    __IO uint32_t DATA;                          /**< Data Input Register,                offset: 0x0 */
    __IO uint32_t DATAOUT;                       /**< Data Output Register,               offset: 0x4 */
         uint32_t RESERVED_0[2];
    __IO uint32_t OUTENSET;                      /**< Output Enable Set Register,         offset: 0x10 */
    __IO uint32_t OUTENCLR;                      /**< Output Enable Clear Register,       offset: 0x14 */
         uint32_t RESERVED_1[2];
    __IO uint32_t INTENSET;                      /**< Interrupt Enable Set Register,      offset: 0x20 */
    __IO uint32_t INTENCLR;                      /**< Interrupt Enable Clear Register,    offset: 0x24 */
    __IO uint32_t INTTYPESET;                    /**< Interrupt Type set Register,        offset: 0x28 */
    __IO uint32_t INTTYPECLR;                    /**< Interrupt Type Clear Register,      offset: 0x2C */
    __IO uint32_t INTPOLSET;                     /**< Interrupt Polarity Set Register,    offset: 0x30 */
    __IO uint32_t INTPOLCLR;                     /**< Interrupt Polarity Clear Register,  offset: 0x34 */
    __IO uint32_t INTSTATUS;                     /**< Interrupt Status Register,          offset: 0x38 */
         uint32_t RESERVED_3[241];
    __IO uint32_t MASKLOWBYTE[256];              /**< Lower Eight Bits Masked Access Register, array offset: 0x400, array step: 0x4 */
    __IO uint32_t MASKHIGHBYTE[256];             /**< Higher Eight Bits Masked Access Register, array offset: 0x800, array step: 0x4 */
} GPIO_TypeDef;

/** @name DATA - GPIO_DATA register */
/** @{ */
#define GPIO_DATA_DVAL_Pos                       (0)
#define GPIO_DATA_DVAL_Msk                       (0xFFFFUL << GPIO_DATA_DVAL_Pos)
/** @} */

/** @name DATAOUT - GPIO_DATAOUT register */
/** @{ */
#define GPIO_DATAOUT_DOVAL_Pos                   (0)
#define GPIO_DATAOUT_DOVAL_Msk                   (0xFFFFUL << GPIO_DATAOUT_DOVAL_Pos)
/** @} */

/** @name OUTENSET - GPIO_OUTENSET register */
/** @{ */
#define GPIO_OUTENSET_OEN_Pos                    (0)
#define GPIO_OUTENSET_OEN_Msk                    (0xFFFFUL << GPIO_OUTENSET_OEN_Pos)
/** @} */

/** @name OUTENCLR - GPIO_OUTENCLR register */
/** @{ */
#define GPIO_OUTENCLR_OCLR_Pos                   (0)
#define GPIO_OUTENCLR_OCLR_Msk                   (0xFFFFUL << GPIO_OUTENCLR_OCLR_Pos)
/** @} */

/** @name INTENSET - GPIO_INTENSET register */
/** @{ */
#define GPIO_INTENSET_INEN_Pos                   (0)
#define GPIO_INTENSET_INEN_Msk                   (0xFFFFUL << GPIO_INTENSET_INEN_Pos)
/** @} */

/** @name INTENCLR - GPIO_INTENCLR register */
/** @{ */
#define GPIO_INTENCLR_INCLR_Pos                  (0)
#define GPIO_INTENCLR_INCLR_Msk                  (0xFFFFUL << GPIO_INTENCLR_INCLR_Pos)
/** @} */

/** @name INTTYPESET - GPIO_INTTYPESET register */
/** @{ */
#define GPIO_INTTYPESET_INTYPE_Pos               (0)
#define GPIO_INTTYPESET_INTYPE_Msk               (0xFFFFUL << GPIO_INTTYPESET_INTYPE_Pos)
/** @} */

/** @name INTTYPECLR - GPIO_INTTYPECLR register */
/** @{ */
#define GPIO_INTTYPECLR_INTYPECLR_Pos            (0)
#define GPIO_INTTYPECLR_INTYPECLR_Msk            (0xFFFFUL << GPIO_INTTYPECLR_INTYPECLR_Pos)
/** @} */

/** @name INTPOLSET - GPIO_INTPOLSET register */
/** @{ */
#define GPIO_INTPOLSET_INPOL_Pos                 (0)
#define GPIO_INTPOLSET_INPOL_Msk                 (0xFFFFUL << GPIO_INTPOLSET_INPOL_Pos)
/** @} */

/** @name INTPOLCLR - GPIO_INTPOLCLR register */
/** @{ */
#define GPIO_INTPOLCLR_INPOLCLR_Pos              (0)
#define GPIO_INTPOLCLR_INPOLCLR_Msk              (0xFFFFUL << GPIO_INTPOLCLR_INPOLCLR_Pos)
/** @} */

/** @name INTSTATUS - GPIO_INTSTATUS register */
/** @{ */
#define GPIO_INTSTATUS_INSTAT_Pos                (0)
#define GPIO_INTSTATUS_INSTAT_Msk                (0xFFFFUL << GPIO_INTSTATUS_INSTAT_Pos)
/** @} */

/** @name MASKLOWBYTE - GPIO_MASKLOWBYTE N register */
/** @{ */
#define GPIO_MASKLOWBYTE_MASK_Pos                (0)
#define GPIO_MASKLOWBYTE_MASK_Msk                (0xFFFFUL << GPIO_MASKLOWBYTE_MASK_Pos)
/** @} */

/** @name MASKHIGHBYTE - GPIO_MASKHIGHBYTE N register */
/** @{ */
#define GPIO_MASKHIGHBYTE_MASK_Pos               (0)
#define GPIO_MASKHIGHBYTE_MASK_Msk               (0xFFFFUL << GPIO_MASKHIGHBYTE_MASK_Pos)
/** @} */

/** Peripheral GPIO0 base address */
#define GPIO0_BASE_ADDR                          (MP_GPIO_BASE_ADDR + 0x0000)

/** Peripheral GPIO0 base pointer */
#define GPIO_0                                   ((GPIO_TypeDef *) GPIO0_BASE_ADDR)

/** Peripheral GPIO1 base address */
#define GPIO1_BASE_ADDR                          (MP_GPIO_BASE_ADDR + 0x1000)

/** Peripheral GPIO1 base pointer */
#define GPIO_1                                   ((GPIO_TypeDef *) GPIO1_BASE_ADDR)

/** @brief GPIO peripheral instance number */
#define GPIO_INSTANCE_NUM                        (2)

/**
  * @}
  */ /* end of group ADC */


/** @addtogroup I2C I2C
  * @{
  */

/**
  * @brief I2C register layout typedef
  *
  */
typedef struct {
    __IO uint32_t MCR;                           /**< Main Control Register,           offset: 0x0 */
    __IO uint32_t SCR;                           /**< Secondary Control Register,      offset: 0x4 */
    __IO uint32_t SAR;                           /**< Slave Address Register,          offset: 0x8 */
    __IO uint32_t TPR;                           /**< Timing Parameter Register,       offset: 0xC */
    union{
    __IO uint32_t TDR;                           /**< Transmit Data Register,          offset: 0x10 */
    __IO uint32_t RDR;                           /**< Receive Data Register,           offset: 0x10 */
    };
    __IO uint32_t TOR;                           /**< Timeout Register,                offset: 0x14 */
    __IO uint32_t ISR;                           /**< Interrupt Status Register,       offset: 0x18 */
    __IO uint32_t IER;                           /**< Interrupt Enable Register,       offset: 0x1C */
    __IO uint32_t IMR;                           /**< Interrupt Mask Register,         offset: 0x20 */
    __IO uint32_t STR;                           /**< Status Register,                 offset: 0x24 */
    __IO uint32_t FSR;                           /**< FIFO Status Register,            offset: 0x28 */
} I2C_TypeDef;

/** @name MCR - I2C_MCR register */
/** @{ */
#define I2C_MCR_I2C_EN_Pos                       (0)
#define I2C_MCR_I2C_EN_Msk                       (0x1UL << I2C_MCR_I2C_EN_Pos)

#define I2C_MCR_DISABLE_SCL_STRETCH_Pos          (1)
#define I2C_MCR_DISABLE_SCL_STRETCH_Msk          (0x1UL << I2C_MCR_DISABLE_SCL_STRETCH_Pos)

#define I2C_MCR_START_BYTE_EN_Pos                (2)
#define I2C_MCR_START_BYTE_EN_Msk                (0x1UL << I2C_MCR_START_BYTE_EN_Pos)

#define I2C_MCR_CONTROL_MODE_Pos                 (3)
#define I2C_MCR_CONTROL_MODE_Msk                 (0x1UL << I2C_MCR_CONTROL_MODE_Pos)

#define I2C_MCR_TX_DMA_EN_Pos                    (4)
#define I2C_MCR_TX_DMA_EN_Msk                    (0x1UL << I2C_MCR_TX_DMA_EN_Pos)

#define I2C_MCR_RX_DMA_EN_Pos                    (5)
#define I2C_MCR_RX_DMA_EN_Msk                    (0x1UL << I2C_MCR_RX_DMA_EN_Pos)

#define I2C_MCR_AGGRESSIVE_MASTER_Pos            (6)
#define I2C_MCR_AGGRESSIVE_MASTER_Msk            (0x1UL << I2C_MCR_AGGRESSIVE_MASTER_Pos)

#define I2C_MCR_AUTOCG_EN_Pos                    (7)
#define I2C_MCR_AUTOCG_EN_Msk                    (0x1UL << I2C_MCR_AUTOCG_EN_Pos)

#define I2C_MCR_DISABLE_MASTER_Pos               (8)
#define I2C_MCR_DISABLE_MASTER_Msk               (0x1UL << I2C_MCR_DISABLE_MASTER_Pos)

#define I2C_MCR_TX_FIFO_THRESHOLD_Pos            (16)
#define I2C_MCR_TX_FIFO_THRESHOLD_Msk            (0xFUL << I2C_MCR_TX_FIFO_THRESHOLD_Pos)

#define I2C_MCR_RX_FIFO_THRESHOLD_Pos            (20)
#define I2C_MCR_RX_FIFO_THRESHOLD_Msk            (0xFUL << I2C_MCR_RX_FIFO_THRESHOLD_Pos)
/** @} */

/** @name SCR - I2C_SCR register */
/** @{ */
#define I2C_SCR_TARGET_SLAVE_ADDR_Pos            (0)
#define I2C_SCR_TARGET_SLAVE_ADDR_Msk            (0x3FFUL << I2C_SCR_TARGET_SLAVE_ADDR_Pos)

#define I2C_SCR_TARGET_SLAVE_ADDR_MODE_Pos       (13)
#define I2C_SCR_TARGET_SLAVE_ADDR_MODE_Msk       (0x1UL << I2C_SCR_TARGET_SLAVE_ADDR_MODE_Pos)

#define I2C_SCR_TARGET_RWN_Pos                   (14)
#define I2C_SCR_TARGET_RWN_Msk                   (0x1UL << I2C_SCR_TARGET_RWN_Pos)

#define I2C_SCR_START_Pos                        (15)
#define I2C_SCR_START_Msk                        (0x1UL << I2C_SCR_START_Pos)

#define I2C_SCR_RESTART_Pos                      (16)
#define I2C_SCR_RESTART_Msk                      (0x1UL << I2C_SCR_RESTART_Pos)

#define I2C_SCR_STOP_Pos                         (17)
#define I2C_SCR_STOP_Msk                         (0x1UL << I2C_SCR_STOP_Pos)

#define I2C_SCR_ACK_Pos                          (18)
#define I2C_SCR_ACK_Msk                          (0x1UL << I2C_SCR_ACK_Pos)

#define I2C_SCR_ACK_VALUE_Pos                    (19)
#define I2C_SCR_ACK_VALUE_Msk                    (0x1UL << I2C_SCR_ACK_VALUE_Pos)

#define I2C_SCR_FLUSH_TX_FIFO_Pos                (20)
#define I2C_SCR_FLUSH_TX_FIFO_Msk                (0x1UL << I2C_SCR_FLUSH_TX_FIFO_Pos)

#define I2C_SCR_FLUSH_RX_FIFO_Pos                (21)
#define I2C_SCR_FLUSH_RX_FIFO_Msk                (0x1UL << I2C_SCR_FLUSH_RX_FIFO_Pos)

#define I2C_SCR_BYTE_NUM_UNKNOWN_Pos             (22)
#define I2C_SCR_BYTE_NUM_UNKNOWN_Msk             (0x1UL << I2C_SCR_BYTE_NUM_UNKNOWN_Pos)

#define I2C_SCR_BYTE_NUM_Pos                     (23)
#define I2C_SCR_BYTE_NUM_Msk                     (0x1FFUL << I2C_SCR_BYTE_NUM_Pos)
/** @} */

/** @name SAR - I2C_SAR register */
/** @{ */
#define I2C_SAR_SLAVE_ADDR_Pos                   (0)
#define I2C_SAR_SLAVE_ADDR_Msk                   (0x3FFUL << I2C_SAR_SLAVE_ADDR_Pos)

#define I2C_SAR_SLAVE_ADDR_EN_Pos                (12)
#define I2C_SAR_SLAVE_ADDR_EN_Msk                (0x1UL << I2C_SAR_SLAVE_ADDR_EN_Pos)

#define I2C_SAR_SLAVE_ADDR_MODE_Pos              (13)
#define I2C_SAR_SLAVE_ADDR_MODE_Msk              (0x1UL << I2C_SAR_SLAVE_ADDR_MODE_Pos)

#define I2C_SAR_GENERAL_CALL_EN_Pos              (16)
#define I2C_SAR_GENERAL_CALL_EN_Msk              (0x1UL << I2C_SAR_GENERAL_CALL_EN_Pos)
/** @} */

/** @name TPR - I2C_TPR register */
/** @{ */
#define I2C_TPR_SCLL_Pos                         (0)
#define I2C_TPR_SCLL_Msk                         (0xFFUL << I2C_TPR_SCLL_Pos)

#define I2C_TPR_SCLH_Pos                         (8)
#define I2C_TPR_SCLH_Msk                         (0xFFUL << I2C_TPR_SCLH_Pos)

#define I2C_TPR_SDA_SETUP_TIME_Pos               (16)
#define I2C_TPR_SDA_SETUP_TIME_Msk               (0x7UL << I2C_TPR_SDA_SETUP_TIME_Pos)

#define I2C_TPR_SDA_HOLD_TIME_Pos                (20)
#define I2C_TPR_SDA_HOLD_TIME_Msk                (0x7UL << I2C_TPR_SDA_HOLD_TIME_Pos)

#define I2C_TPR_SPIKE_FILTER_CNUM_Pos            (24)
#define I2C_TPR_SPIKE_FILTER_CNUM_Msk            (0xFUL << I2C_TPR_SPIKE_FILTER_CNUM_Pos)
/** @} */

/** @name TDR - I2C_TDR register */
/** @{ */
#define I2C_TDR_TX_DATA_Pos                      (0)
#define I2C_TDR_TX_DATA_Msk                      (0xFFUL << I2C_TDR_TX_DATA_Pos)
/** @} */

/** @name RDR - I2C_RDR register */
/** @{ */
#define I2C_RDR_RX_DATA_Pos                      (0)
#define I2C_RDR_RX_DATA_Msk                      (0xFFUL << I2C_RDR_RX_DATA_Pos)
/** @} */

/** @name TOR - I2C_TOR register */
/** @{ */
#define I2C_TOR_WAIT_IDLE_TIMEOUT_TIME_Pos       (0)
#define I2C_TOR_WAIT_IDLE_TIMEOUT_TIME_Msk       (0x3FFUL << I2C_TOR_WAIT_IDLE_TIMEOUT_TIME_Pos)

#define I2C_TOR_SCL_STRETCH_TIMEOUT_TIME_Pos     (16)
#define I2C_TOR_SCL_STRETCH_TIMEOUT_TIME_Msk     (0x3FFUL << I2C_TOR_SCL_STRETCH_TIMEOUT_TIME_Pos)
/** @} */

/** @name ISR - I2C_ISR register */
/** @{ */
#define I2C_ISR_TX_FIFO_EMPTY_Pos                (0)
#define I2C_ISR_TX_FIFO_EMPTY_Msk                (0x1UL << I2C_ISR_TX_FIFO_EMPTY_Pos)

#define I2C_ISR_TX_FIFO_UNDERRUN_Pos             (1)
#define I2C_ISR_TX_FIFO_UNDERRUN_Msk             (0x1UL << I2C_ISR_TX_FIFO_UNDERRUN_Pos)

#define I2C_ISR_TX_FIFO_OVERFLOW_Pos             (2)
#define I2C_ISR_TX_FIFO_OVERFLOW_Msk             (0x1UL << I2C_ISR_TX_FIFO_OVERFLOW_Pos)

#define I2C_ISR_RX_FIFO_FULL_Pos                 (3)
#define I2C_ISR_RX_FIFO_FULL_Msk                 (0x1UL << I2C_ISR_RX_FIFO_FULL_Pos)

#define I2C_ISR_RX_FIFO_OVERFLOW_Pos             (4)
#define I2C_ISR_RX_FIFO_OVERFLOW_Msk             (0x1UL << I2C_ISR_RX_FIFO_OVERFLOW_Pos)

#define I2C_ISR_TX_ONE_DATA_Pos                  (5)
#define I2C_ISR_TX_ONE_DATA_Msk                  (0x1UL << I2C_ISR_TX_ONE_DATA_Pos)

#define I2C_ISR_RX_ONE_DATA_Pos                  (6)
#define I2C_ISR_RX_ONE_DATA_Msk                  (0x1UL << I2C_ISR_RX_ONE_DATA_Pos)

#define I2C_ISR_RX_NACK_Pos                      (7)
#define I2C_ISR_RX_NACK_Msk                      (0x1UL << I2C_ISR_RX_NACK_Pos)

#define I2C_ISR_SLAVE_ADDR_MATCHED_Pos           (8)
#define I2C_ISR_SLAVE_ADDR_MATCHED_Msk           (0x1UL << I2C_ISR_SLAVE_ADDR_MATCHED_Pos)

#define I2C_ISR_TRANSFER_DONE_Pos                (9)
#define I2C_ISR_TRANSFER_DONE_Msk                (0x1UL << I2C_ISR_TRANSFER_DONE_Pos)

#define I2C_ISR_DETECT_STOP_Pos                  (10)
#define I2C_ISR_DETECT_STOP_Msk                  (0x1UL << I2C_ISR_DETECT_STOP_Pos)

#define I2C_ISR_BUS_ERROR_Pos                    (11)
#define I2C_ISR_BUS_ERROR_Msk                    (0x1UL << I2C_ISR_BUS_ERROR_Pos)

#define I2C_ISR_ARBITRATATION_LOST_Pos           (12)
#define I2C_ISR_ARBITRATATION_LOST_Msk           (0x1UL << I2C_ISR_ARBITRATATION_LOST_Pos)

#define I2C_ISR_WAIT_TX_FIFO_Pos                 (13)
#define I2C_ISR_WAIT_TX_FIFO_Msk                 (0x1UL << I2C_ISR_WAIT_TX_FIFO_Pos)

#define I2C_ISR_WAIT_RX_FIFO_Pos                 (14)
#define I2C_ISR_WAIT_RX_FIFO_Msk                 (0x1UL << I2C_ISR_WAIT_RX_FIFO_Pos)

#define I2C_ISR_WAIT_FOR_BUS_IDLE_TIMEOUT_Pos    (15)
#define I2C_ISR_WAIT_FOR_BUS_IDLE_TIMEOUT_Msk    (0x1UL << I2C_ISR_WAIT_FOR_BUS_IDLE_TIMEOUT_Pos)

#define I2C_ISR_STRETCH_SCL_TIMEOUT_Pos          (16)
#define I2C_ISR_STRETCH_SCL_TIMEOUT_Msk          (0x1UL << I2C_ISR_STRETCH_SCL_TIMEOUT_Pos)

#define I2C_ISR_DEDICATE_POINT_Pos               (17)
#define I2C_ISR_DEDICATE_POINT_Msk               (0x1UL << I2C_ISR_DEDICATE_POINT_Pos)
/** @} */

/** @name IER - I2C_IER register */
/** @{ */
#define I2C_IER_TX_FIFO_EMPTY_Pos                (0)
#define I2C_IER_TX_FIFO_EMPTY_Msk                (0x1UL << I2C_IER_TX_FIFO_EMPTY_Pos)

#define I2C_IER_TX_FIFO_UNDERRUN_Pos             (1)
#define I2C_IER_TX_FIFO_UNDERRUN_Msk             (0x1UL << I2C_IER_TX_FIFO_UNDERRUN_Pos)

#define I2C_IER_TX_FIFO_OVERFLOW_Pos             (2)
#define I2C_IER_TX_FIFO_OVERFLOW_Msk             (0x1UL << I2C_IER_TX_FIFO_OVERFLOW_Pos)

#define I2C_IER_RX_FIFO_FULL_Pos                 (3)
#define I2C_IER_RX_FIFO_FULL_Msk                 (0x1UL << I2C_IER_RX_FIFO_FULL_Pos)

#define I2C_IER_RX_FIFO_OVERFLOW_Pos             (4)
#define I2C_IER_RX_FIFO_OVERFLOW_Msk             (0x1UL << I2C_IER_RX_FIFO_OVERFLOW_Pos)

#define I2C_IER_TX_ONE_DATA_Pos                  (5)
#define I2C_IER_TX_ONE_DATA_Msk                  (0x1UL << I2C_IER_TX_ONE_DATA_Pos)

#define I2C_IER_RX_ONE_DATA_Pos                  (6)
#define I2C_IER_RX_ONE_DATA_Msk                  (0x1UL << I2C_IER_RX_ONE_DATA_Pos)

#define I2C_IER_RX_NACK_Pos                      (7)
#define I2C_IER_RX_NACK_Msk                      (0x1UL << I2C_IER_RX_NACK_Pos)

#define I2C_IER_SLAVE_ADDR_MATCHED_Pos           (8)
#define I2C_IER_SLAVE_ADDR_MATCHED_Msk           (0x1UL << I2C_IER_SLAVE_ADDR_MATCHED_Pos)

#define I2C_IER_TRANSFER_DONE_Pos                (9)
#define I2C_IER_TRANSFER_DONE_Msk                (0x1UL << I2C_IER_TRANSFER_DONE_Pos)

#define I2C_IER_DETECT_STOP_Pos                  (10)
#define I2C_IER_DETECT_STOP_Msk                  (0x1UL << I2C_IER_DETECT_STOP_Pos)

#define I2C_IER_BUS_ERROR_Pos                    (11)
#define I2C_IER_BUS_ERROR_Msk                    (0x1UL << I2C_IER_BUS_ERROR_Pos)

#define I2C_IER_ARBITRATATION_LOST_Pos           (12)
#define I2C_IER_ARBITRATATION_LOST_Msk           (0x1UL << I2C_IER_ARBITRATATION_LOST_Pos)

#define I2C_IER_WAIT_TX_FIFO_Pos                 (13)
#define I2C_IER_WAIT_TX_FIFO_Msk                 (0x1UL << I2C_IER_WAIT_TX_FIFO_Pos)

#define I2C_IER_WAIT_RX_FIFO_Pos                 (14)
#define I2C_IER_WAIT_RX_FIFO_Msk                 (0x1UL << I2C_IER_WAIT_RX_FIFO_Pos)

#define I2C_IER_WAIT_FOR_BUS_IDLE_TIMEOUT_Pos    (15)
#define I2C_IER_WAIT_FOR_BUS_IDLE_TIMEOUT_Msk    (0x1UL << I2C_IER_WAIT_FOR_BUS_IDLE_TIMEOUT_Pos)

#define I2C_IER_STRETCH_SCL_TIMEOUT_Pos          (16)
#define I2C_IER_STRETCH_SCL_TIMEOUT_Msk          (0x1UL << I2C_IER_STRETCH_SCL_TIMEOUT_Pos)

#define I2C_IER_DEDICATE_POINT_Pos               (17)
#define I2C_IER_DEDICATE_POINT_Msk               (0x1UL << I2C_IER_DEDICATE_POINT_Pos)
/** @} */

/** @name IMR - I2C_IMR register */
/** @{ */
#define I2C_IMR_TX_FIFO_EMPTY_Pos                (0)
#define I2C_IMR_TX_FIFO_EMPTY_Msk                (0x1UL << I2C_IMR_TX_FIFO_EMPTY_Pos)

#define I2C_IMR_TX_FIFO_UNDERRUN_Pos             (1)
#define I2C_IMR_TX_FIFO_UNDERRUN_Msk             (0x1UL << I2C_IMR_TX_FIFO_UNDERRUN_Pos)

#define I2C_IMR_TX_FIFO_OVERFLOW_Pos             (2)
#define I2C_IMR_TX_FIFO_OVERFLOW_Msk             (0x1UL << I2C_IMR_TX_FIFO_OVERFLOW_Pos)

#define I2C_IMR_RX_FIFO_FULL_Pos                 (3)
#define I2C_IMR_RX_FIFO_FULL_Msk                 (0x1UL << I2C_IMR_RX_FIFO_FULL_Pos)

#define I2C_IMR_RX_FIFO_OVERFLOW_Pos             (4)
#define I2C_IMR_RX_FIFO_OVERFLOW_Msk             (0x1UL << I2C_IMR_RX_FIFO_OVERFLOW_Pos)

#define I2C_IMR_TX_ONE_DATA_Pos                  (5)
#define I2C_IMR_TX_ONE_DATA_Msk                  (0x1UL << I2C_IMR_TX_ONE_DATA_Pos)

#define I2C_IMR_RX_ONE_DATA_Pos                  (6)
#define I2C_IMR_RX_ONE_DATA_Msk                  (0x1UL << I2C_IMR_RX_ONE_DATA_Pos)

#define I2C_IMR_RX_NACK_Pos                      (7)
#define I2C_IMR_RX_NACK_Msk                      (0x1UL << I2C_IMR_RX_NACK_Pos)

#define I2C_IMR_SLAVE_ADDR_MATCHED_Pos           (8)
#define I2C_IMR_SLAVE_ADDR_MATCHED_Msk           (0x1UL << I2C_IMR_SLAVE_ADDR_MATCHED_Pos)

#define I2C_IMR_TRANSFER_DONE_Pos                (9)
#define I2C_IMR_TRANSFER_DONE_Msk                (0x1UL << I2C_IMR_TRANSFER_DONE_Pos)

#define I2C_IMR_DETECT_STOP_Pos                  (10)
#define I2C_IMR_DETECT_STOP_Msk                  (0x1UL << I2C_IMR_DETECT_STOP_Pos)

#define I2C_IMR_BUS_ERROR_Pos                    (11)
#define I2C_IMR_BUS_ERROR_Msk                    (0x1UL << I2C_IMR_BUS_ERROR_Pos)

#define I2C_IMR_ARBITRATATION_LOST_Pos           (12)
#define I2C_IMR_ARBITRATATION_LOST_Msk           (0x1UL << I2C_IMR_ARBITRATATION_LOST_Pos)

#define I2C_IMR_WAIT_TX_FIFO_Pos                 (13)
#define I2C_IMR_WAIT_TX_FIFO_Msk                 (0x1UL << I2C_IMR_WAIT_TX_FIFO_Pos)

#define I2C_IMR_WAIT_RX_FIFO_Pos                 (14)
#define I2C_IMR_WAIT_RX_FIFO_Msk                 (0x1UL << I2C_IMR_WAIT_RX_FIFO_Pos)

#define I2C_IMR_WAIT_FOR_BUS_IDLE_TIMEOUT_Pos    (15)
#define I2C_IMR_WAIT_FOR_BUS_IDLE_TIMEOUT_Msk    (0x1UL << I2C_IMR_WAIT_FOR_BUS_IDLE_TIMEOUT_Pos)

#define I2C_IMR_STRETCH_SCL_TIMEOUT_Pos          (16)
#define I2C_IMR_STRETCH_SCL_TIMEOUT_Msk          (0x1UL << I2C_IMR_STRETCH_SCL_TIMEOUT_Pos)

#define I2C_IMR_DEDICATE_POINT_Pos               (17)
#define I2C_IMR_DEDICATE_POINT_Msk               (0x1UL << I2C_IMR_DEDICATE_POINT_Pos)
/** @} */

/** @name STR - I2C_STR register */
/** @{ */
#define I2C_STR_BUSY_Pos                         (0)
#define I2C_STR_BUSY_Msk                         (0x1UL << I2C_STR_BUSY_Pos)

#define I2C_STR_ADDRESS_PHASE_Pos                (1)
#define I2C_STR_ADDRESS_PHASE_Msk                (0x1UL << I2C_STR_ADDRESS_PHASE_Pos)

#define I2C_STR_DATA_PHASE_Pos                   (2)
#define I2C_STR_DATA_PHASE_Msk                   (0x1UL << I2C_STR_DATA_PHASE_Pos)

#define I2C_STR_SLAVE_ADDRESSED_FLAG_Pos         (8)
#define I2C_STR_SLAVE_ADDRESSED_FLAG_Msk         (0x1UL << I2C_STR_SLAVE_ADDRESSED_FLAG_Pos)

#define I2C_STR_SLAVE_ADDRESSED_IND_Pos          (9)
#define I2C_STR_SLAVE_ADDRESSED_IND_Msk          (0x1UL << I2C_STR_SLAVE_ADDRESSED_IND_Pos)

#define I2C_STR_SLAVE_RWN_Pos                    (10)
#define I2C_STR_SLAVE_RWN_Msk                    (0x1UL << I2C_STR_SLAVE_RWN_Pos)

#define I2C_STR_TXRX_DATA_NUM_Pos                (16)
#define I2C_STR_TXRX_DATA_NUM_Msk                (0x1FFUL << I2C_STR_TXRX_DATA_NUM_Pos)
/** @} */

/** @name FSR - I2C_FSR register */
/** @{ */
#define I2C_FSR_TX_FIFO_FREE_NUM_Pos             (0)
#define I2C_FSR_TX_FIFO_FREE_NUM_Msk             (0x1FUL << I2C_FSR_TX_FIFO_FREE_NUM_Pos)

#define I2C_FSR_RX_FIFO_DATA_NUM_Pos             (8)
#define I2C_FSR_RX_FIFO_DATA_NUM_Msk             (0x1FUL << I2C_FSR_RX_FIFO_DATA_NUM_Pos)
/** @} */

/** Peripheral I2C0 base pointer */
#define I2C0                                     ((I2C_TypeDef *)AP_I2C0_BASE_ADDR)

/** Peripheral I2C1 base pointer */
#define I2C1                                     ((I2C_TypeDef *)AP_I2C1_BASE_ADDR)

/** @brief I2C peripheral instance number */
#define I2C_INSTANCE_NUM                         (2)

/**
  * @}
  */ /* end of group I2C */

/** @addtogroup I2S I2S
  * @{
  */

/**
  * @brief I2S register layout typedef
  *
  */
typedef struct {
    __IO uint32_t DFMT;                           /**< Data Format Register,                offset: 0x0 */
    __IO uint32_t SLOTCTL;                        /**< Slot Control Register,               offset: 0x4 */
    __IO uint32_t CLKCTL;                         /**< Clock Control Register,              offset: 0x8 */
    __IO uint32_t DMACTL;                         /**< DMA Control Register,                offset: 0xC */
    __IO uint32_t INTCTL;                         /**< Interrupt Control Register,          offset: 0x10 */
    __IO uint32_t TIMEOUTCTL;                     /**< Timeout Control Register,            offset: 0x14 */
    __IO uint32_t STAS;                           /**< Status Register,                     offset: 0x18 */
    __IO uint32_t RFIFO;                          /**< Rx Buffer Register,                  offset: 0x1c */
    __IO uint32_t TFIFO;                          /**< Tx Buffer Register,                  offset: 0x20 */
    __IO uint32_t I2SCTL;                         /**< I2S Control Register,                offset: 0x24 */
} I2S_TypeDef;

/** @name DFMT - I2S_DFMT register */
/** @{ */
#define I2S_DFMT_SLAVE_MODE_EN_Pos               (0)
#define I2S_DFMT_SLAVE_MODE_EN_Msk               (0x1UL << I2S_DFMT_SLAVE_MODE_EN_Pos)

#define I2S_DFMT_SLOT_SIZE_Pos                   (1)
#define I2S_DFMT_SLOT_SIZE_Msk                   (0x1FUL << I2S_DFMT_SLOT_SIZE_Pos)

#define I2S_DFMT_WORD_SIZE_Pos                   (6)
#define I2S_DFMT_WORD_SIZE_Msk                   (0x1FUL << I2S_DFMT_WORD_SIZE_Pos)

#define I2S_DFMT_ALIGN_MODE_Pos                  (11)
#define I2S_DFMT_ALIGN_MODE_Msk                  (0x1UL << I2S_DFMT_ALIGN_MODE_Pos)

#define I2S_DFMT_ENDIAN_MODE_Pos                 (12)
#define I2S_DFMT_ENDIAN_MODE_Msk                 (0x1UL << I2S_DFMT_ENDIAN_MODE_Pos)

#define I2S_DFMT_DATA_DLY_Pos                    (13)
#define I2S_DFMT_DATA_DLY_Msk                    (0x3UL << I2S_DFMT_DATA_DLY_Pos)

#define I2S_DFMT_TX_PAD_Pos                      (15)
#define I2S_DFMT_TX_PAD_Msk                      (0x3UL << I2S_DFMT_TX_PAD_Pos)

#define I2S_DFMT_RX_SIGN_EXT_Pos                 (17)
#define I2S_DFMT_RX_SIGN_EXT_Msk                 (0x1UL << I2S_DFMT_RX_SIGN_EXT_Pos)

#define I2S_DFMT_TX_PACK_Pos                     (18)
#define I2S_DFMT_TX_PACK_Msk                     (0x3UL << I2S_DFMT_TX_PACK_Pos)

#define I2S_DFMT_RX_PACK_Pos                     (20)
#define I2S_DFMT_RX_PACK_Msk                     (0x3UL << I2S_DFMT_RX_PACK_Pos)

#define I2S_DFMT_TX_FIFO_ENDIAN_MODE_Pos         (22)
#define I2S_DFMT_TX_FIFO_ENDIAN_MODE_Msk         (0x1UL << I2S_DFMT_TX_FIFO_ENDIAN_MODE_Pos)

#define I2S_DFMT_RX_FIFO_ENDIAN_MODE_Pos         (23)
#define I2S_DFMT_RX_FIFO_ENDIAN_MODE_Msk         (0x1UL << I2S_DFMT_RX_FIFO_ENDIAN_MODE_Pos)
/** @} */

/** @name SLOTCTL - I2S_SLOTCTL register */
/** @{ */
#define I2S_SLOTCTL_SLOT_EN_Pos                  (0)
#define I2S_SLOTCTL_SLOT_EN_Msk                  (0xFFUL << I2S_SLOTCTL_SLOT_EN_Pos)

#define I2S_SLOTCTL_SLOT_NUM_Pos                 (8)
#define I2S_SLOTCTL_SLOT_NUM_Msk                 (0x7UL << I2S_SLOTCTL_SLOT_NUM_Pos)
/** @} */

/** @name CLKCTL - I2S_CLKCTL register */
/** @{ */
#define I2S_CLKCTL_BCLK_POLARITY_Pos             (0)
#define I2S_CLKCTL_BCLK_POLARITY_Msk             (0x1UL << I2S_CLKCTL_BCLK_POLARITY_Pos)

#define I2S_CLKCTL_FS_POLARITY_Pos               (1)
#define I2S_CLKCTL_FS_POLARITY_Msk               (0x1UL << I2S_CLKCTL_FS_POLARITY_Pos)

#define I2S_CLKCTL_FS_WIDTH_Pos                  (2)
#define I2S_CLKCTL_FS_WIDTH_Msk                  (0x3FUL << I2S_CLKCTL_FS_WIDTH_Pos)
/** @} */

/** @name DMA_CTRL - I2S_DMA_CTRL register */
/** @{ */
#define I2S_DMA_CTRL_RX_DMA_REQ_EN_Pos           (0)
#define I2S_DMA_CTRL_RX_DMA_REQ_EN_Msk           (0x1UL << I2S_DMA_CTRL_RX_DMA_REQ_EN_Pos)

#define I2S_DMA_CTRL_TX_DMA_REQ_EN_Pos           (1)
#define I2S_DMA_CTRL_TX_DMA_REQ_EN_Msk           (0x1UL << I2S_DMA_CTRL_TX_DMA_REQ_EN_Pos)

#define I2S_DMA_CTRL_RX_DMA_TIMEOUT_EN_Pos       (2)
#define I2S_DMA_CTRL_RX_DMA_TIMEOUT_EN_Msk       (0x1UL << I2S_DMA_CTRL_RX_DMA_TIMEOUT_EN_Pos)

#define I2S_DMA_CTRL_DMA_WORK_WAIT_CYCLE_Pos     (3)
#define I2S_DMA_CTRL_DMA_WORK_WAIT_CYCLE_Msk     (0x1FUL << I2S_DMA_CTRL_DMA_WORK_WAIT_CYCLE_Pos)

#define I2S_DMA_CTRL_RX_DMA_BURST_SIZE_SUB1_Pos  (8)
#define I2S_DMA_CTRL_RX_DMA_BURST_SIZE_SUB1_Msk  (0xFUL << I2S_DMA_CTRL_RX_DMA_BURST_SIZE_SUB1_Pos)

#define I2S_DMA_CTRL_TX_DMA_BURST_SIZE_SUB1_Pos  (12)
#define I2S_DMA_CTRL_TX_DMA_BURST_SIZE_SUB1_Msk  (0xFUL << I2S_DMA_CTRL_TX_DMA_BURST_SIZE_SUB1_Pos)

#define I2S_DMA_CTRL_RX_DMA_THRESHOLD_Pos        (16)
#define I2S_DMA_CTRL_RX_DMA_THRESHOLD_Msk        (0xFUL << I2S_DMA_CTRL_RX_DMA_THRESHOLD_Pos)

#define I2S_DMA_CTRL_TX_DMA_THRESHOLD_Pos        (20)
#define I2S_DMA_CTRL_TX_DMA_THRESHOLD_Msk        (0xFUL << I2S_DMA_CTRL_TX_DMA_THRESHOLD_Pos)

#define I2S_DMA_CTRL_RX_FIFO_FLUSH_Pos           (24)
#define I2S_DMA_CTRL_RX_FIFO_FLUSH_Msk           (0x1UL << I2S_DMA_CTRL_RX_FIFO_FLUSH_Pos)

#define I2S_DMA_CTRL_TX_FIFO_FLUSH_Pos           (25)
#define I2S_DMA_CTRL_TX_FIFO_FLUSH_Msk           (0x1UL << I2S_DMA_CTRL_TX_FIFO_FLUSH_Pos)
/** @} */


/** @name INT_CTRL - I2S_INT_CTRL register */
/** @{ */
#define I2S_INT_CTRL_TX_UNDERRUN_INT_EN_Pos      (0)
#define I2S_INT_CTRL_TX_UNDERRUN_INT_EN_Msk      (0x1UL << I2S_INT_CTRL_TX_UNDERRUN_INT_EN_Pos)

#define I2S_INT_CTRL_TX_DMA_ERR_INT_EN_Pos       (1)
#define I2S_INT_CTRL_TX_DMA_ERR_INT_EN_Msk       (0x1UL << I2S_INT_CTRL_TX_DMA_ERR_INT_EN_Pos)

#define I2S_INT_CTRL_TX_DAT_INT_EN_Pos           (2)
#define I2S_INT_CTRL_TX_DAT_INT_EN_Msk           (0x1UL << I2S_INT_CTRL_TX_DAT_INT_EN_Pos)

#define I2S_INT_CTRL_RX_OVERFLOW_INT_EN_Pos      (3)
#define I2S_INT_CTRL_RX_OVERFLOW_INT_EN_Msk      (0x1UL << I2S_INT_CTRL_RX_OVERFLOW_INT_EN_Pos)

#define I2S_INT_CTRL_RX_DMA_ERR_INT_EN_Pos       (4)
#define I2S_INT_CTRL_RX_DMA_ERR_INT_EN_Msk       (0x1UL << I2S_INT_CTRL_RX_DMA_ERR_INT_EN_Pos)

#define I2S_INT_CTRL_RX_DAT_INT_EN_Pos           (5)
#define I2S_INT_CTRL_RX_DAT_INT_EN_Msk           (0x1UL << I2S_INT_CTRL_RX_DAT_INT_EN_Pos)

#define I2S_INT_CTRL_RX_TIMEOUT_INT_EN_Pos       (6)
#define I2S_INT_CTRL_RX_TIMEOUT_INT_EN_Msk       (0x1UL << I2S_INT_CTRL_RX_TIMEOUT_INT_EN_Pos)

#define I2S_INT_CTRL_FS_ERR_INT_EN_Pos           (7)
#define I2S_INT_CTRL_FS_ERR_INT_EN_Msk           (0x1UL << I2S_INT_CTRL_FS_ERR_INT_EN_Pos)

#define I2S_INT_CTRL_FRAME_START_INT_EN_Pos      (8)
#define I2S_INT_CTRL_FRAME_START_INT_EN_Msk      (0x1UL << I2S_INT_CTRL_FRAME_START_INT_EN_Pos)

#define I2S_INT_CTRL_FRAME_END_INT_EN_Pos        (9)
#define I2S_INT_CTRL_FRAME_END_INT_EN_Msk        (0x1UL << I2S_INT_CTRL_FRAME_END_INT_EN_Pos)

#define I2S_INT_CTRL_CSPI_BUS_TIMEOUT_INT_EN_Pos (10)
#define I2S_INT_CTRL_CSPI_BUS_TIMEOUT_INT_EN_Msk (0x1UL << I2S_INT_CTRL_CSPI_BUS_TIMEOUT_INT_EN_Pos)

#define I2S_INT_CTRL_RSVD1_Pos                   (11)
#define I2S_INT_CTRL_RSVD1_Msk                   (0x1UL << I2S_INT_CTRL_RSVD1_Pos)

#define I2S_INT_CTRL_RSVD2_Pos                   (12)
#define I2S_INT_CTRL_RSVD2_Msk                   (0x1UL << I2S_INT_CTRL_RSVD2_Pos)

#define I2S_INT_CTRL_RSVD3_Pos                   (13)
#define I2S_INT_CTRL_RSVD3_Msk                   (0x1UL << I2S_INT_CTRL_RSVD3_Pos)

#define I2S_INT_CTRL_RSVD4_Pos                   (14)
#define I2S_INT_CTRL_RSVD4_Msk                   (0x1UL << I2S_INT_CTRL_RSVD4_Pos)

#define I2S_INT_CTRL_RSVD5_Pos                   (15)
#define I2S_INT_CTRL_RSVD5_Msk                   (0x1UL << I2S_INT_CTRL_RSVD5_Pos)

#define I2S_INT_CTRL_TX_INT_THREASHOLD_Pos       (16)
#define I2S_INT_CTRL_TX_INT_THREASHOLD_Msk       (0xFUL << I2S_INT_CTRL_TX_INT_THREASHOLD_Pos)

#define I2S_INT_CTRL_RX_INT_THREASHOLD_Pos       (20)
#define I2S_INT_CTRL_RX_INT_THREASHOLD_Msk       (0xFUL << I2S_INT_CTRL_RX_INT_THREASHOLD_Pos)
/** @} */

/** @name TIMEOUT_CYCLE - I2S_TIMEOUT_CYCLE register */
/** @{ */
#define I2S_TIMEOUT_CYCLE_RX_TIMEOUT_CYCLE_Pos   (0)
#define I2S_TIMEOUT_CYCLE_RX_TIMEOUT_CYCLE_Msk   (0xFFFFFFUL << I2S_TIMEOUT_CYCLE_RX_TIMEOUT_CYCLE_Pos)
/** @} */



/** @name STATS_CTRL - I2S_STATS_CTRL register */
/** @{ */
#define I2S_STATS_CTRL_TX_UNDERRUN_RUN_Pos       (0)
#define I2S_STATS_CTRL_TX_UNDERRUN_RUN_Msk       (0x1UL << I2S_STATS_CTRL_TX_UNDERRUN_RUN_Pos)

#define I2S_STATS_CTRL_TX_DMA_ERR_Pos            (1)
#define I2S_STATS_CTRL_TX_DMA_ERR_Msk            (0x1UL << I2S_STATS_CTRL_TX_DMA_ERR_Pos)

#define I2S_STATS_CTRL_TX_DAT_RDY_Pos            (2)
#define I2S_STATS_CTRL_TX_DAT_RDY_Msk            (0x1UL << I2S_STATS_CTRL_TX_DAT_RDY_Pos)

#define I2S_STATS_CTRL_RX_OVERFLOW_Pos           (3)
#define I2S_STATS_CTRL_RX_OVERFLOW_Msk           (0x1UL << I2S_STATS_CTRL_RX_OVERFLOW_Pos)

#define I2S_STATS_CTRL_RX_DMA_ERR_Pos            (4)
#define I2S_STATS_CTRL_RX_DMA_ERR_Msk            (0x1UL << I2S_STATS_CTRL_RX_DMA_ERR_Pos)

#define I2S_STATS_CTRL_RX_DAT_RDY_Pos            (5)
#define I2S_STATS_CTRL_RX_DAT_RDY_Msk            (0x1UL << I2S_STATS_CTRL_RX_DAT_RDY_Pos)

#define I2S_STATS_CTRL_RX_FIFO_TIMEOUT_Pos       (6)
#define I2S_STATS_CTRL_RX_FIFO_TIMEOUT_Msk       (0x1UL << I2S_STATS_CTRL_RX_FIFO_TIMEOUT_Pos)

#define I2S_STATS_CTRL_FS_ERR_Pos                (7)
#define I2S_STATS_CTRL_FS_ERR_Msk                (0xFUL << I2S_STATS_CTRL_FS_ERR_Pos)

#define I2S_STATS_CTRL_FRAME_START_Pos           (11)
#define I2S_STATS_CTRL_FRAME_START_Msk           (0x1UL << I2S_STATS_CTRL_FRAME_START_Pos)

#define I2S_STATS_CTRL_FRAME_END_Pos             (12)
#define I2S_STATS_CTRL_FRAME_END_Msk             (0x1UL << I2S_STATS_CTRL_FRAME_END_Pos)

#define I2S_STATS_CTRL_TX_FIFO_LEVEL_Pos         (13)
#define I2S_STATS_CTRL_TX_FIFO_LEVEL_Msk         (0x3FUL << I2S_STATS_CTRL_TX_FIFO_LEVEL_Pos)

#define I2S_STATS_CTRL_RX_FIFO_LEVEL_Pos         (19)
#define I2S_STATS_CTRL_RX_FIFO_LEVEL_Msk         (0x3FUL << I2S_STATS_CTRL_RX_FIFO_LEVEL_Pos)

#define I2S_STATS_CTRL_CSPI_BUS_TIMEOUT_Pos      (25)
#define I2S_STATS_CTRL_CSPI_BUS_TIMEOUT_Msk      (0x1UL << I2S_STATS_CTRL_CSPI_BUS_TIMEOUT_Pos)
/** @} */


/** @name RFIFO - I2S_RFIFO register */
/** @{ */
#define I2S_RFIFO_DATA_Pos                       (0)
#define I2S_RFIFO_DATA_Msk                       (0xFFFFFFFFUL << I2S_RFIFO_DATA_Pos)
/** @} */

/** @name TFIFO - I2S_TFIFO register */
/** @{ */
#define I2S_TFIFO_DAT_Pos                        (0)
#define I2S_TFIFO_DAT_Msk                        (0xFFFFFFFFUL << I2S_TFIFO_DAT_Pos)
/** @} */

/** @name I2SCTL - I2S_CTL register */
/** @{ */
#define I2S_CTL_MODE_Pos                         (0)
#define I2S_CTL_MODE_Msk                         (0x3UL << I2S_CTL_MODE_Pos)
/** @} */

/** Peripheral I2S0 base pointer */
#define I2S0                                     ((I2S_TypeDef *)MP_I2S0_BASE_ADDR)

/** Peripheral I2S1 base pointer */
#define I2S1                                     ((I2S_TypeDef *)MP_I2S1_BASE_ADDR)

/** @brief SPI peripheral instance number */
#define I2S_INSTANCE_NUM                         (2)


/**
  * @}
  */ /* end of group I2S */

  /** @addtogroup CSPI CSPI
  * @{
  */

/**
  * @brief CSPI register layout typedef
  *
  */
typedef struct {
    __IO uint32_t DFMT;                           /**< Data Format Register,                offset: 0x0 */
    __IO uint32_t SLOTCTL;                        /**< Slot Control Register,               offset: 0x4 */
    __IO uint32_t CLKCTL;                         /**< Clock Control Register,              offset: 0x8 */
    __IO uint32_t DMACTL;                         /**< DMA Control Register,                offset: 0xC */
    __IO uint32_t INTCTL;                         /**< Interrupt Control Register,          offset: 0x10 */
    __IO uint32_t TIMEOUTCTL;                     /**< Timeout Control Register,            offset: 0x14 */
    __IO uint32_t STAS;                           /**< Status Register,                     offset: 0x18 */
    __IO uint32_t RFIFO;                          /**< Rx Buffer Register,                  offset: 0x1c */
    __IO uint32_t TFIFO;                          /**< Tx Buffer Register,                  offset: 0x20 */
    __IO uint32_t RSVD;                           /**< Reserved,                            offset: 0x24 */
    __IO uint32_t CSPICTL;                        /**< Camera SPI Control Register,         offset: 0x28 */
    __IO uint32_t CCTL;                           /**< Auto Cg Control Register,            offset: 0x2c */
    __IO uint32_t CSPIINFO0;                      /**< Cspi Frame info0 Register,           offset: 0x30 */
    __IO uint32_t CSPIINFO1;                      /**< Cspi Frame info1 Register,           offset: 0x34 */
    __IO uint32_t CSPIDBG;                        /**< Cspi Debug Register,                 offset: 0x38 */
    __IO uint32_t CSPINIT;                        /**< Cspi Init Register,                  offset: 0x3c */
    __IO uint32_t CLSP;                           /**< Cspi Line Start Register,            offset: 0x40 */
    __IO uint32_t CDATP;                          /**< Cspi Data Packet Register,           offset: 0x44 */
    __IO uint32_t CLINFO;                         /**< Cspi Line Info Register,             offset: 0x48 */
} CSPI_TypeDef;

/** @name DFMT - CSPI_DFMT register */
/** @{ */
#define CSPI_DFMT_SLAVE_MODE_EN_Pos               (0)
#define CSPI_DFMT_SLAVE_MODE_EN_Msk               (0x1UL << CSPI_DFMT_SLAVE_MODE_EN_Pos)

#define CSPI_DFMT_SLOT_SIZE_Pos                   (1)
#define CSPI_DFMT_SLOT_SIZE_Msk                   (0x1FUL << CSPI_DFMT_SLOT_SIZE_Pos)

#define CSPI_DFMT_WORD_SIZE_Pos                   (6)
#define CSPI_DFMT_WORD_SIZE_Msk                   (0x1FUL << CSPI_DFMT_WORD_SIZE_Pos)

#define CSPI_DFMT_ALIGN_MODE_Pos                  (11)
#define CSPI_DFMT_ALIGN_MODE_Msk                  (0x1UL << CSPI_DFMT_ALIGN_MODE_Pos)

#define CSPI_DFMT_ENDIAN_MODE_Pos                 (12)
#define CSPI_DFMT_ENDIAN_MODE_Msk                 (0x1UL << CSPI_DFMT_ENDIAN_MODE_Pos)

#define CSPI_DFMT_DATA_DLY_Pos                    (13)
#define CSPI_DFMT_DATA_DLY_Msk                    (0x3UL << CSPI_DFMT_DATA_DLY_Pos)

#define CSPI_DFMT_TX_PAD_Pos                      (15)
#define CSPI_DFMT_TX_PAD_Msk                      (0x3UL << CSPI_DFMT_TX_PAD_Pos)

#define CSPI_DFMT_RX_SIGN_EXT_Pos                 (17)
#define CSPI_DFMT_RX_SIGN_EXT_Msk                 (0x1UL << CSPI_DFMT_RX_SIGN_EXT_Pos)

#define CSPI_DFMT_TX_PACK_Pos                     (18)
#define CSPI_DFMT_TX_PACK_Msk                     (0x3UL << CSPI_DFMT_TX_PACK_Pos)

#define CSPI_DFMT_RX_PACK_Pos                     (20)
#define CSPI_DFMT_RX_PACK_Msk                     (0x3UL << CSPI_DFMT_RX_PACK_Pos)

#define CSPI_DFMT_TX_FIFO_ENDIAN_MODE_Pos         (22)
#define CSPI_DFMT_TX_FIFO_ENDIAN_MODE_Msk         (0x1UL << CSPI_DFMT_TX_FIFO_ENDIAN_MODE_Pos)

#define CSPI_DFMT_RX_FIFO_ENDIAN_MODE_Pos         (23)
#define CSPI_DFMT_RX_FIFO_ENDIAN_MODE_Msk         (0x1UL << CSPI_DFMT_RX_FIFO_ENDIAN_MODE_Pos)
/** @} */

/** @name SLOTCTL - CSPI_SLOTCTL register */
/** @{ */
#define CSPI_SLOTCTL_SLOT_EN_Pos                  (0)
#define CSPI_SLOTCTL_SLOT_EN_Msk                  (0xFFUL << CSPI_SLOTCTL_SLOT_EN_Pos)

#define CSPI_SLOTCTL_SLOT_NUM_Pos                 (8)
#define CSPI_SLOTCTL_SLOT_NUM_Msk                 (0x7UL << CSPI_SLOTCTL_SLOT_NUM_Pos)
/** @} */

/** @name CLKCTL - CSPI_CLKCTL register */
/** @{ */
#define CSPI_CLKCTL_BCLK_POLARITY_Pos             (0)
#define CSPI_CLKCTL_BCLK_POLARITY_Msk             (0x1UL << CSPI_CLKCTL_BCLK_POLARITY_Pos)

#define CSPI_CLKCTL_FS_POLARITY_Pos               (1)
#define CSPI_CLKCTL_FS_POLARITY_Msk               (0x1UL << CSPI_CLKCTL_FS_POLARITY_Pos)

#define CSPI_CLKCTL_FS_WIDTH_Pos                  (2)
#define CSPI_CLKCTL_FS_WIDTH_Msk                  (0x3FUL << CSPI_CLKCTL_FS_WIDTH_Pos)
/** @} */

/** @name DMA_CTRL - CSPI_DMA_CTRL register */
/** @{ */
#define CSPI_DMA_CTRL_RX_DMA_REQ_EN_Pos           (0)
#define CSPI_DMA_CTRL_RX_DMA_REQ_EN_Msk           (0x1UL << CSPI_DMA_CTRL_RX_DMA_REQ_EN_Pos)

#define CSPI_DMA_CTRL_TX_DMA_REQ_EN_Pos           (1)
#define CSPI_DMA_CTRL_TX_DMA_REQ_EN_Msk           (0x1UL << CSPI_DMA_CTRL_TX_DMA_REQ_EN_Pos)

#define CSPI_DMA_CTRL_RX_DMA_TIMEOUT_EN_Pos       (2)
#define CSPI_DMA_CTRL_RX_DMA_TIMEOUT_EN_Msk       (0x1UL << CSPI_DMA_CTRL_RX_DMA_TIMEOUT_EN_Pos)

#define CSPI_DMA_CTRL_DMA_WORK_WAIT_CYCLE_Pos     (3)
#define CSPI_DMA_CTRL_DMA_WORK_WAIT_CYCLE_Msk     (0x1FUL << CSPI_DMA_CTRL_DMA_WORK_WAIT_CYCLE_Pos)

#define CSPI_DMA_CTRL_RX_DMA_BURST_SIZE_SUB1_Pos  (8)
#define CSPI_DMA_CTRL_RX_DMA_BURST_SIZE_SUB1_Msk  (0xFUL << CSPI_DMA_CTRL_RX_DMA_BURST_SIZE_SUB1_Pos)

#define CSPI_DMA_CTRL_TX_DMA_BURST_SIZE_SUB1_Pos  (12)
#define CSPI_DMA_CTRL_TX_DMA_BURST_SIZE_SUB1_Msk  (0xFUL << CSPI_DMA_CTRL_TX_DMA_BURST_SIZE_SUB1_Pos)

#define CSPI_DMA_CTRL_RX_DMA_THRESHOLD_Pos        (16)
#define CSPI_DMA_CTRL_RX_DMA_THRESHOLD_Msk        (0xFUL << CSPI_DMA_CTRL_RX_DMA_THRESHOLD_Pos)

#define CSPI_DMA_CTRL_TX_DMA_THRESHOLD_Pos        (20)
#define CSPI_DMA_CTRL_TX_DMA_THRESHOLD_Msk        (0xFUL << CSPI_DMA_CTRL_TX_DMA_THRESHOLD_Pos)

#define CSPI_DMA_CTRL_RX_FIFO_FLUSH_Pos           (24)
#define CSPI_DMA_CTRL_RX_FIFO_FLUSH_Msk           (0x1UL << CSPI_DMA_CTRL_RX_FIFO_FLUSH_Pos)

#define CSPI_DMA_CTRL_TX_FIFO_FLUSH_Pos           (25)
#define CSPI_DMA_CTRL_TX_FIFO_FLUSH_Msk           (0x1UL << CSPI_DMA_CTRL_TX_FIFO_FLUSH_Pos)
/** @} */


/** @name INT_CTRL - CSPI_INT_CTRL register */
/** @{ */
#define CSPI_INT_CTRL_TX_UNDERRUN_INT_EN_Pos      (0)
#define CSPI_INT_CTRL_TX_UNDERRUN_INT_EN_Msk      (0x1UL << CSPI_INT_CTRL_TX_UNDERRUN_INT_EN_Pos)

#define CSPI_INT_CTRL_TX_DMA_ERR_INT_EN_Pos       (1)
#define CSPI_INT_CTRL_TX_DMA_ERR_INT_EN_Msk       (0x1UL << CSPI_INT_CTRL_TX_DMA_ERR_INT_EN_Pos)

#define CSPI_INT_CTRL_TX_DAT_INT_EN_Pos           (2)
#define CSPI_INT_CTRL_TX_DAT_INT_EN_Msk           (0x1UL << CSPI_INT_CTRL_TX_DAT_INT_EN_Pos)

#define CSPI_INT_CTRL_RX_OVERFLOW_INT_EN_Pos      (3)
#define CSPI_INT_CTRL_RX_OVERFLOW_INT_EN_Msk      (0x1UL << CSPI_INT_CTRL_RX_OVERFLOW_INT_EN_Pos)

#define CSPI_INT_CTRL_RX_DMA_ERR_INT_EN_Pos       (4)
#define CSPI_INT_CTRL_RX_DMA_ERR_INT_EN_Msk       (0x1UL << CSPI_INT_CTRL_RX_DMA_ERR_INT_EN_Pos)

#define CSPI_INT_CTRL_RX_DAT_INT_EN_Pos           (5)
#define CSPI_INT_CTRL_RX_DAT_INT_EN_Msk           (0x1UL << CSPI_INT_CTRL_RX_DAT_INT_EN_Pos)

#define CSPI_INT_CTRL_RX_TIMEOUT_INT_EN_Pos       (6)
#define CSPI_INT_CTRL_RX_TIMEOUT_INT_EN_Msk       (0x1UL << CSPI_INT_CTRL_RX_TIMEOUT_INT_EN_Pos)

#define CSPI_INT_CTRL_FS_ERR_INT_EN_Pos           (7)
#define CSPI_INT_CTRL_FS_ERR_INT_EN_Msk           (0x1UL << CSPI_INT_CTRL_FS_ERR_INT_EN_Pos)

#define CSPI_INT_CTRL_FRAME_START_INT_EN_Pos      (8)
#define CSPI_INT_CTRL_FRAME_START_INT_EN_Msk      (0x1UL << CSPI_INT_CTRL_FRAME_START_INT_EN_Pos)

#define CSPI_INT_CTRL_FRAME_END_INT_EN_Pos        (9)
#define CSPI_INT_CTRL_FRAME_END_INT_EN_Msk        (0x1UL << CSPI_INT_CTRL_FRAME_END_INT_EN_Pos)

#define CSPI_INT_CTRL_BUS_TIMEOUT_INT_EN_Pos      (10)
#define CSPI_INT_CTRL_BUS_TIMEOUT_INT_EN_Msk      (0x1UL << CSPI_INT_CTRL_BUS_TIMEOUT_INT_EN_Pos)

#define CSPI_INT_CTRL_TX_INT_THREASHOLD_Pos       (16)
#define CSPI_INT_CTRL_TX_INT_THREASHOLD_Msk       (0xFUL << CSPI_INT_CTRL_TX_INT_THREASHOLD_Pos)

#define CSPI_INT_CTRL_RX_INT_THREASHOLD_Pos       (20)
#define CSPI_INT_CTRL_RX_INT_THREASHOLD_Msk       (0xFUL << CSPI_INT_CTRL_RX_INT_THREASHOLD_Pos)
/** @} */

/** @name TIMEOUT_CYCLE - CSPI_TIMEOUT_CYCLE register */
/** @{ */
#define CSPI_TIMEOUT_CYCLE_RX_TIMEOUT_CYCLE_Pos   (0)
#define CSPI_TIMEOUT_CYCLE_RX_TIMEOUT_CYCLE_Msk   (0xFFFFFFUL << CSPI_TIMEOUT_CYCLE_RX_TIMEOUT_CYCLE_Pos)
/** @} */

/** @name STATS_CTRL -CSPI_STATS_CTRL register */
/** @{ */
#define CSPI_STATS_CTRL_TX_UNDERRUN_RUN_Pos       (0)
#define CSPI_STATS_CTRL_TX_UNDERRUN_RUN_Msk       (0x1UL << CSPI_STATS_CTRL_TX_UNDERRUN_RUN_Pos)

#define CSPI_STATS_CTRL_TX_DMA_ERR_Pos            (1)
#define CSPI_STATS_CTRL_TX_DMA_ERR_Msk            (0x1UL << CSPI_STATS_CTRL_TX_DMA_ERR_Pos)

#define CSPI_STATS_CTRL_TX_DAT_RDY_Pos            (2)
#define CSPI_STATS_CTRL_TX_DAT_RDY_Msk            (0x1UL << CSPI_STATS_CTRL_TX_DAT_RDY_Pos)

#define CSPI_STATS_CTRL_RX_OVERFLOW_Pos           (3)
#define CSPI_STATS_CTRL_RX_OVERFLOW_Msk           (0x1UL << CSPI_STATS_CTRL_RX_OVERFLOW_Pos)

#define CSPI_STATS_CTRL_RX_DMA_ERR_Pos            (4)
#define CSPI_STATS_CTRL_RX_DMA_ERR_Msk            (0x1UL << CSPI_STATS_CTRL_RX_DMA_ERR_Pos)

#define CSPI_STATS_CTRL_RX_DAT_RDY_Pos            (5)
#define CSPI_STATS_CTRL_RX_DAT_RDY_Msk            (0x1UL << CSPI_STATS_CTRL_RX_DAT_RDY_Pos)

#define CSPI_STATS_CTRL_RX_FIFO_TIMEOUT_Pos       (6)
#define CSPI_STATS_CTRL_RX_FIFO_TIMEOUT_Msk       (0x1UL << CSPI_STATS_CTRL_RX_FIFO_TIMEOUT_Pos)

#define CSPI_STATS_CTRL_FS_ERR_Pos                (7)
#define CSPI_STATS_CTRL_FS_ERR_Msk                (0xFUL << CSPI_STATS_CTRL_FS_ERR_Pos)

#define CSPI_STATS_CTRL_FRAME_START_Pos           (11)
#define CSPI_STATS_CTRL_FRAME_START_Msk           (0x1UL << CSPI_STATS_CTRL_FRAME_START_Pos)

#define CSPI_STATS_CTRL_FRAME_END_Pos             (12)
#define CSPI_STATS_CTRL_FRAME_END_Msk             (0x1UL << CSPI_STATS_CTRL_FRAME_END_Pos)

#define CSPI_STATS_CTRL_TX_FIFO_LEVEL_Pos         (13)
#define CSPI_STATS_CTRL_TX_FIFO_LEVEL_Msk         (0x3FUL << CSPI_STATS_CTRL_TX_FIFO_LEVEL_Pos)

#define CSPI_STATS_CTRL_RX_FIFO_LEVEL_Pos         (19)
#define CSPI_STATS_CTRL_RX_FIFO_LEVEL_Msk         (0x3FUL << CSPI_STATS_CTRL_RX_FIFO_LEVEL_Pos)

#define CSPI_STATS_CTRL_CSPI_BUS_TIMEOUT_Pos      (25)
#define CSPI_STATS_CTRL_CSPI_BUS_TIMEOUT_Msk      (0x1UL << CSPI_STATS_CTRL_CSPI_BUS_TIMEOUT_Pos)
/** @} */


/** @name RFIFO - CSPI_RFIFO register */
/** @{ */
#define CSPI_RFIFO_DATA_Pos                       (0)
#define CSPI_RFIFO_DATA_Msk                       (0xFFFFFFFFUL << CSPI_RFIFO_DATA_Pos)
/** @} */

/** @name TFIFO - CSPI_TFIFO register */
/** @{ */
#define CSPI_TFIFO_DAT_Pos                        (0)
#define CSPI_TFIFO_DAT_Msk                        (0xFFFFFFFFUL << CSPI_TFIFO_DAT_Pos)
/** @} */

/** @name SPI_CTRL - CAMERA_SPI_CTRL register */
/** @{ */
#define CSPI_ENABLE_Pos                           (0)
#define CSPI_ENABLE_Msk                           (0x1UL << CSPI_ENABLE_Pos)

#define CSPI_CS_EN_Pos                            (1)
#define CSPI_CS_EN_Msk                            (0x1UL << CSPI_CS_EN_Pos)

#define CSPI_RXD_WID_Pos                          (2)
#define CSPI_RXD_WID_Msk                          (0x1UL << CSPI_RXD_WID_Pos)

#define CSPI_RXD_SEQ_Pos                          (3)
#define CSPI_RXD_SEQ_Msk                          (0x1UL << CSPI_RXD_SEQ_Pos)

#define CSPI_CPOL_Pos                             (4)
#define CSPI_CPOL_Msk                             (0x1UL << CSPI_CPOL_Pos)

#define CSPI_CPHA_Pos                             (5)
#define CSPI_CPHA_Msk                             (0x1UL << CSPI_CPHA_Pos)

#define CSPI_FRAME_PROC_EN_Pos                    (6)
#define CSPI_FRAME_PROC_EN_Msk                    (0x1UL << CSPI_FRAME_PROC_EN_Pos)

#define CSPI_FILL_Y_ONLY_Pos                      (7)
#define CSPI_FILL_Y_ONLY_Msk                      (0x1UL << CSPI_FILL_Y_ONLY_Pos)

#define CSPI_HW_INIT_EN_Pos                       (8)
#define CSPI_HW_INIT_EN_Msk                       (0x1UL << CSPI_HW_INIT_EN_Pos)

#define CSPI_LS_CHECK_EN_Pos                      (9)
#define CSPI_LS_CHECK_EN_Msk                      (0x1UL << CSPI_LS_CHECK_EN_Pos)

#define CSPI_DP_CHECK_EN_Pos                      (10)
#define CSPI_DP_CHECK_EN_Msk                      (0x1UL << CSPI_DP_CHECK_EN_Pos)

#define CSPI_FRAME_PROC_INIT_EN_Pos               (11)
#define CSPI_FRAME_PROC_INIT_EN_Msk               (0x1UL << CSPI_FRAME_PROC_INIT_EN_Pos)

#define CSPI_ROW_SCALE_RATIO_Pos                  (12)
#define CSPI_ROW_SCALE_RATIO_Msk                  (0xFUL << CSPI_ROW_SCALE_RATIO_Pos)

#define CSPI_COL_SCALE_RATIO_Pos                  (16)
#define CSPI_COL_SCALE_RATIO_Msk                  (0xFUL << CSPI_COL_SCALE_RATIO_Pos)

#define CSPI_SCALE_BYTES_Pos                      (20)
#define CSPI_SCALE_BYTES_Msk                      (0x3UL << CSPI_SCALE_BYTES_Pos)
/** @} */

/** @name CG_CTRL - AUTO_CG_CTRL register */
/** @{ */
#define AUTO_CG_CTRL_AUTOCG_EN_Pos                (0)
#define AUTO_CG_CTRL_AUTOCG_EN_Msk                (0x1UL << AUTO_CG_CTRL_AUTOCG_EN_Pos)
/** @} */

/** @name FRAME_INFO0 - CSPI_FRAME_INFO0 register */
/** @{ */
#define CSPI_FRAME_INFO0_BUS_TIMEOUT_CYCLE_Pos    (0)
#define CSPI_FRAME_INFO0_BUS_TIMEOUT_CYCLE_Msk    (0xFFFFFFUL << CSPI_FRAME_INFO0_BUS_TIMEOUT_CYCLE_Pos)

#define CSPI_FRAME_INFO0_DATA_ID_Pos              (24)
#define CSPI_FRAME_INFO0_DATA_ID_Msk              (0xFFUL << CSPI_FRAME_INFO0_DATA_ID_Pos)
/** @} */

/** @name FRAME_INFO1 - CSPI_FRAME_INFO1 register */
/** @{ */
#define CSPI_FRAME_INFO1_IMAGE_HEIGHT_Pos         (0)
#define CSPI_FRAME_INFO1_IMAGE_HEIGHT_Msk         (0xFFFFUL << CSPI_FRAME_INFO1_IMAGE_HEIGHT_Pos)

#define CSPI_FRAME_INFO1_IMAGE_WIDTH_Pos          (16)
#define CSPI_FRAME_INFO1_IMAGE_WIDTH_Msk          (0xFFFFUL << CSPI_FRAME_INFO1_IMAGE_WIDTH_Pos)
/** @} */

/** @name DEBUG_INFO - CSPI_DEBUG_INFO register */
/** @{ */
#define CSPI_DEBUG_INFO_CSPI_DEBUG_LINE_CNT_Pos   (0)
#define CSPI_DEBUG_INFO_CSPI_DEBUG_LINE_CNT_Msk   (0xFFFFUL << CSPI_DEBUG_INFO_CSPI_DEBUG_LINE_CNT_Pos)

#define CSPI_DEBUG_INFO_CSPI_CS_Pos               (16)
#define CSPI_DEBUG_INFO_CSPI_CS_Msk               (0x7UL << CSPI_DEBUG_INFO_CSPI_CS_Pos)
/** @} */

/** @name INIT - CSPI_INIT register */
/** @{ */
#define CSPI_INIT_CSPI_INIT_Pos                   (0)
#define CSPI_INIT_CSPI_INIT_Msk                   (0x1UL << CSPI_INIT_CSPI_INIT_Pos)
/** @} */

/** @name LS_PACKET - CSPI_LS_PACKET register */
/** @{ */
#define CSPI_LS_PACKET_LS_PACKET_Pos              (0)
#define CSPI_LS_PACKET_LS_PACKET_Msk              (0xFFFFFFFFUL << CSPI_LS_PACKET_LS_PACKET_Pos)
/** @} */

/** @name DAT_PACKET - CSPI_DAT_PACKET register */
/** @{ */
#define CSPI_DAT_PACKET_DAT_PACKET_Pos            (0)
#define CSPI_DAT_PACKET_DAT_PACKET_Msk            (0xFFFFFFFFUL << CSPI_DAT_PACKET_DAT_PACKET_Pos)
/** @} */

/** @name LINE_INFO - CSPI_LINE_INFO register */
/** @{ */
#define CSPI_LINE_INFO_DP_SIZE_Pos                (0)
#define CSPI_LINE_INFO_DP_SIZE_Msk                (0xFFFFUL << CSPI_LINE_INFO_DP_SIZE_Pos)

#define CSPI_LINE_INFO_LINE_ID_Pos                (16)
#define CSPI_LINE_INFO_LINE_ID_Msk                (0xFFFFUL << CSPI_LINE_INFO_LINE_ID_Pos)
/** @} */

/** Peripheral CSPI0 base pointer */
#define CSPI0                                     ((CSPI_TypeDef *)MP_I2S0_BASE_ADDR)

/** Peripheral CSPI1 base pointer */
#define CSPI1                                     ((CSPI_TypeDef *)MP_I2S1_BASE_ADDR)

/** @brief SPI peripheral instance number */
#define CSPI_INSTANCE_NUM                         (2)


/**
  * @}
  */ /* end of group CSPI */

/** @addtogroup KPC KPC
  * @{
  */

/**
  * @brief KPC register layout typedef
  *
  */
typedef struct {
    __IO uint32_t DEBCTL;                           /**< Debounce Control Register,              offset: 0x0 */
    __IO uint32_t KPCTL;                            /**< Keypad Control Register,                offset: 0x4 */
    __IO uint32_t DICTL;                            /**< Direct Input Control Register,          offset: 0x8 */
    __IO uint32_t KPENCTL;                          /**< Keypad Enable Register,                 offset: 0xC */
    __IO uint32_t DIENCTL;                          /**< Direct Input Enable Register,           offset: 0x10 */
    __IO uint32_t AUTOCG;                           /**< Auto Gate Enable Register,              offset: 0x14 */
    __IO uint32_t CLRCTL;                           /**< Direct Input Clear Control Register,    offset: 0x18 */
    __I  uint32_t KPSTAT;                           /**< Keypad Status Register,                 offset: 0x1C */
    __I  uint32_t DISTAT;                           /**< Direct Input Status Register,           offset: 0x20 */
} KPC_TypeDef;

/** @name DEBCTL - KPC_DEBCTL register */
/** @{ */
#define KPC_DEBCTL_DEBOUNCER_DEPTH_Pos           (0)
#define KPC_DEBCTL_DEBOUNCER_DEPTH_Msk           (0xFUL << KPC_DEBCTL_DEBOUNCER_DEPTH_Pos)

#define KPC_DEBCTL_DEBOUNCER_TO0_THRD_Pos        (4)
#define KPC_DEBCTL_DEBOUNCER_TO0_THRD_Msk        (0xFUL << KPC_DEBCTL_DEBOUNCER_TO0_THRD_Pos)

#define KPC_DEBCTL_DEBOUNCER_TO1_THRD_Pos        (8)
#define KPC_DEBCTL_DEBOUNCER_TO1_THRD_Msk        (0xFUL << KPC_DEBCTL_DEBOUNCER_TO1_THRD_Pos)

#define KPC_DEBCTL_DEBOUNCER_TO_MCLK_RATIO_Pos   (12)
#define KPC_DEBCTL_DEBOUNCER_TO_MCLK_RATIO_Msk   (0xFUL << KPC_DEBCTL_DEBOUNCER_TO_MCLK_RATIO_Pos)
/** @} */

/** @name KPCTL - KPC_KPCTL register */
/** @{ */
#define KPC_KPCTL_POLARITY_Pos                   (0)
#define KPC_KPCTL_POLARITY_Msk                   (0x1UL << KPC_KPCTL_POLARITY_Pos)

#define KPC_KPCTL_ROW_VLD_BITMAP_Pos             (1)
#define KPC_KPCTL_ROW_VLD_BITMAP_Msk             (0x1FUL << KPC_KPCTL_ROW_VLD_BITMAP_Pos)

#define KPC_KPCTL_COL_VLD_BITMAP_Pos             (6)
#define KPC_KPCTL_COL_VLD_BITMAP_Msk             (0x1FUL << KPC_KPCTL_COL_VLD_BITMAP_Pos)

#define KPC_KPCTL_SCAN_TO_DEBOUNCE_RATIO_Pos     (11)
#define KPC_KPCTL_SCAN_TO_DEBOUNCE_RATIO_Msk     (0x7UL << KPC_KPCTL_SCAN_TO_DEBOUNCE_RATIO_Pos)
/** @} */

/** @name DICTL - KPC_DICTL register */
/** @{ */
#define KPC_DICTL_INT_MODE_Pos                   (0)
#define KPC_DICTL_INT_MODE_Msk                   (0x3UL << KPC_DICTL_INT_MODE_Pos)

#define KPC_DICTL_INT_EN_Pos                     (2)
#define KPC_DICTL_INT_EN_Msk                     (0x3FFUL << KPC_DICTL_INT_EN_Pos)
/** @} */

/** @name KPENCTL - KPC_KPENCTL register */
/** @{ */
#define KPC_KPENCTL_ENABLE_Pos                   (0)
#define KPC_KPENCTL_ENABLE_Msk                   (0x1UL << KPC_KPENCTL_ENABLE_Pos)
/** @} */

/** @name DIENCTL - KPC_DIENCTL register */
/** @{ */
#define KPC_DIENCTL_ENABLE_Pos                   (0)
#define KPC_DIENCTL_ENABLE_Msk                   (0x1UL << KPC_DIENCTL_ENABLE_Pos)
/** @} */

/** @name AUTOCG - KPC_AUTOCG register */
/** @{ */
#define KPC_AUTOCG_ENABLE_Pos                    (0)
#define KPC_AUTOCG_ENABLE_Msk                    (0x1UL << KPC_AUTOCG_ENABLE_Pos)
/** @} */

/** @name CLRCTL - KPC_CLRCTL register */
/** @{ */
#define KPC_CLRCTL_INPUT_INT_CLR_Pos             (0)
#define KPC_CLRCTL_INPUT_INT_CLR_Msk             (0x3FFUL << KPC_CLRCTL_INPUT_INT_CLR_Pos)

#define KPC_CLRCTL_DEBOUNCER_CLR_Pos             (10)
#define KPC_CLRCTL_DEBOUNCER_CLR_Msk             (0x3FFUL << KPC_CLRCTL_DEBOUNCER_CLR_Pos)
/** @} */

/** @name KPSTAT - KPC_KPSTAT register */
/** @{ */
#define KPC_KPSTAT_STATUS_Pos                    (0)
#define KPC_KPSTAT_STATUS_Msk                    (0x1FFFFFFUL << KPC_KPSTAT_STATUS_Pos)
/** @} */

/** @name DISTAT - KPC_DISTAT register */
/** @{ */
#define KPC_DISTAT_INPUT_INT_NEG_STATUS_Pos      (0)
#define KPC_DISTAT_INPUT_INT_NEG_STATUS_Msk      (0x3FFUL << KPC_DISTAT_INPUT_INT_NEG_STATUS_Pos)

#define KPC_DISTAT_INPUT_INT_POS_STATUS_Pos      (10)
#define KPC_DISTAT_INPUT_INT_POS_STATUS_Msk      (0x3FFUL << KPC_DISTAT_INPUT_INT_POS_STATUS_Pos)

#define KPC_DISTAT_INPUT_STATUS_Pos              (20)
#define KPC_DISTAT_INPUT_STATUS_Msk              (0x3FFUL << KPC_DISTAT_INPUT_STATUS_Pos)
/** @} */

/** Peripheral KPC base pointer */
#define KPC                                      ((KPC_TypeDef *) AP_KPC_BASE_ADDR)

/**
  * @}
  */ /* end of group KPC */

/** @addtogroup LPUSART LPUSART
  * @{
  */

/**
  * @brief LPUSART CORE part register layout typedef
  *
  */
typedef struct {
    __IO uint32_t CSR;                           /**< Control and Status Register,              offset: 0x0 */
    __IO uint32_t TCR;                           /**< Timeout Control Register,                 offset: 0x4 */
    __I  uint32_t RBR;                           /**< Receive Buffer Register,                  offset: 0x8 */
    __IO uint32_t FCSR;                          /**< FIFO Control and Status Register,         offset: 0xC */
    __IO uint32_t IER;                           /**< Interrupt Enable Register,                offset: 0x10 */
    __IO uint32_t IIR;                           /**< Interrupt Identification Register,        offset: 0x14 */
    __IO uint32_t DCR;                           /**< DMA Control Register,                     offset: 0x18 */
    __IO uint32_t TSR;                           /**< Timeout Status Register,                  offset: 0x1C */
} LPUSARTCORE_TypeDef;

/**
  * @brief LPUSART AON part register layout typedef
  *
  */
typedef struct {
    __IO uint32_t CR0;                           /**< Control Register 0,                       offset: 0x0 */
         uint32_t RESERVED_0[138];
    __IO uint32_t CR1;                           /**< Control Register 1,                       offset: 0x0 */
    __IO uint32_t DLR;                           /**< Divisor Latch Register,                   offset: 0x4 */
    __IO uint32_t LCR;                           /**< Line Control Register,                    offset: 0x8 */
    __IO uint32_t SCR;                           /**< Stop Control Register,                    offset: 0xC */
    __IO uint32_t FSR;                           /**< FIFO Status Register,                     offset: 0x10 */
    __IO uint32_t IIR;                           /**< Interrupt Identification Register,        offset: 0x14 */
    __IO uint32_t SR;                            /**< Status Register,                          offset: 0x18 */
} LPUSARTAON_TypeDef;

/** @name CSR - LPUSART_CSR register */
/** @{ */
#define LPUSARTCORE_CSR_AON_EN_Pos               (0)
#define LPUSARTCORE_CSR_AON_EN_Msk               (0x1UL << LPUSARTCORE_CSR_AON_EN_Pos)

#define LPUSARTCORE_CSR_AUTO_CG_EN_Pos           (1)
#define LPUSARTCORE_CSR_AUTO_CG_EN_Msk           (0x1UL << LPUSARTCORE_CSR_AUTO_CG_EN_Pos)
/** @} */

/** @name TCR - LPUSARTCORE_TCR register */
/** @{ */
#define LPUSARTCORE_TCR_TIMEOUT_THRLD_Pos        (0)
#define LPUSARTCORE_TCR_TIMEOUT_THRLD_Msk        (0xFFFFFUL << LPUSARTCORE_TCR_TIMEOUT_THRLD_Pos)

#define LPUSARTCORE_TCR_TOCNT_SWCLR_Pos          (30)
#define LPUSARTCORE_TCR_TOCNT_SWCLR_Msk          (0x1UL << LPUSARTCORE_TCR_TOCNT_SWCLR_Pos)

#define LPUSARTCORE_TCR_TOCNT_SWTRG_Pos          (31)
#define LPUSARTCORE_TCR_TOCNT_SWTRG_Msk          (0x1UL << LPUSARTCORE_TCR_TOCNT_SWTRG_Pos)
/** @} */

/** @name RBR - LPUSARTCORE_RBR register */
/** @{ */
#define LPUSARTCORE_RBR_RX_BUF_Pos               (0)
#define LPUSARTCORE_RBR_RX_BUF_Msk               (0xFFUL << LPUSARTCORE_RBR_RX_BUF_Pos)
/** @} */

/** @name FCSR - LPUSARTCORE_FCSR register */
/** @{ */
#define LPUSARTCORE_FCSR_FLUSH_RXFIFO_Pos        (0)
#define LPUSARTCORE_FCSR_FLUSH_RXFIFO_Msk        (0x1UL << LPUSARTCORE_FCSR_FLUSH_RXFIFO_Pos)

#define LPUSARTCORE_FCSR_RXFIFO_EMPTY_Pos        (1)
#define LPUSARTCORE_FCSR_RXFIFO_EMPTY_Msk        (0x1UL << LPUSARTCORE_FCSR_RXFIFO_EMPTY_Pos)

#define LPUSARTCORE_FCSR_RXFIFO_FULL_Pos         (2)
#define LPUSARTCORE_FCSR_RXFIFO_FULL_Msk         (0x1UL << LPUSARTCORE_FCSR_RXFIFO_FULL_Pos)

#define LPUSARTCORE_FCSR_AON_RX_BUSY_Pos         (3)
#define LPUSARTCORE_FCSR_AON_RX_BUSY_Msk         (0x1UL << LPUSARTCORE_FCSR_AON_RX_BUSY_Pos)

#define LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Pos    (4)
#define LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Msk    (0x1UL << LPUSARTCORE_FCSR_AON_RXFIFO_EMPTY_Pos)

#define LPUSARTCORE_FCSR_AON_RXFIFO_FULL_Pos     (5)
#define LPUSARTCORE_FCSR_AON_RXFIFO_FULL_Msk     (0x1UL << LPUSARTCORE_FCSR_AON_RXFIFO_FULL_Pos)

#define LPUSARTCORE_FCSR_AON_STOP_FLAG_Pos       (6)
#define LPUSARTCORE_FCSR_AON_STOP_FLAG_Msk       (0x1UL << LPUSARTCORE_FCSR_AON_STOP_FLAG_Pos)

#define LPUSARTCORE_FCSR_RXFIFO_NUM_Pos          (8)
#define LPUSARTCORE_FCSR_RXFIFO_NUM_Msk          (0x7FUL << LPUSARTCORE_FCSR_RXFIFO_NUM_Pos)

#define LPUSARTCORE_FCSR_RXFIFO_THRLD_Pos        (16)
#define LPUSARTCORE_FCSR_RXFIFO_THRLD_Msk        (0x3FUL << LPUSARTCORE_FCSR_RXFIFO_THRLD_Pos)
/** @} */

/** @name IER - LPUSARTCORE_IER register */
/** @{ */
#define LPUSARTCORE_IER_AON_RX_OVERRUN_Pos       (1)
#define LPUSARTCORE_IER_AON_RX_OVERRUN_Msk       (0x1UL << LPUSARTCORE_IER_AON_RX_OVERRUN_Pos)

#define LPUSARTCORE_IER_AON_RX_PARITY_Pos        (2)
#define LPUSARTCORE_IER_AON_RX_PARITY_Msk        (0x1UL << LPUSARTCORE_IER_AON_RX_PARITY_Pos)

#define LPUSARTCORE_IER_AON_RX_FRMERR_Pos        (3)
#define LPUSARTCORE_IER_AON_RX_FRMERR_Msk        (0x1UL << LPUSARTCORE_IER_AON_RX_FRMERR_Pos)

#define LPUSARTCORE_IER_RX_DATA_AVAIL_Pos        (9)
#define LPUSARTCORE_IER_RX_DATA_AVAIL_Msk        (0x1UL << LPUSARTCORE_IER_RX_DATA_AVAIL_Pos)

#define LPUSARTCORE_IER_RX_TIMEOUT_Pos           (10)
#define LPUSARTCORE_IER_RX_TIMEOUT_Msk           (0x1UL << LPUSARTCORE_IER_RX_TIMEOUT_Pos)

#define LPUSARTCORE_IER_RX_OVERRUN_Pos           (11)
#define LPUSARTCORE_IER_RX_OVERRUN_Msk           (0x1UL << LPUSARTCORE_IER_RX_OVERRUN_Pos)
/** @} */

/** @name IIR - LPUSARTCORE_IIR register */
/** @{ */
#define LPUSARTCORE_IIR_CLR_Pos                  (0)
#define LPUSARTCORE_IIR_CLR_Msk                  (0x1UL << LPUSARTCORE_IIR_CLR_Pos)

#define LPUSARTCORE_IIR_AON_RX_OVERRUN_Pos       (1)
#define LPUSARTCORE_IIR_AON_RX_OVERRUN_Msk       (0x1UL << LPUSARTCORE_IIR_AON_RX_OVERRUN_Pos)

#define LPUSARTCORE_IIR_AON_RX_PARITY_Pos        (2)
#define LPUSARTCORE_IIR_AON_RX_PARITY_Msk        (0x1UL << LPUSARTCORE_IIR_AON_RX_PARITY_Pos)

#define LPUSARTCORE_IIR_AON_RX_FRMERR_Pos        (3)
#define LPUSARTCORE_IIR_AON_RX_FRMERR_Msk        (0x1UL << LPUSARTCORE_IIR_AON_RX_FRMERR_Pos)

#define LPUSARTCORE_IIR_RX_DATA_AVAIL_Pos        (9)
#define LPUSARTCORE_IIR_RX_DATA_AVAIL_Msk        (0x1UL << LPUSARTCORE_IIR_RX_DATA_AVAIL_Pos)

#define LPUSARTCORE_IIR_RX_TIMEOUT_Pos           (10)
#define LPUSARTCORE_IIR_RX_TIMEOUT_Msk           (0x1UL << LPUSARTCORE_IIR_RX_TIMEOUT_Pos)

#define LPUSARTCORE_IIR_RX_OVERRUN_Pos           (11)
#define LPUSARTCORE_IIR_RX_OVERRUN_Msk           (0x1UL << LPUSARTCORE_IIR_RX_OVERRUN_Pos)
/** @} */

/** @name DCR - LPUSARTCORE_DCR register */
/** @{ */
#define LPUSARTCORE_DCR_RX_REQ_EN_Pos            (0)
#define LPUSARTCORE_DCR_RX_REQ_EN_Msk            (0x1UL << LPUSARTCORE_DCR_RX_REQ_EN_Pos)

#define LPUSARTCORE_DCR_RX_BUSY_Pos              (1)
#define LPUSARTCORE_DCR_RX_BUSY_Msk              (0x1UL << LPUSARTCORE_DCR_RX_BUSY_Pos)
/** @} */

/** @name TSR - LPUSARTCORE_TSR register */
/** @{ */
#define LPUSARTCORE_TSR_TOCNT_Pos                (0)
#define LPUSARTCORE_TSR_TOCNT_Msk                (0xFFFFFUL << LPUSARTCORE_TSR_TOCNT_Pos)

#define LPUSARTCORE_TSR_TOCNT_REACH_Pos          (31)
#define LPUSARTCORE_TSR_TOCNT_REACH_Msk          (0x1UL << LPUSARTCORE_TSR_TOCNT_REACH_Pos)
/** @} */

/** @name CR0 - LPUSARTAON_CR0 register */
/** @{ */
#define LPUSARTAON_CR0_RX_ENABLE_Pos             (0)
#define LPUSARTAON_CR0_RX_ENABLE_Msk             (0x1UL << LPUSARTAON_CR0_RX_ENABLE_Pos)

#define LPUSARTAON_CR0_CLK_ENABLE_Pos            (1)
#define LPUSARTAON_CR0_CLK_ENABLE_Msk            (0x1UL << LPUSARTAON_CR0_CLK_ENABLE_Pos)
/** @} */

/** @name CR1 - LPUSARTAON_CR1 register */
/** @{ */
#define LPUSARTAON_CR1_ENABLE_Pos                (0)
#define LPUSARTAON_CR1_ENABLE_Msk                (0x1UL << LPUSARTAON_CR1_ENABLE_Pos)

#define LPUSARTAON_CR1_ACG_EN_Pos                (1)
#define LPUSARTAON_CR1_ACG_EN_Msk                (0x1UL << LPUSARTAON_CR1_ACG_EN_Pos)

#define LPUSARTAON_CR1_AUTO_ADJ_Pos              (2)
#define LPUSARTAON_CR1_AUTO_ADJ_Msk              (0x1UL << LPUSARTAON_CR1_AUTO_ADJ_Pos)
/** @} */

/** @name DLR - LPUSARTAON_DLR register */
/** @{ */
#define LPUSARTAON_DLR_DIVISOR_Pos               (0)
#define LPUSARTAON_DLR_DIVISOR_Msk               (0xFFFUL << LPUSARTAON_DLR_DIVISOR_Pos)
/** @} */

/** @name LCR - LPUSARTAON_LCR register */
/** @{ */
#define LPUSARTAON_LCR_CHAR_LEN_Pos              (0)
#define LPUSARTAON_LCR_CHAR_LEN_Msk              (0x3UL << LPUSARTAON_LCR_CHAR_LEN_Pos)

#define LPUSARTAON_LCR_STOPBIT_DETECT_EN_Pos     (2)
#define LPUSARTAON_LCR_STOPBIT_DETECT_EN_Msk     (0x1UL << LPUSARTAON_LCR_STOPBIT_DETECT_EN_Pos)

#define LPUSARTAON_LCR_PARITY_EN_Pos             (3)
#define LPUSARTAON_LCR_PARITY_EN_Msk             (0x1UL << LPUSARTAON_LCR_PARITY_EN_Pos)

#define LPUSARTAON_LCR_EVEN_PARITY_Pos           (4)
#define LPUSARTAON_LCR_EVEN_PARITY_Msk           (0x1UL << LPUSARTAON_LCR_EVEN_PARITY_Pos)
/** @} */

/** @name SCR - LPUSARTAON_SCR register */
/** @{ */
#define LPUSARTAON_SCR_STOP_SW_SET_Pos           (0)
#define LPUSARTAON_SCR_STOP_SW_SET_Msk           (0x1UL << LPUSARTAON_SCR_STOP_SW_SET_Pos)

#define LPUSARTAON_SCR_STOP_SW_CLR_Pos           (1)
#define LPUSARTAON_SCR_STOP_SW_CLR_Msk           (0x1UL << LPUSARTAON_SCR_STOP_SW_CLR_Pos)

#define LPUSARTAON_SCR_STOP_FLAG_Pos             (3)
#define LPUSARTAON_SCR_STOP_FLAG_Msk             (0x1UL << LPUSARTAON_SCR_STOP_FLAG_Pos)
/** @} */

/** @name FSR - LPUSARTAON_FSR register */
/** @{ */
#define LPUSARTAON_FSR_RXFIFO_EMPTY_Pos          (1)
#define LPUSARTAON_FSR_RXFIFO_EMPTY_Msk          (0x1UL << LPUSARTAON_FSR_RXFIFO_EMPTY_Pos)

#define LPUSARTAON_FSR_RXFIFO_FULL_Pos           (2)
#define LPUSARTAON_FSR_RXFIFO_FULL_Msk           (0x1UL << LPUSARTAON_FSR_RXFIFO_FULL_Pos)

#define LPUSARTAON_FSR_RX_BUSY_Pos               (3)
#define LPUSARTAON_FSR_RX_BUSY_Msk               (0x1UL << LPUSARTAON_FSR_RX_BUSY_Pos)

#define LPUSARTAON_FSR_RXFIFO_NUM_Pos            (8)
#define LPUSARTAON_FSR_RXFIFO_NUM_Msk            (0xFUL << LPUSARTAON_FSR_RXFIFO_NUM_Pos)
/** @} */

/** @name IIR - LPUSARTAON_IIR register */
/** @{ */
#define LPUSARTAON_IIR_RXFIFO_OVERRUN_Pos        (1)
#define LPUSARTAON_IIR_RXFIFO_OVERRUN_Msk        (0x1UL << LPUSARTAON_IIR_RXFIFO_OVERRUN_Pos)

#define LPUSARTAON_IIR_PARITY_ERR_Pos            (2)
#define LPUSARTAON_IIR_PARITY_ERR_Msk            (0x1UL << LPUSARTAON_IIR_PARITY_ERR_Pos)

#define LPUSARTAON_IIR_FRAME_ERR_Pos             (3)
#define LPUSARTAON_IIR_FRAME_ERR_Msk             (0x1UL << LPUSARTAON_IIR_FRAME_ERR_Pos)
/** @} */

/** @name LSR - LPUSARTAON_LSR register */
/** @{ */
#define LPUSARTAON_LSR_STATUS_Pos                (0)
#define LPUSARTAON_LSR_STATUS_Msk                (0xFFFFFFFFUL << LPUSARTAON_LSR_STATUS_Pos)
/** @} */

/** Peripheral LPUART base pointer */
#define LPUSART_AON                              ((LPUSARTAON_TypeDef *) LPUSARTAON_BASE_ADDR)
#define LPUSART_CORE                             ((LPUSARTCORE_TypeDef *) MP_LPUART_BASE_ADDR)
/**
  * @}
  */ /* end of group LPUSART */

/** @addtogroup OWC OWC
  * @{
  */

/**
  * @brief OWC register layout typedef
  *
  */
typedef struct {
    __IO uint32_t ECR;                           /**< Enable Control Register,              offset: 0x0 */
    __IO uint32_t CDR;                           /**< Clock Divider Register,               offset: 0x4 */
    __IO uint32_t IOR;                           /**< IO Control/Status Register,           offset: 0x8 */
    __IO uint32_t DFR;                           /**< Data Format Register,                 offset: 0xC */
    __IO uint32_t OCR;                           /**< Operation Command Register,           offset: 0x10 */
    __IO uint32_t TBR;                           /**< Transmit Buffer Register,             offset: 0x14 */
    __IO uint32_t RBR;                           /**< Receive Buffer Register,              offset: 0x18 */
    __IO uint32_t IER;                           /**< Interrupt Enable Register,            offset: 0x1C */
    __IO uint32_t IIR;                           /**< Interrupt Identification Register,    offset: 0x20 */
    __IO uint32_t CSR;                           /**< Control Status Register,              offset: 0x24 */
    __IO uint32_t RTCR;                          /**< Reset Timing Control Register,        offset: 0x28 */
    __IO uint32_t ATCR;                          /**< Access Timing Control Register,       offset: 0x2C */
} OWC_TypeDef;


/** @name ECR - OWC_ECR register */
/** @{ */
#define OWC_ECR_ENABLE_Pos                       (0)
#define OWC_ECR_ENABLE_Msk                       (0x1UL << OWC_ECR_ENABLE_Pos)

#define OWC_ECR_CLK_EN_Pos                       (1)
#define OWC_ECR_CLK_EN_Msk                       (0x1UL << OWC_ECR_CLK_EN_Pos)

#define OWC_ECR_AUTO_CGEN_Pos                    (2)
#define OWC_ECR_AUTO_CGEN_Msk                    (0x1UL << OWC_ECR_AUTO_CGEN_Pos)

#define OWC_ECR_RXD_MJR_Pos                      (3)
#define OWC_ECR_RXD_MJR_Msk                      (0x1UL << OWC_ECR_RXD_MJR_Pos)
/** @} */

/** @name CDR - OWC_CDR register */
/** @{ */
#define OWC_CDR_CLKUS_DIVIDER_Pos                (0)
#define OWC_CDR_CLKUS_DIVIDER_Msk                (0xFFUL << OWC_CDR_CLKUS_DIVIDER_Pos)
/** @} */

/** @name IOR - OWC_IOR register */
/** @{ */
#define OWC_IOR_SWMODE_EN_Pos                    (0)
#define OWC_IOR_SWMODE_EN_Msk                    (0x1UL << OWC_IOR_SWMODE_EN_Pos)

#define OWC_IOR_SWOEN_Pos                        (1)
#define OWC_IOR_SWOEN_Msk                        (0x1UL << OWC_IOR_SWOEN_Pos)

#define OWC_IOR_SWOUT_Pos                        (2)
#define OWC_IOR_SWOUT_Msk                        (0x1UL << OWC_IOR_SWOUT_Pos)

#define OWC_IOR_SWIN_Pos                         (3)
#define OWC_IOR_SWIN_Msk                         (0x1UL << OWC_IOR_SWIN_Pos)

#define OWC_IOR_SWIN_SYNC_Pos                    (4)
#define OWC_IOR_SWIN_SYNC_Msk                    (0x1UL << OWC_IOR_SWIN_SYNC_Pos)
/** @} */

/** @name DFR - OWC_DFR register */
/** @{ */
#define OWC_DFR_MODE_Pos                         (0)
#define OWC_DFR_MODE_Msk                         (0x1UL << OWC_DFR_MODE_Pos)

#define OWC_DFR_BYTE_ENDIAN_Pos                  (1)
#define OWC_DFR_BYTE_ENDIAN_Msk                  (0x1UL << OWC_DFR_BYTE_ENDIAN_Pos)

#define OWC_DFR_POLARITY_Pos                     (2)
#define OWC_DFR_POLARITY_Msk                     (0x1UL << OWC_DFR_POLARITY_Pos)
/** @} */

/** @name OCR - OWC_OCR register */
/** @{ */
#define OWC_OCR_FLUSH_Pos                        (0)
#define OWC_OCR_FLUSH_Msk                        (0x1UL << OWC_OCR_FLUSH_Pos)

#define OWC_OCR_RESET_Pos                        (1)
#define OWC_OCR_RESET_Msk                        (0x1UL << OWC_OCR_RESET_Pos)

#define OWC_OCR_WRITE_Pos                        (2)
#define OWC_OCR_WRITE_Msk                        (0x1UL << OWC_OCR_WRITE_Pos)

#define OWC_OCR_READ_Pos                         (3)
#define OWC_OCR_READ_Msk                         (0x1UL << OWC_OCR_READ_Pos)
/** @} */

/** @name TBR - OWC_TBR register */
/** @{ */
#define OWC_TBR_TX_BUF_Pos                       (0)
#define OWC_TBR_TX_BUF_Msk                       (0xFFUL << OWC_TBR_TX_BUF_Pos)
/** @} */

/** @name RBR - OWC_RBR register */
/** @{ */
#define OWC_RBR_RX_BUF_Pos                       (0)
#define OWC_RBR_RX_BUF_Msk                       (0xFFUL << OWC_RBR_RX_BUF_Pos)
/** @} */

/** @name IER - OWC_IER register */
/** @{ */
#define OWC_IER_RESET_Pos                        (1)
#define OWC_IER_RESET_Msk                        (0x1UL << OWC_IER_RESET_Pos)

#define OWC_IER_RESET_PD_Pos                     (2)
#define OWC_IER_RESET_PD_Msk                     (0x1UL << OWC_IER_RESET_PD_Pos)

#define OWC_IER_WRITE_Pos                        (3)
#define OWC_IER_WRITE_Msk                        (0x1UL << OWC_IER_WRITE_Pos)

#define OWC_IER_READ_Pos                         (4)
#define OWC_IER_READ_Msk                         (0x1UL << OWC_IER_READ_Pos)
/** @} */

/** @name IIR - OWC_IIR register */
/** @{ */
#define OWC_IIR_INT_CLR_Pos                      (0)
#define OWC_IIR_INT_CLR_Msk                      (0x1UL << OWC_IIR_INT_CLR_Pos)

#define OWC_IIR_RESET_Pos                        (1)
#define OWC_IIR_RESET_Msk                        (0x1UL << OWC_IIR_RESET_Pos)

#define OWC_IIR_RESET_PD_Pos                     (2)
#define OWC_IIR_RESET_PD_Msk                     (0x1UL << OWC_IIR_RESET_PD_Pos)

#define OWC_IIR_WRITE_Pos                        (3)
#define OWC_IIR_WRITE_Msk                        (0x1UL << OWC_IIR_WRITE_Pos)

#define OWC_IIR_READ_Pos                         (4)
#define OWC_IIR_READ_Msk                         (0x1UL << OWC_IIR_READ_Pos)

#define OWC_IIR_RESET_PD_RES_Pos                 (7)
#define OWC_IIR_RESET_PD_RES_Msk                 (0x1UL << OWC_IIR_RESET_PD_RES_Pos)
/** @} */

/** @name CSR - OWC_CSR register */
/** @{ */
#define OWC_CSR_SFTREG_Pos                       (0)
#define OWC_CSR_SFTREG_Msk                       (0xFFUL << OWC_CSR_SFTREG_Pos)

#define OWC_CSR_SFTCNT_Pos                       (8)
#define OWC_CSR_SFTCNT_Msk                       (0x7UL << OWC_CSR_SFTCNT_Pos)

#define OWC_CSR_FSM_Pos                          (12)
#define OWC_CSR_FSM_Msk                          (0x7UL << OWC_CSR_FSM_Pos)

#define OWC_CSR_USCNT_Pos                        (16)
#define OWC_CSR_USCNT_Msk                        (0x3FFUL << OWC_CSR_USCNT_Pos)

#define OWC_CSR_MODE_Pos                         (28)
#define OWC_CSR_MODE_Msk                         (0x3UL << OWC_CSR_MODE_Pos)

#define OWC_CSR_USCLK_ENABLE_Pos                 (31)
#define OWC_CSR_USCLK_ENABLE_Msk                 (0x1UL << OWC_CSR_USCLK_ENABLE_Pos)
/** @} */

/** @name RTCR - OWC_RTCR register */
/** @{ */
#define OWC_RTCR_SEND_DIV10_Pos                  (0)
#define OWC_RTCR_SEND_DIV10_Msk                  (0x7FUL << OWC_RTCR_SEND_DIV10_Pos)

#define OWC_RTCR_WAIT_DIV10_Pos                  (8)
#define OWC_RTCR_WAIT_DIV10_Msk                  (0x7FUL << OWC_RTCR_WAIT_DIV10_Pos)

#define OWC_RTCR_RDDLY_MIN_Pos                   (16)
#define OWC_RTCR_RDDLY_MIN_Msk                   (0x3FUL << OWC_RTCR_RDDLY_MIN_Pos)

#define OWC_RTCR_RDDLY_MAX_DIV10_Pos             (24)
#define OWC_RTCR_RDDLY_MAX_DIV10_Msk             (0x1FUL << OWC_RTCR_RDDLY_MAX_DIV10_Pos)
/** @} */

/** @name ATCR - OWC_ATCR register */
/** @{ */
#define OWC_ATCR_RECO_Pos                        (0)
#define OWC_ATCR_RECO_Msk                        (0x7UL << OWC_ATCR_RECO_Pos)

#define OWC_ATCR_SLOT_DIV10_Pos                  (8)
#define OWC_ATCR_SLOT_DIV10_Msk                  (0xFUL << OWC_ATCR_SLOT_DIV10_Pos)

#define OWC_ATCR_START_Pos                       (12)
#define OWC_ATCR_START_Msk                       (0x7UL << OWC_ATCR_START_Pos)

#define OWC_ATCR_WRDLY_Pos                       (16)
#define OWC_ATCR_WRDLY_Msk                       (0x1FUL << OWC_ATCR_WRDLY_Pos)

#define OWC_ATCR_RDDLY_Pos                       (24)
#define OWC_ATCR_RDDLY_Msk                       (0x1FUL << OWC_ATCR_RDDLY_Pos)
/** @} */

/** Peripheral OWC base pointer */
#define OWC                                      ((OWC_TypeDef *) AP_ONEWIRE_BASE_ADDR)

/**
  * @}
  */ /* end of group OWC */


/** @addtogroup PAD PAD
  * @{
  */

/** max number of addr in PAD */
#define PAD_ADDR_MAX_NUM                          (61U)

/**
  * @brief PAD register layout typedef
  *
  */
typedef struct {
    __IO uint32_t PCR[PAD_ADDR_MAX_NUM];          /**< PAD Control Register n, array offset: 0x0, array step:0x4 */
} PAD_TypeDef;

/** @name PCR - PAD_PCR register */
/** @{ */
#define PAD_PCR_MUX_Pos                          (4)
#define PAD_PCR_MUX_Msk                          (0x7UL << PAD_PCR_MUX_Pos)

#define PAD_PCR_PULL_UP_ENABLE_Pos               (8)
#define PAD_PCR_PULL_UP_ENABLE_Msk               (0x1UL << PAD_PCR_PULL_UP_ENABLE_Pos)

#define PAD_PCR_PULL_DOWN_ENABLE_Pos             (9)
#define PAD_PCR_PULL_DOWN_ENABLE_Msk             (0x1UL << PAD_PCR_PULL_DOWN_ENABLE_Pos)

#define PAD_PCR_PULL_SELECT_Pos                  (10)
#define PAD_PCR_PULL_SELECT_Msk                  (0x1UL << PAD_PCR_PULL_SELECT_Pos)

#define PAD_PCR_INPUT_BUFFER_ENABLE_Pos          (13)
#define PAD_PCR_INPUT_BUFFER_ENABLE_Msk          (0x1UL << PAD_PCR_INPUT_BUFFER_ENABLE_Pos)
/** @} */

/** Peripheral PAD base pointer */
#define PAD                                      ((PAD_TypeDef *) MP_PAD_BASE_ADDR)

/**
  * @}
  */ /* end of group PAD */

/** @addtogroup SPI SPI
  * @{
  */

/**
  * @brief SPI register layout typedef
  *
  */
typedef struct {
    __IO uint32_t CR0;                           /**< Control Register 0,                     offset: 0x0 */
    __IO uint32_t CR1;                           /**< Control Register 1,                     offset: 0x4 */
    __IO uint32_t DR;                            /**< Data Register,                          offset: 0x8 */
    __IO uint32_t SR;                            /**< Status Register,                        offset: 0xC */
    __IO uint32_t CPSR;                          /**< Clock Prescale Register,                offset: 0x10 */
    __IO uint32_t IMSC;                          /**< Interrupt Mask Set or Clear Register,   offset: 0x14 */
    __IO uint32_t RIS;                           /**< Raw Interrupt Status Register,          offset: 0x18 */
    __IO uint32_t MIS;                           /**< Masked Interrupt Status Register,       offset: 0x1C */
    __IO uint32_t ICR;                           /**< Interrupt Clear Register,               offset: 0x20 */
    __IO uint32_t DMACR;                         /**< DMA Control Register,                   offset: 0x24 */
} SPI_TypeDef;

/** @name CR0 - SPI_CR0 register */
/** @{ */
#define SPI_CR0_DSS_Pos                          (0)
#define SPI_CR0_DSS_Msk                          (0xFUL << SPI_CR0_DSS_Pos)

#define SPI_CR0_FRF_Pos                          (4)
#define SPI_CR0_FRF_Msk                          (0x3UL << SPI_CR0_FRF_Pos)

#define SPI_CR0_SPO_Pos                          (6)
#define SPI_CR0_SPO_Msk                          (0x1UL << SPI_CR0_SPO_Pos)

#define SPI_CR0_SPH_Pos                          (7)
#define SPI_CR0_SPH_Msk                          (0x1UL << SPI_CR0_SPH_Pos)

#define SPI_CR0_SCR_Pos                          (8)
#define SPI_CR0_SCR_Msk                          (0xFFUL << SPI_CR0_SCR_Pos)
/** @} */

/** @name CR1 - SPI_CR1 register */
/** @{ */
#define SPI_CR1_LBM_Pos                          (0)
#define SPI_CR1_LBM_Msk                          (0x1UL << SPI_CR1_LBM_Pos)

#define SPI_CR1_SSE_Pos                          (1)
#define SPI_CR1_SSE_Msk                          (0x1UL << SPI_CR1_SSE_Pos)

#define SPI_CR1_MS_Pos                           (2)
#define SPI_CR1_MS_Msk                           (0x1UL << SPI_CR1_MS_Pos)

#define SPI_CR1_SOD_Pos                          (3)
#define SPI_CR1_SOD_Msk                          (0x1UL << SPI_CR1_SOD_Pos)
/** @} */

/** @name DR - SPI_DR register */
/** @{ */
#define SPI_DR_DATA_Pos                          (0)
#define SPI_DR_DATA_Msk                          (0xFFFFUL << SPI_DR_DATA_Pos)
/** @} */

/** @name SR - SPI_SR register */
/** @{ */
#define SPI_SR_TFE_Pos                           (0)
#define SPI_SR_TFE_Msk                           (0x1UL << SPI_SR_TFE_Pos)

#define SPI_SR_TNF_Pos                           (1)
#define SPI_SR_TNF_Msk                           (0x1UL << SPI_SR_TNF_Pos)

#define SPI_SR_RNE_Pos                           (2)
#define SPI_SR_RNE_Msk                           (0x1UL << SPI_SR_RNE_Pos)

#define SPI_SR_RFF_Pos                           (3)
#define SPI_SR_RFF_Msk                           (0x1UL << SPI_SR_RFF_Pos)

#define SPI_SR_BSY_Pos                           (4)
#define SPI_SR_BSY_Msk                           (0x1UL << SPI_SR_BSY_Pos)
/** @} */

/** @name CPSR - SPI_CPSR register */
/** @{ */
#define SPI_CPSR_CPSDVSR_Pos                     (0)
#define SPI_CPSR_CPSDVSR_Msk                     (0xFFUL << SPI_CPSR_CPSDVSR_Pos)
/** @} */

/** @name IMSC - SPI_IMSC register */
/** @{ */
#define SPI_IMSC_RORIM_Pos                       (0)
#define SPI_IMSC_RORIM_Msk                       (0x1UL << SPI_IMSC_RORIM_Pos)

#define SPI_IMSC_RTIM_Pos                        (1)
#define SPI_IMSC_RTIM_Msk                        (0x1UL << SPI_IMSC_RTIM_Pos)

#define SPI_IMSC_RXIM_Pos                        (2)
#define SPI_IMSC_RXIM_Msk                        (0x1UL << SPI_IMSC_RXIM_Pos)

#define SPI_IMSC_TXIM_Pos                        (3)
#define SPI_IMSC_TXIM_Msk                        (0x1UL << SPI_IMSC_TXIM_Pos)
/** @} */

/** @name RIS - SPI_RIS register */
/** @{ */
#define SPI_RIS_RORRIS_Pos                       (0)
#define SPI_RIS_RORRIS_Msk                       (0x1UL << SPI_RIS_RORRIS_Pos)

#define SPI_RIS_RTRIS_Pos                        (1)
#define SPI_RIS_RTRIS_Msk                        (0x1UL << SPI_RIS_RTRIS_Pos)

#define SPI_RIS_RXRIS_Pos                        (2)
#define SPI_RIS_RXRIS_Msk                        (0x1UL << SPI_RIS_RXRIS_Pos)

#define SPI_RIS_TXRIS_Pos                        (3)
#define SPI_RIS_TXRIS_Msk                        (0x1UL << SPI_RIS_TXRIS_Pos)
/** @} */

/** @name MIS - SPI_MIS register */
/** @{ */
#define SPI_MIS_RORMIS_Pos                       (0)
#define SPI_MIS_RORMIS_Msk                       (0x1UL << SPI_MIS_RORMIS_Pos)

#define SPI_MIS_RTMIS_Pos                        (1)
#define SPI_MIS_RTMIS_Msk                        (0x1UL << SPI_MIS_RTMIS_Pos)

#define SPI_MIS_RXMIS_Pos                        (2)
#define SPI_MIS_RXMIS_Msk                        (0x1UL << SPI_MIS_RXMIS_Pos)

#define SPI_MIS_TXMIS_Pos                        (3)
#define SPI_MIS_TXMIS_Msk                        (0x1UL << SPI_MIS_TXMIS_Pos)
/** @} */

/** @name ICR - SPI_ICR register */
/** @{ */
#define SPI_ICR_RORIC_Pos                        (0)
#define SPI_ICR_RORIC_Msk                        (0x1UL << SPI_ICR_RORIC_Pos)

#define SPI_ICR_RTIC_Pos                         (1)
#define SPI_ICR_RTIC_Msk                         (0x1UL << SPI_ICR_RTIC_Pos)
/** @} */

/** @name DMACR - SPI_DMACR register */
/** @{ */
#define SPI_DMACR_RXDMAE_Pos                     (0)
#define SPI_DMACR_RXDMAE_Msk                     (0x1UL << SPI_DMACR_RXDMAE_Pos)

#define SPI_DMACR_TXDMAE_Pos                     (1)
#define SPI_DMACR_TXDMAE_Msk                     (0x1UL << SPI_DMACR_TXDMAE_Pos)
/** @} */

/** Peripheral SPI0 base pointer */
#define SPI0                                     ((SPI_TypeDef *)MP_SSP0_BASE_ADDR)

/** Peripheral SPI1 base pointer */
#define SPI1                                     ((SPI_TypeDef *)MP_SSP1_BASE_ADDR)

/** @brief SPI peripheral instance number */
#define SPI_INSTANCE_NUM                         (2)

/**
  * @}
  */ /* end of group SPI */

/** @addtogroup TIMER Timer
  * @{
  */

/**
  * @brief TIMER register layout typedef
  *
  */
typedef struct {
    __IO uint32_t TCCR;                          /**< Timer Clock Control Register,                offset: 0x0 */
    __IO uint32_t TCTLR;                         /**< Timer Control Register,                      offset: 0x4 */
    __IO uint32_t TSR;                           /**< Timer Status Register,                       offset: 0x8 */
    __IO uint32_t TIVR;                          /**< Timer Init Value Register,                   offset: 0xC */
    __IO uint32_t TMR[3];                        /**< Timer Match N Register, array offset: 0x10, array step: 0x4 */
    __I  uint32_t TCR;                           /**< Timer Counter Register,                      offset: 0x1C */
    __IO uint32_t TCLR;                          /**< Timer Counter Latch Register,                offset: 0x20 */
    __I  uint32_t TCAR;                          /**< Timer Counter Actual Register,               offset: 0x24 */
} TIMER_TypeDef;

/** @name TCCR - TIMER_TCCR register */
/** @{ */
#define TIMER_TCCR_ENABLE_Pos                    (0)
#define TIMER_TCCR_ENABLE_Msk                    (0x1UL << TIMER_TCCR_ENABLE_Pos)
/** @} */

/** @name TCTLR - TIMER_TCTLR register */
/** @{ */
#define TIMER_TCTLR_MODE_Pos                     (0)
#define TIMER_TCTLR_MODE_Msk                     (0x1UL << TIMER_TCTLR_MODE_Pos)

#define TIMER_TCTLR_MCS_Pos                      (1)
#define TIMER_TCTLR_MCS_Msk                      (0x3UL << TIMER_TCTLR_MCS_Pos)

#define TIMER_TCTLR_IE_0_Pos                     (3)
#define TIMER_TCTLR_IE_0_Msk                     (0x1UL << TIMER_TCTLR_IE_0_Pos)

#define TIMER_TCTLR_IE_1_Pos                     (4)
#define TIMER_TCTLR_IE_1_Msk                     (0x1UL << TIMER_TCTLR_IE_1_Pos)

#define TIMER_TCTLR_IE_2_Pos                     (5)
#define TIMER_TCTLR_IE_2_Msk                     (0x1UL << TIMER_TCTLR_IE_1_Pos)

#define TIMER_TCTLR_IT_0_Pos                     (6)
#define TIMER_TCTLR_IT_0_Msk                     (0x1UL << TIMER_TCTLR_IT_0_Pos)

#define TIMER_TCTLR_IT_1_Pos                     (7)
#define TIMER_TCTLR_IT_1_Msk                     (0x1UL << TIMER_TCTLR_IT_1_Pos)

#define TIMER_TCTLR_IT_2_Pos                     (8)
#define TIMER_TCTLR_IT_2_Msk                     (0x1UL << TIMER_TCTLR_IT_2_Pos)

#define TIMER_TCTLR_PWMOUT_Pos                   (9)
#define TIMER_TCTLR_PWMOUT_Msk                   (0x1UL << TIMER_TCTLR_PWMOUT_Pos)
/** @} */

/** @name TSR - TIMER_TSR register */
/** @{ */
#define TIMER_TSR_ICLR_0_Pos                     (0)
#define TIMER_TSR_ICLR_0_Msk                     (0x1UL << TIMER_TSR_ICLR_0_Pos)

#define TIMER_TSR_ICLR_1_Pos                     (1)
#define TIMER_TSR_ICLR_1_Msk                     (0x1UL << TIMER_TSR_ICLR_1_Pos)

#define TIMER_TSR_ICLR_2_Pos                     (2)
#define TIMER_TSR_ICLR_2_Msk                     (0x1UL << TIMER_TSR_ICLR_2_Pos)
/** @} */

/** @name TIVR - TIMER_TIVR register */
/** @{ */
#define TIMER_TIVR_VALUE_Pos                     (0)
#define TIMER_TIVR_VALUE_Msk                     (0xFFFFFFFFUL << TIMER_TIVR_VALUE_Pos)
/** @} */

/** @name TMR - TIMER_TMR N register */
/** @{ */
#define TIMER_TMR_MATCH_Pos                      (0)
#define TIMER_TMR_MATCH_Msk                      (0xFFFFFFFFUL << TIMER_TMR_MATCH_Pos)
/** @} */

/** @name TCR - TIMER_TCR register */
/** @{ */
#define TIMER_TCR_VALUE_Pos                      (0)
#define TIMER_TCR_VALUE_Msk                      (0xFFFFFFFFUL << TIMER_TCR_VALUE_Pos)
/** @} */

/** @name TCLR - TIMER_TCLR register */
/** @{ */
#define TIMER_TCLR_LATCH_Pos                      (0)
#define TIMER_TCLR_LATCH_Msk                      (0x1UL << TIMER_TCLR_LATCH_Pos)
/** @} */


/** @brief TIMER peripheral instance number */
#define TIMER_INSTANCE_NUM                       (6)

/**
  * @}
  */ /* end of group TIMER */


/** @addtogroup USART USART
  * @{
  */

/**
  * @brief USART register layout typedef
  *
  */
typedef struct {
    union{
    __IO uint32_t RBR;                           /**< Receive Buffer Register,                  offset: 0x0 */
    __IO uint32_t THR;                           /**< Transmit Holding Register,                offset: 0x0 */
    __IO uint32_t DLL;                           /**< Divisor Latch Low,                        offset: 0x0 */
    };
    union{
    __IO uint32_t DLH;                           /**< Divisor Latch High,                       offset: 0x4 */
    __IO uint32_t IER;                           /**< Interrupt Enable Register,                offset: 0x4 */
    };
    union{
    __IO uint32_t IIR;                           /**< Interrupt Identification Register,        offset: 0x8 */
    __IO uint32_t FCR;                           /**< FIFO Control Register,                    offset: 0x8 */
    };
    __IO uint32_t LCR;                           /**< Line Control Register,                    offset: 0xC */
    __IO uint32_t MCR;                           /**< Modem Control Register,                   offset: 0x10 */
    __IO uint32_t LSR;                           /**< Line Status Register,                     offset: 0x14 */
    __IO uint32_t MSR;                           /**< Modem Status Register,                    offset: 0x18 */
    __IO uint32_t SCR;                           /**< Scratchpad Register,                      offset: 0x1C */
    __IO uint32_t MFCR;                          /**< Main Function Control Register,           offset: 0x20 */
    __IO uint32_t EFCR;                          /**< Extended Function Control Register,       offset: 0x24 */
    __IO uint32_t LPDR;                          /**< SIR Divisor Register,                     offset: 0x28 */
    __IO uint32_t FCNR;                          /**< Tx and Rx FIFO Character Number Register, offset: 0x2C */
    __IO uint32_t ADCR;                          /**< Auto-baud Detect Control Register,        offset: 0x30 */
    __IO uint32_t ADRR;                          /**< Auto-baud Detect Result Register,         offset: 0x34 */
    __IO uint32_t ISR;                           /**< Interrupt Status Register,                offset: 0x38 */
    __IO uint32_t ICR;                           /**< Interrupt Clear Register,                 offset: 0x3C */
} USART_TypeDef;

/** @name RBR - USART_RBR register */
/** @{ */
#define USART_RBR_RX_BUF_Pos                     (0)
#define USART_RBR_RX_BUF_Msk                     (0xFFUL << USART_RBR_RX_BUF_Pos)
/** @} */

/** @name THR - USART_THR register */
/** @{ */
#define USART_THR_TX_HOLDING_Pos                 (0)
#define USART_THR_TX_HOLDING_Msk                 (0xFFUL << USART_THR_TX_HOLDING_Pos)
/** @} */

/** @name DLL - USART_DLL register */
/** @{ */
#define USART_DLL_DLL_Pos                        (0)
#define USART_DLL_DLL_Msk                        (0xFFUL << USART_DLL_DLL_Pos)
/** @} */

/** @name DLH - USART_DLH register */
/** @{ */
#define USART_DLH_DLH_Pos                        (0)
#define USART_DLH_DLH_Msk                        (0xFFUL << USART_DLH_DLH_Pos)
/** @} */

/** @name IER - USART_IER register */
/** @{ */
#define USART_IER_RX_DATA_REQ_Pos                (0)
#define USART_IER_RX_DATA_REQ_Msk                (0x1UL << USART_IER_RX_DATA_REQ_Pos)

#define USART_IER_TX_DATA_REQ_Pos                (1)
#define USART_IER_TX_DATA_REQ_Msk                (0x1UL << USART_IER_TX_DATA_REQ_Pos)

#define USART_IER_RX_LINE_STATUS_Pos             (2)
#define USART_IER_RX_LINE_STATUS_Msk             (0x1UL << USART_IER_RX_LINE_STATUS_Pos)

#define USART_IER_MODEM_STATUS_Pos               (3)
#define USART_IER_MODEM_STATUS_Msk               (0x1UL << USART_IER_MODEM_STATUS_Pos)

#define USART_IER_RX_TIMEOUT_Pos                 (4)
#define USART_IER_RX_TIMEOUT_Msk                 (0x1UL << USART_IER_RX_TIMEOUT_Pos)
/** @} */

/** @name IIR - USART_IIR register */
/** @{ */
#define USART_IIR_INT_PENDING_Pos                (0)
#define USART_IIR_INT_PENDING_Msk                (0x1UL << USART_IIR_INT_PENDING_Pos)

#define USART_IIR_INT_ID_Pos                     (1)
#define USART_IIR_INT_ID_Msk                     (0xFUL << USART_IIR_INT_ID_Pos)
/** @} */

/** @name FCR - USART_FCR register */
/** @{ */
#define USART_FCR_FIFO_EN_Pos                    (0)
#define USART_FCR_FIFO_EN_Msk                    (0x1UL << USART_FCR_FIFO_EN_Pos)

#define USART_FCR_RESET_RX_FIFO_Pos              (1)
#define USART_FCR_RESET_RX_FIFO_Msk              (0x1UL << USART_FCR_RESET_RX_FIFO_Pos)

#define USART_FCR_RESET_TX_FIFO_Pos              (2)
#define USART_FCR_RESET_TX_FIFO_Msk              (0x1UL << USART_FCR_RESET_TX_FIFO_Pos)

#define USART_FCR_DMA_MODE_Pos                   (3)
#define USART_FCR_DMA_MODE_Msk                   (0x1UL << USART_FCR_DMA_MODE_Pos)

#define USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos   (4)
#define USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Msk   (0x3UL << USART_FCR_TX_FIFO_EMPTY_TRIG_LEVEL_Pos)

#define USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos   (6)
#define USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Msk   (0x3UL << USART_FCR_RX_FIFO_AVAIL_TRIG_LEVEL_Pos)
/** @} */

/** @name LCR - USART_LCR register */
/** @{ */
#define USART_LCR_CHAR_LEN_Pos                   (0)
#define USART_LCR_CHAR_LEN_Msk                   (0x3UL << USART_LCR_CHAR_LEN_Pos)

#define USART_LCR_STOP_BIT_NUM_Pos               (2)
#define USART_LCR_STOP_BIT_NUM_Msk               (0x1UL << USART_LCR_STOP_BIT_NUM_Pos)

#define USART_LCR_PARITY_EN_Pos                  (3)
#define USART_LCR_PARITY_EN_Msk                  (0x1UL << USART_LCR_PARITY_EN_Pos)

#define USART_LCR_EVEN_PARITY_Pos                (4)
#define USART_LCR_EVEN_PARITY_Msk                (0x1UL << USART_LCR_EVEN_PARITY_Pos)

#define USART_LCR_STICKY_PARITY_Pos              (5)
#define USART_LCR_STICKY_PARITY_Msk              (0x1UL << USART_LCR_STICKY_PARITY_Pos)

#define USART_LCR_SET_BREAK_Pos                  (6)
#define USART_LCR_SET_BREAK_Msk                  (0x1UL << USART_LCR_SET_BREAK_Pos)

#define USART_LCR_ACCESS_DIVISOR_LATCH_Pos       (7)
#define USART_LCR_ACCESS_DIVISOR_LATCH_Msk       (0x1UL << USART_LCR_ACCESS_DIVISOR_LATCH_Pos)
/** @} */

/** @name MCR - USART_MCR register */
/** @{ */
#define USART_MCR_DTR_Pos                        (0)
#define USART_MCR_DTR_Msk                        (0x1UL << USART_MCR_DTR_Pos)

#define USART_MCR_RTS_Pos                        (1)
#define USART_MCR_RTS_Msk                        (0x1UL << USART_MCR_RTS_Pos)

#define USART_MCR_OUT1_Pos                       (2)
#define USART_MCR_OUT1_Msk                       (0x1UL << USART_MCR_OUT1_Pos)

#define USART_MCR_OUT2_Pos                       (3)
#define USART_MCR_OUT2_Msk                       (0x1UL << USART_MCR_OUT2_Pos)

#define USART_MCR_LOOPBACK_MODE_Pos              (4)
#define USART_MCR_LOOPBACK_MODE_Msk              (0x1UL << USART_MCR_LOOPBACK_MODE_Pos)
/** @} */

/** @name LSR - USART_LSR register */
/** @{ */
#define USART_LSR_RX_DATA_READY_Pos              (0)
#define USART_LSR_RX_DATA_READY_Msk              (0x1UL << USART_LSR_RX_DATA_READY_Pos)

#define USART_LSR_RX_OVERRUN_ERROR_Pos           (1)
#define USART_LSR_RX_OVERRUN_ERROR_Msk           (0x1UL << USART_LSR_RX_OVERRUN_ERROR_Pos)

#define USART_LSR_RX_PARITY_ERROR_Pos            (2)
#define USART_LSR_RX_PARITY_ERROR_Msk            (0x1UL << USART_LSR_RX_PARITY_ERROR_Pos)

#define USART_LSR_RX_FRAME_ERROR_Pos             (3)
#define USART_LSR_RX_FRAME_ERROR_Msk             (0x1UL << USART_LSR_RX_FRAME_ERROR_Pos)

#define USART_LSR_RX_BREAK_Pos                   (4)
#define USART_LSR_RX_BREAK_Msk                   (0x1UL << USART_LSR_RX_BREAK_Pos)

#define USART_LSR_TX_DATA_REQ_Pos                (5)
#define USART_LSR_TX_DATA_REQ_Msk                (0x1UL << USART_LSR_TX_DATA_REQ_Pos)

#define USART_LSR_TX_EMPTY_Pos                   (6)
#define USART_LSR_TX_EMPTY_Msk                   (0x1UL << USART_LSR_TX_EMPTY_Pos)

#define USART_LSR_RX_FIFO_ERROR_Pos              (7)
#define USART_LSR_RX_FIFO_ERROR_Msk              (0x1UL << USART_LSR_RX_FIFO_ERROR_Pos)

#define USART_LSR_RX_BUSY_Pos                    (10)
#define USART_LSR_RX_BUSY_Msk                    (0x1UL << USART_LSR_RX_FIFO_ERROR_Pos)

/** @} */

/** @name MSR - USART_MSR register */
/** @{ */
#define USART_MSR_CTS_CHANGED_Pos                (0)
#define USART_MSR_CTS_CHANGED_Msk                (0x1UL << USART_MSR_CTS_CHANGED_Pos)

#define USART_MSR_DSR_CHANGED_Pos                (1)
#define USART_MSR_DSR_CHANGED_Msk                (0x1UL << USART_MSR_DSR_CHANGED_Pos)

#define USART_MSR_RI_CHANGED_Pos                 (2)
#define USART_MSR_RI_CHANGED_Msk                 (0x1UL << USART_MSR_RI_CHANGED_Pos)

#define USART_MSR_DCD_CHANGED_Pos                (3)
#define USART_MSR_DCD_CHANGED_Msk                (0x1UL << USART_MSR_DCD_CHANGED_Pos)

#define USART_MSR_CTS_Pos                        (4)
#define USART_MSR_CTS_Msk                        (0x1UL << USART_MSR_CTS_Pos)

#define USART_MSR_DSR_Pos                        (5)
#define USART_MSR_DSR_Msk                        (0x1UL << USART_MSR_DSR_Pos)

#define USART_MSR_RI_Pos                         (6)
#define USART_MSR_RI_Msk                         (0x1UL << USART_MSR_RI_Pos)

#define USART_MSR_DCD_Pos                        (7)
#define USART_MSR_DCD_Msk                        (0x1UL << USART_MSR_DCD_Pos)
/** @} */

/** @name SCR - USART_SCR register */
/** @{ */
#define USART_SCR_SCRATCH_Pos                    (0)
#define USART_SCR_SCRATCH_Msk                    (0xFFUL << USART_SCR_SCRATCH_Pos)
/** @} */

/** @name MFCR - USART_MFCR register */
/** @{ */
#define USART_MFCR_UART_EN_Pos                   (0)
#define USART_MFCR_UART_EN_Msk                   (0x1UL << USART_MFCR_UART_EN_Pos)

#define USART_MFCR_NRZ_CODING_Pos                (1)
#define USART_MFCR_NRZ_CODING_Msk                (0x1UL << USART_MFCR_NRZ_CODING_Pos)

#define USART_MFCR_DMA_EN_Pos                    (2)
#define USART_MFCR_DMA_EN_Msk                    (0x1UL << USART_MFCR_DMA_EN_Pos)

#define USART_MFCR_AUTO_FLOW_RTS_EN_Pos          (4)
#define USART_MFCR_AUTO_FLOW_RTS_EN_Msk          (0x1UL << USART_MFCR_AUTO_FLOW_RTS_EN_Pos)

#define USART_MFCR_AUTO_FLOW_CTS_EN_Pos          (5)
#define USART_MFCR_AUTO_FLOW_CTS_EN_Msk          (0x1UL << USART_MFCR_AUTO_FLOW_CTS_EN_Pos)

#define USART_MFCR_PRESCALE_FACTOR_Pos           (8)
#define USART_MFCR_PRESCALE_FACTOR_Msk           (0x3UL << USART_MFCR_PRESCALE_FACTOR_Pos)

/** @} */

/** @name EFCR - USART_EFCR register */
/** @{ */
#define USART_EFCR_TX_MODE_Pos                   (0)
#define USART_EFCR_TX_MODE_Msk                   (0x1UL << USART_EFCR_TX_MODE_Pos)

#define USART_EFCR_RX_MODE_Pos                   (1)
#define USART_EFCR_RX_MODE_Msk                   (0x1UL << USART_EFCR_RX_MODE_Pos)

#define USART_EFCR_SIR_LOW_POWER_Pos             (2)
#define USART_EFCR_SIR_LOW_POWER_Msk             (0x1UL << USART_EFCR_SIR_LOW_POWER_Pos)

#define USART_EFCR_TX_POLARITY_Pos               (3)
#define USART_EFCR_TX_POLARITY_Msk               (0x1UL << USART_EFCR_TX_POLARITY_Pos)

#define USART_EFCR_RX_POLARITY_Pos               (4)
#define USART_EFCR_RX_POLARITY_Msk               (0x1UL << USART_EFCR_RX_POLARITY_Pos)

#define USART_EFCR_FRAC_DIVISOR_Pos              (8)
#define USART_EFCR_FRAC_DIVISOR_Msk              (0xFUL << USART_EFCR_FRAC_DIVISOR_Pos)
/** @} */

/** @name LPDR - USART_LPDR register */
/** @{ */
#define USART_LPDR_SIR_DIVISOR_Pos               (0)
#define USART_LPDR_SIR_DIVISOR_Msk               (0xFFFFUL << USART_LPDR_SIR_DIVISOR_Pos)
/** @} */

/** @name FCNR - USART_FCNR register */
/** @{ */
#define USART_FCNR_TX_FIFO_NUM_Pos               (0)
#define USART_FCNR_TX_FIFO_NUM_Msk               (0xFFUL << USART_FCNR_TX_FIFO_NUM_Pos)

#define USART_FCNR_RX_FIFO_NUM_Pos               (16)
#define USART_FCNR_RX_FIFO_NUM_Msk               (0xFFUL << USART_FCNR_RX_FIFO_NUM_Pos)
/** @} */

/** @name ADCR - USART_ADCR register */
/** @{ */
#define USART_ADCR_AUTO_BAUD_EN_Pos              (0)
#define USART_ADCR_AUTO_BAUD_EN_Msk              (0x1UL << USART_ADCR_AUTO_BAUD_EN_Pos)

#define USART_ADCR_AUTO_BAUD_INT_EN_Pos          (1)
#define USART_ADCR_AUTO_BAUD_INT_EN_Msk          (0x1UL << USART_ADCR_AUTO_BAUD_INT_EN_Pos)

#define USART_ADCR_AUTO_BAUD_PROG_SEL_Pos        (2)
#define USART_ADCR_AUTO_BAUD_PROG_SEL_Msk        (0x1UL << USART_ADCR_AUTO_BAUD_PROG_SEL_Pos)
/** @} */

/** @name ADRR - USART_ADRR register */
/** @{ */
#define USART_ADRR_AUTO_BAUD_INTE_Pos            (0)
#define USART_ADRR_AUTO_BAUD_INTE_Msk            (0xFFFFUL << USART_ADRR_AUTO_BAUD_INTE_Pos)

#define USART_ADRR_AUTO_BAUD_FRAC_Pos            (16)
#define USART_ADRR_AUTO_BAUD_FRAC_Msk            (0xFUL << USART_ADRR_AUTO_BAUD_FRAC_Pos)
/** @} */

/** @name ISR - USART_ISR register */
/** @{ */
#define USART_ISR_RX_DATA_REQ_Pos                (0)
#define USART_ISR_RX_DATA_REQ_Msk                (0x1UL << USART_ISR_RX_DATA_REQ_Pos)

#define USART_ISR_RX_TIMEOUT_Pos                 (1)
#define USART_ISR_RX_TIMEOUT_Msk                 (0x1UL << USART_ISR_RX_TIMEOUT_Pos)

#define USART_ISR_TX_DATA_REQ_Pos                (2)
#define USART_ISR_TX_DATA_REQ_Msk                (0x1UL << USART_ISR_TX_DATA_REQ_Pos)

#define USART_ISR_MODEM_STATUS_Pos               (3)
#define USART_ISR_MODEM_STATUS_Msk               (0x1UL << USART_ISR_MODEM_STATUS_Pos)

#define USART_ISR_RX_LINE_STATUS_Pos             (4)
#define USART_ISR_RX_LINE_STATUS_Msk             (0x1UL << USART_ISR_RX_LINE_STATUS_Pos)

#define USART_ISR_LCR_BUSY_Pos                   (5)
#define USART_ISR_LCR_BUSY_Msk                   (0x1UL << USART_ISR_LCR_BUSY_Pos)

#define USART_ISR_AUTO_BAUD_Pos                  (6)
#define USART_ISR_AUTO_BAUD_Msk                  (0x1UL << USART_ISR_AUTO_BAUD_Pos)
/** @} */

/** @name ICR - USART_ICR register */
/** @{ */
#define USART_ICR_RX_DATA_REQ_Pos                (0)
#define USART_ICR_RX_DATA_REQ_Msk                (0x1UL << USART_ICR_RX_DATA_REQ_Pos)

#define USART_ICR_RX_TIMEOUT_Pos                 (1)
#define USART_ICR_RX_TIMEOUT_Msk                 (0x1UL << USART_ICR_RX_TIMEOUT_Pos)

#define USART_ICR_TX_DATA_REQ_Pos                (2)
#define USART_ICR_TX_DATA_REQ_Msk                (0x1UL << USART_ICR_TX_DATA_REQ_Pos)

#define USART_ICR_MODEM_STATUS_Pos               (3)
#define USART_ICR_MODEM_STATUS_Msk               (0x1UL << USART_ICR_MODEM_STATUS_Pos)

#define USART_ICR_RX_LINE_STATUS_Pos             (4)
#define USART_ICR_RX_LINE_STATUS_Msk             (0x1UL << USART_ICR_RX_LINE_STATUS_Pos)

#define USART_ICR_LCR_BUSY_Pos                   (5)
#define USART_ICR_LCR_BUSY_Msk                   (0x1UL << USART_ICR_LCR_BUSY_Pos)

#define USART_ICR_AUTO_BAUD_Pos                  (6)
#define USART_ICR_AUTO_BAUD_Msk                  (0x1UL << USART_ICR_AUTO_BAUD_Pos)
/** @} */


/** Peripheral USART_0 base pointer */
#define USART_0                                  ((USART_TypeDef *)MP_UART0_BASE_ADDR)

/** Peripheral USART_1 base pointer */
#define USART_1                                  ((USART_TypeDef *)MP_UART1_BASE_ADDR)

/** Peripheral USART_2 base pointer */
#define USART_2                                  ((USART_TypeDef *)MP_UART2_BASE_ADDR)


/** @brief USART peripheral instance number */
#define USART_INSTANCE_NUM                       (3)

/**
  * @}
  */ /* end of group USART */

/** @addtogroup WDT Watchdog
  * @{
  */

/**
  * @brief WDT register layout typedef
  *
  */
typedef struct {
    __IO uint32_t CTRL;                          /**< WDT Control Register,               offset: 0x0 */
    __IO uint32_t TOVR;                          /**< WDT Timerout Value Register,        offset: 0x4 */
    __O  uint32_t CCR;                           /**< WDT Counter Clear Register,         offset: 0x8 */
    __O  uint32_t ICR;                           /**< WDT Interrupt Clear Register,       offset: 0xC */
    __O  uint32_t LOCK;                          /**< WDT Lock Register,                  offset: 0x10 */
    __I  uint32_t STAT;                          /**< WDT Status Register,                offset: 0x14 */
} WDT_TypeDef;

/** @name CTRL - WDT_CTRL register */
/** @{ */
#define WDT_CTRL_ENABLE_Pos                      (0)
#define WDT_CTRL_ENABLE_Msk                      (0x1UL << WDT_CTRL_ENABLE_Pos)

#define WDT_CTRL_MODE_Pos                        (1)
#define WDT_CTRL_MODE_Msk                        (0x1UL << WDT_CTRL_MODE_Pos)
/** @} */

/** @name TOVR - WDT_TOVR register */
/** @{ */
#define WDT_TOVR_VAL_Pos                         (0)
#define WDT_TOVR_VAL_Msk                         (0xFFFFUL << WDT_TOVR_VAL_Pos)
/** @} */

/** @name CCR - WDT_CCR register */
/** @{ */
#define WDT_CCR_CNT_CLR_Pos                      (0)
#define WDT_CCR_CNT_CLR_Msk                      (0x1UL << WDT_CCR_CNT_CLR_Pos)
/** @} */

/** @name ICR - WDT_ICR register */
/** @{ */
#define WDT_ICR_ICLR_Pos                         (0)
#define WDT_ICR_ICLR_Msk                         (0x1UL << WDT_ICR_ICLR_Pos)
/** @} */

/** @name LOCK - WDT_LOCK register */
/** @{ */
#define WDT_LOCK_LOCK_VAL_Pos                    (0)
#define WDT_LOCK_LOCK_VAL_Msk                    (0xFFFFUL << WDT_LOCK_LOCK_VAL_Pos)
/** @} */

/** @name STAT - WDT_STAT register */
/** @{ */
#define WDT_STAT_CV_Pos                          (0)
#define WDT_STAT_CV_Msk                          (0xFFFFUL << WDT_STAT_CV_Pos)

#define WDT_STAT_ISTAT_Pos                       (16)
#define WDT_STAT_ISTAT_Msk                       (0x1UL << WDT_STAT_ISTAT_Pos)
/** @} */

/** Peripheral WDT base pointer */
#define WDT                                      ((WDT_TypeDef *)AP_WDG_BASE_ADDR)

/**
  * @}
  */ /* end of group WDT */


/** @addtogroup oneWire
  * @{
  */

/**
  * @brief oneWire register layout typedef
  *
  */
typedef struct {
    __IO  uint32_t ECR;                          /**< OW Enable Control Register,                                offset: 0x0  */
    __IO  uint32_t CDR;                          /**< OW Clock Divider Register,                                 offset: 0x4  */
    __IO  uint32_t IOR;                          /**< OW IO Control/Status Register,                             offset: 0x8  */
    __IO  uint32_t DFR;                          /**< OW Data Format Register,                                   offset: 0xC  */
    __IO  uint32_t OCR;                          /**< OW Operation Cmd Register,                                 offset: 0x10 */
    __IO  uint32_t TBR;                          /**< OW Transmit Buffer Register,                               offset: 0x14 */
    __IO  uint32_t RBR;                          /**< OW Receive Buffer Register,                                offset: 0x18 */
    __IO  uint32_t IER;                          /**< OW Interrupt Enable Register,                              offset: 0x1C */
    __IO  uint32_t IIR;                          /**< OW Interrupt Identification Register,                      offset: 0x20 */
    __IO  uint32_t CSR;                          /**< OW Control Status Register,                                offset: 0x24 */
    __IO  uint32_t RTCR;                         /**< OW Reset Timing Control Register,                          offset: 0x28 */
    __IO  uint32_t ATCR;                         /**< OW Access(write/read) Timing Control Register,             offset: 0x2C */
} OW_TypeDef;

/** @name ECR - OW_ECR register */
/** @{ */
#define OW_ECR_ENABLE_Pos                        (0)
#define OW_ECR_ENABLE_Msk                        (0x1UL << OW_ECR_ENABLE_Pos)

#define OW_ECR_CLK_EN_Pos                        (1)
#define OW_ECR_CLK_EN_Msk                        (0x1UL << OW_ECR_CLK_EN_Pos)

#define OW_ECR_AUTO_CGEN_Pos                     (2)
#define OW_ECR_AUTO_CGEN_Msk                     (0x1UL << OW_ECR_AUTO_CGEN_Pos)

#define OW_ECR_RXD_MJR_Pos                       (3)
#define OW_ECR_RXD_MJR_Msk                       (0x1UL << OW_ECR_RXD_MJR_Pos)
/** @} */

/** @name CDR - OW_CDR register */
/** @{ */
#define OW_CDR_CLKUS_DIV_SUB1_Pos                (0)
#define OW_CDR_CLKUS_DIV_SUB1_Msk                (0xFFUL << OW_CDR_CLKUS_DIV_SUB1_Pos)
/** @} */

/** @name IOR - OW_IOR register */
/** @{ */
#define OW_IOR_IO_SWMODE_Pos                     (0)
#define OW_IOR_IO_SWMODE_Msk                     (0x1UL << OW_IOR_IO_SWMODE_Pos)

#define OW_IOR_IO_SWOEN_Pos                      (1)
#define OW_IOR_IO_SWOEN_Msk                      (0x1UL << OW_IOR_IO_SWOEN_Pos)

#define OW_IOR_IO_SWOUT_Pos                      (2)
#define OW_IOR_IO_SWOUT_Msk                      (0x1UL << OW_IOR_IO_SWOUT_Pos)

#define OW_IOR_IO_SWIN_Pos                       (3)
#define OW_IOR_IO_SWIN_Msk                       (0x1UL << OW_IOR_IO_SWIN_Pos)

#define OW_IOR_IO_SWIN_SYNC_Pos                  (4)
#define OW_IOR_IO_SWIN_SYNC_Msk                  (0x1UL << OW_IOR_IO_SWIN_SYNC_Pos)
/** @} */

/** @name DFR - OW_DFR register */
/** @{ */
#define OW_DFR_MODE_BYTE_Pos                     (0)
#define OW_DFR_MODE_BYTE_Msk                     (0x1UL << OW_DFR_MODE_BYTE_Pos)

#define OW_DFR_MODE_ENDIAN_Pos                   (1)
#define OW_DFR_MODE_ENDIAN_Msk                   (0x1UL << OW_DFR_MODE_ENDIAN_Pos)

#define OW_DFR_MODE_POLARITY_Pos                 (2)
#define OW_DFR_MODE_POLARITY_Msk                 (0x1UL << OW_DFR_MODE_POLARITY_Pos)
/** @} */

/** @name OCR - OW_OCR register */
/** @{ */
#define OW_OCR_CMD_FLUSH_Pos                     (0)
#define OW_OCR_CMD_FLUSH_Msk                     (0x1UL << OW_OCR_CMD_FLUSH_Pos)

#define OW_OCR_CMD_RESET_Pos                     (1)
#define OW_OCR_CMD_RESET_Msk                     (0x1UL << OW_OCR_CMD_RESET_Pos)

#define OW_OCR_CMD_WRITE_Pos                     (2)
#define OW_OCR_CMD_WRITE_Msk                     (0x1UL << OW_OCR_CMD_WRITE_Pos)

#define OW_OCR_CMD_READ_Pos                      (3)
#define OW_OCR_CMD_READ_Msk                      (0x1UL << OW_OCR_CMD_READ_Pos)
/** @} */

/** @name TBR - OW_TBR register */
/** @{ */
#define OW_TBR_TX_BUF_Pos                        (0)
#define OW_TBR_TX_BUF_Msk                        (0xFFUL << OW_TBR_TX_BUF_Pos)
/** @} */

/** @name RBR - OW_RBR register */
/** @{ */
#define OW_RBR_RX_BUF_Pos                        (0)
#define OW_RBR_RX_BUF_Msk                        (0xFFUL << OW_RBR_RX_BUF_Pos)
/** @} */

/** @name IER - OW_IER register */
/** @{ */
#define OW_IER_INTEN_RESET_Pos                   (1)
#define OW_IER_INTEN_RESET_Msk                   (0x1UL << OW_IER_INTEN_RESET_Pos)

#define OW_IER_INTEN_RESET_PD_Pos                (2)
#define OW_IER_INTEN_RESET_PD_Msk                (0x1UL << OW_IER_INTEN_RESET_PD_Pos)

#define OW_IER_INTEN_WRITE_Pos                   (3)
#define OW_IER_INTEN_WRITE_Msk                   (0x1UL << OW_IER_INTEN_WRITE_Pos)

#define OW_IER_INTEN_READ_Pos                    (4)
#define OW_IER_INTEN_READ_Msk                    (0x1UL << OW_IER_INTEN_READ_Pos)
/** @} */

/** @name IIR - OW_IIR register */
/** @{ */
#define OW_IIR_INT_CLR_Pos                       (0)
#define OW_IIR_INT_CLR_Msk                       (0x1UL << OW_IIR_INT_CLR_Pos)

#define OW_IIR_INT_RESET_Pos                     (1)
#define OW_IIR_INT_RESET_Msk                     (0x1UL << OW_IIR_INT_RESET_Pos)

#define OW_IIR_INT_RESET_PD_Pos                  (2)
#define OW_IIR_INT_RESET_PD_Msk                  (0x1UL << OW_IIR_INT_RESET_PD_Pos)

#define OW_IIR_INT_WRITE_Pos                     (3)
#define OW_IIR_INT_WRITE_Msk                     (0x1UL << OW_IIR_INT_WRITE_Pos)

#define OW_IIR_INT_READ_Pos                      (4)
#define OW_IIR_INT_READ_Msk                      (0x1UL << OW_IIR_INT_READ_Pos)

#define OW_IIR_RESET_PD_RES_Pos                  (7)
#define OW_IIR_RESET_PD_RES_Msk                  (0x1UL << OW_IIR_RESET_PD_RES_Pos)
/** @} */

/** @name CSR - OW_CSR register */
/** @{ */
#define OW_CSR_STATUS_SFTREG_Pos                 (0)
#define OW_CSR_STATUS_SFTREG_Msk                 (0xFFUL << OW_CSR_STATUS_SFTREG_Pos)

#define OW_CSR_STATUS_SFTCNT_Pos                 (8)
#define OW_CSR_STATUS_SFTCNT_Msk                 (0x7UL << OW_CSR_STATUS_SFTCNT_Pos)

#define OW_CSR_STATUS_FSM_Pos                    (12)
#define OW_CSR_STATUS_FSM_Msk                    (0x7UL << OW_CSR_STATUS_FSM_Pos)

#define OW_CSR_STATUS_USCNT_Pos                  (16)
#define OW_CSR_STATUS_USCNT_Msk                  (0x3FFUL << OW_CSR_STATUS_USCNT_Pos)

#define OW_CSR_STATUS_MODE_Pos                   (28)
#define OW_CSR_STATUS_MODE_Msk                   (0x3UL << OW_CSR_STATUS_MODE_Pos)

#define OW_CSR_STATUS_USCLK_ENABLE_Pos           (31)
#define OW_CSR_STATUS_USCLK_ENABLE_Msk           (0x1UL << OW_CSR_STATUS_USCLK_ENABLE_Pos)
/** @} */

/** @name RTCR - OW_RTCR register */
/** @{ */
#define OW_RTCR_RESET_SEND_DIV10_Pos             (0)
#define OW_RTCR_RESET_SEND_DIV10_Msk             (0x7FUL << OW_RTCR_RESET_SEND_DIV10_Pos)

#define OW_RTCR_RESET_WAIT_DIV10_Pos             (8)
#define OW_RTCR_RESET_WAIT_DIV10_Msk             (0x7FUL << OW_RTCR_RESET_WAIT_DIV10_Pos)

#define OW_RTCR_RESET_RDDLY_MIN_Pos              (16)
#define OW_RTCR_RESET_RDDLY_MIN_Msk              (0x3FUL << OW_RTCR_RESET_RDDLY_MIN_Pos)

#define OW_RTCR_RESET_RDDLY_MAX_DIV10_Pos        (24)
#define OW_RTCR_RESET_RDDLY_MAX_DIV10_Msk        (0x1FUL << OW_RTCR_RESET_RDDLY_MAX_DIV10_Pos)

/** @} */

/** @name ATCR - OW_ATCR register */
/** @{ */
#define OW_ATCR_WRRD_RECO_Pos                    (0)
#define OW_ATCR_WRRD_RECO_Msk                    (0x7UL << OW_ATCR_WRRD_RECO_Pos)

#define OW_ATCR_WRRD_SLOT_DIV10_Pos              (8)
#define OW_ATCR_WRRD_SLOT_DIV10_Msk              (0xFUL << OW_ATCR_WRRD_SLOT_DIV10_Pos)

#define OW_ATCR_WRRD_START_Pos                   (12)
#define OW_ATCR_WRRD_START_Msk                   (0x7UL << OW_ATCR_WRRD_START_Pos)

#define OW_ATCR_WRRD_WRDLY_Pos                   (16)
#define OW_ATCR_WRRD_WRDLY_Msk                   (0x1FUL << OW_ATCR_WRRD_WRDLY_Pos)

#define OW_ATCR_WRRD_RDDLY_Pos                   (24)
#define OW_ATCR_WRRD_RDDLY_Msk                   (0x1FUL << OW_ATCR_WRRD_RDDLY_Pos)

/** @} */


/** Peripheral OW base pointer */
#define OW                                      ((OW_TypeDef *)AP_ONEWIRE_BASE_ADDR)

/**
  * @}
  */ /* end of group OW */


/** @addtogroup XIC XIC(external interrupt controller)
  * @{
  */



/**
  * @brief XIC register layout typedef
  *
  */
typedef struct {
    __IO uint32_t LATCHIRQ;                      /**< Latch IRQ Register,                           offset: 0x0 */
    __IO uint32_t IRQSTATUS;                     /**< IRQ Status Register,                          offset: 0x4 */
    __IO uint32_t MASK;                          /**< IRQ Mask Register,                            offset: 0x8 */
    __IO uint32_t PEND;                          /**< Pend Register,                                offset: 0xC */
    __IO uint32_t SWGENIRQ;                      /**< Software Generat IRQ Register,                offset: 0x10 */
    __IO uint32_t CLRIRQ;                        /**< IRQ Clear Register,                           offset: 0x14 */
    __IO uint32_t CLROVF;                        /**< Clear IRQ Overflow Register,                  offset: 0x18 */
    __IO uint32_t OVFSTATUS;                     /**< IRQ Overflow Status Register,                 offset: 0x1C */
} XIC_TypeDef;

/** AP XIC_0 for IPC/APB base pointer */
#define APXIC_0                                    ((XIC_TypeDef *)APXIC0_BASE_ADDR)

/** AP XIC_1 for APB/AHB base pointer */
#define APXIC_1                                    ((XIC_TypeDef *)APXIC1_BASE_ADDR)

/** AP ULDP XIC_2 base pointer */
#define APXIC_2                                    ((XIC_TypeDef *)APXIC2_BASE_ADDR)

/** AP USB XIC_3 base pointer */
#define APXIC_3                                    ((XIC_TypeDef *)APXIC3_BASE_ADDR)


/**
  * @}
  */ /* end of group XIC */
/** @addtogroup DMA DMA
  * @{
  */

/** @brief Number of DMA channel */
#define DMA_NUMBER_OF_HW_CHANNEL_SUPPORTED       (8U)

/** @brief List of DMA request sources */
typedef enum
{
    DMA_MEMORY_TO_MEMORY = -1,                     /**< Dummy for memory to memory transfer */
    DMA_REQUEST_LPUSART_RX = 4,                    /**< LPUSART RX                          */
    DMA_REQUEST_USART0_TX,                         /**< USART0 TX                           */
    DMA_REQUEST_USART0_RX,                         /**< USART0 RX                           */
    DMA_REQUEST_USART1_TX,                         /**< USART1 TX                           */
    DMA_REQUEST_USART1_RX,                         /**< USART1 RX                           */
    DMA_REQUEST_USART2_TX,                         /**< USART2 TX                           */
    DMA_REQUEST_USART2_RX,                         /**< USART2 RX                           */
    DMA_REQUEST_SPI0_TX,                           /**< SPI0 TX                             */
    DMA_REQUEST_SPI0_RX,                           /**< SPI0 RX                             */
    DMA_REQUEST_SPI1_TX,                           /**< SPI1 TX                             */
    DMA_REQUEST_SPI1_RX,                           /**< SPI1 RX                             */
    DMA_REQUEST_I2S0_TX,                           /**< I2S0 TX                             */
    DMA_REQUEST_I2S0_RX,                           /**< I2S0 RX                             */
    DMA_REQUEST_I2S1_TX,                           /**< I2S1 TX                             */
    DMA_REQUEST_I2S1_RX,                           /**< I2S1 RX                             */


    DMA_REQUEST_I2C0_TX = 3,                       /**< I2C0 TX                             */
    DMA_REQUEST_I2C0_RX,                           /**< I2C0 RX                             */
    DMA_REQUEST_I2C1_TX,                           /**< I2C1 TX                             */
    DMA_REQUEST_I2C1_RX,                           /**< I2C1 RX                             */
    DMA_REQUEST_USIM0_TX,                          /**< USIM0 TX                            */
    DMA_REQUEST_USIM0_RX,                          /**< USIM0 RX                            */
    DMA_REQUEST_USIM1_TX,                          /**< USIM1 TX                            */
    DMA_REQUEST_USIM1_RX,                          /**< USIM1 RX                            */

    DMA_REQUEST_FLASH_TX = 44,                     /**< FLASH TX                            */
    DMA_REQUEST_FLASH_RX,                          /**< FLASH RX                            */
    DMA_REQUEST_PSRAM_TX,
    DMA_REQUEST_PSRAM_RX,
    DMA_REQUEST_UNILOG_TX,                         /**< UNILOG TX                           */
} DmaRequestSource_e;

/** @brief DMA channel mapping */
#define UNILOG_TX_CHANNEL                        (0)

/**
  * @}
  */ /* end of group DMA */


/*  End of section using anonymous unions and disabling warnings   */
#if   defined (__CC_ARM)
  #pragma pop
#elif defined (__ICCARM__)
  /* leave anonymous unions enabled */
#elif (__ARMCC_VERSION >= 6010050)
  #pragma clang diagnostic pop
#elif defined (__GNUC__)
  /* anonymous unions are enabled by default */
#elif defined (__TMS470__)
  /* anonymous unions are enabled by default */
#elif defined (__TASKING__)
  #pragma warning restore
#elif defined (__CSMC__)
  /* anonymous unions are enabled by default */
#else
  #warning Not supported compiler type
#endif

/** @addtogroup Bit_Field_Access_Macros Macros for use with bit field definitions (xxx_Pos, xxx_Msk)
  * @{
  */

/**
 * @brief   Mask and shift a bit field value for use in a register bit range
 *
 * @param[in] field  Name of the register bit field
 * @param[in] value  Value of the bit field
 * @return           Masked and shifted value
 */
#define EIGEN_VAL2FLD(field, value)    (((value) << field ## _Pos) & field ## _Msk)

/**
 * @brief     Mask and shift a register value to extract a bit filed value
 *
 * @param[in] field  Name of the register bit field
 * @param[in] value  Value of register
 * @return           Masked and shifted bit field value
*/
#define EIGEN_FLD2VAL(field, value)    (((value) & field ## _Msk) >> field ## _Pos)

/**
  * @}
  */ /* end of group Bit_Field_Access_Macros */

/**
  * @}
  */ /* end of group Device_peripheral_access */

#ifdef __cplusplus
}
#endif

#endif /* EC618_H */
