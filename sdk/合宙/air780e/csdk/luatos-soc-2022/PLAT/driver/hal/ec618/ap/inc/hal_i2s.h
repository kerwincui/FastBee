/****************************************************************************
 *
 * Copy right:   2019-, Copyrigths of AirM2M Ltd.
 * File name:    hal_i2s.h
 * Description:  EC618 i2s hal driver header file
 * History:      Rev1.0   2021-9-18
 *
 ****************************************************************************/

#ifndef _HAL_I2S_H
#define _HAL_I2S_H

#include "i2s.h"
#include "codecDrv.h"

/**
  \addtogroup i2s_interface_gr
  \{
 */

// 1. Static control part
typedef enum
{
    CODEC_ES8388            = 0,        ///< ES8388 codec
    CODEC_NAU88C22          = 1,        ///< NAU88C22 codec
    CODEC_ES7148			= 2,		    ///< ES7148
	CODEC_ES7149			= 3,		    ///< ES7149
    CODEC_ES8311			= 4,		    ///< ES8311
    CODEC_TM8211            = 5,            ///< TM8211
}i2sCodecType_e;

typedef enum
{
    MSB_MODE                = 0,        ///< Left aligned mode
    LSB_MODE                = 1,        ///< Right aligned mode
    I2S_MODE                = 2,        ///< I2S mode
    PCM_MODE                = 3,        ///< PCM mode
}i2sMode_e;

typedef enum
{
    CODEC_MASTER_MODE       = 0,        ///< Codec plays as master    
    CODEC_SLAVE_MODE        = 1,        ///< Codec plays as slave
}i2sRole_e;

typedef enum
{
    SAMPLERATE_8K           = 1,        ///< Sample rate 8k
    SAMPLERATE_16K          = 2,        ///< Sample rate 16k
    SAMPLERATE_32K          = 3,        ///< Sample rate 32k
    SAMPLERATE_22_05K       = 4,        ///< Sample rate 22.05k
    SAMPLERATE_44_1K        = 5,        ///< Sample rate 44.1k
    SAMPLERATE_48K          = 6,        ///< Sample rate 48k
    SAMPLERATE_96K          = 7,        ///< Sample rate 96k
}i2sSampleRate_e;

typedef enum
{
    FRAME_SIZE_16_16        = 0,        ///< WordSize 16bit, SlotSize 16bit
    FRAME_SIZE_16_32        = 1,        ///< WordSize 16bit, SlotSize 32bit
    FRAME_SIZE_24_32        = 2,        ///< WordSize 24bit, SlotSize 32bit
    FRAME_SIZE_32_32        = 3,        ///< WordSize 32bit, SlotSize 32bit
}i2sFrameSize_e;

typedef enum
{
    PLAY                    = 0,        ///< Audio play
    RECORD                  = 1,        ///< Audio record
}i2sPlayRecord_e;

typedef enum
{
    I2S_CLK_DISABLE         = 0,        ///< Disable I2S clock 
    I2S_CLK_ENABLE          = 1,        ///< Enable I2S clock
}i2sPowerCtrl_e;

typedef enum
{
	MONO					= 0,
	DUAL_CHANNEL			= 1,
}i2sChannelSel_e;

typedef struct
{
    i2sCodecType_e          codecType;  ///< Codec choose
    i2sMode_e               mode;       ///< Audio mode choose
    i2sRole_e               role;       ///< Role choose
    i2sSampleRate_e         sampleRate; ///< Sample rate choose
    i2sFrameSize_e          frameSize;  ///< Frame size choose
    i2sPlayRecord_e         playRecord; ///< Play or record choose
    i2sChannelSel_e			channelSel;	///< Mono or dual channel select
    uint32_t                totalNum;   ///< Audio source total num
}i2sParamCtrl_t;

// 2. Dynamic control part
typedef enum
{
    STOP_I2S                = 0,        ///< Stop play or record
    START_SEND              = 1,        ///< Start Play   
    START_RECV				= 2,		///< Start record 
    START_SEND_RECV		    = 3,		///< Start Play or record 
}i2sStartStop_e;

typedef enum
{
    VOLUMN_INCREASE         = 0,        ///< Volumn increase
    VOLUMN_DECREASE         = 1,        ///< Volumn decrease
}i2sVolumnCtrl_e;

typedef enum
{
	// @ 1.8V level
	VOL_1_65V = 0,
	VOL_1_70V,
	VOL_1_75V,
	VOL_1_80V,
	VOL_1_85V,
	VOL_1_90V,
	VOL_1_95V,
	VOL_2_00V,

	// @ 2.8V level
	VOL_2_65V = 8,
	VOL_2_70V,
	VOL_2_75V,
	VOL_2_80V,
	VOL_2_85V,
	VOL_2_90V,
	VOL_2_95V,
	VOL_3_00V,

	// @ 3.3V level
	VOL_3_05V = 16,
	VOL_3_10V,
	VOL_3_15V,
	VOL_3_20V,
	VOL_3_25V,
	VOL_3_30V,
	VOL_3_35V,
	VOL_3_40V,

}i2sIOVolSel_t;


typedef void (*i2sCbFunc_fn) (uint32_t event, uint32_t arg);  ///< I2S init callback event.





