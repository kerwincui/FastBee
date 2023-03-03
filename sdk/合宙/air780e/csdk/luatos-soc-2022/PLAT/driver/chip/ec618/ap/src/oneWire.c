/****************************************************************************
 *
 * Copy right:   2020-, Copyrigths of AirM2M Ltd.
 * File name:    oneWire.c
 * Description:  EC618 one wire bus driver source file
 * History:      Rev1.0   2020-12-17
 *
 ****************************************************************************/
#include "ec618.h"
#include "bsp.h"
#include "oneWire.h"
#include "hal_misc.h"

extern void delay_us(uint32_t us);


#if OW_DEBUG_EN
#define  OW_DEBUG(...)     printf(__VA_ARGS__)
#else
#define OW_DEBUG(...)
#endif

#define OW_IRQ_MODE     1

static volatile OwStats_e owStats = OW_IDLE;

#define OW_PAD_ADDR     (17)        //(19)->gpio4       (17)->gpio2             (48)->gpio28        (22)->gpio7
#define OW_PAD_FUNC     PAD_MUX_ALT4 //PAD_MUX_ALT3       PAD_MUX_ALT4             PAD_MUX_ALT4         PAD_MUX_ALT4


uint8_t *readBuf = NULL;

#if (OW_IRQ_MODE == 1)
void owIrqHandler(void);
#else
    int A, B, C, D, E, F, G, H, I, J;
#endif

void owSetMode(OwModeSel_e mode)
{
    if (mode == STANDARD)
    {
#if (OW_IRQ_MODE == 1)
#if 0
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_SEND_DIV10, 50);
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_WAIT_DIV10, 50);
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_RDDLY_MIN, 15);
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_RDDLY_MAX_DIV10, 10);

        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_RECO, 2);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_SLOT_DIV10, 7);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_START, 1);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_WRDLY, 14);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_RDDLY, 11);
#endif
#else
        OW->ECR |= OW_ECR_RXD_MJR_Msk;

        A = 2;  // 6us
        B = 12; // 64us
        C = 16; // 60us
        D = 1;  // 10us
        E = 5;  // 9us
        F = 28; // 55us
        G = 0;
        H = 120;// 480us
        I = 35; // 70us
        J = 150;// 410us
#endif
    }
    else
    {
#if (OW_IRQ_MODE == 1)
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_SEND_DIV10, 50);
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_WAIT_DIV10, 50);
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_RDDLY_MIN, 15);
        OW->RTCR = EIGEN_VAL2FLD(OW_RTCR_RESET_RDDLY_MAX_DIV10, 10);

        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_RECO, 2);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_SLOT_DIV10, 7);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_START, 1);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_WRDLY, 14);
        OW->ATCR = EIGEN_VAL2FLD(OW_ATCR_WRRD_RDDLY, 11);
#else

#endif
    }
}

#if (OW_IRQ_MODE != 1)
void write(uint8_t val)
{
    if (val == 1)
    {
        OW->IOR |= OW_IOR_IO_SWOEN_Msk;
        OW->IOR |= OW_IOR_IO_SWOUT_Msk;
    }
    else
    {
        OW->IOR |= OW_IOR_IO_SWOEN_Msk;
        OW->IOR &= ~OW_IOR_IO_SWOUT_Msk;
    }
}

uint8_t read()
{
    uint8_t retData, rmjData;

    OW->IOR &= ~OW_IOR_IO_SWOEN_Msk;
    rmjData = EIGEN_FLD2VAL(OW_ECR_RXD_MJR, OW->ECR);

    if (rmjData > 0)
    {
        retData = EIGEN_FLD2VAL(OW_IOR_IO_SWIN_SYNC, OW->IOR);
    }
    else
    {
        retData = EIGEN_FLD2VAL(OW_IOR_IO_SWIN, OW->IOR);
    }

    return retData;
}
#endif



