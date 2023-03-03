#include "relay.h"
#include "luat_debug.h"


/*
J0  J1  J2  J3  J4  J5  J6  J7
O17 O16 O2  O24 O12 O13 O7 O6   O3
23  22  21  20  58  57  56  55  54
*/
#define RELAY0_PIN HAL_GPIO_17
#define RELAY1_PIN HAL_GPIO_16
#define RELAY2_PIN HAL_GPIO_2
#define RELAY3_PIN HAL_GPIO_24
#define RELAY4_PIN HAL_GPIO_12
#define RELAY5_PIN HAL_GPIO_13
#define RELAY6_PIN HAL_GPIO_7
#define RELAY7_PIN HAL_GPIO_6
#define RELAY8_PIN HAL_GPIO_3

static unsigned char nRelayValue[8] = {0};

static inline unsigned char getPin(unsigned char nRelayIndex)
{
	unsigned char nResult = RELAY0_PIN;
	switch (nRelayIndex)
	{
		case 0: nResult = RELAY0_PIN; break;
		case 1: nResult = RELAY1_PIN; break;
		case 2: nResult = RELAY2_PIN; break;
		case 3: nResult = RELAY3_PIN; break;
		case 4: nResult = RELAY4_PIN; break;
		case 5: nResult = RELAY5_PIN; break;
		case 6: nResult = RELAY6_PIN; break;
		case 7: nResult = RELAY7_PIN; break;
		case 8: nResult = RELAY8_PIN; break;
		default:
			break;
	}
	return nResult;
}

/*
*Summary:继电器初始化
*Parameters:
*Return: 
*/
void relayInit()
{
	luat_gpio_cfg_t gpioCfg; //创建结构体
	luat_gpio_set_default_cfg(&gpioCfg); //初始化结构体
	gpioCfg.pull = LUAT_GPIO_PULLDOWN; //外部有三极管下拉 这里也配置成下拉
	gpioCfg.mode = LUAT_GPIO_OUTPUT; 
	gpioCfg.output_level = LUAT_GPIO_LOW; 
	for (unsigned char i = 0; i < 9; i++)
	{
		gpioCfg.pin = getPin(i);
		luat_gpio_open(&gpioCfg); //打开
		luat_gpio_set(gpioCfg.pin, 0); //输出低电平
	}
}

/*
*Summary:继电器控制
*Parameters:
*	nRelayIndex:继电器号
*   nValue 设置值
*Return: 0 失败 1成功
*/
unsigned char relayControl(unsigned char nRelayIndex, unsigned char nValue)
{
	if(nValue == 0)
		luat_gpio_set(getPin(nRelayIndex), 0);
	else
		luat_gpio_set(getPin(nRelayIndex), 1);
	nRelayValue[nRelayIndex] = nValue;
	return 1; //默认都成功
}

unsigned char relayGetValue(unsigned char nRelayIndex)
{
	return nRelayValue[nRelayIndex];
}

