#ifndef __HTTP_TASK_QUEUE_H__
#define __HTTP_TASK_QUEUE_H__


typedef enum
{
    SPEECH_POST,
    PUSH_SPEECH,
    SPEECH_BY_SYNTHESIS
}SPEECH_TYPE_E;

typedef struct http_queue
{
    char *url;
    char *filename;
    SPEECH_TYPE_E type;
}http_queue_t;


#endif