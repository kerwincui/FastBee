#ifndef __PS_PDU_H__
#define __PS_PDU_H__

/******************************************************************************
 ******************************************************************************
 Copyright:      - 2017, All rights reserved by AirM2M Ltd.
 File name:      - pspdu.h
 Description:    - PS DATA PDU info
 History:        - 10/19/2018, Originated by Jason
 ******************************************************************************
******************************************************************************/
#ifdef WIN32
#include "winsys.h"
#else
#include "commontypedef.h"
#endif

/*
 * UL PDU memory type
*/
typedef enum UlPduMemType_Tag
{
    UL_HEAP_MEM = 0,    // dynamic memory, OsaAllocMemory/OsaAllocZeroMemory/OsaFreeMemory
    UL_LWIP_PKG_MEM,    // LwipFreeUlIpPkgMem() free it
    UL_STACK_MEM,       // stack memory, don't need to free
    UL_RBUF_MEM,        // uldp rbuf memory, uldpRbufDequeue
    UL_AFC_MEM,         // ulfc memory, OsaUlfcFreeMem

    UL_MEM_TYPE_MAX = 15
}UlPduMemType;


/*
 * ticks type, which carried in "UlPduBlock"
*/
typedef enum UlPduTickType_Tag
{
    UL_PDU_NO_TICK_INFO = 0,// no tick info
    UL_PDU_DISCARD_TICK,    // this UL PDU could be discarded if exceed this tick: "current tick" > "UL_PDU_DISCARD_TICK"
    UL_PDU_START_TICK       // systick when LWIP create/send this UL PDU
}UlPduTickType;


/*
 * UL data PDU info, this just the UL user data need to send to NW
 *
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * A: if UL data is "IP PKG" from LWIP, memtype = "UL_LWIP_PKG_MEM"
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  Maybe need ROHC:
 *  Before ROHC:
 *  +------------------+-----------------------------------+
 *  | ip/udp/other hdr |       payload                     |
 *  +------------------+-----------------------------------+
 *  ^
 *  |ptr
 *  |<------------------- length ------------------------->|
 *
 *  After ROHC:
 *  1> if (ip/udp/other hdr length) >= (comp len): (most case)
 *  +---------+--------+-----------------------------------+
 *  |         |comp hdr|        payload                    |
 *  +---------+--------+-----------------------------------+
 *  ^
 *  |ptr
 *  |<------->|validOffset
 *  |         |<-------------- length -------------------->|
 *
 *  2> if (ip/udp/other hdr length) < (comp len):
 *      i> need to create a new "data_pdu_info" to store the compressed header
 *      ii> and this "data_pdu_info" only contain the payload info;
 *  +--------------------+
 *  |      comp hdr      |
 *  +--------------------+
 *  ^
 *  |ptr
 *  |<---- length ------>|
 *  bContinue = TRUE, and pNext ->
 *  +------------------+-----------------------------------+
 *  | ip/udp/other hdr |        payload                    |
 *  +------------------+-----------------------------------+
 *  ^
 *  |ptr
 *  |<---------------->|validOffset
 *  |                  |<----------- length -------------->|
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * B: if UL data is not from LWIP, maybe from ATCMD, memtype = "UL_HEAP_MEM"
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  +------------------------------------------------------+
 *  |                   UL USER DATA                       |
 *  +------------------------------------------------------+
 *  ^
 *  |ptr
 *  |<------------------- length ------------------------->|
 *
 */
