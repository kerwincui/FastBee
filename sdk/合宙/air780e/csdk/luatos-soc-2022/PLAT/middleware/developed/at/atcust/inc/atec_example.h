/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename: atec_example.h
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_EXAMPLE_H__
#define __ATEC_EXAMPLE_H__

#include "at_util.h"


#define  EC_TESTDEMO_VALUE_MIN   0
#define  EC_TESTDEMO_VALUE_MAX   1
#define  EC_TESTDEMO_VALUE_DEF   0

#define  EC_TESTA_VALUE_MIN   0
#define  EC_TESTA_VALUE_MAX   8
#define  EC_TESTA_VALUE_DEF   0

#define  EC_TESTA_STR_LEN_MAX   32
#define  EC_TESTA_STR_BUF_SIZE  (EC_TESTA_STR_LEN_MAX + 1)
#define  EC_TESTA_STR_DEFAULT   NULL

#define  EC_TESTB_VALUE_MIN   0
#define  EC_TESTB_VALUE_MAX   8
#define  EC_TESTB_VALUE_DEF   0

#define  EC_TESTB_STR_LEN_MAX   32
#define  EC_TESTB_STR_BUF_SIZE  (EC_TESTB_STR_LEN_MAX + 1)
#define  EC_TESTB_STR_DEFAULT   NULL

#define  EC_TESTC_VALUE_MIN   0
#define  EC_TESTC_VALUE_MAX   8
#define  EC_TESTC_VALUE_DEF   0

#define  EC_TESTC_STR_LEN_MAX   32
#define  EC_TESTC_STR_BUF_SIZE  (EC_TESTC_STR_LEN_MAX + 1)
#define  EC_TESTC_STR_DEFAULT   NULL


CmsRetId  ecTESTDEMO(const AtCmdInputContext *pAtCmdReq);
CmsRetId  ecTESTA(const AtCmdInputContext *pAtCmdReq);
CmsRetId  ecTESTB(const AtCmdInputContext *pAtCmdReq);
CmsRetId  ecTESTC(const AtCmdInputContext *pAtCmdReq);

CmsRetId ecTESTBcnf(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId ecTESTCcnf(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);

CmsRetId ecTESTCind(UINT16 primId, UINT16 reqHandle, UINT16 rc, void *paras);

#endif

/* END OF FILE */

