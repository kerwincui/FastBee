#ifndef __AUDIO_TASK__
#define __AUDIO_TASK__
#include "luat_audio_play_ec618.h"
typedef struct
{
    uint8_t playType;
    struct
    {
        luat_audio_play_info_t *info;
        uint8_t count;
    } file;
    void *userParam;
} audioQueueData;
typedef enum
{
    SPEECH_BY_SYNTHESIS_PLAY,
} AUDIO_PLAY_TYPE;
void audio_task_init(void);
#endif