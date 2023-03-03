/**
 * @file driver_gpio.h
 * @brief 使用本模块API时，不可以使用原厂的GPIO API，不能用wakeupPAD相关API，但是能使用PAD 普通API。所有API都是任务不安全的和中断不安全的！！！
 * @version 0.1
 * @date 2022-10-25
 *
 * @copyright
 *
 */

#ifndef __CORE_GPIO_H__
#define __CORE_GPIO_H__
#include "bsp_common.h"
/**
 * @brief GPIO全局初始化
 *
 * @param Fun 中断回调函数，回调时，PIN序号是pData，void *->uint32_t。这里是给全部的GPIO统一设置，可以留空，然后给每个GPIO单独配置

 */
void GPIO_GlobalInit(CBFuncEx_t Fun);

/**
 * @brief GPIO初始化
 *
 * @param Pin Pin序号
 * @param IsInput 是否为输入功能，1是，0否
 * @param InitValue 初始电平，1高，0低，只对输出有效

 */
void GPIO_Config(uint32_t Pin, uint8_t IsInput, uint8_t InitValue);

/**
 * @brief GPIO初始化，并且同步控制上下拉电阻，增强驱动力
 *
 * @param Pin Pin序号
 * @param IsInput 是否为输入功能，1是，0否
 * @param InitValue 初始电平，1高并且上拉，0低并且下拉
 * @param AltFun 复用功能，大部分Pad和GPIO是一一对应的，如果出现多个Pad对应1个GPIO，如果AltFun不能匹配则默认用Alt0的PAD
 */
void GPIO_ConfigWithPullEC618(uint32_t Pin, uint8_t IsInput, uint8_t InitValue, uint8_t AltFun);

/**
 * @brief GPIO上下拉控制
 *
 * @param Pad Pad序号，注意这个不是Pin序号
 * @param IsPull 是否需要上下拉
 * @param IsUp 是否上拉

 */
void GPIO_PullConfig(uint32_t Pad, uint8_t IsPull, uint8_t IsUp);

/**
 * @brief GPIO外部中断初始化，GPIO20~22只有配置成双边沿中断时，因为开启了wakeuppad功能，才有了弱上拉！
 *
 * @param Pin Pin序号
 * @param IsLevel 是否是电平中断，0边沿型，1电平型
 * @param IsRiseHigh 上升沿或者高电平，EC618的大部分GPIO只能单边沿中断，所以上升沿和下降沿同时配置，设置成上升沿。GPIO20~22由于和wakeuppad重叠，才能实现双边沿触发
 * @param IsFallLow 下降沿或者低电平
 */
void GPIO_ExtiConfig(uint32_t Pin, uint8_t IsLevel, uint8_t IsRiseHigh, uint8_t IsFallLow);

/**
 * @brief GPIO复用功能
 *
 * @param Pad Pad序号，注意这个不是Pin序号
 * @param Function 复用功能，这个需要根据芯片实际情况决定，当前是0~7
 * @param AutoPull 上下拉是否启动外设功能的默认配置，1启动，0关闭，调用GPIO_PullConfig时会自动关闭，如果配置成外设功能，建议开启
 * @param IsInputBuffer 输入是否启用缓冲功能，1开启，0关闭，如果是中断，建议开启
 *
 */
void GPIO_IomuxEC618(uint32_t Pad, uint32_t Function, uint8_t AltFunctionPull, uint8_t IsInputBuffer);
/**
 * @brief GPIO输出电平
 *
 * @param Pin Pin序号
 * @param Level 1高电平，0低电平
 */
void GPIO_Output(uint32_t Pin, uint8_t Level);
void GPIO_FastOutput(uint32_t Pin, uint8_t Level);
/**
 * @brief GPIO输出电平，并且同步控制上下拉电阻，增强驱动力，同时希望能接解决休眠无法保持电平的问题
 *
 * @param Pin Pin序号
 * @param Level 1高电平，0低电平
 * @param AltFun 复用功能，大部分Pad和GPIO是一一对应的，如果出现多个Pad对应1个GPIO，如果AltFun不能匹配则默认用Alt0的PAD
 */
void GPIO_OutputWithPullEC618(uint32_t Pin, uint8_t Level, uint8_t AltFun);

/**
 * @brief 读取GPIO输入电平
 *
 * @param Pin Pin序号
 * @return 1高电平， 0低电平，其他无效
 */
uint8_t GPIO_Input(uint32_t Pin);

/**
 * @brief 翻转GPIO输出电平
 *
 * @param Pin Pin序号
 * @return 无
 */
void GPIO_Toggle(uint32_t Pin);
/**
 * @brief GPIO同一端口多个pin输出电平，针对类似STM32GPIO分布有效
 *
 * @param Port 端口号 0或者1
 * @param Pins Pin序号组合
 * @param Level 1高电平，0低电平
 */
void GPIO_OutputMulti(uint32_t Port, uint32_t Pins, uint32_t Level);

/**
 * @brief 读取GPIO同一端口多个pin输入电平，如果是端口1，GPIO20~GPIO22对应的bit可能是不正常的，需要用GPIO_Input
 *
 * @param Port 端口号 0或者1
 * @return 0x0000~0xffff，每个bit代表一个pin的电平
 */
uint32_t GPIO_InputMulti(uint32_t Port);

/**
 * @brief 翻转GPIO同一端口多个pin输出电平
 * @param Port 端口号
 * @param Pins Pin序号组合
 * @return 无
 */
void GPIO_ToggleMulti(uint32_t Port, uint32_t Pins);

/**
 * @brief GPIO模拟单线输出模式
 * @param Pin Pin序号
 * @param Data 输出电平序列
 * @param BitLen 输出电平序列中一共有几个bit
 * @param Delay 每个bit之间的delay
 * @return 无
 */
void GPIO_OutPulse(uint32_t Pin, uint8_t *Data, uint16_t BitLen, uint16_t Delay);

/**
 * @brief 设置外部中断，注意低功耗模式下普通GPIO是不能用的，只能用wakepad唤醒
 * @param Pin Pin序号，WAKEUPPAD3~5已经和GPIO复用了，额外可以用HAL_WAKEUP_0~HAL_WAKEUP_2
 * @param CB 中断回调函数
 * @param Pins 中断回调时的param
 * @return 无
 */
void GPIO_ExtiSetCB(uint32_t Pin, CBFuncEx_t CB, void *pParam);

/**
 * @brief GPIO初始化成OD门输出
 * @param Pin Pin序号
 * @param InitValue 初始电平
 * @return 无
 */
void GPIO_ODConfig(uint32_t Pin, uint8_t InitValue);

/**
 * @brief 从GPIO序号转换出Pad序号，如果有多个Pad序号，则会通过AltFun决定用哪个
 *
 * @param Pin Pin序号
 * @param AltFun 复用功能，大部分Pad和GPIO是一一对应的，如果出现多个Pad对应1个GPIO，如果AltFun不能匹配则默认用Alt0的PAD
 * @return Pad序号
 */
uint32_t GPIO_ToPadEC618(uint32_t Pin, uint8_t AltFun);

/**
 * @brief 设置WAKEUPPAD0,1,2
 *
 * @param Pin Pin序号，HAL_WAKEUP_0~HAL_WAKEUP_2
 * @param IsRiseHigh 上升沿触发
 * @param IsFallLow 下降沿触发
 * @param Pullup 上拉
 * @param Pulldown 下拉
 */
void GPIO_WakeupPadConfig(uint32_t Pin, uint8_t IsRiseHigh, uint8_t IsFallLow, uint8_t Pullup, uint8_t Pulldown);
#endif
