
#ifndef _APMU_PERIPHERAL_
#define _APMU_PERIPHERAL_

#include <stdint.h>
#include <stdbool.h>

void apmuPeriUsbEnterStartProc(bool forceCfgPwrDown);

void apmuPeriUsbEnterAbortProc(bool forceCfgPwrDown);

void apmuPeriUsbSusp2VbusTblGuardDlyChk(uint32_t cur_tick);

void apmuPeriUsbSusp2HibGuardDlyChk(uint32_t cur_tick);

void apmuPeriUsbSleep1LateRecoverFlow(bool sleepSuccess);

void apmuPeriUsbSleep1PreRecoverFlow(bool sleepSuccess);

bool apmuPeriLpuartPreSleepProcess(void);

bool apmuPeriLpuartIsRxActive(void);

void apmuPeriStartWFITimer(uint32_t ms);

void apmuPeriDeleteWFITimer(void);

void apmuPeriDeleteCPTimer(void);

void apmuPeriClearCPTimerInterrupt(void);

void apmuPeriStartCPTimer(uint32_t cpStartTime, void* expFunc);

#endif
