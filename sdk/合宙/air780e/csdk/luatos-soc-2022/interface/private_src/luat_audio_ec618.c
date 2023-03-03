/*
 * Copyright (c) 2022 OpenLuat & AirM2M
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "luat_audio_play_ec618.h"
extern void audio_play_file_default_fun(void *param);
extern void audio_play_tts_default_fun(void *param);
extern void audio_play_tts_set_resource_ex(void *address, void *sdk_id, void *read_resource_fun);
extern void audio_play_global_init_ex(audio_play_event_cb_fun_t event_cb, audio_play_data_cb_fun_t data_cb, audio_play_default_fun_t play_file_fun, audio_play_default_fun_t play_tts_fun, void *user_param);
extern int audio_play_write_blank_raw_ex(uint32_t multimedia_id, uint8_t cnt, uint8_t add_font);
void luat_audio_play_file_default_fun(void *param)
{
	audio_play_file_default_fun(param);
}
void luat_audio_play_tts_default_fun(void *param)
{
	audio_play_TTS_default_fun(param);
}

void luat_audio_play_global_init(
		audio_play_event_cb_fun_t event_cb,
		audio_play_data_cb_fun_t data_cb,
		audio_play_default_fun_t play_file_fun,
		audio_play_default_fun_t play_tts_fun,
		void *user_param)
{
	audio_play_global_init_ex(event_cb, data_cb, play_file_fun, play_tts_fun, user_param);
}

int luat_audio_play_multi_files(uint32_t multimedia_id, audio_play_info_t info[], uint32_t files_num)
{
	return audio_play_multi_files(multimedia_id, info, files_num);
}

uint8_t luat_audio_play_is_finish(uint32_t multimedia_id)
{
	return audio_play_is_finish(multimedia_id);
}

int luat_audio_play_stop(uint32_t multimedia_id)
{
	return audio_play_stop(multimedia_id);
}

int luat_audio_play_pause_raw(uint32_t multimedia_id, uint8_t is_pause)
{
	return audio_play_pause_raw(multimedia_id, is_pause);
}

int luat_audio_play_get_last_error(uint32_t multimedia_id)
{
	return audio_play_get_last_error(multimedia_id);
}

int luat_audio_play_write_blank_raw(uint32_t multimedia_id, uint8_t cnt, uint8_t add_font)
{
	return audio_play_write_blank_raw_ex(multimedia_id, cnt, add_font);
}

int luat_audio_play_start_raw(uint32_t multimedia_id, uint8_t audio_format, uint8_t num_channels, uint32_t sample_rate, uint8_t bits_per_sample, uint8_t is_signed)
{
	return audio_play_start_raw(multimedia_id, audio_format, num_channels, sample_rate, bits_per_sample, is_signed);
}

int luat_audio_play_write_raw(uint32_t multimedia_id, uint8_t *data, uint32_t len)
{
	return audio_play_write_raw(multimedia_id, data, len);
}

int luat_audio_play_stop_raw(uint32_t multimedia_id)
{
	return audio_play_stop_raw(multimedia_id);
}

int luat_audio_play_tts_text(uint32_t multimedia_id, void *text, uint32_t text_bytes)
{
	return audio_play_tts_text(multimedia_id, text, text_bytes);
}

int luat_audio_play_tts_set_param(uint32_t multimedia_id, uint32_t param_id, uint32_t param_value)
{
	return audio_play_tts_set_param(multimedia_id, param_id, param_value);
}


void luat_audio_play_tts_set_resource(void *address, void *sdk_id, void *tts_resource_read_fun)
{
	audio_play_tts_set_resource_ex(address, sdk_id, tts_resource_read_fun);
}

