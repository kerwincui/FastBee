#ifndef __RTE_DEVICE_H
#define __RTE_DEVICE_H

#include "ec618.h"

/*  Peripheral IO Mode Select, Must Configure First !!!
    Note, when receiver works in DMA_MODE, interrupt is also enabled to transfer tailing bytes.
*/

#define POLLING_MODE            0x1
#define DMA_MODE                0x2
#define IRQ_MODE                0x3
#define UNILOG_MODE             0x4

#define RTE_UART0_TX_IO_MODE    UNILOG_MODE
#define RTE_UART0_RX_IO_MODE    IRQ_MODE
#define USART0_RX_TRIG_LVL      (30)

#define RTE_UART1_TX_IO_MODE    DMA_MODE
#define RTE_UART1_RX_IO_MODE    DMA_MODE

#define RTE_UART2_TX_IO_MODE    DMA_MODE
#define RTE_UART2_RX_IO_MODE    DMA_MODE

#define RTE_SPI0_IO_MODE        POLLING_MODE

#define RTE_SPI1_IO_MODE        POLLING_MODE

#define RTE_I2C0_IO_MODE        POLLING_MODE
#define RTE_I2C1_IO_MODE        POLLING_MODE


// I2C0 (Inter-integrated Circuit Interface) [Driver_I2C0]
// Configuration settings for Driver_I2C0 in component ::Drivers:I2C
#define RTE_I2C0                        1

// { PAD_PIN13},  // 4 : gpio14 / 2 : I2C0 SCL
// { PAD_PIN14},  // 4 : gpio15 / 2 : I2C0 SDA
#define RTE_I2C0_SCL_BIT                13			// AUDIO use 13
#define RTE_I2C0_SCL_FUNC               PAD_MUX_ALT2

#define RTE_I2C0_SDA_BIT                14			// AUDIO use 14
#define RTE_I2C0_SDA_FUNC               PAD_MUX_ALT2

// DMA
//   Tx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_I2C0_DMA_TX_EN              0
#define RTE_I2C0_DMA_TX_REQID           DMA_REQUEST_I2C0_TX
//   Rx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_I2C0_DMA_RX_EN              0
#define RTE_I2C0_DMA_RX_REQID           DMA_REQUEST_I2C0_RX

// I2C1 (Inter-integrated Circuit Interface) [Driver_I2C1]
// Configuration settings for Driver_I2C1 in component ::Drivers:I2C
#define RTE_I2C1                        1

// { PAD_PIN20},  // 0 : gpio5  / 2 : I2C1 SCL
// { PAD_PIN19},  // 0 : gpio4  / 2 : I2C1 SDA
#define RTE_I2C1_SCL_BIT                20
#define RTE_I2C1_SCL_FUNC               PAD_MUX_ALT2

#define RTE_I2C1_SDA_BIT                19
#define RTE_I2C1_SDA_FUNC               PAD_MUX_ALT2

// DMA
//   Tx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_I2C1_DMA_TX_EN              1
#define RTE_I2C1_DMA_TX_REQID           DMA_REQUEST_I2C1_TX
//   Rx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_I2C1_DMA_RX_EN              1
#define RTE_I2C1_DMA_RX_REQID           DMA_REQUEST_I2C1_RX


// UART0 (Universal asynchronous receiver transmitter) [Driver_USART0]
// Configuration settings for Driver_USART0 in component ::Drivers:USART
#define RTE_UART0_CTS_PIN_EN            0
#define RTE_UART0_RTS_PIN_EN            0

// { PAD_PIN27},  // 0 : gpio12 / 3 : UART0 RTSn
// { PAD_PIN28},  // 0 : gpio13 / 3 : UART0 CTSn
// { PAD_PIN29},  // 0 : gpio14 / 3 : UART0 RXD
// { PAD_PIN30},  // 0 : gpio15 / 3 : UART0 TXD
#define RTE_UART0_RTS_BIT               27
#define RTE_UART0_RTS_FUNC              PAD_MUX_ALT3

#define RTE_UART0_CTS_BIT               28
#define RTE_UART0_CTS_FUNC              PAD_MUX_ALT3

