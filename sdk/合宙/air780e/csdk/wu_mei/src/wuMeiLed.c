#include "wuMeiLed.h"


#define LED0_PIN HAL_GPIO_26
void ledInit()
{
	luat_gpio_cfg_t gpioCfg; //创建结构体
	luat_gpio_set_default_cfg(&gpioCfg); //初始化结构体
	gpioCfg.pull = LUAT_GPIO_PULLDOWN; //外部有三极管下拉 这里也配置成下拉
	gpioCfg.mode = LUAT_GPIO_OUTPUT;
	gpioCfg.output_level = LUAT_GPIO_LOW;

	gpioCfg.pin = LED0_PIN;
	luat_gpio_open(&gpioCfg); //打开
	luat_gpio_set(gpioCfg.pin, 0); //输出低电平
}

unsigned char ledControl(unsigned char nledIndex, unsigned char nValue)
{
	if (nValue == 0)
		luat_gpio_set(LED0_PIN, 0);
	else
		luat_gpio_set(LED0_PIN, 1);
	return 1; //默认都成功
}