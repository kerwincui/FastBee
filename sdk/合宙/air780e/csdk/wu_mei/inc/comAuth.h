#pragma once

#include "header.h"
/**************************************************************************

Copyright: 杜兴杰

Author: 杜兴杰 1066950103@qq.com

Date: 2022-11-20

Description: 物美csdk 认证

**************************************************************************/
char* getComAuthUser();
char* getComAuthPassword();
char* getComAuthClientId();
char* getComAuthIp();
/*没有返回值 参数为结果0 失败 1成功*/
typedef void(*pComAuthResultFunction)(unsigned char );

/*
*Summary:公共认证初始化
*Parameters:
* pstrEncryptionMode 加密模式
* pstrProductId 产品ID
* pstrDeviceId 设备ID
* pstrUserId 用户ID
* pstrUse 用户
* pstrPassword 密码
* nTimeout 过期时间 秒为单位
* pstrIp ip
* pstrDeviceAuthorizationCode 设备认证code
* pstrProductPassword 产品密码
* callback 回调函数
*Return:
*/
void ComAuthInit(
	const char* pstrEncryptionMode, 
	const int nProductId,
	const char* pstrDeviceId, 
	const char* pstrUserId, 
	const char* pstrUser, 
	const char* pstrPassword, 
	unsigned int nTimeout, 
	const char* pstrIp, 
	const char* pstrDeviceAuthorizationCode, 
	const char* pstrProductPassword, 
	void* callback
);


