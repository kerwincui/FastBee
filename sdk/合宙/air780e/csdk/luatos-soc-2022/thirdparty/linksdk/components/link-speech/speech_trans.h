#ifndef __SPEECH_TRANS_H__
#define __SPEECH_TRANS_H__

#include <stdio.h>
#include "core_list.h"

typedef struct {
    char *filename;
    struct core_list_head linked_node;
} play_node_t;

/* 语料名字转换成文件添加进链表 */
void name_to_speech(const char *value, char *format, struct core_list_head *list);
/* 将金钱转换成语料文件添加进链表 */
void money_to_speech(const char *value, char *format, struct core_list_head *list);

#endif