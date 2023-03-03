
#ifndef TIME_TRANSLATE_H
#define TIME_TRANSLATE_H

#include <stdint.h>
#include <stdbool.h>


typedef enum
{
    SC_FREQ_32K=0,
    SC_FREQ_2048=1,
    SC_FREQ_100=2,
    SC_FREQ_32000,
    SC_FREQ_XXK,
    // other possiable value

}ScFreq;

uint32_t SlowCounterToSysTick(uint32_t scCntValue, ScFreq freq);
uint32_t SlowCounterToMs(uint32_t scCntValue, ScFreq freq);
uint32_t SysTickToSlowCounter(uint32_t ticks, ScFreq freq);
uint32_t SlowCounterTo8HzCounter(uint32_t delta_sc_value, ScFreq freq, uint32_t *remain, bool need_compensate);
void SlowCounter32KTSave(uint32_t freq);
uint32_t SlowCounter32KTFreqGet(void);

#endif

