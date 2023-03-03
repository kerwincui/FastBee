#include "optocoupler.h"

/*
U   U   U   D   D   D
In0 In1 In2 In3 In4 In5 In6 In7
I28 I4  I5  I30 I31 I23 I25 I12(X)
78  80  81  31  32  99  106 97
*/

#define PIN_0 HAL_GPIO_19
#define PIN_1 HAL_GPIO_29
#define PIN_2 HAL_GPIO_5
#define PIN_3 HAL_GPIO_4 
#define PIN_4 HAL_GPIO_28
#define PIN_5 HAL_GPIO_30
#define PIN_6 HAL_GPIO_31
#define PIN_7 HAL_GPIO_23

static inline unsigned char getPin(unsigned char nRelayIndex)
{
	unsigned char nResult = PIN_0;
	switch (nRelayIndex)
	{
	case 0: nResult = PIN_0; break;
	case 1: nResult = PIN_1; break;
	case 2: nResult = PIN_2; break;
	case 3: nResult = PIN_3; break;
	case 4: nResult = PIN_4; break;
	case 5: nResult = PIN_5; break;
	case 6: nResult = PIN_6; break;
	case 7: nResult = PIN_7; break;
	default:
		break;
	}
	return nResult;
}

void optocouplerInit()
{
	luat_gpio_cfg_t gpioCfg; //创建结构体
	luat_gpio_set_default_cfg(&gpioCfg); //初始化结构体
	gpioCfg.pull = LUAT_GPIO_PULLUP; //外部有三极管下拉 这里也配置成下拉
	gpioCfg.mode = LUAT_GPIO_INPUT;

	for (unsigned char i = 1; i < 8; i++)
	{
		gpioCfg.pin = getPin(i);
		luat_gpio_open(&gpioCfg); //打开
		luat_gpio_set(gpioCfg.pin, 0); //输出低电平
	}
	gpioCfg.pin = getPin(0);
	gpioCfg.alt_fun = 4;// 功能4 才是GPIO19
	luat_gpio_open(&gpioCfg); //打开
	luat_gpio_set(gpioCfg.pin, 0); //输出低电平
}

unsigned char getOptocoupler(unsigned char nIndex)
{
	return luat_gpio_get(getPin(nIndex));
}
