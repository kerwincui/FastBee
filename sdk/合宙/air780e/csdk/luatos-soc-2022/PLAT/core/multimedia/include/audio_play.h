/**
 * @file audio_play.h

 * @brief 音频播放层，需要配合tts库，audio_decoder库和audio_ll_drv使用
 * @version 0.1
 * @date 2022-10-23
 * 
 * @copyright
 * 
 */

#ifndef __AUDIO_PLAY_H__
#define __AUDIO_PLAY_H__

typedef struct
{
	char *path;		//文件路径，如果为NULL，则表示是ROM数组
	uint32_t address;	//ROM数组地址
	uint32_t rom_data_len;	//ROM数组长度
	uint8_t fail_continue;	//如果解码失败是否跳过继续下一个，如果是最后一个文件，强制停止并设置错误信息
	uint8_t dummy[3];
}audio_play_info_t;

enum
{
	MULTIMEDIA_DATA_TYPE_NONE,
	MULTIMEDIA_DATA_TYPE_PCM,
	MULTIMEDIA_DATA_TYPE_MP3,
	MULTIMEDIA_DATA_TYPE_WAV,
	MULTIMEDIA_DATA_TYPE_AMR_NB,
	MULTIMEDIA_DATA_TYPE_AMR_WB,
};

enum
{
	MULTIMEDIA_CB_AUDIO_DECODE_START,	//开始解码文件
	MULTIMEDIA_CB_AUDIO_OUTPUT_START,	//开始输出解码后的音数据
	MULTIMEDIA_CB_AUDIO_NEED_DATA,		//底层驱动播放播放完一部分数据，需要更多数据
	MULTIMEDIA_CB_AUDIO_DONE,			//底层驱动播放完全部数据了
	MULTIMEDIA_CB_DECODE_DONE,			//音频解码完成
	MULTIMEDIA_CB_TTS_INIT,				//TTS做完了必要的初始化，用户可以通过audio_play_tts_set_param做个性化配置
	MULTIMEDIA_CB_TTS_DONE,				//TTS编码完成了。注意不是播放完成
};
extern const unsigned char ivtts_8k[];
extern const unsigned char ivtts_8k_lite[];
extern const unsigned char ivtts_16k_lite[];
extern const unsigned char ivtts_16k[];
extern const unsigned char ivtts_8k_tz_data[];
extern const unsigned char ivtts_8k_tz_frags[];
extern const unsigned char ivtts_16k_tz_data[];
extern const unsigned char ivtts_16k_tz_frags[];
/**
 * @brief 播放时event回调，见MULTIMEDIA_CB_XXX，user_param就是初始化时传入的user_param
 * 
 */
typedef void (*audio_play_event_cb_fun_t)(uint32_t cb_audio_event, void *user_param);

/**
 * @brief 播放文件时，在数据解码出来后，会回调给用户做进一步处理，比如音量的软件增减，软件静音，当然也可以不处理。数据长度是字节数，bits是量化位数，一般是16，channels是声道数，1或者2
 * 
 */
typedef void (*audio_play_data_cb_fun_t)(uint8_t *data, uint32_t data_len, uint8_t bits, uint8_t channels);

typedef void (*audio_play_default_fun_t)(void *param);
/**
 * @brief 音频播放初始化
 * 
 * @param event_cb 播放时event回调函数
 * @param data_cb 数据解码回调函数，如果是直接播放原始数据流就不会用到
 * @param user_param 回调函数的用户参数
 */
void audio_play_global_init(audio_play_event_cb_fun_t event_cb, audio_play_data_cb_fun_t data_cb, void *user_param);

/**
 * @brief 播放指定数量的文件或者ROM数组（文件数据直接写成数组形式）
 * 
 * @param multimedia_id 多媒体通道，目前只有0
 * @param info 文件信息，文件路径或者ROM信息
 * @param files_num 文件数量
 * @return int =0成功，其他失败
 */
int audio_play_multi_files(uint32_t multimedia_id, audio_play_info_t info[], uint32_t files_num);

/**
 * @brief 是否播放完全部数据
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @return uint8_t =1是，=0没有
 */
