#include "cameraDrv.h"
#include "quirc.h"

static volatile bool isTransferDone;
extern void delay_us(uint32_t);
struct quirc *qr;
uint8_t* pic0Internal = NULL;


static void camRecvCb(uint32_t event)
{
    if(event & ARM_SPI_EVENT_TRANSFER_COMPLETE)
    {
        isTransferDone = true;
    }
}

bool decodeBegin(uint8_t* result)
{
    int num_codes=0, w, h;
    struct quirc_code code;
    struct quirc_data data;
    quirc_decode_error_t err;
    
	quirc_begin(qr, &w, &h);
	quirc_end(qr);
	num_codes = quirc_count(qr);
	
	if (num_codes != 1)
	{
		return false;
	}
	
	quirc_extract(qr, 0, &code);
	/* Decoding stage */
	err = quirc_decode(&code, &data);
	if (err)
	{
		return false;
		//printf("D F2: %s\n", quirc_strerror(err));
	}
	else
	{
		memcpy(result, data.payload, data.payload_len);	
		return true;
		//printf("Data: %s\n", data.payload);
	}
}

void camPrepare(uint8_t* pic0)
{
	pic0Internal = pic0;
	
	// Camera register part
	camRegCfg(); // Only need to init once

	// Quirc part
	qr = quirc_new();
	quirc_init(qr, pic0, 320, 240);	
}

bool camBegin(bool start, uint8_t* result)
{
    uint32_t timeOut_ms = 5000;

	if (start)
	{
		camInit(camRecvCb);

		camStart(true);
		camRecv(pic0Internal);
		
		do
        {
            delay_us(1000);
        }
        while((isTransferDone == false) && --timeOut_ms);
	}
	else
	{
		camStart(false);
		return true;
	}
	
	if (isTransferDone)
	{
		isTransferDone = false;
		
		return decodeBegin(result); 
	}
	else
	{	
		// Error: camera doesn't take picture fail
		return false;
	}
}



