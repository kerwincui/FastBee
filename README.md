
### 一、项目简介

#### 1. WumeiSmart是一个简单易用的生活物联网平台。可用于搭建物联网平台以及二次开发和学习。[演示地址>>](https://iot.wumei.live/)

#### 2. 项目采用AGPL3协议，可用于个人学习和使用，商业用途需要赞助项目，获得授权。[查看详情 >>](https://wumei.live/doc/pages/sponsor/)

#### 3. 设备接入使用EMQX消息服务器，加密认证；后端采用Spring boot；前端采用Vue；移动端采用Uniapp；数据库采用Mysql、TDengine和Redis；设备端支持ESP32、ESP8266、树莓派等；系统架构图如下：
<img src="https://oscimg.oschina.net/oscnet/up-98eefff896394066a60d664b875a3d05d1d.png" max-width="800" />

#### 4. 相关硬件
|[空气检测仪](https://wumei.live/doc/pages/hardware/)  |   [物联网开发板](https://wumei.live/doc/pages/hardware/)  |  [Air724开发板](https://wumei.live/doc/pages/hardware/)  |  [智能开关](https://wumei.live/doc/pages/hardware/) | [查看更多>>](https://wumei.live/doc/pages/hardware/)  |
|  :----:  | :----------:  |:----------:  |:----------:  |:----------:  |
| ![](https://oscimg.oschina.net/oscnet/up-ad98a81677e5e68d660866770e3266ca4cf.png) | ![](https://oscimg.oschina.net/oscnet/up-68caf860d0659444e73f42717a03d2fdf72.png) | ![](https://oscimg.oschina.net/oscnet/up-cf690f6058042dccb567ff382ea9432ebab.png) |![](https://oscimg.oschina.net/oscnet/up-c4a7971510127324d6566dd6ea95d571483.jpg) | ![](https://oscimg.oschina.net/oscnet/up-4ce09be3599e3ff7ed91fe182572abd258b.jpg) | 



### 二、功能
- 权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等
- 系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等
- 产品管理： 产品、产品物模型、产品分类、产品固件、设备授权码等
- 设备管理： 设备控制、设备分组、设备定时、设备日志、监测统计、设备定位、设备分享、智能配网、设备禁用、OTA升级、实时状态、影子模式、实时监测、加密认证等
- EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理、规则引擎、资源
- 硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报监测数据、AES加密、NTP时间等
- 物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）
- 其他功能：多租户、统计、新闻资讯、通知公告、支持TDengine时序数据库
- 开发中功能：设备告警、场景联动、云云对接智能音箱、第三方登录、短信登录、APP界面自定义、视频流处理等


### 四、技术栈    
* 服务端
    - 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、TDengine、EMQX、Mqtt等
    - 开发工具：IDEA    
* Web端
    - 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui等 
    - 开发工具：Visual Studio Code    
* 移动端（Android / Ios / 微信小程序 / H5）
    - 相关技术：uniapp、[uView](https://www.uviewui.com/)、[uChart](https://www.ucharts.cn/)
    - 开发工具：HBuilder
* 硬件端
    - 相关技术： ESP-IDF、Arduino、FreeRTOS、Python等
    - 开发工具：Visual Studio Code 和 Arduino

### 五、硬件接入
1. 设备认证
    * 加密认证（推荐）
    * 简单认证
2. 设备交互
    * 发布物模型、设备信息、时钟同步相关Mqtt主题
    * 订阅物模型、设备升级、时钟同步相关Mqtt主题


### 六、项目目录
&nbsp;&nbsp;&nbsp;&nbsp; spring-boot --------------- 后端<br/>
&nbsp;&nbsp;&nbsp;&nbsp; vue ----------------------- 前端<br />
&nbsp;&nbsp;&nbsp;&nbsp; docker -------------------- docker部署文件<br />
&nbsp;&nbsp;&nbsp;&nbsp; sdk ----------------------- 硬件SDK，不同设备的SDK示例在不断增加<br />
&nbsp;&nbsp;&nbsp;&nbsp; app ----------------------- 移动端打包文件

###### 移动端适配多端
|安卓/Android|苹果/IOS|微信小程序| 网页/H5|Vue2.0
| :---: | :---: | :---: | :---: |:---: |
| √ | √| √ | √ | √ |


### 七、相关文档
##### 权限管理基于ruoyi-vue系统，Mqtt消息服务器基于EMQX4.0开源版，SDK示例使用ESP8266 Core For Arduino开发
* [项目文档](https://wumei.live/doc/)
* [物美智能官网](http://wumei.live/)
* [若依权限管理系统ruoyi-vue](https://gitee.com/y_project/RuoYi-Vue)
* [Mqtt消息服务器EMQX4.0](https://github.com/emqx/emqx)
* [ESP8266 Core For Arduino](https://github.com/esp8266/Arduino)
* [uCharts高性能跨平台图表库](https://www.ucharts.cn)
* [TDengine时序数据库](https://www.taosdata.com/?zh)


### 八、其他
1. 互助交流群：946029159 1073236354
2. 项目贡献者 
  - [小驿物联](https://gitee.com/iot-xiaoyi)、 [Guanshubiao](https://gitee.com/guanshubiao)、[CrazyDull](https://gitee.com/crazyDull)、 [Kami0314](https://github.com/kami0314)、 [YBZX](https://github.com/YBZX)
  - [SXH](https://gitee.com/sixiaohu)、 [Redamancy_zxp](https://gitee.com/redamancy-zxp)、 [LEE](https://gitee.com/yueming188)、 [LemonTree](https://gitee.com/fishhunterplus)、 [Tang](https://gitee.com/mexiaotang)、 [Tang](https://gitee.com/mexiaotang)、 [xxmfl](https://gitee.com/xxmfl)


### 九、部分图片

![](https://oscimg.oschina.net/oscnet/up-75a392de73aff6110e7345399aed1cc78fb.png)
![](https://oscimg.oschina.net/oscnet/up-94aa4573358d29b485d71bb251964d2bfb3.png)

<table>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-60ff517f5362f4c7b98bb4cb3df543e4ecb.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-d9dd014cec34b6424eb6d768e362356a622.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-cefbaf28d2ea5438b17dbad53638852519b.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-20672c691106771f3a38168c0f6c6a7bf20.png"/></td>
    </tr>
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-75e099216e1fa33f5e83989838ffd1b16fa.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-51d2ae913a83a542fc2c3b6f802dc34369f.png"/></td>
    </tr>
        <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-287864587ec8116ee8be115a94d1d6f9302.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-2b0a744a83f939b6694dc33c7b80193029b.png"/></td>
    </tr>	 
    <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-c8c388b20e70f6a668749aab94d214b8270.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-cc512e6367b55a3afa78bee7e1cd8c8cab9.png"/></td>
    </tr>
        <tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-457424f66db64e5e66d200d94a0d42358ad.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-bf47113b636fa96ceaf9607df795f8b3a17.png"/></td>
    </tr>
        <td><img src="https://oscimg.oschina.net/oscnet/up-e05690366e11fb173cebafcba57b5567e38.png"/></td>
        <td><img src="https://oscimg.oschina.net/oscnet/up-f7856cca6a3dd60afafd1cb0e1ae67c596e.png"/></td>
    </tr>
</table>



