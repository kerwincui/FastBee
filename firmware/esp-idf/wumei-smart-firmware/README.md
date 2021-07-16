
#### ESP-IDF完整项目
* 雷达感应、报警
* 继电器通断
* 七彩灯控制
* OTA升级
* AP配网
* 智能配网
* 遥控学习、清码
* Wifi和Mqtt功能
* 温湿度监控



#### 引脚分配参考，基于乐鑫ESP32S2芯片

* GPIO1	ADC1-CH0	    SCL-i2c传感器
* GPIO2	ADC1-CH1	    SDA-i2c传感器
* GPIO3	ADC1-CH2	    引出
* GPIO4	ADC1-CH3	    引出
* GPIO5	ADC1-CH4	    继电器 	
    
RGB灯：
* GPIO11	Red电源灯：红色（接通电源）、绿色（已经联网）、蓝色（接收信号、智能配网）
* GPIO12	Green
* GPIO13	Blue

按键：
* GPIO15	控制按钮

433M遥控
* GND
* VCC      3.3V
* GPIO19   信号1
* GPIO20   信号2
* GPIO21   信号3
* GPIO26   信号4
* GPIO33  对码按键

代码烧录
* GPIO43	TXD
* GPIO44	RXD
* GND
* GPIO0	启动模式
* EN		重启按键（EN引脚：高电平，芯片使能；低电平，芯片关闭；芯片已默认拉高）

