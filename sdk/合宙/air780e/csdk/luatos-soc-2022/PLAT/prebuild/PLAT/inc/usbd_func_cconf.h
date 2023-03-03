#ifndef __FUNC_VCOM_CONF_H__
#define  __FUNC_VCOM_CONF_H__


//#include "usbc_ctrl_config.h"


#define USBD_CFG_MAX_NUM                1


 #define CDC_DATA_MAX_PACKET_SIZE       512  



 #define CDC_IN_FRAME_INTERVAL          40   

#ifndef USE_USBC_CTRL_HS
#define USE_USBC_CTRL_HS
#endif

#endif