typedef struct UlPduBlock_Tag
{
    UINT8       memType    :4;      /* UlPduMemType
                                     * indicate the "ptr" memory type, which would affect how to free the "*ptr" memory
                                    */
    UINT8       bSameMem   :1;      /* whether the UlPduBlock and "ptr" use the same memory,
                                     * if TRUE, this memory only need to free once,
                                     * if not, UlPduBlock struct should allocated in heap, the memType indicated the memory type of ptr
                                    */
    UINT8       bFreed     :1;      /* whether this UlPduBlock and ptr are freed, only used for USB Rx Cycle buffer */
    UINT8       bContinue  :1;      /* Whether following seg belong to the same IP PKG:
                                     *  TRUE - next seg is the same IP PKG PDU
                                     *  FALSE - Not the same IP PKG PDU
                                    */
    UINT8       pbufBefore :1;      /* whether consecutive memory for "struct pbuf" before this block, set when allocate buffer */
    UINT8       validOffset;        /* Valid/real data offset, start from: ptr */
    UINT16      length;

    UINT8       *ptr;
    struct UlPduBlock_Tag *pNext;


    /*
     * Other DATA info
    */
    UINT32      epsId       :4;     /* epsId, should set in ESM task */
    UINT32      esmRai      :2;     /* DataRelAssistIndEnum, release assistance indication, set in APP */
    UINT32      bExceptData :1;     /* need to pass to CEMM/CERRC, if "Except Data", CERRC need to establish connection even if it's barred, set in APP */
    UINT32      bRohcFeedback :1;   /* Whether this pkg is ROHC feedback pkg only, set in ROHC task */

    UINT32      bRohcComped :1;     /* Whether ROHC compressed in this pkg */
    UINT32      bTestLoopback :1;   /* Whether this UL data is test loop back data*/
    UINT32      tickType    :2;     /* UlPduTickType, indicate the "sysTick" type */
    UINT32      pppCrcNok   :1;     /* PPP deescape, whether CRC checked failed */
    UINT32      fastPathNextAction :2; /*the ul pdu hase process by fastpath. and the next action is rohc process*/ /*UlPduNextActType*/
    UINT32      rsvd0       :1;

    UINT32      chanNo      :5;     /* for uldp UL_RBUF_MEM */
    UINT32      rsvd        :11;

    /*
    * Note:
    * 1> if "systick" is "UL_PDU_DISCARD_TICK", then PS (DR/ESM/EMM) MAYBE (not must) discard this pkg, if "current sys tick" > "sysTick";
    *    LWIP could set this if has a clear valid period for this UL PKG, such as: TCP pkg, or DNS/IPv6 RS pkg (as has retry timer);
    * 2> if "systick" is "UL_PDU_START_TICK", then PS (DR/ESM/EMM) MAYBE (not must) discard this pkg in case:
    *     a> the time passed more than 20s, and b> has anyother UL pkg followed;
    * 3> if "systick" is "UL_PDU_NO_TICK_INFO", then PS (DR/ESM/EMM) could try best to send it, don't discard it easily;
    *
    * Another note:
    * 1> DR/ESM will pending not more then (3*1500) bytes pkgs, or not more then 10 pkgs;
    *    if exceeded, will discard the oldest pkg;
    */
    UINT32      sysTick;            /*system tick, type is indicated by: tickType */
}UlPduBlock;     //20 bytes

#define UL_PDU_BLOCK_SET_BASICS(ulpdu, chno, mtype, bsame, buf, len, bpbuf, bcont, next)   \
             do\
             {\
                 ((UlPduBlock*)(ulpdu))->chanNo      = (chno);\
                 ((UlPduBlock*)(ulpdu))->memType     = (mtype);\
                 ((UlPduBlock*)(ulpdu))->bSameMem    = (bsame);\
                 ((UlPduBlock*)(ulpdu))->ptr         = (buf);\
                 ((UlPduBlock*)(ulpdu))->validOffset = 0;\
                 ((UlPduBlock*)(ulpdu))->length      = (len);\
                 ((UlPduBlock*)(ulpdu))->pbufBefore  = (bpbuf);\
                 ((UlPduBlock*)(ulpdu))->bContinue   = (bcont);\
                 ((UlPduBlock*)(ulpdu))->pNext       = (next);\
             }while(0)

#define UL_PDU_BLOCK_INCR(ulpdu, n)  \
            do\
            {\
                EC_ASSERT(((UlPduBlock*)(ulpdu))->length >= (n), ((UlPduBlock*)(ulpdu))->length, n, ulpdu);\
                ((UlPduBlock*)(ulpdu))->validOffset += (n);\
                ((UlPduBlock*)(ulpdu))->length      -= (n);\
            }while(0)

#define UL_PDU_BLOCK_DECR(ulpdu, n)  \
            do\
            {\
                EC_ASSERT(((UlPduBlock*)(ulpdu))->validOffset >= (n), ((UlPduBlock*)(ulpdu))->validOffset, n, ulpdu);\
                ((UlPduBlock*)(ulpdu))->validOffset -= (n);\
                ((UlPduBlock*)(ulpdu))->length      += (n);\
            }while(0)

/******************************************************************************
 ******************************************************************************
 * DL PDU defination
 ******************************************************************************
******************************************************************************/


/*
 * Reserved for ROHC decompression;
 * 80 = ipv6 + udp + rtp + 20 others
*/
#define ROHC_DL_HDR_RSVD_LEN    80

#define LWIP_PBUF_STRUCT_LEN    24          //sizeof(pbuf)

