#include "stdint.h"
#include "bsp.h"

#define SPI_INSTANCE            SPI0
#define SPI_APB_CLOCK           PCLK_SPI0
#define SPI_FUNC_CLOCK          FCLK_SPI0
#define SPI_DMA_TX_REQID        DMA_REQUEST_SPI0_TX // DMA SPI Request ID
#define LCD_DMA_DESCRIPTOR_CHAIN_NUM                    20  // 30w pixel
#define LCD_TRANSFER_SIZE_ONCE                          480//7680 // less than 8k





#define SPI_BUS_SPEED           (1000000) // 13M

#define SPI_FLAG_TIMEOUT        (0x1000)

#define HEIGHT                  (320)
#define WIDTH                   (240)
#define RED                     (0xf800)
#define GREEN                   (0x07e0)
#define BLUE                    (0x001f)
#define YELLOW                  (0xffe0)
#define WHITE                   (0xffff)
#define BLACK                   (0x0000)
#define PURPLE                  (0xf81f)


// SPI cs pin definition
#define CS_GPIO_INSTANCE        (0)
#define CS_GPIO_PIN             (8)
#define CS_GPIO_ADDR            (23)
#define CS_PAD_ALT_FUNC         (PAD_MUX_ALT0)

// SPI clk pin definition
#define CLK_GPIO_INSTANCE       (0)
#define CLK_GPIO_PIN            (11)
#define CLK_GPIO_ADDR           (26)
#define CLK_PAD_ALT_FUNC        (PAD_MUX_ALT1)

// SPI mosi pin definition
#define MOSI_GPIO_INSTANCE      (0)
#define MOSI_GPIO_PIN           (9)
#define MOSI_GPIO_ADDR          (24)
#define MOSI_PAD_ALT_FUNC       (PAD_MUX_ALT1)

// SPI miso pin definition
#define MISO_GPIO_INSTANCE      (0)
#define MISO_GPIO_PIN           (10)
#define MISO_GPIO_ADDR          (25)
#define MISO_PAD_ALT_FUNC       (PAD_MUX_ALT1)


// LCD rst pin definition
#define RST_GPIO_INSTANCE       (1)
#define RST_GPIO_PIN            (1)
#define RST_GPIO_ADDR           (32)
#define RST_PAD_ALT_FUNC        (PAD_MUX_ALT0)

// LCD ds pin definition
#define DS_GPIO_INSTANCE        (1)
#define DS_GPIO_PIN             (0)
#define DS_GPIO_ADDR            (31)
#define DS_PAD_ALT_FUNC         (PAD_MUX_ALT0)

void st7789v2_init(void);

