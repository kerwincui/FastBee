/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    hal_i2s.c
 * Description:  EC618 i2s hal driver source file
 * History:      Rev1.0   2021-9-18
 *
 ****************************************************************************/

#include "hal_i2s.h"

void es8388MasterInit(void);
void es8388SlaveInit(void);
void nau88c22SlaveInit(void);
void nau88c22MasterInit(void);
void es8311MasterInit(void);
void es8311SlaveInit(void);

extern i2sDrvInterface_t    i2sDrvInterface0;
extern i2sDrvInterface_t    i2sDrvInterface1;

#if (RTE_I2S0)
static i2sDrvInterface_t   *i2sDrv = &CREATE_SYMBOL(i2sDrvInterface, 0); // Choose i2s0
#elif (RTE_I2S1)
static i2sDrvInterface_t   *i2sDrv = &CREATE_SYMBOL(i2sDrvInterface, 1); // Choose i2s1
#endif

extern i2sDataFmt_t         i2sDataFmt;
extern i2sSlotCtrl_t        i2sSlotCtrl;
extern i2sBclkFsCtrl_t      i2sBclkFsCtrl;
extern i2sCtrl_t            i2sCtrl;
extern i2sDmaCtrl_t         i2sDmaCtrl;


static codecType_e          codecType; // Record codec type
static i2sMode_e            i2sMode;

// Register 
void HAL_I2sInit(i2sPowerCtrl_e powerCtrl, i2sCbFunc_fn txCb, i2sCbFunc_fn rxCb)
{
    i2sDrv->init(txCb, rxCb);

    switch (powerCtrl)
    {
        case I2S_CLK_DISABLE:
            i2sDrv->powerCtrl(I2S_POWER_OFF);
            break;

        case I2S_CLK_ENABLE:
            i2sDrv->powerCtrl(I2S_POWER_FULL);
            break;
    }
}

void HAL_I2SSetTotalNum(uint32_t totalNum)
{
    i2sDrv->ctrl(I2S_CTRL_SET_TOTAL_NUM , totalNum);
}

uint32_t HAL_I2SGetTotalNum()
{
	return i2sDrv->getTotalCnt();
}

void HAL_I2SSetPlayRecord(i2sPlayRecord_e playRecord)
{
    if (playRecord == PLAY)
    {
        i2sCtrl.i2sMode = 0x1; // Set I2S controller to send
        i2sDmaCtrl.txDmaReqEn = 1;
        i2sDmaCtrl.rxDmaReqEn = 0;
    }
    else if (playRecord == RECORD)
    {
        i2sCtrl.i2sMode = 0x2; // Set I2S controller to receive
        i2sDmaCtrl.rxDmaReqEn = 1; // Enable I2S controller RX DMA
        i2sDmaCtrl.txDmaReqEn = 0;
    }

	i2sDrv->ctrl(I2S_CTRL_I2SCTL , 0);
	i2sDrv->ctrl(I2S_CTRL_DMA_CTRL , 0);

}

