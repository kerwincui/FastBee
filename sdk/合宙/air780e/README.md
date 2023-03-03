## AIR780E CSDK说明

#### 一、开发环境

1. 安装 相关驱动 参考 https://doc.openluat.com/wiki/37?wiki_page_id=4454
2. 根据自己的习惯选择代码编辑器 vscoode vs2022 si等
3. 编译参考 https://gitee.com/openLuat/luatos-soc-2022
4. 使用luatools


#### 二、物美CSDK 说明
1. 工程路径 sdk\合宙\air780e\csdk\wu_mei
2. 这个路径下面包含了头文件目录 源文件目录 xmake 管理工程文件
#### 三、代码文件说明
1. app.c 对封装好的物美通信sdk 进行的应用开发。比如采集温度 平台下发控制指令等 都会在这个文件里面处理
2. base64.c 用于处理物美认证所有的base64 编码
3. comAuth.c 用于物美的http 同步授时，mqtt的客户端ID 的加密生成
4. comInteraction.c 封装的物美平台的物模型进行的一些交互 
5. main.c 程序入口 里面为air780e的标准开发入口，里面创建一个线程 运行起来
6. optocoupler.c 物美配air780e开发板 光耦采集代码
7. relay.c 物美配air780e开发板 继电器操作代码
8. uart.c 物美配air780e开发板 串口代码 支持rs485 控制
9. wuMeiLed.c 物美配air780e开发板 LED 灯代码
10. wuMeiMqtt.c sdk 与平台通信的一些参数配置 已经mqtt 通信管理在里面
    
#### 四、必坑指南
1. air780e csdk mqtt 订阅数量有限制。可以在 sdk\合宙\air780e\csdk\luatos-soc-2022\thirdparty\mqtt\MQTTClient-C\src\MQTTClient.h 文件调整
 #define MAX_MESSAGE_HANDLERS 5 /* redefinable - how many subscriptions do you want? */
2. 注意air780e mqtt 内部是开启的线程 注意过来的数据处理 封装好了合宙sdk 是避免了这个坑的
3. 标准cjson 不支持 64位number类型，但是同步时间的时候使用到了。这个问题已经解决 且提交到了合宙官方代码仓库 直接拉去就行
#### 四、必坑指南
1. 配套开发原理图路径 sdk\合宙\air780e\开发板原理图\wumeiair780e.pdf