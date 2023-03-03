#include "commontypedef.h"
#include "common_api.h"

#define SNTP_RCV_TIMEOUT 15  //seconds
#define SNTP_RETRY_TIMES 3
#define SNTP_RESEND_REQUEST_DELAY 3000 //ms

#define SNTP_DEFAULT_PORT  123

typedef struct
{
	uint8_t succ;	//1成功，0失败
	uint32_t sec;
	uint32_t us;
}sntp_result_t;


BOOL SntpInit(CHAR* serverAddr, UINT16 serverPort, BOOL autoSync, UINT8 cid, CBFuncEx_t callback, void *user_param);

void SntpTerminat(void);

//check sntp whether running,TRUE->running, FALSE->not run
BOOL SntpChkStatus(CHAR *serverAddr, UINT16 *serverPort, UINT8 *cid);



