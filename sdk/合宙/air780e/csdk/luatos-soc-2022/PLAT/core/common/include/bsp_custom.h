#ifndef  BSP_CUSTOM_H
#define  BSP_CUSTOM_H

#ifdef __cplusplus
extern "C" {
#endif

#include "bsp.h"

void BSP_CustomInit(void);
uint32_t BSP_UsbGetVBUSMode(void);
uint32_t BSP_UsbGetVBUSWkupPad(void);
void Usim1GpioConfig(BOOL bSetUsimFunc);


#ifdef __cplusplus
}
#endif

#endif /* BSP_CUSTOM_H */
