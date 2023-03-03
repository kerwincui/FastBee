#ifndef _RNDIS_H
#define _RNDIS_H

#include <stdint.h>


#define RNDIS_MAJOR_VERSION	1
#define RNDIS_MINOR_VERSION 0

#define RNDIS_STATUS_SUCCESS            0X00000000
#define RNDIS_STATUS_FAILURE            0XC0000001
#define RNDIS_STATUS_INVALID_DATA       0XC0010015
#define RNDIS_STATUS_NOT_SUPPORTED      0XC00000BB
#define RNDIS_STATUS_MEDIA_CONNECT      0X4001000B
#define RNDIS_STATUS_MEDIA_DISCONNECT   0X4001000C


/* Message set for Connectionless (802.3) Devices */
#define REMOTE_NDIS_PACKET_MSG          0x00000001
#define REMOTE_NDIS_INITIALIZE_MSG      0X00000002
#define REMOTE_NDIS_HALT_MSG            0X00000003
#define REMOTE_NDIS_QUERY_MSG           0X00000004
#define REMOTE_NDIS_SET_MSG             0X00000005
#define REMOTE_NDIS_RESET_MSG           0X00000006
#define REMOTE_NDIS_INDICATE_STATUS_MSG 0X00000007
#define REMOTE_NDIS_KEEPALIVE_MSG       0X00000008
#define REMOTE_NDIS_INITIALIZE_CMPLT    0X80000002
#define REMOTE_NDIS_QUERY_CMPLT         0X80000004
#define REMOTE_NDIS_SET_CMPLT           0X80000005
#define REMOTE_NDIS_RESET_CMPLT         0X80000006
#define REMOTE_NDIS_KEEPALIVE_CMPLT     0X80000008

typedef uint32_t rndis_MessageType_t;
typedef uint32_t rndis_MessageLength_t;
typedef uint32_t rndis_RequestId_t;
typedef uint32_t rndis_MajorVersion_t;
typedef uint32_t rndis_MinorVersion_t;
typedef uint32_t rndis_MaxTransferSize_t;
typedef uint32_t rndis_Status_t;


/* Device Flags */
#define RNDIS_DF_CONNECTIONLESS      0x00000001
#define RNDIS_DF_CONNECTION_ORIENTED 0x00000002
typedef uint32_t rndis_DeviceFlags_t;

/* Mediums */
#define RNDIS_MEDIUM_802_3           0x00000000
typedef uint32_t rndis_Medium_t;


typedef uint32_t rndis_MaxPacketsPerTransfer_t;
typedef uint32_t rndis_PacketAlignmentFactor_t;
typedef uint32_t rndis_AfListOffset_t;
typedef uint32_t rndis_AfListSize_t;

/*** Remote NDIS Generic Message type ***/
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	} rndis_generic_msg_t;


/*** Remote NDIS Initialize Message ***/
typedef struct{
	rndis_MessageType_t 	MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_MajorVersion_t	MajorVersion;
	rndis_MinorVersion_t	MinorVersion;
	rndis_MaxTransferSize_t	MaxTransferSize;
	} rndis_initialize_msg_t;
	
/* Response: */
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_Status_t			Status;
	rndis_MajorVersion_t	MajorVersion;
	rndis_MinorVersion_t	MinorVersion;
	rndis_DeviceFlags_t		DeviceFlags;
	rndis_Medium_t			Medium;
	rndis_MaxPacketsPerTransfer_t 	MaxPacketsPerTransfer;
	rndis_MaxTransferSize_t			MaxTransferSize;
	rndis_PacketAlignmentFactor_t 	PacketAlignmentFactor;
	rndis_AfListOffset_t	AfListOffset;
	rndis_AfListSize_t		AfListSize;
	} rndis_initialize_cmplt_t;
	

/*** Remote NDIS Halt Message ***/
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	} rndis_halt_msg_t;
	
typedef uint32_t rndis_Oid_t;
typedef uint32_t rndis_InformationBufferLength_t;
typedef uint32_t rndis_InformationBufferOffset_t;
typedef uint32_t rndis_DeviceVcHandle_t;