void owInit()
{
    GPR_clockEnable(PCLK_ONEW);

    // configure onew pins
    PadConfig_t padConfig;
    PAD_getDefaultConfig(&padConfig);
    padConfig.mux = OW_PAD_FUNC;
    PAD_setPinConfig(OW_PAD_ADDR, &padConfig);

#if (OW_IRQ_MODE == 1)
    OW->IOR &= ~OW_IOR_IO_SWMODE_Msk;
    XIC_SetVector(PXIC0_ONEW_IRQn, owIrqHandler);
    XIC_EnableIRQ(PXIC0_ONEW_IRQn);
#else
    OW->IOR |= OW_IOR_IO_SWMODE_Msk;
#endif

    OW->ECR |= OW_ECR_ENABLE_Msk; // enable onewire
}

void owDeInit()
{
#if (OW_IRQ_MODE == 1)
    XIC_DisableIRQ(PXIC0_ONEW_IRQn);
#endif

    GPR_clockDisable(PCLK_ONEW);
}


#if (OW_IRQ_MODE == 1)
volatile uint32_t irqNo;
volatile uint16_t count = 0;
void owIrqHandler()
{
    ++count;
    irqNo = OW->IIR;

    // Disable ONEW IRQ
    XIC_DisableIRQ(PXIC0_ONEW_IRQn);

    // Clear pending ONEW interrupts
    XIC_ClearPendingIRQ(PXIC0_ONEW_IRQn);

    if ((OW->IIR & OW_IIR_INT_RESET_PD_Msk) && ((OW->IIR & OW_IIR_INT_RESET_Msk)!=OW_IIR_INT_RESET_Msk))
    {
        OW->IER &= ~OW_IER_INTEN_RESET_PD_Msk;

        owStats |= OW_RESET_SUCCESS;

        OW->IIR |= OW_IIR_INT_CLR_Msk;
    }
    else if ((OW->IIR & OW_IIR_INT_RESET_Msk) && (OW->IIR & OW_IIR_INT_RESET_PD_Msk))
    {
        if (OW->IIR & OW_IIR_RESET_PD_RES_Msk)
        {
            owStats |= OW_RESETPD_SUCCESS;
        }
        else
        {
            owStats &= ~OW_RESETPD_SUCCESS;
        }

        OW->IIR |= OW_IIR_INT_CLR_Msk;
        OW->IER &= ~OW_IER_INTEN_RESET_PD_Msk;
    }
    else if (OW->IIR & OW_IIR_INT_WRITE_Msk)
    {
        if (OW->IIR & OW_IIR_INT_WRITE_Msk)
        {
            owStats |= OW_WRITE_SUCCESS;
        }
        else
        {
            owStats &= ~OW_WRITE_SUCCESS;
        }

        OW->IIR |= OW_IIR_INT_CLR_Msk;
        OW->IER &= ~OW_IER_INTEN_WRITE_Msk;
    }
    else if (OW->IIR & OW_IIR_INT_READ_Msk)
    {
        *readBuf = OW->RBR;

        if (OW->IIR & OW_IIR_INT_READ_Msk)
        {
            owStats |= OW_READ_SUCCESS;
        }
        else
        {
            owStats &= ~OW_READ_SUCCESS;
        }

        OW->IIR |= OW_IIR_INT_CLR_Msk;
        OW->IER &= ~OW_IER_INTEN_READ_Msk;
    }

    OW->OCR |= OW_OCR_CMD_FLUSH_Msk;

    XIC_EnableIRQ(PXIC0_ONEW_IRQn);
}
#endif


int32_t owReset()
{
#if (OW_IRQ_MODE == 1)
    OW->IER |= OW_IER_INTEN_RESET_PD_Msk;
    OW->IER |= OW_IER_INTEN_RESET_Msk;
    OW->OCR |= OW_OCR_CMD_RESET_Msk;
    while ((owStats & OW_RESET_SUCCESS) != OW_RESET_SUCCESS);

    owStats &= ~OW_RESET_SUCCESS;

#else

#endif
    return OWDRV_OK;
}
int32_t owResetPd()
{
#if (OW_IRQ_MODE == 1)
    OW->IER |= OW_IER_INTEN_RESET_Msk;
    delay_us(20); // wait until former irq finish
    OW->OCR |= OW_OCR_CMD_RESET_Msk;

    while ((owStats & OW_RESETPD_SUCCESS) != OW_RESETPD_SUCCESS);
    owStats &= ~OW_RESETPD_SUCCESS;

    return OWDRV_OK;
#else
    delay_us(50);
    //owDelay(G);
    write(0);
    delay_us(H);
    write(1);
    delay_us(I);
    int ret = read();
    delay_us(J);
    if (ret == 1)
    {
        owStats |= OW_RESETPD_SUCCESS;
        return OWDRV_OK;
    }
    else
    {
        owStats &= ~OW_RESETPD_SUCCESS;
        return OWDRV_RESETPD_ERR;
    }
#endif
}