/*
 *  +----------+----------+----------+---------+------------------------------------+---------+---------+
 *  |    pbuf  |DlPduBlock| RNDIS HDR|Ether HDR|       ip pkg (len <= MTU)          |Ether CRC|RNDIS PAD|
 *  +----------+----------+----------+---------|------------------------------------+---------+---------+
 *  | 24 bytes | 16 bytes | 44 bytes | 14 bytes|       28 ~ 1500 bytes              | 4 bytes | 3 bytes |
 *
 * RNDIS_ETH_NET_DL_RESV_LEN = 44+14+7 = 65 ~= 68
*/
#define RNDIS_ETH_NET_DL_RSVD_HDR_LEN       60  // 44+14 = 58 ~= 60
#define RNDIS_ETH_NET_DL_RSVD_TAILER_LEN    8   // 4+3 = 7 ~= 8


/*
 * Magic word
*/
#define DL_PDU_MAGIC_WORD       0xA7C5

/*
 * set and check one magic byte
*/
#define DL_PDU_BLOCK_SET_MAGIC_WORD(pDlPduBlock)        ((pDlPduBlock)->magicWord = DL_PDU_MAGIC_WORD)
#define DL_PDU_BLOCK_CHECK_MAGIC_WORD(pDlPduBlock)      ((pDlPduBlock)->magicWord == DL_PDU_MAGIC_WORD)



/*
 * DL PDU memory type
*/
typedef enum DlPduMemType_Tag
{
    DL_HEAP_MEM = 0,       // dynamic memory, GosAllocMemory/GosAllocZeroMemory/GosFreeMemory
    DL_PS_PKG_MEM,
    DL_AFC_MEM,            // OsaDlfcFreeMem

    DL_MEM_TYPE_MAX = 15
}DlPduMemType;

/*
 * DL PDU memory type
*/
typedef enum DlPduIpType_Tag
{
    DL_PDU_IP_TYPE_INVALID = 0,       // invalid ip type
    DL_PDU_IP_TYPE_V4      = 1,       // invalid ip type
    DL_PDU_IP_TYPE_V6      = 2,       // invalid ip type
}DlPduIpType;


/*
 * How LWIP/Txtask proc this DL PDU
*/
typedef enum DlPduNextActType_Tag
{
    DL_PDU_NO_ACT   = 0,            /* No special action, default value.
                                     *  Case example: DLPDU(AT CMD) only need to transmit to USB host.
                                    */
    DL_PDU_PARSE    = 0,            /* need parse received IP pkg, LWIP task response how to proc this DL IP pkg.
                                     * 1> when PS (L2) recv a DL IP pkg, set to this value.
                                    */
    DL_PDU_DISCARD  = 1,            /* This DL PDU need to discard, as PDU memory can't be freed in ISR, then if
                                     *  this DL PDU is useless, could set to this value, and discard it later in task
                                    */
    DL_PDU_NAT_PAT_MAP = 2,         /* This DL PDU need to NAT/PAT transliation
                                     * Note: NAT/PAT transliation is handled in LWIP task
                                    */
    DL_PDU_NEED_FRAGEMENT = 3,      /* This DL PDU is too large, IP pkg length > LAN MTU size,  it need fragment
                                    */
    DL_PDU_NEED_MSS_CHECK = 4,      /* TCP MSS adpt */

    DL_PDU_NEED_WINDOWS_CHECK = 5,      /* TCP widnows adpt, TCP SYN PKG */

    DL_PDU_NEED_NDS_RELAY = 6,          /* for RNDIS private IP solution, host DNS resolve need relay */
    /* === to RNDIS host === */
    DL_PDU_ADD_IPV4_ETH_RNDIS_HDR = 7,  /* DL PDU to RNDIS host, need to add ethernet ipv4 header and RNDIS header */
    DL_PDU_ADD_IPV6_ETH_RNDIS_HDR_0 = 8,  /* DL PDU to RNDIS host, need to add ethernet ipv6 header and RNDIS header */
    DL_PDU_ADD_IPV6_ETH_RNDIS_HDR_1 = 9,  /* DL PDU to RNDIS host, need to add ethernet ipv6 header and RNDIS header */
    DL_PDU_ADD_IPV6_ETH_RNDIS_HDR_2 = 10,  /* DL PDU to RNDIS host, need to add ethernet ipv6 header and RNDIS header */
    DL_PDU_ADD_RNDIS_HDR = 11,           /* DL PDU to RNDIS host, need to add RNDIS header
                                         * 1> if eth_type is not ipv4(0x0800U)/ipv6(0x86DDU) (enum eth_type in ethernet.h)
                                         *    need to set it in LWIP task
                                        */

    /* === to PPP host === */
    DL_PDU_ADD_IPV4_PPP_HDR = 12,    /* DL PDU to PPP host, need to add IPv4 PPP header */
    DL_PDU_ADD_IPV6_PPP_HDR = 13,    /* DL PDU to PPP host, need to add IPv6 PPP header */

    /* === to ECM host === */
    DL_PDU_ADD_IPV4_ETH_ECM_HDR = 14,  /* DL PDU to ECM host, need to add ethernet ipv4 header and ECM header */
    DL_PDU_ADD_IPV6_ETH_ECM_HDR_0 = 15,  /* DL PDU to ECM host, need to add ethernet ipv6 header and ECM header */
    DL_PDU_ADD_IPV6_ETH_ECM_HDR_1 = 16,  /* DL PDU to ECM host, need to add ethernet ipv6 header and ECM header */
    DL_PDU_ADD_IPV6_ETH_ECM_HDR_2 = 17,  /* DL PDU to ECM host, need to add ethernet ipv6 header and ECM header */
    DL_PDU_ADD_ECM_HDR = 18,           /* DL PDU to ECM host, need to add ECM HDR
                                         * 1> if eth_type is not ipv4(0x0800U)/ipv6(0x86DDU) (enum eth_type in ethernet.h)
                                         *    need to set it in LWIP task
                                        */

    /* === to local wan/UE local socket APP === */
    DL_PDU_TO_LOCAL_WAN = 19,        /* DL PDU is sent to local WAN/local socket APP */

    DL_PDU_TO_LOCAL_TCP_WINDOWS_CHECK_ETH = 20,

    DL_PDU_TO_LOCAL_TCP_WINDOWS_CHECK_PPP = 21,

    DL_PDU_ACT_TYPE_MAX = 31
}DlPduNextActType;

