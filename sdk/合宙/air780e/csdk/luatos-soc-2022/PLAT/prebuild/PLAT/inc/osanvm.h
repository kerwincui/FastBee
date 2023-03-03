#ifndef __OSA_NVM_H__
#define __OSA_NVM_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M Ltd.
 File name:      - osanvm.h
 Description:    - OSA EC NVM operation code
 History:        - 2021/04/06, Originated by Jason
 ******************************************************************************
******************************************************************************/
#ifdef WIN32
#include "winsys.h"
#else
#include "commontypedef.h"
#endif

/******************************************************************************
 *****************************************************************************
 * MARCO/ENUM
 *****************************************************************************
******************************************************************************/

/*
 * NVM file now should limited in 4KB
*/
#define OSA_NVM_FILE_BODY_MAX_SIZE      4096

/*
*/
typedef enum OsaNvmRet_enum
{
    OSA_NVM_SUCC        = 0,
    OSA_NVM_ERR         = -1,
    OSA_NVM_NO_FILE_ERR = -2,   /* if read only, no file exist */
    OSA_NVM_NO_MEM_ERR  = -3,
    OSA_NVM_CKS_ERR     = -4,   /* checksum err */
    OSA_NVM_FILE_ERR    = -5,   /* file format/context not right */
    OSA_NVM_INPUT_ERR   = -6,
}OsaNvmRetE;

typedef INT32   OsaNvmRet;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/


/*
 * EC NVM file header struct
*/
#define OSA_NVM_FILE_NAME_SIZE 32
typedef struct OsaNvmHeader_Tag
{
    UINT8   fName[OSA_NVM_FILE_NAME_SIZE];

    UINT16  fileBodySize;   //file body size, not include size of header
    UINT16  checkSum;

    UINT8   version;
    UINT8   rsvd0;
    UINT16  rsvd1;
}OsaNvmHeader;      //40 bytes


/*
 * OSA NVM file body info
*/
typedef struct OsaNvmBodyInfo_Tag
{
    UINT8   *pBuf;     //allocated in heap: OsaAllocMemory()/OsaFreeMemory()

    /*
     * As the caller maybe need to write new parameter into NVM, here reserve more memory
     * 1> "bodySize": real NVM body data size
     * 2> "bufSize": allcated buffer size
     * 3> "bufSize" >= "bodySize", and reserved size: "bufSize" - "bodySize"
    */
    UINT16  bodySize;
    UINT16  bufSize;
}OsaNvmBodyInfo;    // 8 bytes


/******************************************************************************
 *****************************************************************************
 * FUNC
 *****************************************************************************
******************************************************************************/

/*
 * Read whole NVM file, the file size should limited in 4KB
 * Note: if file not exist, return: OSA_NVM_NO_FILE_ERR, and not allocate buffer for NVM body
*/
OsaNvmRet OsaNvmRead(const CHAR *pName, UINT8 *pVer, OsaNvmBodyInfo *pBodyInfo, UINT16 rsvdLen);

/*
 * Write whole NVM file
*/
OsaNvmRet OsaNvmWrite(const CHAR *pName, UINT8 ver, void *pData, UINT32 size);

/*
 * remove file
*/
OsaNvmRet OsaNvmRemove(const CHAR *pName);

/*
 * After the NVM body used/parsed, need to free the memory
*/
void OsaNvmFreeBody(OsaNvmBodyInfo *pNvmBodyInfo);

/*
 * Allocate buffer to store NVM file body
*/
void OsaNvmAllocBody(OsaNvmBodyInfo *pNvmBodyInfo, UINT16 bufSize);

/*
 * realloc/enlarge buffer to store NVM file body
*/
void OsaNvmReAllocBody(OsaNvmBodyInfo *pNvmBodyInfo, UINT16 newBufSize);


#endif