#define RTE_UART0_RX_BIT                29
#define RTE_UART0_RX_FUNC               PAD_MUX_ALT3

#define RTE_UART0_TX_BIT                30
#define RTE_UART0_TX_FUNC               PAD_MUX_ALT3

// DMA
//  Tx
//    Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_UART0_DMA_TX_REQID          DMA_REQUEST_USART0_TX
//  Rx
//    Channel    <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_UART0_DMA_RX_REQID          DMA_REQUEST_USART0_RX

// UART1 (Universal asynchronous receiver transmitter) [Driver_USART1]
// Configuration settings for Driver_USART1 in component ::Drivers:USART
#define RTE_UART1_CTS_PIN_EN            0
#define RTE_UART1_RTS_PIN_EN            0

// { PAD_PIN31},  // 0 : gpio16  / 1 : UART1 RTS
// { PAD_PIN32},  // 0 : gpio17  / 1 : UART1 CTS
// { PAD_PIN33},  // 0 : gpio18  / 1 : UART1 RXD
// { PAD_PIN34},  // 0 : gpio19  / 1 : UART1 TXD
#define RTE_UART1_RTS_BIT               31
#define RTE_UART1_RTS_FUNC              PAD_MUX_ALT1

#define RTE_UART1_CTS_BIT               32
#define RTE_UART1_CTS_FUNC              PAD_MUX_ALT1

#define RTE_UART1_RX_BIT                33
#define RTE_UART1_RX_FUNC               PAD_MUX_ALT1

#define RTE_UART1_TX_BIT                34
#define RTE_UART1_TX_FUNC               PAD_MUX_ALT1

// DMA
//   Tx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_UART1_DMA_TX_REQID          DMA_REQUEST_USART1_TX
//   Rx
//     Channel    <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_UART1_DMA_RX_REQID          DMA_REQUEST_USART1_RX

// UART2 (Universal asynchronous receiver transmitter) [Driver_USART2]
// Configuration settings for Driver_USART2 in component ::Drivers:USART
#define RTE_UART2_CTS_PIN_EN            0
#define RTE_UART2_RTS_PIN_EN            0

// { PAD_PIN25},  // 0 : gpio10 / 3 : UART2 RXD
// { PAD_PIN26},  // 0 : gpio11 / 3 : UART2 TXD
#define RTE_UART2_RX_BIT                25
#define RTE_UART2_RX_FUNC               PAD_MUX_ALT3

#define RTE_UART2_TX_BIT                26
#define RTE_UART2_TX_FUNC               PAD_MUX_ALT3


// DMA
//   Tx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_UART2_DMA_TX_REQID          DMA_REQUEST_USART2_TX
//   Rx
//     Channel    <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_UART2_DMA_RX_REQID          DMA_REQUEST_USART2_RX

// SPI0 (Serial Peripheral Interface) [Driver_SPI0]
// Configuration settings for Driver_SPI0 in component ::Drivers:SPI
#define RTE_SPI0                        1

// { PAD_PIN23},  // 0 : gpio8  / 1 : SPI0 SSn
// { PAD_PIN24},  // 0 : gpio9  / 1 : SPI0 MOSI
// { PAD_PIN25},  // 0 : gpio10 / 1 : SPI0 MISO
// { PAD_PIN26},  // 0 : gpio11 / 1 : SPI0 SCLK
#define RTE_SPI0_SSN_BIT                0xFF
#define RTE_SPI0_SSN_FUNC               PAD_MUX_ALT1

#define RTE_SPI0_MOSI_BIT               24
#define RTE_SPI0_MOSI_FUNC              PAD_MUX_ALT1

#define RTE_SPI0_MISO_BIT               25
#define RTE_SPI0_MISO_FUNC              PAD_MUX_ALT1

#define RTE_SPI0_SCLK_BIT               26
#define RTE_SPI0_SCLK_FUNC              PAD_MUX_ALT1

#define RTE_SPI0_SSN_GPIO_INSTANCE      0
#define RTE_SPI0_SSN_GPIO_INDEX         8