/*
 * How LWIP proc this UL PDU
*/
typedef enum UlPduNextActType_Tag
{
    UL_PDU_PARSE        = 0, /*need lwip parse and process*/
    UL_PDU_ROHC_IP4     = 1, /*need do rohc with ip4 channel*/
    UL_PDU_ROHC_IP6     = 2, /*need do rohc with ip6 channel*/
    UL_PDU_ACT_TYPE_MAX = 3,
}UlPduNextActType;


/*
 * DL PDU BLOCK info, just the DL user data
 *
 * 1> !!! "DlPduBlock" and "DL user data" should use the continuous memory !!!
 * 2> !!! One "DlPduBlock" one DL IP packet !!!
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * A. if DL user PDU is IP PKG data, and need to pass to up layer
 *    this memory should be allocated in memory: DL_PS_PKG_MEM
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * DL IP PDU buffer:
 * 1. If no ROHC:
 *  +----------+----------+----------+---------+------------------------------------+---------+---------+
 *  |    pbuf  |DlPduBlock| RNDIS HDR|Ether HDR|       ip pkg (len <= MTU)          |Ether CRC|RNDIS PAD|
 *  +----------+----------+----------+---------|------------------------------------+---------+---------+
 *  | 24 bytes | 16 bytes | 44 bytes | 14 bytes|       28 ~ 1500 bytes              | 4 bytes | 3 bytes |
 *     *payload--------------------------------^
 *                pPdu-------------------------^
 *                length          =            |<---------------------------------->|
 *
 * 2. If ROHC Feedback:
 *  +--------------+---------------------------+
 *  |   DlPduBlock |     ROHC Feedback         |
 *  +--------------+---------------------------+
 *        pPdu-----^
 *        length = |<------------------------->|
 *
 * 3. If ROHC, before decomp:
 *  +----------+----------+----------+---------+--------------------+--------+---------------------+---------+---------+
 *  |    pbuf  |DlPduBlock| RNDIS HDR|Ether HDR|ROHC_DL_HDR_RSVD_LEN|comp hdr|       pkg data      |Ether CRC|RNDIS PAD|
 *  +----------+----------+----------+---------|--------------------+--------+---------------------+---------+---------+
 *  | 24 bytes | 16 bytes | 44 bytes | 14 bytes|     80 bytes       |        3 ~ 1500 bytes        | 4 bytes | 3 bytes |
 *                pPdu----------------------------------------------^
 *                 length                     =                     |<---------------------------->|
 *
 *  Note: ROHC_DL_HDR_RSVD_LEN = 80, reserved for decompressed IP header, 80 = ipv6 + udp + rtp + 20 others
 *
 *  After decomp:
 *  3.1> If reserved 80 bytes is enough (most case):
 *  +----------+----------+----------+---------+------------+----------------+---------------------+---------+---------+
 *  |    pbuf  |DlPduBlock| RNDIS HDR|Ether HDR|            | decomped ip hdr|       pkg data      |Ether CRC|RNDIS PAD|
 *  +----------+----------+----------+---------|------------+----------------+---------------------+---------+---------+
 *  | 24 bytes | 16 bytes | 44 bytes | 14 bytes|RSVD/useless|       28 ~ 1500 bytes                | 4 bytes | 3 bytes |
 *                pPdu--------------------------------------^
 *                 length                 =                 |<------------------------------------>|
 *    *payload----------------------------------------------^
 *
 *  3.2> If reserved 80 bytes is not enough (rarely)
 *      ROHC decompression side, need to allocate a new block (suggest also from : DL_PS_PKG_MEM), and soft copy to this new block;
 *   i> copy to ->
 *  +----------+----------+----------+---------+----------------+---------------------+---------+---------+
 *  |    pbuf  |DlPduBlock| RNDIS HDR|Ether HDR| decomped ip hdr|       pkg data      |Ether CRC|RNDIS PAD|
 *  +----------+----------+----------+---------|----------------+---------------------+---------+---------+
 *  | 24 bytes | 16 bytes | 44 bytes | 14 bytes|        28 ~ 1500 bytes               | 4 bytes | 3 bytes |
 *     *payload--------------------------------^
 *                pPdu-------------------------^
 *                length          =            |<------------------------------------>|
 *
 *   ii> Free the old block
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * A. if DL user PDU is not IP PKG data, (if need to LOOPBACK, or non-ip data)
 *    This memory should be allcated in HEAP
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *  +----------+-----------------------------------+
 *  |DlPduBlock|         PDCP User data            |
 *  +----------+-----------------------------------+
 *   pPdu------^
 *   length =  |<--------------------------------->|
 *
*/
typedef struct DlPduBlock_Tag
{
    UINT16      magicWord;      // used to memory protection
    UINT16      length;

    /*
     * !!! "DlPduBlock" and "pPdu" should use the continuous memory !!!
    */
    UINT8       *pPdu;
    struct DlPduBlock_Tag *pNext;

    /*
     * Other DATA info
    */
    UINT32      dlMemType     : 4;  /* DlPduMemType */
    UINT32      bOnlyDecomp   : 1;  /* Whether only need to do ROHC DECOMP, but don't need to pass to LWIP;
                                     * Note:
                                     * 1> During PDCP DL re-establishment procedure, here, as PDCP COUNT maybe re-order, DL PDCP SDU need to
                                     *    deciphered & decompressed, and stored in PDCP side;
                                     * 2> Here, set it (in PDCP task), notify LWIP(ROHC) task only do decompression, but don't pass to LWIP task;
                                     * 3> Set & Clear it in PDCP task;
                                    */
    UINT32      bIgnoreDecomp : 1;  /* If configed ROHC, whether need to ignore decompression for this pkg;
                                     * Note:
                                     * 1> PDCP set it, if pass re-order PDCP SDU, which decomped before
                                    */
    UINT32      bRohcFeedback : 1;  /* The PDU is ROHC feedback, not IP data, PDCP set it. */
    UINT32      bRohcBuffRsvd : 1;  /* whether reserved ROHC buffer with length: ROHC_DL_HDR_RSVD_LEN, in this DL PDU */

    UINT32      pbufBefore    : 1;  /* whether memory for "struct pbuf" before this block, set when allocate buffer */
    UINT32      bNetHdrRsvd   : 1;  /* whether reserved RNDIS/Ethernet header and padding, in this DL PDU */
    UINT32      reserved0     : 1;
    UINT32      nextAct       : 5;  /* DlPduNextActType, how LWIP/Tx task proc this DL PDU */

    UINT32      reserved : 16;
}DlPduBlock;   // 16 bytes

#define DL_PDU_BLOCK_SET_BASICS(dlpdu, mtype, buf, len, bpbuf, next)   \
              do\
              {\
                  ((DlPduBlock*)(dlpdu))->magicWord   = DL_PDU_MAGIC_WORD;\
                  ((DlPduBlock*)(dlpdu))->dlMemType   = (mtype);\
                  ((DlPduBlock*)(dlpdu))->pPdu        = (buf);\
                  ((DlPduBlock*)(dlpdu))->length      = (len);\
                  ((DlPduBlock*)(dlpdu))->pbufBefore  = (bpbuf);\
                  ((DlPduBlock*)(dlpdu))->pNext       = (next);\
              }while(0)


#endif

