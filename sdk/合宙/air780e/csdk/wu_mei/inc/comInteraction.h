#pragma once

#include "header.h"
/**************************************************************************

Copyright: 杜兴杰

Author: 杜兴杰 1066950103@qq.com

Date: 2022-11-19

Description: 物美开发板 公共交互

**************************************************************************/

typedef void(*fnCallbackSendData)(const char* pstrTopic, const char* pstrMessage, unsigned char nQs);
typedef const char* (*fnCallbackGetMessage)(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage);
/*
*Summary:交互初始化
*Parameters:
* pstrProductId 产品ID
* pstrDeviceNum 设备名字 IMEI
* callbackSendData 数据发送函数
* callbackPropertyData 产品获取
*Return:
*/
void comInteractionInit(
	const int nProductId,
	const char* pstrDeviceNum,
	void* callbackSendData,
	void* callbackPropertyData,
	void* callbackFunctionData,
	void* callbackEventData,
	void* callbackDeviceInformationData);
/*
*Summary:延时初始化
*Parameters:
*Return:
*/
void comInteractionDelayInit();

/*
*Summary:设置属性发布
*Parameters:
* nTime 数字类型, 0停止定时器 其他值开启定时器
*Return:
*/
void setPropertyPush(unsigned int nTime);

/*
*Summary:设置功能发布
*Parameters:
* nTime 数字类型, 0停止定时器 其他值开启定时器
*Return:
*/
void setFunctionPush(unsigned int nTime);

/*
*Summary:设置事件发布
*Parameters:
* nTime 数字类型, 0停止定时器 其他值开启定时器
*Return:
*/
void setEventPush(unsigned int nTime);

/*
*Summary:获取要订阅的所有主题
*Parameters:
*Return: 返回内部字符串 已分隔符组成多个
*/
const char* getSubscriberAll();

/*
*Summary:数据回调函数
*Parameters:
* pstrTopic 主题
* pstrmessage 消息
*Return:
*/
void onRecvData(const char* pstrTopic, const char* pstrmessage);

void triggerPropertyPush();
void triggerFunctionPush();
void triggerEventPush();