int32_t owWriteBit(uint8_t data)
{
#if (OW_IRQ_MODE == 1)
    OW->DFR &= ~OW_DFR_MODE_BYTE_Msk;
    OW->TBR = data;
    OW->IER |= OW_IER_INTEN_WRITE_Msk;
    OW->OCR |= OW_OCR_CMD_WRITE_Msk;

    while ((owStats & OW_WRITE_SUCCESS) != OW_WRITE_SUCCESS);
    owStats &= ~OW_WRITE_SUCCESS;
#else
    if (data == 1)
    {
        write(0);
        delay_us(A);
        write(1);
        delay_us(B);
    }
    else
    {
        write(0);
        delay_us(C);
        write(1);
        delay_us(D);
    }
#endif

    return OWDRV_OK;
}

int32_t owReadBit(uint8_t * dataRead)
{
    if (dataRead != NULL)
    {
        readBuf = dataRead;
    }

#if (OW_IRQ_MODE == 1)
    OW->DFR &= ~OW_DFR_MODE_BYTE_Msk;
    OW->IER |= OW_IER_INTEN_READ_Msk;
    OW->OCR |= OW_OCR_CMD_READ_Msk;

    while ((owStats & OW_READ_SUCCESS) != OW_READ_SUCCESS);
    owStats &= ~OW_READ_SUCCESS;
#else
    write(0);
    delay_us(1);
    write(1);
    delay_us(2);
    *dataRead = read();
    delay_us(14);
#endif

    return OWDRV_OK;
}

int32_t owWriteByte(uint8_t data)
{
#if (OW_IRQ_MODE == 1)
    OW->DFR |= OW_DFR_MODE_BYTE_Msk;
    OW->TBR = data;
    OW->IER |= OW_IER_INTEN_WRITE_Msk;
    OW->OCR |= OW_OCR_CMD_WRITE_Msk;

    while ((owStats & OW_WRITE_SUCCESS) != OW_WRITE_SUCCESS);
    owStats &= ~OW_WRITE_SUCCESS;
#else
    for (int i=0; i<8; i++)
    {
        owWriteBit(data & 0x01);
        data >>= 1;
    }
#endif

    return OWDRV_OK;
}

int32_t owReadByte(uint8_t * dataRead)
{
    if (dataRead != NULL)
    {
        readBuf = dataRead;
    }

#if (OW_IRQ_MODE == 1)
    OW->DFR |= OW_DFR_MODE_BYTE_Msk;

    OW->IER |= OW_IER_INTEN_READ_Msk;
    OW->OCR |= OW_OCR_CMD_READ_Msk;

    while ((owStats & OW_READ_SUCCESS) != OW_READ_SUCCESS);

    owStats &= ~OW_READ_SUCCESS;
#else
    uint8_t result=0;
    uint8_t readBitVal[8];
    memset(readBitVal, 0, 8);

    for (int i=0; i<8; i++)
    {
        result >>= 1;
        owReadBit(readBitVal+i);

        if (readBitVal[i] == 1)
        {
            result |= 0x80;
        }
    }
    *dataRead = result;
#endif

    return OWDRV_OK;
}

int32_t owTouchByte(uint8_t data)
{
    int32_t result = 0;

    for (uint8_t i=0; i<8; i++)
    {
        result >>= 1;

        // if sending a '1' then read a bit, else write a '0'
        if (data & 0x01)
        {
            if (owReadBit(NULL))
            {
                result |= 0x80;
            }
        }
        else
        {
            owWriteBit(0);
        }

        data >>= 1;
    }

    return result;
}