uint8_t audio_play_is_finish(uint32_t multimedia_id);

/**
 * @brief 强制停止播放文件，但是不会停止已经输出到底层驱动的数据播放
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @return int =0成功，其他失败
 */
int audio_play_stop(uint32_t multimedia_id);
/**
 * @brief 暂停/恢复播放
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @param is_pause 0恢复，其他暂停
 * @return int =0成功，其他失败
 */
int audio_play_pause_raw(uint32_t multimedia_id, uint8_t is_pause);

/**
 * @brief 获取上一次播放结果，在MULTIMEDIA_CB_AUDIO_DONE回调时调用最佳
 *
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @return int =0完整的播放完成，<0被用户停止了，>0 TTS失败，或者第几个音频文件解码失败（用户在play_info未设置了解码失败后继续，文件位置+1）
 */
int audio_play_get_last_error(uint32_t multimedia_id);

/**
 * @brief 插入多段空白数据，每段数据约100ms
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @param cnt 段数
 * @return int =0成功，其他失败
 */
int audio_play_write_blank_raw(uint32_t multimedia_id, uint8_t cnt);
/**
 * @brief 立刻初始化播放未编码的原始音频数据流
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @param audio_format 音频数据格式，目前只支持PCM，即需要手动解码
 * @param num_channels 声道数，目前只能1或2
 * @param sample_rate 采样率，注意只有8K,16K,32K,48K,96K,22.05K,44.1K这些能被支持
 * @param bits_per_sample 量化bit，只能是16
 * @param is_signed 量化数据是否带符号，只能是1
 * @return int =0成功，其他失败
 */
int audio_play_start_raw(uint32_t multimedia_id, uint8_t audio_format, uint8_t num_channels, uint32_t sample_rate, uint8_t bits_per_sample, uint8_t is_signed);
/**
 * @brief 向底层驱动传入一段原始音频数据
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @param data 原始音频数据
 * @param len 原始音频数据长度
 * @return int =0成功，其他失败
 */
int audio_play_write_raw(uint32_t multimedia_id, uint8_t *data, uint32_t len);
/**
 * @brief 强制停止所有播放，同时底层驱动也会停止输出，不要用于播放文件的结束
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @return int =0成功，其他失败
 */
int audio_play_stop_raw(uint32_t multimedia_id);
/**
 * @brief 编码并播放一段文字
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @param text 文字数据
 * @param text_bytes 文字数据长度
 * @return int =0成功，其他失败
 */
int audio_play_tts_text(uint32_t multimedia_id, void *text, uint32_t text_bytes);
/**
 * @brief 在收到MULTIMEDIA_CB_TTS_INIT回调时，可以设置TTS参数，等同于ivTTS_SetParam
 * 
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @param param_id 见ivTTS_PARAM_XXX
 * @param param_value param_id对应的value
 * @return int =0成功，其他失败
 */
int audio_play_tts_set_param(uint32_t multimedia_id, uint32_t param_id, uint32_t param_value);
/**
 * @brief 设置TTS的资源和对应SDKID，TTS资源有很多种。
 * 
 * @param address 资源的flash或者ram地址
 * @param sdk_id 本质上就是传入AISOUND_SDK_USERID
 */
void audio_play_tts_set_resource(void *address, void *sdk_id);

/**
 * @brief 获取当前播放的音频的采样率
 *
 * @param multimedia_id multimedia_id 多媒体通道，目前只有0
 * @return uint32_t 采样率
 */
uint32_t audio_play_get_sample_rate(uint32_t multimedia_id);

void audio_play_file_default_fun(void *param);
void audio_play_TTS_default_fun(void *param);
void audio_play_tts_set_resource_ex(void *address, void *sdk_id, void *read_resource_fun);
void audio_play_global_init_ex(audio_play_event_cb_fun_t event_cb, audio_play_data_cb_fun_t data_cb, audio_play_default_fun_t play_file_fun, audio_play_default_fun_t play_tts_fun, void *user_param);
int audio_play_write_blank_raw_ex(uint32_t multimedia_id, uint8_t cnt, uint8_t add_font);
#endif