/*** Remote NDIS Query Message ***/
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_Oid_t				Oid;
	rndis_InformationBufferLength_t	InformationBufferLength;
	rndis_InformationBufferOffset_t	InformationBufferOffset;
	rndis_DeviceVcHandle_t			DeviceVcHandle;
	}  rndis_query_msg_t;
	
/* Response: */

typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_Status_t			Status;
	rndis_InformationBufferLength_t	InformationBufferLength;
	rndis_InformationBufferOffset_t	InformationBufferOffset;
	} rndis_query_cmplt_t;
	
/*** Remote NDIS Set Message ***/
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_Oid_t				Oid;
	rndis_InformationBufferLength_t	InformationBufferLength;
	rndis_InformationBufferOffset_t	InformationBufferOffset;
	rndis_DeviceVcHandle_t			DeviceVcHandle;
	} rndis_set_msg_t;
	
/* Response */
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_Status_t			Status;
	}rndis_set_cmplt_t;

/* Information buffer layout for OID_GEN_RNDIS_CONFIG_PARAMETER */
typedef uint32_t rndis_ParameterNameOffset_t;
typedef uint32_t rndis_ParameterNameLength_t;
typedef uint32_t rndis_ParameterType_t;
typedef uint32_t rndis_ParameterValueOffset_t;
typedef uint32_t rndis_ParameterValueLength_t;

#define PARAMETER_TYPE_STRING		2
#define PARAMETER_TYPE_NUMERICAL	0

typedef struct{
	rndis_ParameterNameOffset_t		ParameterNameOffset;
	rndis_ParameterNameLength_t		ParameterNameLength;
	rndis_ParameterType_t			ParameterType;
	rndis_ParameterValueOffset_t	ParameterValueOffset;
	rndis_ParameterValueLength_t	ParameterValueLength;	
	}rndis_config_parameter_t;
	
typedef uint32_t rndis_Reserved_t;

/*** Remote NDIS Soft Reset Message ***/
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_Reserved_t		Reserved;
	} rndis_reset_msg_t;
	
typedef uint32_t rndis_AddressingReset_t;

/* Response: */
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_Status_t			Status;
	rndis_AddressingReset_t	AddressingReset;
	}  rndis_reset_cmplt_t;
	
/*** Remote NDIS Indicate Status Message ***/
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_Status_t			Status;
	rndis_Status_t			StatusBufferLength;
	rndis_Status_t			StatusBufferOffset;
	}  rndis_indicate_status_t;
	
typedef uint32_t rndis_DiagStatus_t;
typedef uint32_t rndis_ErrorOffset_t;

typedef struct {
	rndis_DiagStatus_t		DiagStatus;
	rndis_ErrorOffset_t		ErrorOffset;
	}rndis_diagnostic_info_t;
	
/*** Remote NDIS Keepalive Message */
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	}rndis_keepalive_msg_t;
	
/* Response: */
typedef struct{
	rndis_MessageType_t		MessageType;
	rndis_MessageLength_t	MessageLength;
	rndis_RequestId_t		RequestId;
	rndis_Status_t			Status;
	}rndis_keepalive_cmplt_t;

/*** Remote NDIS Data Packet ***/

typedef uint32_t rndis_DataOffset_t;
typedef uint32_t rndis_DataLength_t;
typedef uint32_t rndis_OOBDataOffset_t;
typedef uint32_t rndis_OOBDataLength_t;
typedef uint32_t rndis_NumOOBDataElements_t;
typedef uint32_t rndis_PerPacketInfoOffset_t;
typedef uint32_t rndis_PerPacketInfoLength_t;

typedef struct{
	rndis_MessageType_t			MessageType;
	rndis_MessageLength_t		MessageLength;
	rndis_DataOffset_t			DataOffset;
	rndis_DataLength_t			DataLength;
	rndis_OOBDataOffset_t		OOBDataOffset;
	rndis_OOBDataLength_t		OOBDataLength;
	rndis_NumOOBDataElements_t	NumOOBDataElements;
	rndis_PerPacketInfoOffset_t	PerPacketInfoOffset;
	rndis_PerPacketInfoLength_t PerPacketInfoLength;
	rndis_DeviceVcHandle_t		DeviceVcHandle;
	rndis_Reserved_t			Reserved;
	}rndis_data_packet_t;

