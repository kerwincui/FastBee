#pragma once

#include "header.h"
/**************************************************************************

Copyright: 杜兴杰

Author: 杜兴杰 1066950103@qq.com

Date: 2022-11-23

Description: 物美app 对接开发

**************************************************************************/

//const char* pstrVersion = "0.1";
//const char* pstrUserId = "1";

const char* getFunctionData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage);
const char* getPropertyData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage);
const char* getInformationData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage);
const char* getEventData(char* pGetDataBuffer, int nLength, const char* pstrRecvMessage);