// DMA
//   Tx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_SPI0_DMA_TX_REQID           DMA_REQUEST_SPI0_TX

//   Rx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_SPI0_DMA_RX_REQID           DMA_REQUEST_SPI0_RX

// SPI1 (Serial Peripheral Interface) [Driver_SPI1]
// Configuration settings for Driver_SPI1 in component ::Drivers:SPI
#define RTE_SPI1                        0

// { PAD_PIN27},  // 0 : gpio12  / 1 : SPI1 SSn
// { PAD_PIN28},  // 0 : gpio13  / 1 : SPI1 MOSI
// { PAD_PIN29},  // 0 : gpio14  / 1 : SPI1 MISO
// { PAD_PIN30},  // 0 : gpio15  / 1 : SPI1 SCLK
// { PAD_PIN31},  // 0 : gpio16  / 4 : SPI1 SSn1
#define RTE_SPI1_SSN_BIT                27
#define RTE_SPI1_SSN_FUNC               PAD_MUX_ALT1

#define RTE_SPI1_MOSI_BIT               28
#define RTE_SPI1_MOSI_FUNC              PAD_MUX_ALT1

#define RTE_SPI1_MISO_BIT               29
#define RTE_SPI1_MISO_FUNC              PAD_MUX_ALT1

#define RTE_SPI1_SCLK_BIT               30
#define RTE_SPI1_SCLK_FUNC              PAD_MUX_ALT1

#define RTE_SPI1_SSN_GPIO_INSTANCE      0
#define RTE_SPI1_SSN_GPIO_INDEX         12

#define RTE_SPI1_SSN1_BIT               31
#define RTE_SPI1_SSN1_FUNC              PAD_MUX_ALT4

// DMA
//   Tx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_SPI1_DMA_TX_REQID           DMA_REQUEST_SPI1_TX

//   Rx
//     Channel     <0=>0 <1=>1 <2=>2 <3=>3 <4=>4 <5=>5 <6=>6 <7=>7
#define RTE_SPI1_DMA_RX_REQID           DMA_REQUEST_SPI1_RX


// PWM0 Controller [Driver_PWM0]
// Configuration settings for Driver_PWM0 in component ::Drivers:PWM
#define RTE_PWM                         1

#define EFUSE_INIT_MODE POLLING_MODE
#define L2CTLS_INIT_MODE POLLING_MODE

#define FLASH_BARE_RW_MODE 1





#define RTE_UART0                       1
#define RTE_UART1                       1
#define RTE_UART2                       1
/* to enable external thermal */
#define EXTERNAL_NTC_EXIST              0


#if (RTE_UART1 == 1)
#define UART1_DTR_PAD_INDEX             26     // GPIO11
#define UART1_DTR_GPIO_INSTANCE         0
#define UART1_DTR_GPIO_PIN              11

#define UART1_RI_PAD_INDEX              44     // AONIO 4 = GPIO24
#define UART1_RI_GPIO_INSTANCE          1
#define UART1_RI_GPIO_PIN               8
#define UART1_RI_PWM_INSTANCE           1
#define UART1_RI_PWM_CLK_ID             FCLK_TIMER1
#define UART1_RI_PWM_CLK_SEL            FCLK_TIMER1_SEL_26M

#define UART1_DCD_PAD_INDEX             45     // AONIO 5 = GPIO25
#define UART1_DCD_GPIO_INSTANCE         1
#define UART1_DCD_GPIO_PIN              9
#endif

#if (RTE_UART2 == 1)
#define UART2_DTR_PAD_INDEX             25     // GPIO10
#define UART2_DTR_GPIO_INSTANCE         0
#define UART2_DTR_GPIO_PIN              10

#define UART2_RI_PAD_INDEX              43     // AONIO 3 = GPIO23
#define UART2_RI_GPIO_INSTANCE          1
#define UART2_RI_GPIO_PIN               7
#define UART2_RI_PWM_INSTANCE           0
#define UART2_RI_PWM_CLK_ID             FCLK_TIMER0
#define UART2_RI_PWM_CLK_SEL            FCLK_TIMER0_SEL_26M

