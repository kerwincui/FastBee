![](https://oscimg.oschina.net/oscnet/up-09e0fd4e7966a3049aa39e7ab2a99dc5586.png)

### 一、项目介绍
0. 物美智能(wumei-smart)更名为[蜂信物联(FastBee)](https://fastbee.cn)。

1. FastBee开源物联网平台，简单易用，更适合中小企业和个人学习使用。适用于智能家居、智慧办公、智慧社区、农业监测、水利监测、工业控制等。

2. 系统后端采用Spring boot；前端采用Vue；消息服务器采用EMQX；移动端支持微信小程序、安卓、苹果和H5采用Uniapp；数据库采用Mysql、TDengine和Redis；设备端支持ESP32、ESP8266、树莓派、合宙等；
   <img src="https://oscimg.oschina.net/oscnet/up-004a50200a81efff7530d2cf963052b4e8c.png" />

### 二、系统功能

| 系统功能     | 功能说明                                            | 开源版本 | 商业版本  |
|:--------:|:-----------------------------------------------:|------|--------------|
| 产品管理     | 产品详情、产品物模型、产品分类、设备授权、产品固件                       | 支持   | 支持  |
| 设备管理     | 设备详情、设备分组、设备日志、设备分享、设备实时控制、实时状态、数据监测            | 支持   | 支持  |
| 物模型管理    | 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）          | 支持   | 支持  |
| MQTT接入   | emqx开源版、netty版本MqttBroker | 支持 | 支持           |
| 硬件 SDK   | ESP-IDF、Arduino、RaspberryPi、合宙等平台设备接入           | 支持   | 支持           |
| 视频监控接入   | 基于GB/T28181协议支持主流厂商监控设备接入，直播、设备录制回放、 云端录像和云台控制  | 支持设备接入和直播                    | 支持 |
| 多协议管理 | 硬件设备多种协议支持管理 | 支持JSON | 支持多种 |
| TCP接入 | 基于Netty搭建的TCP服务器 | 不支持 | 支持 |
| UDP接入 | 基于Netty搭建的UDP服务器 | 不支持 | 支持 |
| Modbus接入 | 透传Modbus/边缘网关接入Modbus设备 | 不支持 | 支持 |
| 采集点管理 | 网关设备管理子设备接入 | 不支持 | 支持 |
| OTA升级 | 固件在线升级 | 不支持 | 支持 |
| 设备模拟器调试 | Modbus设备在线调试       | 不支持                                | 支持 |
| 数据大屏 | 数据大屏可视化，将图表或页面元素封装为基础组件，0代码即可完成业务需求。      | 不支持  | 支持           |
| 规则引擎-规则脚本 | 可视化规则引擎编写，支持js,java等脚本修改消息结构，处理设备上行/下行/上线/下线/数据解析/数据转换 | 不支持  | 支持           |
| 场景联动 | 基于规则引擎生成场景联动 | 不支持 | 支持 |
| 告警&&告警配置&&告警记录 | 告警:           设备告警/平台告警判定                                           告警配置：    基于规则引擎开发的平台告警判定                                   告警记录：设备告警记录入库 | 不支持  | 支持           |
| 通知渠道 &&通知面板&&通知日志 | 阿里云短信/腾讯云短信阿里云语言/腾讯云语音/QQ邮箱/163邮箱/微信小程序/企业微信群机器人/企业微信应用信息/钉钉消息通知/钉钉群机器人 | 不支持 | 支持 |
| 多租户      | 系统内租户的管理，独占一套系统配置，数据相互隔离。如:租户权限、过期时间、用户数量、企业信息等 | 不支持  | 支持           |
| 移动端app   | 移动端（安卓 / 苹果 / 微信小程序）                            | 不支持  | 支持           |
| 云云对接 -智能音响（小度、天猫精灵、小爱同学） | 云云对接 | 不支持 | 额外付费模块 |
| web组态 | 自定义数据大屏/2D/3D | 不支持 | 额外付费模块 |
| 萤石云，海康sdk接入、AI SDK接入 | 视频接入 | 不支持 | 额外付费模块 |
| 数据存储 | 设备数据处理 | redis存储最后一条数据，不支持实时更新 | redis存储最新数据,实时更新/mysql存储系统数据/TDengine时序数据库存储设备数据 |
| 设备接入数/上行数据并发支持 | 设备接入数，以及设备数据并发量 | 支持小规模设备接入，同步处理数据 | 支持规模量大设备。消息队列削峰，线程池异步处理高并发数据 |
| 技术支持 |  | 不支持 | 提供一定的技术支持/技术方案 |



![](https://oscimg.oschina.net/oscnet/up-a9a7fdaf40208becd26c2485783bc0f86e6.png)

|[空气检测仪](https://fastbee.cn/doc/pages/hardware/)  |   [物联网开发板](https://fastbee.cn/doc/pages/hardware/)  |  [Air724开发板](https://fastbee.cn/doc/pages/hardware/)  |  [智能开关](https://fastbee.cn/doc/pages/hardware/) | [查看更多>>](https://fastbee.cn/doc/pages/hardware/)  |
|  :----:  | :----------:  |:----------:  |:----------:  |:----------:  |
| ![](https://oscimg.oschina.net/oscnet/up-ad98a81677e5e68d660866770e3266ca4cf.png) | ![](https://oscimg.oschina.net/oscnet/up-68caf860d0659444e73f42717a03d2fdf72.png) | ![](https://oscimg.oschina.net/oscnet/up-cf690f6058042dccb567ff382ea9432ebab.png) |![](https://oscimg.oschina.net/oscnet/up-c4a7971510127324d6566dd6ea95d571483.jpg) | ![](https://oscimg.oschina.net/oscnet/up-4ce09be3599e3ff7ed91fe182572abd258b.jpg) | 


### 三、技术栈
* 服务端
- 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、TDengine、EMQX、Netty等
- 开发工具：IDEA
* Web端
- 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui、Echart等
- 开发工具：Visual Studio Code
* 移动端（微信小程序 / Android / Ios / H5）
- 相关技术：uniapp、[uView](https://www.uviewui.com/)、[uChart](https://www.ucharts.cn/)
- 开发工具：HBuilder
* 硬件端
- 相关技术： ESP-IDF、Arduino、FreeRTOS、Python、Lua等
- 开发工具：Visual Studio Code 和 Arduino等


### 四、项目目录
&nbsp;&nbsp;&nbsp;&nbsp; app         -------------------- 移动端（微信小程序 / Android / Ios / H5） 商业版开源<br/>
&nbsp;&nbsp;&nbsp;&nbsp; docker      ---------------- docker部署文件<br />
&nbsp;&nbsp;&nbsp;&nbsp; sdk         -------------------- 硬件SDK,已集成多种设备<br />
&nbsp;&nbsp;&nbsp;&nbsp; spring-boot ----------   后端<br/>
&nbsp;&nbsp;&nbsp;&nbsp; vue         -------------------- 前端<br />


### 五、商用授权
项目采用AGPL3协议，可用于个人学习和使用，商业用途需要赞助项目，获得授权，并提供商业版本源码、可视化平台和移动端源码。赞助过的用户请下载商业版本源码。
- [授权详情>>](https://fastbee.cn/doc/pages/sponsor/) &nbsp; [商业版本源码>>](https://fastbee.cn/doc/pages/sponsor/)
- [移动端源码>>](https://fastbee.cn/doc/pages/sponsor/) &nbsp; [可视化平台源码>>](https://fastbee.cn/doc/pages/sponsor/)
- 二开项目同样遵守AGPL3.0协议进行开源，可以向原作者申请授权
- 如果商业项目想转闭源，可以向原作者申请或者购买闭源授权

### 六、贡献代码
- [贡献者指南>>](./doc/贡献者指南.md)
- [Git提交规范>>](./doc/Git提交规范.md)
- [功能规划>>](./RoadMap.md)

### 七、其他
1. QQ交流群：&#x1F680;946029159    &#x1F680;1073236354(已满)

2. 权限管理基于ruoyi-vue系统开发，Mqtt消息服务器使用EMQX5.0开源版

* [开源版本在线演示](http://101.33.237.12/)
* [商业版本在线演示](https://iot.fastbee.cn/)
* [项目使用文档](https://fastbee.cn/doc/)
* [若依权限管理系统文档](http://doc.ruoyi.vip/ruoyi-vue/)
* [EMQX5.0消息服务器文档](https://www.emqx.io/docs/zh/v5.0/)
* [uCharts高性能跨平台图表库](https://www.ucharts.cn)

3. 项目贡献者(如有遗漏请联系作者)：
- [小驿物联](https://gitee.com/iot-xiaoyi)、[CrazyDull](https://gitee.com/crazyDull)、[YBZX](https://github.com/YBZX)、 [CQAdu](https://gitee.com/iot.adu)、[孙阿龙](https://gitee.com/sunalong)、[xxmfl](https://gitee.com/xxmfl)、[董晓龙-3715687@qq.com](https://fastbee.cn/)
- [SXH](https://gitee.com/sixiaohu)、 [Redamancy_zxp](https://gitee.com/redamancy-zxp)、 [LEE](https://gitee.com/yueming188)、 [LemonTree](https://gitee.com/fishhunterplus)、 [Tang](https://gitee.com/mexiaotang)、 [Tang](https://gitee.com/mexiaotang)、[KUN](https://gitee.com/L_KUN_KUN)

4. 主要参与用户：
    - [Guanshubiao](https://gitee.com/guanshubiao)：熟悉物联网开发，完善和优化系统的网关架构和部分功能等
    - [帐篷](https://gitee.com/zhuangpengli)：熟悉物联网开发，完善视频监控模块和部分协议等
    - [JaminDeng](https://gitee.com/jamin-deng)：熟悉物联网开发，完善平台前端设计可视化等

### 八、部分图片

![](https://oscimg.oschina.net/oscnet/up-972dea7b54eca705dcc8bf2fe0680b12c09.png)
![](https://oscimg.oschina.net/oscnet/up-6d89f1558797a9becf07c20f92c1407a13a.png)

<table>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-19ef5b528bb044253848722118b694bef47.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-8b4c24353bc2340b8362438b87ceac27a9d.png"></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-a0c864679be6c4f9bb5547244aeb19657b4.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-9cc3bc5abe8dd95cb3924e5f7b6864a0342.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-ec8c6251884d81f234487d3e25d459ce302.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-e5e7ef5027723051e97d6861d4296c08da5.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-3ae8cef86db794ff37d9186e83b12b88958.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-e20900a12e3781467d05163665ca04645fa.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-5c755895fc1a7ba02d487b75cf493ffb0df.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-4e279e657c6f8b6af2d58fa215ab7fae02d.jpg"></td>
    </tr>
</table>


