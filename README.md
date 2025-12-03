![](./images/banner.jpg)

### 一、项目介绍

1. FastBee 是一款面向中小企业与个人开发者的**轻量、易用、全栈开源**的物联网平台。它集设备管理、数据监控、多端应用于一体，支持一键容器化部署，助力快速构建物联网应用。适用于智能家居、智慧办公、智慧社区、农业监测、水利监测、工业控制等多种场景。

2. 平台采用前后端分离架构：后端基于Spring Boot开发，<b>内置使用Netty搭建的高性能MQTT服务端，无需额外部署EMQX或其他mqtt服务端</b>；前端采用Vue与ElementUI，清晰易维护；移动端支持微信小程序、Android、iOS及H5，基于Uniapp实现多端兼容。设备端兼容ESP32、ESP8266、树莓派、合宙等常见硬件，接入灵活。数据存储支持关系型数据库和Redis，兼顾事务处理与缓存需求。系统使用Docker部署，可 [一键快速搭建全套系统](https://fastbee.cn/doc/install/docker.html)，简化运维。


### 二、系统功能简述

|           系统功能           | 功能说明                                            | 
|:------------------------:|:-----------------------------------------------:|
|           产品管理          | 支持创建产品、定义物模型、设置设备认证方式、管理产品分类及固件版本                       | 
|           设备管理          | 设备注册、分组、实时状态监测、远程控制、操作日志追溯及设备分享功能            | 
|          物模型管理         | 提供标准化的属性（监测与状态）、功能（服务调用）和事件（设备上报）定义，实现设备与平台的数据语义统一         | 
|          规则脚本          | 对设备上报和平台下发的原始数据进行处理，转发后匹配设备交互格式 | 
|          MQTT接入          | 内置基于 Netty 开发的高性能 MQTT Broker，无需额外部署第三方服务，支持设备安全连接与通信 | 
|          视频监控接入       | 支持 GB/T 28181 国家标准协议，可接入主流监控设备，实现视频直播、设备管理  | 
|          权限管理          | 基于成熟的 [若依权限框架](http://doc.ruoyi.vip/ruoyi-vue/)，实现用户、角色、部门、岗位及操作日志的精细化管控  | 
|          多数据源          | 数据存储到关系型数据库，例如mysql、postgres、mssql           | 
|          硬件 SDK         | 提供 ESP-IDF、Arduino、树莓派、合宙 等常见硬件平台的接入示例与 SDK，降低设备端开发门槛。           | 
|          多端应用支持      | 提供 Web 控制台（Vue + ElementUI）、微信小程序、Android/iOS App 及 H5 界面，方便用户随时随地管理设备。          | 
|          一键部署          | 推荐使用 Docker 容器化部署，支持一条命令[快速搭建完整环境](https://fastbee.cn/doc/install/docker.html)，大幅降低运维成本。         | 

![](https://gitee.com/beecue/fastbee-sdk/raw/master/Arduino/FastBeeEsp32/device.png)

### 三、快速开始

1.  **环境准备**：确保服务器已安装 `Docker` 和 `Docker Compose`。
2.  **执行命令**：
    ```bash
    sudo wget -c https://hub.fastbee.cn/resource/install.sh && bash ./install.sh
    ```
    命令窗口根据提示，选择“**开源版本**”，脚本将自动完成所有服务的拉取与启动。
3.  **访问系统**：部署完成后，通过浏览器访问 `http://你的服务器IP:端口` ，默认账号admin admin123。

4. 详细步骤请查阅 [官方安装文档](https://fastbee.cn/doc/install/docker.html)。

---


### 四、技术栈
* 🖥️ 服务端
    - 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、TDengine、Netty等
    - 开发工具：IDEA
    - 源码目录：spring-boot文件夹下
* 🌐Web端
    - 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui、Echart等
    - 开发工具：Visual Studio Code
    - 源码目录：vue文件夹下
* 📱移动端（微信小程序 / Android / Ios / H5）
    - 相关技术：uniapp、[uView](https://www.uviewui.com/)、[uChart](https://www.ucharts.cn/)
    - 开发工具：HBuilder
    - 源码地址：[https://gitee.com/beecue/fastbee-app](https://gitee.com/beecue/fastbee-app) 
* 🔌硬件端
    - 相关技术： ESP-IDF、Arduino、FreeRTOS、Python、Lua等
    - 开发工具：Visual Studio Code 和 Arduino等
    - 源码地址：[https://gitee.com/beecue/fastbee-sdk](https://gitee.com/beecue/fastbee-sdk)
* 🚀部署与运维
    - 相关技术：docker、docker-compose、shell
    - [快速部署](https://fastbee.cn/doc/install/docker.html)：安装好docker和docker-compose后执行命令 `  sudo wget -c https://hub.fastbee.cn/resource/install.sh && bash ./install.sh  ` 然后选择开源版本，等待完成部署

#### 📦 技术全景与特点
- **全栈开源**：从设备 SDK、后端服务到前端应用和移动端，代码完全开放
- **内置 MQTT Broker**：减少外部依赖，降低部署与运维复杂度
- **多端覆盖**：统一技术栈支持 Web、小程序与原生 App
- **多数据源支持**：支持常用关系型数据库，默认mysql
- **容器化部署**：提供标准化 Docker 镜像与脚本，实现快速安装与迁移

该技术选型兼顾了成熟度、性能与开发效率，既适合中小企业快速构建物联网业务，也便于开发者进行二次开发与学习研究。


|空气检测仪|   物联网开发板 |  Air724开发板 |  智能开关| [查看更多>>](https://fastbee.cn/doc/device/)  |
|  :----:  | :----------:  |:----------:  |:----------:  |:----------:  |
| ![](https://oscimg.oschina.net/oscnet/up-ad98a81677e5e68d660866770e3266ca4cf.png) | ![](https://oscimg.oschina.net/oscnet/up-68caf860d0659444e73f42717a03d2fdf72.png) | ![](https://oscimg.oschina.net/oscnet/up-cf690f6058042dccb567ff382ea9432ebab.png) |![](https://oscimg.oschina.net/oscnet/up-c4a7971510127324d6566dd6ea95d571483.jpg) | ![](https://oscimg.oschina.net/oscnet/up-4ce09be3599e3ff7ed91fe182572abd258b.jpg) | 



### 五、其他
1. 商用授权：开源版本采用AGPL3协议，可用于个人学习和使用，商业用途推荐购买[商业版本授权](https://fastbee.cn/doc/pages/sponsor/)

2. 商业版本在线演示（开源版本暂只支持mqtt协议）：[https://iot.fastbee.cn/](https://iot.fastbee.cn/)

3. 系统文档：[https://fastbee.cn/doc/](https://fastbee.cn/doc/)

4. QQ交流群：&#x1F680;720136372   &#x1F680;946029159    &#x1F680;1073236354  



### 六、部分图片

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


