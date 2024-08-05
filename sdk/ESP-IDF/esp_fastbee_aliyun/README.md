# ESP 设备对接Fastbee物联网云平台指南
# 目录

- [1.目的](#aim)  
- [2.硬件准备](#hardwareprepare)  
- [3.云平台准备](#fastbeeprepare)  
- [4.环境搭建](#compileprepare)  
- [5.SDK 准备](#sdkprepare)  
- [6.编译&烧写&运行](#makeflash)  


# <span id = "aim">1.目的</span>
本项目基于esp-aliyun SDK进行修改，介绍 ESP 设备对接Fastbee物联网云平台，阿里云平台的具体流程。
主要实现的功能：
- 支持 <Fastbee物联网云平台> 配网&接入&控制
- 支持 <云智能> APP 一键配网
- 支持 <云智能> APP 控制设备
- 支持 <天猫精灵智能音箱> 控制设备
- 支持 <天猫精灵智能音箱> 配网并控制设备
- 支持 LED 控制(开关,颜色等)
- 支持 OTA 升级

# <span id = "hardwareprepare">2.硬件准备</span>
- **linux 环境**  
用来编译 & 烧写 & 运行等操作的必须环境。 
> windows 用户可安装虚拟机，在虚拟机中安装 linux。

- **ESP 设备**  
ESP 设备包括 [ESP芯片](https://www.espressif.com/zh-hans/products/hardware/socs)，[ESP模组](https://www.espressif.com/zh-hans/products/hardware/modules)，[ESP开发板](https://www.espressif.com/zh-hans/products/hardware/development-boards)等。

- **USB 线**  
连接 PC 和 ESP 设备，用来烧写/下载程序，查看 log 等。

# <span id = "compileprepare">3.云平台准备</span>

# <span id = "compileprepare">4.环境搭建</span>
**如果您熟悉 ESP 开发环境，可以很顺利理解下面步骤; 如果您不熟悉某个部分，比如编译，烧录，需要您结合官方的相关文档来理解。如您需阅读 [ESP-IDF 编程指南](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/index.html)文档等。**  

## 4.1 编译器环境搭建
- ESP8266 平台: 根据[官方链接](https://github.com/espressif/ESP8266_RTOS_SDK)中 **Get toolchain**，获取 toolchain
- ESP32  & ESP32S2 平台：根据[官方链接](https://github.com/espressif/esp-idf/blob/master/docs/zh_CN/get-started/linux-setup.rst)中 **工具链的设置**，下载 toolchain

toolchain 设置参考 [ESP-IDF 编程指南](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/get-started/index.html#get-started-setup-toolchain)。  
## 4.2 烧录工具/下载工具获取
- ESP8266 平台：烧录工具位于 [ESP8266_RTOS_SDK](https://github.com/espressif/ESP8266_RTOS_SDK) 下 `./components/esptool_py/esptool/esptool.py`
- ESP32 & ESP32S2 平台：烧录工具位于 [esp-idf](https://github.com/espressif/esp-idf) 下 `./components/esptool_py/esptool/esptool.py`

esptool 功能参考:  

```
$ ./components/esptool_py/esptool/esptool.py --help
```

# <span id = "sdkprepare">5.SDK 准备</span> 
- [esp-aliyun SDK](https://github.com/espressif/esp-aliyun), 通过该 SDK 可实现使用 MQTT 协议，连接 ESP 设备到阿里云。
- Espressif SDK
  - ESP32 & ESP32S2 平台: [ESP-IDF](https://github.com/espressif/esp-idf)
  - ESP8266 平台: [ESP8266_RTOS_SDK](https://github.com/espressif/ESP8266_RTOS_SDK)

> Espressif SDK 下载好后：  
> ESP-IDF: 请切换到 v4.2 分支： `git checkout v4.2`
如果需要使用 ESP32S2 模组，请切换到 v4.2 版本： `git checkout v4.2`
> ESP8266_RTOS_SDK: 请切换到 v3.3 分支： `git checkout v3.3`

# <span id = "makeflash">6.编译 & 烧写 & 运行</span>
## 6.1 编译

### 6.1.1 导出编译器
参考 [工具链的设置](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/get-started/linux-setup.html)

### 6.1.2 编译 demo 示例
**由于 esp32 和 esp8266 将会采用不同的 sdkconfig.defaults 和对应的 partitions.csv，在对应的 make 命令中加入了对应的芯片选项，如 chip=esp32 或 chip=esp8266。**

当 chip=esp32 时将默认使用 sdkconfig_esp32.defaults 以及 partitions_esp32.csv。

当 chip=esp8266 时将默认使用 sdkconfig_esp8266.defaults 以及 partitions_esp8266.csv。

当使用 esp32s2 时，将默认使用 sdkconfig.defaults ，sdkconfig.defaults.esp32s2 以及 partitions_esp32s2.csv，编译方式与 8266 & 32 都不一样，需要使用 cmake 进行编译。

以上需要特别注意。

在 esp-aliyun 目录下执行：

```
cd fastbee\sdk\ESP-IDF\esp-aliyun
make chip=esp32 defconfig
make menuconfig
```

如果需要编译esp32s2版本, 请按照如下步骤编译:

在 esp-aliyun 目录下执行：

```
cd fastbee\sdk\ESP-IDF\esp-aliyun
idf.py set-target esp32s2
idf.py menuconfig
```

- 配置烧写串口
- 配置 `WIFI_SSID`, `WIFI_PASSWORD`

如果需要编译esp32s3版本, 请按照如下步骤编译:

在 esp-aliyun 目录下执行：

```
cd fastbee\sdk\ESP-IDF\esp-aliyun
idf.py set-target esp32s3
idf.py menuconfig
```

2.生成最终 bin

```
make -j8
```
使用 esp32s2/esp32s3 生成 bin

```
idf.py build
```

## 6.2 擦除 & 编译烧写 & 下载固件 & 查看 log
将 USB 线连接好 ESP 设备和 PC,确保烧写端口正确。 

### 6.2.1[可选] 擦除 flash
```
make erase_flash
```
> 注：无需每次擦除，擦除后需要重做 6.2.3。

### 6.2.2 烧录程序
```
make flash
```

使用 esp32s2/esp32s3 擦除 flash
```
idf.py -p (PORT) erase_flash
```

### 6.2.3 烧录三元组信息
参考 [量产说明](./aliyunsdk/config/mass_mfg/README.md) 文档烧录三元组 NVS 分区。

## 6.2.4 运行

```
make monitor
```

> 也可执行 `make flash monitor` 来编译烧写和查看 log。