void HAL_I2sConfig(i2sParamCtrl_t paramCtrl)
{   
    // 1. Setting parameters per the I2S working mode    
    i2sMode = paramCtrl.mode;
    switch (i2sMode)
    {
        case MSB_MODE:
            i2sDataFmt.dataDly          = 0;
            i2sBclkFsCtrl.bclkPolarity  = 1;
            i2sBclkFsCtrl.fsPolarity    = 1;
            
            break;

        case LSB_MODE:
            i2sDataFmt.dataDly          = 1;
            i2sBclkFsCtrl.bclkPolarity  = 1;
            i2sBclkFsCtrl.fsPolarity    = 1;

            break;

        case I2S_MODE:
            i2sDataFmt.dataDly          = 1;
            if (paramCtrl.codecType == CODEC_ES8311)
            {
                i2sBclkFsCtrl.bclkPolarity  = 1;
            }
            else
            {
                i2sBclkFsCtrl.bclkPolarity  = 0;
            }
            i2sBclkFsCtrl.fsPolarity    = 1;

            break;

        case PCM_MODE:    
            // Configure codec to PCM mode
            i2sBclkFsCtrl.bclkPolarity  = 1;
            break;

        default:
            break;
    }

    
    // 2. Init codec and I2S controller
    switch (paramCtrl.codecType)
    {
        case CODEC_ES8388:
        {
            codecType = ES8388;
            if (paramCtrl.role == CODEC_MASTER_MODE) // Codec act as master
            {
                i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_SLAVE , paramCtrl.sampleRate); // I2S Set sample rate in slave role 
                es8388MasterInit();
            }
            else // Codec act as slave
            {
                i2sDataFmt.slaveModeEn = 0; // Master mode
                i2sDrv->ctrl(I2S_CTRL_DATA_FORMAT , 0); 
                i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_MASTER , paramCtrl.sampleRate); // I2S Set sample rate in master role
                es8388SlaveInit();
            }
                
            break;
        }

        case CODEC_NAU88C22:
        {
            codecType = NAU88C22;
            if (paramCtrl.role == CODEC_MASTER_MODE) // Codec act as master
            {
                i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_SLAVE , paramCtrl.sampleRate); // I2S Set sample rate in slave role
                nau88c22MasterInit();
            }
            else // Codec act as slave
            {
                i2sDataFmt.slaveModeEn = 0; // Master mode
                i2sDrv->ctrl(I2S_CTRL_DATA_FORMAT , 0);
                i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_MASTER , paramCtrl.sampleRate); // I2S Set sample rate in slave role
                nau88c22SlaveInit(); 
            }
                
            break;
        }

        case CODEC_ES7148:
        case CODEC_ES7149:
        case CODEC_TM8211:
        {	
        	// now we only can act as master mode
         	i2sDataFmt.slaveModeEn = 0; // Master mode
            i2sDrv->ctrl(I2S_CTRL_DATA_FORMAT , 0); 
            i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_MASTER , paramCtrl.sampleRate); // I2S Set sample rate in master role
                
			break;
        }

        case CODEC_ES8311:
        {
            codecType = ES8311;
            
            if (paramCtrl.role == CODEC_MASTER_MODE) // Codec act as master
            {
                i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_SLAVE , paramCtrl.sampleRate); // I2S Set sample rate in slave role 
                es8311MasterInit();
            }
            else // Codec act as slave
            {
                i2sDataFmt.slaveModeEn = 0; // Master mode
                i2sDrv->ctrl(I2S_CTRL_DATA_FORMAT , 0); 
                i2sDrv->ctrl(I2S_CTRL_SAMPLE_RATE_MASTER , paramCtrl.sampleRate); // I2S Set sample rate in master role
                es8311SlaveInit();
            } 
            break;
        }

        default:
            break;
    }

    // 3. Set frame size
    switch (paramCtrl.frameSize)
    {
        case FRAME_SIZE_16_16:
            i2sDataFmt.slotSize     = 0xf;
            i2sBclkFsCtrl.fsWidth   = 0xf;
            i2sDataFmt.wordSize     = 0xf;

            break;

        case FRAME_SIZE_16_32:
            // I2S controller part
            i2sDataFmt.slotSize     = 0x1f;
            i2sDataFmt.wordSize     = 0xf;
            i2sBclkFsCtrl.fsWidth   = 0x1f;

            break;

        case FRAME_SIZE_24_32:
            // I2S controller part
            i2sDataFmt.slotSize     = 0x1f;
            i2sDataFmt.wordSize     = 0x17;
            i2sBclkFsCtrl.fsWidth   = 0x1f;

            break;

        case FRAME_SIZE_32_32:
            // I2S controller part
            i2sDataFmt.slotSize     = 0x1f;
            i2sDataFmt.wordSize     = 0x1f;
            i2sBclkFsCtrl.fsWidth   = 0x1f;

            break;

        default:
            break;
    }

	// 4. Select mono or dual-channel
    switch(paramCtrl.channelSel)
    {
		case MONO:
			{
				i2sSlotCtrl.slotEn  = 1;
				i2sSlotCtrl.slotNum = 1;
			}
			break;

		case DUAL_CHANNEL:
			{
				i2sSlotCtrl.slotEn  = 3;
				i2sSlotCtrl.slotNum = 1;
			}
			break;

		default:
			break;
    }

    // Init part of I2S controller
    i2sDrv->ctrl(I2S_CTRL_DATA_FORMAT , 0);
    i2sDrv->ctrl(I2S_CTRL_BCLK_FS_CTRL , 0);
    i2sDrv->ctrl(I2S_CTRL_SLOT_CTRL , 0);

    // 5. Set play or record
	HAL_I2SSetPlayRecord(paramCtrl.playRecord); 
}

void HAL_I2sTransfer(i2sPlayRecord_e playRecord, uint8_t* memAddr, uint32_t trunkSize)
{
    // 5. After other parameters are ready, start the I2S controller
    if (playRecord == PLAY) // Play audio
    {
        i2sDrv->send(memAddr, trunkSize);
    }
    else  // Record audio
    {
        i2sDrv->recv(memAddr, trunkSize);
    }
}

void HAL_I2sSrcAdjustVolumn(int16_t* srcBuf, uint32_t srcTotalNum, uint16_t volScale)
{
	int integer = volScale / 10;
	int decimal = volScale % 10;
	int scale = 0;
	int32_t tmp = 0;
	uint32_t totalNum = srcTotalNum;
	uint32_t step = 0;
	
	while (totalNum)
	{
		if (volScale < 10)
		{
			tmp = ((*(srcBuf + step)) * (256 * integer + 26 * decimal)) >> 8;
		}
		else
		{
			scale = (256 * integer + 26 * decimal) >> 8;
			tmp = (*(srcBuf + step)) * scale;
		}
		
		if (tmp > 32767)
		{
			tmp = 32767;
		}
		else if (tmp < -32768)
		{
			tmp = -32768;
		}
			
		*(srcBuf + step) = (int16_t)tmp;
		step += 1;
		totalNum -= 2;
	}
}


// Control I2S to start or stop. Note: when app wakeup from sleep1, need to call this api to start MCLK and i2s
void HAL_I2sStartSop(i2sStartStop_e startStop)
{
	i2sDrv->ctrl(I2S_CTRL_START_STOP , startStop);
}




#if 0
// Control volumn of codec when play the audio
void HAL_I2sVolumnCtrl(i2sVolumnCtrl_e volumnCtrl, uint8_t step)
{
    if (volumnCtrl == VOLUMN_INCREASE)
    {
        codecCtrlVolume(codecType, TRUE, step); // Increase volumn
    }
    else 
    {
        codecCtrlVolume(codecType, FALSE, step); // Decrease volumn
    }
}
#endif

