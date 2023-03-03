/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef __ATEC_FILE_CNF_IND_H__
#define __ATEC_FILE_CNF_IND_H__

#include "at_util.h"

CmsRetId fileOpenCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileReadCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileWriteCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileSeekCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId filePositionCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileTucatCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileCloseCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileRenameCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileEraseCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileDeleteCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileMsLdsCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileMsLstCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileMsDelCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileMsUplCnf(UINT16 reqHandle, UINT16 rc, void *paras);
CmsRetId fileMsDwlCnf(UINT16 reqHandle, UINT16 rc, void *paras);

void atApplFileProcCmsCnf(CmsApplCnf *pCmsCnf);

#endif

/* END OF FILE */
