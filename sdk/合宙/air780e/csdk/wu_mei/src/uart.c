#include "uart.h"

#include "luat_gpio.h"
#include "platform_define.h"

#define RS485_PIN1 HAL_GPIO_22 //串口1
#define RS485_PIN2 HAL_GPIO_25 //串口2

static unsigned char uart1RxBuffer[1024];
static unsigned char uart2RxBuffer[1024];
static unsigned int uart1RxLength = 0;
static unsigned int uart2RxLength = 0;

static void uartRecvCb(int uart_id, uint32_t data_len)
{
    if (uart_id == 1)
    {
        luat_uart_read(uart_id, uart1RxBuffer, data_len);
        uart1RxLength = data_len;
        LUAT_DEBUG_PRINT("luat_uart_cb uart_id:%d data:%s data_len:%d", uart_id, uart1RxBuffer, data_len);
    }
    if (uart_id == 2)
    {
        luat_uart_read(uart_id, uart2RxBuffer, data_len);
        uart2RxLength = data_len;
        LUAT_DEBUG_PRINT("luat_uart_cb uart_id:%d data:%s data_len:%d", uart_id, uart2RxBuffer, data_len);
    }
}

static void uart1Init()
{
    luat_gpio_cfg_t gpioCfg; //创建结构体
    luat_gpio_set_default_cfg(&gpioCfg); //初始化结构体
    gpioCfg.pull = LUAT_GPIO_PULLDOWN; //外部有三极管下拉 这里也配置成下拉
    gpioCfg.mode = LUAT_GPIO_OUTPUT;
    gpioCfg.output_level = LUAT_GPIO_LOW;

    gpioCfg.pin = RS485_PIN1;
    luat_gpio_open(&gpioCfg); //打开
    luat_gpio_set(RS485_PIN1, 0); //输出低电平
   

    luat_uart_t uart = {
          .id = 1,
          .baud_rate = 9600,
          .data_bits = 8,
          .stop_bits = 1,
          .parity = 0 ,
         // .pin485 = RS485_PIN1,
          .delay = 50,
          .rx_level = 0
    };

    luat_uart_setup(&uart);

    luat_uart_ctrl(1, LUAT_UART_SET_RECV_CALLBACK, uartRecvCb);
}

static void uart2Init()
{
    luat_gpio_cfg_t gpioCfg; //创建结构体
    luat_gpio_set_default_cfg(&gpioCfg); //初始化结构体
    gpioCfg.pull = LUAT_GPIO_PULLDOWN; //外部有三极管下拉 这里也配置成下拉
    gpioCfg.mode = LUAT_GPIO_OUTPUT;
    gpioCfg.output_level = LUAT_GPIO_LOW;

    gpioCfg.pin = RS485_PIN2;
    luat_gpio_open(&gpioCfg); //打开
    luat_gpio_set(RS485_PIN2, 0); //输出低电平

    luat_uart_t uart = {
      .id = 2,
      .baud_rate = 9600,
      .data_bits = 8,
      .stop_bits = 1,
      .parity = 0 ,
      //.pin485 = RS485_PIN2,
      .delay = 50,
      .rx_level = 0
    };

    luat_uart_setup(&uart);

    luat_uart_ctrl(2, LUAT_UART_SET_RECV_CALLBACK, uartRecvCb);
}

void uartInit()
{
    uart1Init();
    uart2Init();
}

void uartSend(unsigned char nUartId, unsigned char* pnData, unsigned int nLength)
{
    if (nUartId == 1)
    {
        luat_gpio_set(RS485_PIN1, 1);
        luat_rtos_task_sleep(200);
        luat_uart_write(1, pnData, nLength);
        luat_rtos_task_sleep(200);
        luat_gpio_set(RS485_PIN1, 0);
    }
    else if (nUartId == 2)
    {
        luat_gpio_set(RS485_PIN2, 1);
        luat_rtos_task_sleep(200);
        luat_uart_write(2, pnData, nLength);
        luat_rtos_task_sleep(200);
        luat_gpio_set(RS485_PIN2, 0);
    }
}

unsigned char* getUartBuffer(unsigned char nUartId)
{
    if(nUartId == 1)
        return uart1RxBuffer;
    else
        return uart2RxBuffer;
}

unsigned int getUartRxLength(unsigned char nUartId)
{
    if (nUartId == 1)
        return uart1RxLength;
    else
        return uart2RxLength;
}