///////////////////////////////////////////////////////////////
// When play, everytime play 1k size of audio src, then in i2sTxCb function, calculate how many data remained for 
// sending. Data on the tail of transfering can be abandon, it won't influence the user to listen.
////////////////////////////////////////////////////////////////
#define I2S_DMA_TX_DESCRIPTOR_CHAIN_NUM                 1 		///< DMA TX descriptor chain number   
#define AUDIO_TX_TRANSFER_SIZE                          1024  	///< Maximum TX DMA transfer size each descriptor

///////////////////////////////////////////////////////////////
// This macro controls record. Every receive buffer is 8k, total has 35 picecs of this buffer that using DMA to receive.
// If you want to change the time of record, modify these two macros.
// How to set these parameters?
// For example: 
// Your buffer size is 284954byte, use it to divide 8000, get 35.61925. Define this macro to 35.
////////////////////////////////////////////////////////////////
#define I2S_DMA_RX_DESCRIPTOR_CHAIN_NUM					35		///< DMA RX descriptor chain number
#define AUDIO_RX_TRANSFER_SIZE							8000	///< Maximum RX DMA transfer size each descriptor

/**
  \brief Init I2S interface, include pinMux, and enable clock.
  \param[out] powerCtrl     Enable or disable I2S clock.
  \param[out] txCb     Indicate that i2s tx operation has been done.
  \param[out] rxCb     Indicate that i2s rx operation has been done.

  \return              
*/
void HAL_I2sInit(i2sPowerCtrl_e powerCtrl, i2sCbFunc_fn txCb, i2sCbFunc_fn rxCb);


/**
  \brief Configure i2s.
  \param[in] paramCtrl     Every i2s control parameters
  \return
  \details

  1. Parameter "paramCtrl" involves all the parameters that need to set in i2s development. 
    (1). i2sCodecType_e          codecType
    Choose the codec that you use.

    (2). i2sMode_e               mode
    We support 4 I2S interface modes, choose the one you need.
    Note! Since I2S mode will have phase difference with other 3 modes, so please note that if you connect a speaker
    in the LOUT1 or LOUT2, I2S mode will change to another speaker outer pin than other 3 modes.

    (3). i2sRole_e               role
    Codec acts as master or slave, so our controller will act as slave or master accordingly.

    (4). i2sSampleRate_e         sampleRate
    Choose the Sample rate you need.

    (5). i2sFrameSize_e          frameSize
    WordSize shouldn't bigger than slotSize. WordSize is the real size you use, and slotSize is the length that one
    frame occupys. 

    (6). i2sPlayRecord_e         playRecord
    Choose play audio or record audio.

    (7). i2sChannelSel_e		 channelSel
    Choose mono or dual channel.

    (8). uint32_t                totalNum
	When playing, the total size of audio source.
*/
void HAL_I2sConfig(i2sParamCtrl_t paramCtrl);

/**
  \brief Use i2s interface to play or record audio.
  \param[in] playRecord     Play or record.
  \param[in,out] memAddr    Audio source buffer when playing or recording
  \param[in] trunkSize      The size of everytime send or receive data.
  \return
*/
void HAL_I2sTransfer(i2sPlayRecord_e playRecord, uint8_t* memAddr, uint32_t trunkSize);

/**
  \brief Start play/record audio or stop play/record audio.
  \param[in] startStop     Start or stop play/record audio.
  \return              
*/
void HAL_I2sStartSop(i2sStartStop_e startStop);

/**
  \brief Set total num of sending data to i2s.
  \param[in] totalNum     Total num of data.
  \return              
*/
void HAL_I2SSetTotalNum(uint32_t totalNum);

/**
  \brief Get total num of data.
  \return  Total num of data.            
*/
uint32_t HAL_I2SGetTotalNum(void);

/**
  \brief Set play or record.
  \param[in] playRecord     Set i2s to play or record.
  \return              
*/
void HAL_I2SSetPlayRecord(i2sPlayRecord_e playRecord);

/**
  \brief If codec don't have the ablity to adjust volumn, using this api to achieve it.
  \param[in] srcBuf        Audio source address of playing.
  \param[in] srcTotalNum   Total num of audio source for playing.
  \param[in] volScale      Increase or decrease the volumn. 
  \details
    1. Mute, write 00 for volScale.
  	1. Decrease volumn to 50% of original, write 05 for volScale.
  	2. Increase volumn to 5 times of original, write 50 for volScale.
  	3. Increase volumn to 10 times of original, write 100 for volScale.
  	4. "volScale" can change from 00(mute), 01(10%), 02(20%)......30(300%), 40(400%), 100(1000%)......
  \return              
*/
void HAL_I2sSrcAdjustVolumn(int16_t* srcBuf, uint32_t srcTotalNum, uint16_t volScale);

void HAL_normalIOVoltSet(i2sIOVolSel_t sel);
void HAL_aonIOVoltSet(i2sIOVolSel_t sel);



#if 0
/**
  \brief Control the volumn by codec when play audio.
  \param[out] volumnCtrl     Increase or decrease the volumn.
  \param[out] step     The gap each time when adjust the volumn.
  \return              
*/
void HAL_I2sVolumnCtrl(i2sVolumnCtrl_e volumnCtrl, uint8_t step);
#endif

/** \} */

#ifdef __cplusplus
}
#endif

#endif /* _HAL_I2S_H */
