#ifndef __RNG_EC618_H__
#define __RNG_EC618_H__

#include "ec618.h"
#include "Driver_Common.h"
#include "clock.h"
#include "ic.h"
#include "string.h"

#define RNG_DEBUG_USING_PRINTF          0
#define RNG_DEBUG_USING_UNILOG          0

#define RNG_IRQ_MODE                    0

#define RNG_MAX_POLL_DELAY_US           (8000*2)
#define RNG_MAX_TRY_NUM                 10
#define RNG                             ((RngDesc_t*)MP_TRNG_BASE_ADDR)
#define RNG_R_MAGIC                     0xf45a97d4



#if (RNG_DEBUG_USING_UNILOG == 1)
#include DEBUG_LOG_HEADER_FILE
#endif

#ifdef PM_FEATURE_ENABLE
#include "slpman.h"
#endif


#if RNG_DEBUG_USING_PRINTF
#define RNGDEBUG(...)     printf(__VA_ARGS__)
#else
#define RNGDEBUG(...)
#endif



typedef struct
{
    __IM uint32_t rsvd1[64];
    __IO uint32_t imrReg;               //Interrupt mask reg ,0x100
    __IO uint32_t isrReg;               //Interrupt status reg
    __OM uint32_t icrReg;               //Interrupt clear reg
    __IO uint32_t cfgReg;               //Configuration reg
    __IM uint32_t validReg;             //Valid reg
    __IM uint32_t dataReg[6];
    __IO uint32_t srcEnableReg;         //Random source enable reg
    __IO uint32_t sampleCntReg;         //Sample Count reg
    __IO uint32_t autoCorrReg;          //Auto correlation reg
    __IM uint32_t debugCtrlReg;         //Debug Control reg
    __IM uint32_t rsvd2;
    __OM uint32_t swRstReg;             //Reset reg
    __IM uint32_t rsvd3[29];
    __IM uint32_t busyReg;              //Busy reg
    __OM uint32_t rstBitsCntReg;        //Reset bits counter reg
    __IM uint32_t rsvd4[8];
    __IM uint32_t bistCntReg[3];        //BIST Counter reg
    __IO uint32_t rsvd5[5];
}RngDesc_t;

typedef enum
{
    RNG_SRC_SHORT_TEST_TYPE = 0,
    RNG_SRC_SHORT_TYPE      = 1,
    RNG_SRC_LONG_TYPE       = 2,
    RNG_SRC_LONGEST_TYPE    = 3,
}RngSrcSelType_e;

#define RNGDRV_OK               (0)
#define RNGDRV_IntErr           (-1)
#define RNGDRV_TimeOutErr       (-2)

typedef enum{
    RNG_EHR_VALID_TYPE      = 1,
    RNG_AUTO_CORR_ERR_TYPE  = 2,
    RNG_CRNGT_ERR_TYPE      = 4,
    RNG_VN_ERR_TYPE         = 8
}RngIntStatType_e;

/**
  \brief When rand is null, means generate random number to efuse. If rand isn't null, means generate to this parameter.
  \param[out] rand   Memory address to receive generated random number.
  \return status              
*/
int32_t rngGenRandom(uint8_t rand[24]);
#endif
