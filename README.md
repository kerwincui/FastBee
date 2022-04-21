
### 一、项目简介

#### 1. 物美智能 [wumei-smart](http://wumei.live/) 是一个简单易用的生活物联网平台。可用于搭建物联网平台以及二次开发和学习。

#### 2. 设备接入使用EMQX消息服务器，加密认证；后端采用Spring boot；前端采用Vue；移动端采用Uniapp；数据库采用Mysql和Redis；设备端支持ESP32、ESP8266、树莓派等；系统架构图如下：
<img src="https://oscimg.oschina.net/oscnet/up-98eefff896394066a60d664b875a3d05d1d.png" max-width="800" />

#### 3. 案例展示
|   Wifi通断器  |   信息牌  |  桌面小电视  |  雾霾/粉尘/空气检测仪
|  :----  | :----------  |:----------  |:----------  |
| ![](https://oscimg.oschina.net/oscnet/up-91921ed009aed9b70e99e6216a3ffb5c707.png)  | ![](https://oscimg.oschina.net/oscnet/up-b25dde78b0127e0ec08db4496fcf777069d.png) | ![](https://oscimg.oschina.net/oscnet/up-9c53911f42386189b943ce753abed5346f7.png) | ![](https://oscimg.oschina.net/oscnet/up-072a5880eaf5ea502dc265bc208902b8529.png)
| 【小驿物联】<br /> 1. 手机、电脑远程控制<br /> 2. 遥控配对、清码和控制<br /> 3. 空气温湿度实时监测<br />4. 雷达感应和报警<br /> 5. 供电电压220V和5V<br /> 6. 控制阻性负载2500W，感性负载250W家用设备开关。 | 【更多设备等您加入】<br />待定 | 【更多设备等您加入】<br />待定 | 【小驿物联】<br />1. PM2.5雾霾监测<br />2. PM10粉尘监测<br /> 3. 空气质量监测 <br />4. TFT彩色屏幕

#### 4. 项目可用于个人学习和使用，商业用途需要赞助项目，获得授权。[查看详情 >>](https://gitee.com/kerwincui/wumei-smart/blob/master/app/README.md)


### 二、功能
- 权限管理： 用户管理、部门管理、岗位管理、菜单管理、角色管理、字典和参数管理等
- 系统监控： 操作日志、登录日志、系统日志、在线用户、服务监控、连接池监控、缓存监控等
- 产品管理： 产品、产品物模型、产品分类、产品固件、授权码等
- 设备管理： 控制、分组、定时、日志、统计、定位、OTA升级、影子模式、实时监测、加密认证等
- EMQ管理： Mqtt客户端、监听器、消息主题、消息订阅、插件管理
- 硬件 SDK： 支持WIFI和MQTT连接、物模型响应、实时监测、定时上报监测数据、AES加密、NTP时间等
- 物模型管理： 属性（设备状态和监测数据），功能（执行特定任务），事件（设备主动上报给云端）

### 三、计划开发功能
- 设备分享、设备告警、场景联动（进度50%）
- 智能音箱、多租户、APP界面自定义（进度40%）
- 时序数据库、分布式集群部署、Granfa监控（进度30%）
- 视频流处理、桌面端模拟器/监控、安卓端模拟器/监控（进度0%）
- App和小程序（正在开发中......）

### 四、技术栈    
* 服务端
    - 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、TDengine、EMQX、Mqtt等
    - 开发工具：IDEA    
* Web端
    - 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui等 
    - 开发工具：Visual Studio Code    
* 移动端（android / ios / 微信小程序）
    - 相关技术：uniapp、smartconfig
    - 开发工具：HBuilder
* 硬件端
    - 相关技术： ESP-IDF、Arduino、FreeRTOS等
    - 开发工具：Visual Studio Code 和 Arduino
* 安卓端模拟器/监控
    - 相关技术：android
    - 开发工具：Android Studio
* 电脑端模拟器/监控
    - 相关技术：WPF
    - 开发工具：Visual Studio

### 五、硬件接入
1. 设备认证
    * 加密认证（推荐）
    * 简单认证
    * EMQX支持的其他认证方式 
2. 设备交互
    * 发布物模型、设备信息、时钟同步相关Mqtt主题
    * 订阅物模型、设备升级、时钟同步相关Mqtt主题

###### 项目提供了示例SDK，使用ESP8266芯片，基于Arduino开发。设备烧录使用串口模块，例如Ch340，接线图如下：
![烧录代码](https://oscimg.oschina.net/oscnet/up-ed61da9a62390de451715686d6a6b37c190.png)


### 六、项目目录
&nbsp;&nbsp;&nbsp;&nbsp; spring-boot --------------- 后端<br/>
&nbsp;&nbsp;&nbsp;&nbsp; vue ----------------------- 前端<br />
&nbsp;&nbsp;&nbsp;&nbsp; docker -------------------- docker部署文件<br />
&nbsp;&nbsp;&nbsp;&nbsp; sdk ----------------------- 硬件SDK<br />
&nbsp;&nbsp;&nbsp;&nbsp; app ----------------------- [获取App源码](https://gitee.com/kerwincui/wumei-smart/tree/master/app)<br />

###### 移动端适配多端
|安卓|IOS|微信小程序|支付宝小程序|百度小程序|字节小程序|QQ小程序|快应用|
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
|√|√|√|未测试|未测试|未测试|未测试|未测试|


### 七、相关文档
##### 权限管理基于ruoyi-vue系统，Mqtt消息服务器基于EMQX4.0开源版，SDK示例使用ESP8266 Core For Arduino开发
* [项目文档](http://wumei.live/kerwincui/document/wiki/)
* [物美智能官网](http://wumei.live/)
* [权限管理系统ruoyi-vue](https://gitee.com/y_project/RuoYi-Vue)
* [Mqtt消息服务器EMQX4.0](https://github.com/emqx/emqx)
* [ESP8266 Core For Arduino](https://github.com/esp8266/Arduino)
##### Docker快速安装
* Mysql中创建wumei-smart数据库，[导入Sql脚本](https://gitee.com/kerwincui/wumei-smart/tree/master/springboot/sql)
* 修改命令中的Mysql配置，并执行
```
docker run \
--name wumei-smart \
--env DB_HOST=localhost:3306 \
--env DB_NAME=wumei-smart \
--env DB_USER=root \
--env DB_PASSWORD=wumei-smart \
--publish 80:80 \
--publish 1883:1883 \
--publish 8083:8083 \
--volume /var/wumei-smart/java/uploadPath:/var/wumei-smart/java/uploadPath \
--restart unless-stopped \
--detach \
kerwincui/wumei-smart:1.1
```


### 八、其他
* 互助交流群：1073236354
* [演示地址>>](https://iot.wumei.live/)

##### 项目贡献者 
|[小驿物联](https://gitee.com/iot-xiaoyi) |[guanshubiao](https://gitee.com/guanshubiao)|[crazyDull](https://gitee.com/crazyDull) |[kami0314](https://github.com/kami0314)| [sxh](https://gitee.com/sixiaohu) | [redamancy_zxp](https://gitee.com/redamancy-zxp) | [LEE](https://gitee.com/yueming188)
|--|--|--|--|--|--|--|


### 九、部分图片
<img src="https://oscimg.oschina.net/oscnet/up-a6e2f49e9886cd9d4ee72449f148beabe9e.png"/><br />

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



