#ifndef __CAMERA_DRV_H__
#define __CAMERA_DRV_H__

#include "cspi.h"
#include "sp0A39.h"
#include "sp0821.h"
#include "gc6123.h"
#include "gc032A.h"
#include "bf30a2.h"
#include "gc6153.h"

#ifdef __USER_CODE__
#ifndef CAM_CHAIN_COUNT
#define CAMERA_ENABLE_BF30A2 1
#define BF30A2_1SDR 1
#define CAM_CHAIN_COUNT CAM_8W
#endif
#endif

/**
  \addtogroup cam_interface_gr
  \{
 */

typedef struct
{
    uint8_t regAddr;                            ///< Sensor I2C register address
    uint8_t regVal;                             ///< Sensor I2C register value
}camI2cCfg_t;

typedef enum
{
    LSB_MODE    = 0,                            ///< Little endian
    MSB_MODE    = 1,                            ///< Big endian
}endianMode_e;

typedef enum
{
    WIRE_1      = 0,                            ///< 1 wire
    WIRE_2      = 1,                            ///< 2 wire
}wireNum_e;


typedef enum
{
    SEQ_0       = 0,                            ///< rxd[0] 6 4 2 0
                                                ///< rxd[1] 7 5 3 1    
    SEQ_1       = 1,                            ///< rxd[1] 6 4 2 0
                                                ///< rxd[0] 7 5 3 1
}rxSeq_e;

typedef enum
{
	CSPI_0		= 0,
	CSPI_1		= 1,
}cspiInstance_e;

typedef enum
{
	CSPI_START	 = 1,			///< cspi enable
	CSPI_STOP    = 0,			///< Cspi disable
}cspiStartStop_e;

typedef enum
{
	CSPI_INT_ENABLE	    = 1,		///< cspi interrupt enable
	CSPI_INT_DISABLE    = 0,		///< Cspi interrupt disable
}cspiIntEnable_e;


typedef struct
{
    endianMode_e    endianMode;                 ///< Endian mode
    wireNum_e       wireNum;                    ///< Wire numbers
    rxSeq_e         rxSeq;                      ///< Bit sequence in 2 wire mode
    uint8_t 		cpol;
    uint8_t			cpha;
    uint8_t         yOnly;
    uint8_t         rowScaleRatio;
    uint8_t         colScaleRatio;
    uint8_t         scaleBytes;
}camParamCfg_t;

typedef void (*camCbEvent_fn) (uint32_t event); ///< Camera callback event.
typedef void (*camIrq_fn)(void); 					///< Camera irq


/**
  \brief Init camera, include pinMux, and enable clock.  
  \param[in] dataAddr     Mem addr to store picture.
  \param[in] cb           Indicate that a picture has been taken.
  \return              
*/
void camInit(void* dataAddr, camCbEvent_fn cb);

/**
  \brief Receive the picture has been taken.
  \param[out] dataIn     The buffer which is used to store the picture.
  \return              
*/
void camRecv(uint8_t * dataIn);

/**
  \brief Init sensor's registers.
  \return              
*/
void camRegCfg(void);

/**
  \brief Write some parameters into the sensor.
  \param[in] regInfo     Sensor I2C addr and value.
  \return              
*/
void camWriteReg(camI2cCfg_t* regInfo);

/**
  \brief Read from the sensor's I2C address.
  \param[in] regAddr     Sensor's I2C register address.
  \return              
*/
uint8_t camReadReg(uint8_t regAddr);

/**
  \brief Start or stop Camera controller.
  \param[in] startStop     If true, start camera controller. If false, stop camera controller.
  \return              
*/
void camStartStop(cspiStartStop_e startStop);

/**
  \brief Register irq for cspi.
  \param[in] instance     cspi0 or cspi1.
  \param[in] irqCb        irq cb.
  \return              
*/
void camRegisterIRQ(cspiInstance_e instance, camIrq_fn irqCb);

/**
  \brief Get cspi status.
  \param[in] instance     cspi0 or cspi1.
  \return              
*/
uint32_t camGetCspiStats(cspiInstance_e instance);

/**
  \brief Clear cspi interrupt status.
  \param[in] instance     cspi0 or cspi1.
  \param[in] mask         which bit needs to clear.
  \return              
*/
void camClearIntStats(cspiInstance_e instance, uint32_t mask);

/**
  \brief Set memory addr which is used to store picture of camera.
  \param[in] dataAddr     data addr.
  \return              
*/
void camSetMemAddr(uint32_t dataAddr);

/**
  \brief Enable or disable interrupt of cspi.
  \param[in] intEnable     interrupt enable or not.
  \return              
*/
void cspiIntEnable(cspiIntEnable_e intEnable);


/** \} */

#endif