#define UART2_DCD_PAD_INDEX             47     // AONIO 7 = GPIO27
#define UART2_DCD_GPIO_INSTANCE         1
#define UART2_DCD_GPIO_PIN              11
#endif


#define NETLIGHT_PAD_INDEX              46     // AONIO 6 = GPIO26
#define NETLIGHT_PAD_ALT_FUNC           PAD_MUX_ALT5
#define NETLIGHT_PWM_INSTANCE           3

//USIM1 OPTION1
#define USIM1_URST_OP1_PAD_INDEX             19     // GPIO4
#define USIM1_URST_OP1_GPIO_INSTANCE         0
#define USIM1_URST_OP1_GPIO_PIN              4
#define USIM1_UCLK_OP1_PAD_INDEX             20     // GPIO5
#define USIM1_UCLK_OP1_GPIO_INSTANCE         0
#define USIM1_UCLK_OP1_GPIO_PIN              5
#define USIM1_UIO_OP1_PAD_INDEX              21     // GPIO6
#define USIM1_UIO_OP1_GPIO_INSTANCE          0
#define USIM1_UIO_OP1_GPIO_PIN               6

//USIM1 OPTION2
#define USIM1_UIO_OP2_PAD_INDEX              27     // GPIO12
#define USIM1_UIO_OP2_GPIO_INSTANCE          0
#define USIM1_UIO_OP2_GPIO_PIN               12
#define USIM1_URST_OP2_PAD_INDEX             28     // GPIO13
#define USIM1_URST_OP2_GPIO_INSTANCE         0
#define USIM1_URST_OP2_GPIO_PIN              13
#define USIM1_UCLK_OP2_PAD_INDEX             29     // GPIO14
#define USIM1_UCLK_OP2_GPIO_INSTANCE         0
#define USIM1_UCLK_OP2_GPIO_PIN              14

//USIM1 clock latched by AONIO, for example, use AONIO-6 test on EVB
#define AONIO_6_PAD_INDEX        46     // AONIO 6 = GPIO26
#define AONIO_6_GPIO_INSTANCE    1
#define AONIO_6_GPIO_PIN         10

#define RTE_CSPI0                       0

#define RTE_CSPI0_MCLK_PAD_ADDR         39
#define RTE_CSPI0_MCLK_FUNC             PAD_MUX_ALT1

#define RTE_CSPI0_PCLK_PAD_ADDR         35
#define RTE_CSPI0_PCLK_FUNC             PAD_MUX_ALT1

#define RTE_CSPI0_CS_PAD_ADDR           36
#define RTE_CSPI0_CS_FUNC               PAD_MUX_ALT1

#define RTE_CSPI0_SDO0_PAD_ADDR         37
#define RTE_CSPI0_SDO0_FUNC             PAD_MUX_ALT1

#define RTE_CSPI0_SDO1_PAD_ADDR         38
#define RTE_CSPI0_SDO1_FUNC             PAD_MUX_ALT1

// DMA CSPI0 Request ID
#define RTE_CSPI0_DMA_RX_REQID          DMA_REQUEST_I2S0_RX

// CSPI1 Configuration
#define RTE_CSPI1                       1

#define RTE_CSPI1_MCLK_PAD_ADDR         18
#define RTE_CSPI1_MCLK_FUNC             PAD_MUX_ALT1

#define RTE_CSPI1_PCLK_PAD_ADDR         19
#define RTE_CSPI1_PCLK_FUNC             PAD_MUX_ALT1

#define RTE_CSPI1_CS_PAD_ADDR           20
#define RTE_CSPI1_CS_FUNC               PAD_MUX_ALT1

#define RTE_CSPI1_SDO0_PAD_ADDR         21
#define RTE_CSPI1_SDO0_FUNC             PAD_MUX_ALT1

#define RTE_CSPI1_SDO1_PAD_ADDR         22
#define RTE_CSPI1_SDO1_FUNC             PAD_MUX_ALT1

// DMA CSPI1 Request ID
#define RTE_CSPI1_DMA_RX_REQID          DMA_REQUEST_I2S1_RX

#endif  /* __RTE_DEVICE_H */
