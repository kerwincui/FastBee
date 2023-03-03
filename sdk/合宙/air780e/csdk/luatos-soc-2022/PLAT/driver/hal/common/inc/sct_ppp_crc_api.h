#ifndef __SCT_PPP_CRC_API_H__
#define __SCT_PPP_CRC_API_H__

/******************************************************************************
 ******************************************************************************
  Copy right:   2017-, Copyrigths of AirM2M Ltd.
  File name:    sct_ppp_crc_api.h
  Description:  SCT PPP EEA and CRC API, which provide to app
  History:      2022/02/08    Originated by Jason
 ******************************************************************************
******************************************************************************/
#include "osasys.h"


/******************************************************************************
 *****************************************************************************
 * MARCO
 *****************************************************************************
******************************************************************************/
/*
 * UINT32 * 8 = 256 bits
*/
#define SCT_PPP_ACCM_TABLE_WORD_SIZE        8


typedef enum
{
    SCT_PPP_RET_OK      = 0,
    SCT_PPP_ERROR       = -1,
    SCT_PPP_BUSY        = -2,
    SCT_PPP_INVALID_INPUT   = -3
}SctPppRetEnum;

typedef INT32   SctPppRet;


/******************************************************************************
 *****************************************************************************
 * STRUCT
 *****************************************************************************
******************************************************************************/




/******************************************************************************
 *****************************************************************************
 * Functions
 *****************************************************************************
******************************************************************************/

/*
 * PPP escape ACCM table config
*/
void SctPppEscapeAccmConfig(UINT32 pppAccmTbl[SCT_PPP_ACCM_TABLE_WORD_SIZE]);

/*
 * PPP de-escape ACCM table config
*/
void SctPppDeEscapeAccmConfig(UINT32 pppAccmTbl[SCT_PPP_ACCM_TABLE_WORD_SIZE]);

/******************************************************************************
 * SctPppEscapeCalcSize
 * Description: calc PPP escape PKG size/length in bytes
 * input:   const DlPduBlock *pHead     //input, a list, one PDU one PPP raw packet
 *          UINT32 *pOutList            //output, should be a UINT32 array, escape pkg size for each PDU, and must 4 bytes aligned
 *          UINT32  listSize            //input, "pOutList" array size
 *          DlPduBlock **pRetNext       //output, if PDU number in input: "pHead" > "listSize", then not all PDU could calc escaped size, then output here
 * output: INT32    //succ return 0, or return < 0
 * Comment:
 * 1> PPP raw pkg (DlPduBlock) input format:
 *    +-------+---------------------+
 *    |PPP hdr|        data         |
 *    +-------+---------------------+
 * 2>  \PPP escape pkg format:        \
 *   +--+-------------------------------+-----+--+
 *   |7E|      escaped PPP pkg          | CRC |7E|
 *   +--+-------------------------------+-----+--+
 *   |<-------------- output size -------------->|
 * 3> if "pOutList[n]" set to 0, means last PKG
 * 4> !!!!!! "pOutList" must be __ALIGNED(4) !!!!!!
******************************************************************************/
SctPppRet SctPppEscapeCalcSize(DlPduBlock *pHead, UINT32 *pOutList, UINT32 listSize, DlPduBlock **pRetNext);

/******************************************************************************
 * SctPppEscape
 * Description: PPP escape: add "7E" and CRC
 * input:   const DlPduBlock *pHead     //input, a list, one PDU one PPP raw packet
 *          DlPduBlock *pEscapeHead     //ouput, output buffer should allocated in caller
 * output: INT32    //succ return 0, or return < 0
 * Comment:
 * 1> PPP raw pkg (DlPduBlock) input format:
 *    +-------+---------------------+
 *    |PPP hdr|        data         |
 *    +-------+---------------------+
 * 2>  \output PPP escape pkg format: \
 *   +--+-------------------------------+-----+--+
 *   |7E|      escaped PPP pkg          | CRC |7E|
 *   +--+-------------------------------+-----+--+
 *   |<------ pEscapeHead->length -------------->|
 *   ^pEscapeHead->pPdu
 * Note:
 * a) Caller should call: SctPppEscapeCalcSize() to calc the escaped pkg size;
 * b) then alloc the buffer (maybe from DLFC) according to the escaped pkg size;
 * c) finally call this API: SctPppEscape() to do PPP escape, and the escaped pkg size
 *     will be checked again in this API, to avoid a bug cause overflow
******************************************************************************/
SctPppRet SctPppEscape(const DlPduBlock *pHead, DlPduBlock *pEscapeHead);


/******************************************************************************
 * SctPppDeEscape
 * Description: PPP deescape
 * input:   const UlPduBlock *pHead     //input, a list, PPP pkg start and end with "7E"
 *          UlPduBlock *pDeEscapeHead   //ouput, output buffer should allocated in caller
 * output: INT32    //succ return 0, or return < 0
 * Comment:
 * 1> PPP pkg (UlPduBlock) input format:    //note, PKG should start and end with "7E" (will check in this API)
 *    +--+-------------------------------+-----+--+
 *    |7E|      escaped PPP pkg          | CRC |7E|
 *    +--+-------------------------------+-----+--+
 * 2>    |output PPP deescape pkg format:      /
 *       +-------+----------------------+-----+
 *       |PPP hdr|         data         | CRC |
 *       +-------+----------------------+-----+
 *       |<------ pDeEscapeHead->length ----->|
 *       ^pDeEscapeHead->ptr
 * 3> If CRC checked failed, "pDeEscapeHead->pppCrcNok" set to 1
 * Note:
 * a) The caller should be pre-alloc the buffer in "pDeEscapeHead", use to fill
 *    de-escaped pkg. And the pre-alloc buffer size should be estimated big enough, suggest
 *    equal the input escaped pkg size.
 * b) After de-escaped in this API, de-escaped pkg size will be checked and set to
 *    the actually value.
 * c) In some case, the caller can't input the header "7E", so we don't check it as mandatory
******************************************************************************/
SctPppRet SctPppDeEscape(const UlPduBlock *pHead, UlPduBlock *pDeEscapeHead);


#endif

