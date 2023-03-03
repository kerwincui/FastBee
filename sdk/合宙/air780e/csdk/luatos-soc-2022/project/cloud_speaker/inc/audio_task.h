#ifndef __AUDIO_TASK__
#define __AUDIO_TASK__
#include "queue.h"
// #include "audio_play.h"
#include "luat_audio_play_ec618.h"
typedef struct
{
    uint32_t priority;
    uint32_t playType;
    union
    {
        struct
        {
            char *data;
            uint8_t len;
        } tts;
        struct
        {
            luat_audio_play_info_t *info;
            uint8_t count;
        } file;
    } message;
    void * userParam;
} audioQueueData;

typedef enum
{
    MONEY_PLAY = 0,
    PAD_PLAY,
    SYS_PLAY
} AUDIO_PLAY_PRIORITY;

typedef enum
{
    TTS_PLAY = 0,
    FILE_PLAY,
} AUDIO_PLAY_TYPE;


void audio_task_init(void);
#endif