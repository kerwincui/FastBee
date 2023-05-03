![](https://oscimg.oschina.net/oscnet/up-09e0fd4e7966a3049aa39e7ab2a99dc5586.png)

### 一、项目介绍
0. 物美智能(wumei-smart)更名为[蜂信物联(FastBee)](https://fastbee.cn)。

1. FastBee开源物联网平台，简单易用，更适合中小企业和个人学习使用。适用于智能家居、智慧办公、智慧社区、农业监测、水利监测、工业控制等。

2. 系统后端采用Spring boot；前端采用Vue；消息服务器采用EMQX；移动端支持微信小程序、安卓、苹果和H5采用Uniapp；数据库采用Mysql、TDengine和Redis；设备端支持ESP32、ESP8266、树莓派、合宙等；
<img src="https://oscimg.oschina.net/oscnet/up-004a50200a81efff7530d2cf963052b4e8c.png" />

### 二、系统功能
- 权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等
- 系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等
- 产品管理： 产品、产品物模型、产品分类、产品固件、设备授权码、自定义告警等
- 设备管理： 设备控制、设备分组、设备定时、设备日志、监测统计、设备定位、设备分享、设备禁用、OTA升级、实时状态、影子模式、实时监测、加密认证等
- EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理、规则引擎、资源
- 硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报数据、AES加密、NTP时间、AP配网等
- 物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）
- 其他功能：多租户、场景联动、视频监控、数据可视化平台、统计、新闻资讯、通知公告、支持TDengine时序数据库
- 开发中功能：网关、TCP/Modbus协议支持等

![](https://oscimg.oschina.net/oscnet/up-a9a7fdaf40208becd26c2485783bc0f86e6.png)

|[空气检测仪](https://fastbee.cn/doc/pages/hardware/)  |   [物联网开发板](https://fastbee.cn/doc/pages/hardware/)  |  [Air724开发板](https://fastbee.cn/doc/pages/hardware/)  |  [智能开关](https://fastbee.cn/doc/pages/hardware/) | [查看更多>>](https://fastbee.cn/doc/pages/hardware/)  |
|  :----:  | :----------:  |:----------:  |:----------:  |:----------:  |
| ![](https://oscimg.oschina.net/oscnet/up-ad98a81677e5e68d660866770e3266ca4cf.png) | ![](https://oscimg.oschina.net/oscnet/up-68caf860d0659444e73f42717a03d2fdf72.png) | ![](https://oscimg.oschina.net/oscnet/up-cf690f6058042dccb567ff382ea9432ebab.png) |![](https://oscimg.oschina.net/oscnet/up-c4a7971510127324d6566dd6ea95d571483.jpg) | ![](https://oscimg.oschina.net/oscnet/up-4ce09be3599e3ff7ed91fe182572abd258b.jpg) | 


### 三、技术栈    
* 服务端
    - 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、TDengine、EMQX、Netty等
    - 开发工具：IDEA    
* Web端
    - 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui等 
    - 开发工具：Visual Studio Code    
* 移动端（微信小程序 / Android / Ios / H5）
    - 相关技术：uniapp、[uView](https://www.uviewui.com/)、[uChart](https://www.ucharts.cn/)
    - 开发工具：HBuilder
* 硬件端
    - 相关技术： ESP-IDF、Arduino、FreeRTOS、Python、Lua等
    - 开发工具：Visual Studio Code 和 Arduino等


### 四、项目目录
&nbsp;&nbsp;&nbsp;&nbsp; spring-boot --------------- 后端<br/>
&nbsp;&nbsp;&nbsp;&nbsp; vue ----------------------- 前端<br />
&nbsp;&nbsp;&nbsp;&nbsp; docker -------------------- docker部署文件<br />
&nbsp;&nbsp;&nbsp;&nbsp; sdk ----------------------- 硬件SDK,已集成多种设备<br />


### 五、商用授权
项目采用AGPL3协议，可用于个人学习和使用，商业用途需要赞助项目，获得授权，并提供商业版本源码、可视化平台和移动端源码。赞助过的用户请下载商业版本源码。
- [授权详情>>](https://fastbee.cn/doc/pages/sponsor/) &nbsp; [商业版本源码>>](https://fastbee.cn/doc/pages/sponsor/)
- [移动端源码>>](https://fastbee.cn/doc/pages/sponsor/) &nbsp; [可视化平台源码>>](https://fastbee.cn/doc/pages/sponsor/) 


### 六、其他
1. QQ交流群：&#x1F680;946029159    &#x1F680;1073236354(已满)

2. 权限管理基于ruoyi-vue系统开发，Mqtt消息服务器使用EMQX4.0开源版

    * [在线演示](https://iot.fastbee.cn/)
    * [项目使用文档](https://fastbee.cn/doc/)
    * [若依权限管理系统文档](http://doc.ruoyi.vip/ruoyi-vue/)
    * [EMQX4.0消息服务器文档](https://www.emqx.io/docs/zh/v4.0/)
    * [uCharts高性能跨平台图表库](https://www.ucharts.cn)

3. 项目贡献者(如有遗漏请联系作者)：
    - [小驿物联](https://gitee.com/iot-xiaoyi)、[CrazyDull](https://gitee.com/crazyDull)、[YBZX](https://github.com/YBZX)、 [CQAdu](https://gitee.com/iot.adu)、[孙阿龙](https://gitee.com/sunalong)、[xxmfl](https://gitee.com/xxmfl)、[董晓龙-3715687@qq.com](https://fastbee.cn/)
    - [SXH](https://gitee.com/sixiaohu)、 [Redamancy_zxp](https://gitee.com/redamancy-zxp)、 [LEE](https://gitee.com/yueming188)、 [LemonTree](https://gitee.com/fishhunterplus)、 [Tang](https://gitee.com/mexiaotang)、 [Tang](https://gitee.com/mexiaotang)、[KUN](https://gitee.com/L_KUN_KUN)

4. 主要参与用户：
    - [Guanshubiao](https://gitee.com/guanshubiao)：熟悉物联网开发，完善和优化系统的网关架构和部分功能等
    - [帐篷](https://gitee.com/zhuangpengli)：熟悉物联网开发，完善视频监控模块和部分协议等
    - [Kami0314](https://github.com/kami0314)：熟悉物联网开发，完善可视化平台和其他功能等

### 七、部分图片

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



