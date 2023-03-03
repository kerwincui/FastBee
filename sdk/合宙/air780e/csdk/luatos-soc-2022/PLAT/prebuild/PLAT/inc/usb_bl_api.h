#ifndef __USB_BL_API_H__
#define __USB_BL_API_H__

#define VCOM_DBGEN

#ifdef VCOM_DBGEN
void vcomdbg_hex(uint32_t hex);
void vcomdbg_str(uint8_t* str);
void vcomdbg_str_and_hex(uint8_t* str, uint32_t hex);

#define VCDBG_STR(str) vcomdbg_str((uint8_t*)str)
#define VCDBG_STR_AND_HEX(str, hex) vcomdbg_str_and_hex((uint8_t*)str, hex)
#else
void vcomdbg_hex(uint32_t hex);
void vcomdbg_str(uint8_t* str);
void vcomdbg_str_and_hex(uint8_t* str, uint32_t hex);
#define VCDBG_STR(str) 
#define VCDBG_STR_AND_HEX(str, hex) 
#endif


#define ERR_DEV_BASE  (-200)
#define ERR_DEV_NUM_REDEF(err) (ERR_DEV_BASE + err)
#define ERR_DEV_NO_CONNECT  ERR_DEV_NUM_REDEF(-2)
#define ERR_DEV_RX_TIMOUT ERR_DEV_NUM_REDEF(-32)
#define ERR_DEV_TX_TIMOUT ERR_DEV_NUM_REDEF(-33)

#endif