typedef uint32_t rndis_ClassInformationOffset_t;
typedef uint32_t rndis_Size_t;
typedef uint32_t rndis_Type_t;

typedef struct{
	rndis_Size_t					Size;
	rndis_Type_t					Type;
	rndis_ClassInformationOffset_t	ClassInformationType;
	}rndis_OOB_packet_t;

#include "ndis.h"

typedef enum rnids_state_e {
	rndis_uninitialized,
	rndis_initialized,
	rndis_data_initialized
} rndis_state_t;

typedef struct {
	uint32_t		txok;
	uint32_t		rxok;
	uint32_t		txbad;
	uint32_t		rxbad;
	uint16_t		ext_notifyok;
	uint16_t		int_encbuf_notifyok;    
	uint8_t           int_listbuf_notifyok;
	uint8_t		int_encbuf_srcmiss;   //enc buf is send, but no encbuf src flag is set 
	uint8_t		int_listbuf_srcmiss;
	uint8_t		int_listbuf_overlap_cnt;
	uint8_t		int_listbuf_rstdrop_cnt;
	uint8_t		int_listbuf_livedrop_cnt;
    
} usb_eth_stat_t;


typedef struct
{
    rndis_state_t rndis_state;
    uint32_t oid_packet_filter;
    usb_eth_stat_t usb_eth_stat;
}rndis_ctrl_data_st;


void RdsProInitalMsgHdl(rndis_generic_msg_t *msgIn);
void RdsProQueryHdl(rndis_query_msg_t *m, rndis_ctrl_data_st *p_ctrl_data);
void FuncRndisInitNotify(void);
void FuncRndisHaltNotify(void);
void FuncRndisResetNotify(void);
uint32_t RndisGetEncBufSize(void);

void RdsProInitalMsgHdl(rndis_generic_msg_t *msgIn);
void RdsProQueryCmplt(rndis_query_msg_t *m, int status, const void *data, int size);
void RdsProQueryCmplt32(rndis_query_msg_t *m, int status, uint32_t data);
void RdsProQueryHdl(rndis_query_msg_t *m, rndis_ctrl_data_st *p_ctrl_data);
void RdsProCfgParaHdl(const char *data, int keyoffset, int valoffset, int keylen, int vallen);
void RdsProPktFilter(uint32_t newfilter);
void RdsProSetMsgHdl(rndis_set_msg_t *msgIn, rndis_ctrl_data_st *p_ctrl_data);
void RdsProResetMsgHdl(rndis_reset_cmplt_t *m, rndis_ctrl_data_st *p_ctrl_data);

void RdsProKeepAliveMsgHdl(rndis_keepalive_cmplt_t *m, uint32_t RequestId, rndis_ctrl_data_st *p_ctrl_data);

#define RNDIS_MTU        1500                           
#define RNDIS_LINK_SPEED 100000000                      
#define RNDIS_VENDOR     "AirM2M"                   
#define RNDIS_HWADDR     0x20,0x89,0x84,0x6A,0x96,0xAB  


#define RNDIS_MAX_PACK_PER_XFER      10
#define ETH_HEADER_SIZE             14
#define ETH_MAX_PACKET_SIZE         ETH_HEADER_SIZE + RNDIS_MTU
#define ETH_MIN_PACKET_SIZE         60

#define RNDIS_RX_BUFFER_SIZE        ((((ETH_MAX_PACKET_SIZE + sizeof(rndis_data_packet_t)) + 99) / 100) * 100 * 2)
#define RNDIS_TX_BUFFER_SIZE        (ETH_MAX_PACKET_SIZE + sizeof(rndis_data_packet_t))



#endif /* _RNDIS_H */

/** @} */
