#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "speech_trans.h"
#include "aiot_sysdep_api.h"
#include "core_string.h"

/* 系统默认的数字语音路径 */
static const char *sys_tone_number[] = {
    "SYS_TONE_0",
    "SYS_TONE_1",
    "SYS_TONE_2",
    "SYS_TONE_3",
    "SYS_TONE_4",
    "SYS_TONE_5",
    "SYS_TONE_6",
    "SYS_TONE_7",
    "SYS_TONE_8",
    "SYS_TONE_9",
};

/* 系统默认的单元路径*/
static const char *sys_tone_measure[] = {
    "SYS_TONE_MONETARY_fen",
    "SYS_TONE_MONETARY_jiao",
    "SYS_TONE_MONETARY_yuan",
    "SYS_TONE_MEASURE_WORD_shi",
    "SYS_TONE_MEASURE_WORD_bai",
    "SYS_TONE_MEASURE_WORD_qian",
    "SYS_TONE_MEASURE_WORD_wan",
    "SYS_TONE_MEASURE_WORD_yi",
};

/* 语料名字转换成文件添加进链表 */
void name_to_speech(const char *value, char *format, struct core_list_head *list)
{
    aiot_sysdep_portfile_t *sysdep = NULL;
    play_node_t *node = NULL;
    char *src[] = { (char *)value, format };
    sysdep = aiot_sysdep_get_portfile();
    if(sysdep == NULL) {
        return;
    }

    node = sysdep->core_sysdep_malloc(sizeof(play_node_t), "");
    if (node == NULL) {
        return;
    }
    memset(node, 0, sizeof(play_node_t));
    CORE_INIT_LIST_HEAD(&node->linked_node);

    core_sprintf(sysdep, &node->filename, "%s.%s", src, sizeof(src) / sizeof(char *), "");
    if (node->filename == NULL) {
        sysdep->core_sysdep_free(node);
        return;
    }

    printf("add name %s\r\n", node->filename);
    core_list_add_tail(&node->linked_node, list);
}

/* 转换整形数字 */
void play_integer_number(uint64_t integer, char *format, struct core_list_head *list)
{
    uint64_t quotient = 0, remain = 0;
    if(integer >= 100000000ul) {
        quotient = integer / 100000000ul;
        remain = integer % 100000000ul;
        play_integer_number(quotient, format, list);
        name_to_speech(sys_tone_measure[7], format, list);
        if(remain > 0 && 100000000ul / remain > 10) {
            name_to_speech(sys_tone_number[0], format, list);
        }
        play_integer_number(remain, format, list);
    } else if (integer >= 10000ul) {
        quotient = integer / 10000ul;
        remain = integer % 10000ul;
        play_integer_number(quotient, format, list);
        name_to_speech(sys_tone_measure[6], format, list);
        if(remain > 0 && 10000ul / remain > 10) {
            name_to_speech(sys_tone_number[0], format, list);
        }
        play_integer_number(remain, format, list);
    } else if (integer >= 1000ul) {
        quotient = integer / 1000ul;
        remain = integer % 1000ul;
        play_integer_number(quotient, format, list);
        name_to_speech(sys_tone_measure[5], format, list);
        if(remain > 0 && 1000ul / remain > 10) {
            name_to_speech(sys_tone_number[0], format, list);
        }
        play_integer_number(remain, format, list);
    } else if (integer >= 100ul) {
        quotient = integer / 100ul;
        remain = integer % 100ul;
        play_integer_number(quotient, format, list);
        name_to_speech(sys_tone_measure[4], format, list);
        if(remain > 0 && 100ul / remain > 10) {
            name_to_speech(sys_tone_number[0], format, list);
        }
        play_integer_number(remain, format, list);
    } else if (integer >= 10ul) {
        quotient = integer / 10ul;
        remain = integer % 10ul;
        play_integer_number(quotient, format, list);
        name_to_speech(sys_tone_measure[3], format, list);
        play_integer_number(remain, format, list);
    } else {
        quotient = integer % 10ul;
        if(quotient > 0) {
            name_to_speech(sys_tone_number[quotient], format, list);
        }
    }
}

/* 将金钱转换成语料文件添加进链表 */
void money_to_speech(const char *value, char *format, struct core_list_head *list)
{
    uint64_t integer = 0;
    uint32_t decimal = 0;
    uint32_t tmp_int = 0;
    char *dot = NULL, *end = NULL;

    end = strstr(value, "}");
    if(end == NULL){
        return;
    }

    dot = strstr(value, ".");
    if(dot != NULL){
        core_str2uint64((char *)value, dot - value, &integer);
    } else {
        core_str2uint64((char *)value, end - value, &integer);
    }

    /*读取分数：分*/
    if(dot != NULL && dot[1] >= '0' && dot[1] <= '9') {
        decimal = (dot[1] - '0') * 10;
        if(dot[2] >= '0' && dot[2] <= '9') {
            decimal += (dot[2] - '0');
        }
    }

    //元
    if(integer > 0) {
        play_integer_number(integer, format, list);
        name_to_speech(sys_tone_measure[2], format, list);
    }

    if(decimal > 0) {
        //角
        tmp_int = decimal / 10;
        if(tmp_int > 0) {
            name_to_speech(sys_tone_number[tmp_int], format, list);
            name_to_speech(sys_tone_measure[1], format, list);
        } else if(integer > 0) {
            name_to_speech(sys_tone_number[0], format, list);
        }
        //分
        tmp_int = decimal % 10;
        if(tmp_int > 0) {
            name_to_speech(sys_tone_number[tmp_int], format, list);
            name_to_speech(sys_tone_measure[0], format, list);
        }
    }
}