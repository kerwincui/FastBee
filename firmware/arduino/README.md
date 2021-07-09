
##### 一、支持 ESP8266和ESP32，使用ESPMQTTClient和ArduinoJson库，用于连接wifi和mqtt，以及JSON的处理
##### 二、环境搭建
1. 安装新版Arduino开发工具
2. 安装开发板和库
    * 文件 > 首选项，附加开发板管理网址添加下面地址
      * ESP8266使用：http://arduino.esp8266.com/stable/package_esp8266com_index.json
      * ESP32使用：https://dl.espressif.com/dl/package_esp32_index.json
    * 重启Arduino，打开工具 > 开发板 > 开发板管理器安装ESP8266或者ESP32
    * 打开工具 > 管理库 > 安装 ESPMQTTClient 和 ArduinoJson (可以直接把项目中的libraries拷贝至本地环境)

##### 三、项目适配
1. 修改设备编号保证唯一，调整用户ID和分类ID。
2. 修改WIFI的SSID和密码
3. 修改Mqtt消息服务器的地址、端口和账号密码

##### 四、后端和硬件交互
![图片](https://gitee.com/kerwincui/wumei-smart/raw/master/document/flow.png)  

##### 五、[硬件通用接入文档看这里 >>>](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4203154&doc_id=1506495)