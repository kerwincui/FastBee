/**
 * @file audio_ll_drv.h
 * @brief 音频数据对接到底层硬件驱动的中间层，为了兼容多种情况并不是最优化，由于硬件驱动代码是开源的，用户可以不用，自己对接驱动代码
 * @version 0.1
 * @date 2022-10-23
 * 
 * @copyright 
 * 
 */
#ifndef __AUDIO_LL_DRV_H__
#define __AUDIO_LL_DRV_H__

typedef enum
{
    AUSTREAM_FORMAT_UNKNOWN, ///< placeholder for unknown format
    AUSTREAM_FORMAT_PCM,     ///< raw PCM data
    AUSTREAM_FORMAT_WAVPCM,  ///< WAV, PCM inside
    AUSTREAM_FORMAT_MP3,     ///< MP3
    AUSTREAM_FORMAT_AMRNB,   ///< AMR-NB
    AUSTREAM_FORMAT_AMRWB,   ///< AMR_WB
    AUSTREAM_FORMAT_SBC,     ///< bt SBC
} auStreamFormat_t;

typedef enum
{
    AUSTREAM_BUS_DAC,
	AUSTREAM_BUS_I2S,
} auStreamBusType_t;

typedef struct
{
	CBFuncEx_t CB;	//pData是自身Audio_StreamStruct指针
	CBFuncEx_t Decoder;
	CBFuncEx_t Encoder;
	void *pParam;
	void *fd;
	void *CoderParam;
	void *UserParam;
	Buffer_Struct FileDataBuffer;
	Buffer_Struct AudioDataBuffer;
	Buffer_Struct RomDataBuffer;
	llist_head DataHead;
	uint32_t SampleRate;
	uint32_t waitRequire;
	uint8_t BitDepth;
	uint8_t ChannelCount;	//声道，目前只有1或者2
	auStreamFormat_t Format;
	auStreamBusType_t BusType;	//音频总线类型，DAC, IIS之类的
	uint8_t BusID;		//音频总线ID
	uint8_t IsDataSigned;	//数据是否是有符号的
	uint8_t IsHardwareRun;
	uint8_t IsPause;
	uint8_t IsStop;
	uint8_t IsPlaying;
	uint8_t IsFileNotEnd;
	uint8_t DecodeStep;
}Audio_StreamStruct;

/**
 * @brief 音频驱动初始化
 * 
 */
void Audio_GlobalInit(void);
/**
 * @brief 基于I2S总线的外部codec相关I2S总线模式配置，并不对codec的I2C处理
 * 
 * @param bus_id I2S总线序号，0或者1
 * @param mode I2S模式，I2S_MODE_I2S，I2S_MODE_MSB，I2S_MODE_LSB，一般常见MODE_I2S和MODE_MSB
 * @param frame_size I2S帧模式，I2S_FRAME_SIZE_16_16，I2S_FRAME_SIZE_16_32，I2S_FRAME_SIZE_24_32，I2S_FRAME_SIZE_32_32，目前只用到
 * I2S_FRAME_SIZE_16_16
 */
void Audio_CodecI2SInit(uint8_t bus_id, uint8_t mode,  uint8_t frame_size);

/**
 * @brief 开始播放原始音频流
 *
 * @param pStream 原始音频流数据结构, 底层不保存这个结构，需要用户保存
 * @return =0 成功 < 0失败错误码
 */
int32_t Audio_StartRaw(Audio_StreamStruct *pStream);
/**
 * @brief 写入原始音频数据到底层
 * 
 * @param pStream 原始音频流数据结构
 * @param pByteData 原始音频数据
 * @param ByteLen 原始音频数据字节长度
 * @param AddHead 是否插入到开头播放序列，1插入开头，0插入结尾。一般用于开始/恢复播放时插入空白段以消除爆破音，正常数据不要插入开头
 * @return int32_t =0 成功 < 0失败错误码
 */
int32_t Audio_WriteRaw(Audio_StreamStruct *pStream, uint8_t *pByteData, uint32_t ByteLen, uint8_t AddHead);
/**
 * @brief 终止音频数据播放
 * 
 * @param pStream 原始音频流数据结构
 */
void Audio_Stop(Audio_StreamStruct *pStream);
/**
 * @brief 清除播放完的数据，需要在任务中进行
 * 
 * @param pStream 原始音频流数据结构
 */
void Audio_DeleteOldData(Audio_StreamStruct *pStream);
/**
 * @brief 暂停播放音频数据，只是设置停止标志，已经在驱动中的数据仍然会播放
 * 
 * @param pStream 原始音频流数据结构
 */
void Audio_Pause(Audio_StreamStruct *pStream);
/**
 * @brief 恢复播放音频数据
 * 
 * @param pStream 原始音频流数据结构
 */
void Audio_Resume(Audio_StreamStruct *pStream);

#endif
