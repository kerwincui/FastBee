##### 一、实现wifi和mqtt功能，对接系统的基本示例。
* 修改wifi.c文件中的 SSID和密码，连接自己wifi
* 修改mqtt.c文件中的mqtt信息，连接自己的mqtt代理服务


##### 二、环境
* 芯片采用ESP32S2，基于ESP-IDF v4.2版本开发，其他版本未测试
* [更多文档 >>](https://docs.espressif.com/projects/esp-idf/zh_CN/v4.2/esp32s2/get-started/index.html)

##### 三、项目适配
* wifi.c文件，修改wifi的账号和密码
* mqtt.c文件，修改mqtt配置信息，以及设备编号、用户ID和设备分类ID

##### 四、后端和服务端交互
![图片](https://gitee.com/kerwincui/wumei-smart/raw/master/document/flow.png)  

##### 五、[硬件通用接入文档看这里 >>>](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4203154&doc_id=1506495)