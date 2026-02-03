#### 免责声明和提醒：本项目仅用于个人学习和使用，请遵循网络安全法规，及时更新源码修复漏洞，加强服务器防护，杜绝网络安全时间发生。修复漏洞可更新源码或参考[修复指南](https://fastbee.cn/doc/relate/bug.html)

<br /><br /><br />


FastBee 是一款面向中小企业与个人开发者的**轻量**、**易用**、**全栈**开源物联网平台。

---

### 一、项目介绍

FastBee 集设备管理、数据监控、多端应用于一体，支持[一键容器化部署](https://fastbee.cn/doc/install/docker.html)，适用于智能家居、智慧办公、智慧社区、农业监测、水利监测、工业控制等多种场景。平台基于 Spring Boot 开发，<b>内置 MQTT 服务端，无需额外部署 EMQX 或其他 MQTT 服务端</b>，前端采用 Vue 与 ElementUI，移动端支持微信小程序、Android、iOS 及 H5，设备端兼容 ESP32、ESP8266、树莓派、合宙等常见硬件。

---

### 二、系统功能

| 系统功能    | 功能说明                                                                       |
|---------|----------------------------------------------------------------------------|
| 产品管理    | 创建产品、定义物模型、设置设备认证方式、管理产品分类及固件版本                                            |
| 设备管理    | 设备注册、分组、实时状态监测、远程控制、操作日志追溯及设备分享功能                                          |
| 物模型管理   | 提供标准化的属性、功能和事件定义，实现设备与平台的数据语义统一                                            |
| 规则脚本    | 对设备上报和平台下发的原始数据进行处理，转发后匹配设备交互格式                                            |
| MQTT 接入 | 内置基于 Netty 开发的 MQTT Broker，无需额外部署第三方服务                                  |
| 视频监控接入  | 支持 GB/T 28181 国家标准协议，实现视频直播与设备管理                                           |
| 权限管理    | 基于成熟的若依权限框架，实现用户、角色、部门、岗位及操作日志的精细化管控                                       |
| 多数据源    | 支持 MySQL、PostgreSQL、MSSQL 等关系型数据库                                          |
| 时序数据库   | 支持 TDengine、ioTDB、influxDB 等时序数据库                                          |
| 硬件 SDK  | 提供 ESP-IDF、Arduino、树莓派、合宙等常见硬件平台的接入示例与 SDK                                 |
| 多端应用支持  | 提供 Web 控制台（Vue + ElementUI）、微信小程序、Android/iOS App 及 H5 界面                  |
| 一键部署    | 推荐使用 Docker 容器化部署，支持[快速搭建](https://fastbee.cn/doc/install/docker.html)完整环境 |


[![](https://gitee.com/beecue/fastbee-sdk/raw/master/Arduino/FastBeeEsp32/device.png)](https://gitee.com/beecue/FastBee-Arduino)

---

### 三、快速开始

1. **环境准备**：确保服务器已安装 `Docker` 和 `Docker Compose`。
2. **执行命令**：
   ```bash
   sudo wget -c https://hub.fastbee.cn/resource/install.sh && bash ./install.sh
   ```
   根据提示选择“开源版本”，脚本将自动完成所有服务的拉取与启动。
3. **访问系统**：部署完成后，通过浏览器访问 `http://你的服务器IP:端口`，默认账号为 `admin`，密码为 `admin123`。
4. **详细步骤**：请查阅 [官方安装文档](https://fastbee.cn/doc/install/docker.html)。

---


### 四、技术栈
##### 服务端
- 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、TDengine、Netty等
- 开发工具：IDEA
- 源码目录：spring-boot文件夹下

##### Web端
- 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui、Echart等
- 开发工具：Visual Studio Code
- 源码目录：vue文件夹下

##### 移动端（微信小程序 / Android / Ios / H5）
- 相关技术：uniapp、[uView](https://www.uviewui.com/)、[uChart](https://www.ucharts.cn/)
- 开发工具：HBuilder
- 源码地址：[https://gitee.com/beecue/fastbee-app](https://gitee.com/beecue/fastbee-app) 

##### 硬件端
- 相关技术： ESP-IDF、Arduino、FreeRTOS、Python、Lua等
- 开发工具：Visual Studio Code 和 Arduino等
- 源码地址：[https://gitee.com/beecue/fastbee-sdk](https://gitee.com/beecue/fastbee-sdk)

##### 部署与运维
- 相关技术：docker、docker-compose、shell
- [快速部署](https://fastbee.cn/doc/install/docker.html)：安装好docker和docker-compose后执行命令 `  sudo wget -c https://hub.fastbee.cn/resource/install.sh && bash ./install.sh  ` 然后选择开源版本，等待完成部署

|空气检测仪|   物联网开发板 |  Air724开发板 |  智能开关| [查看更多>>](https://fastbee.cn/doc/device/)  |
|  :----:  | :----------:  |:----------:  |:----------:  |:----------:  |
| ![](https://oscimg.oschina.net/oscnet/up-ad98a81677e5e68d660866770e3266ca4cf.png) | ![](https://oscimg.oschina.net/oscnet/up-68caf860d0659444e73f42717a03d2fdf72.png) | ![](https://oscimg.oschina.net/oscnet/up-cf690f6058042dccb567ff382ea9432ebab.png) |![](https://oscimg.oschina.net/oscnet/up-c4a7971510127324d6566dd6ea95d571483.jpg) | ![](https://oscimg.oschina.net/oscnet/up-4ce09be3599e3ff7ed91fe182572abd258b.jpg) | 

---

### 五、其他

1. **商用授权**：开源版本采用 AGPL3 协议，可用于个人学习和使用，商业用途推荐购买[商业版本授权](https://fastbee.cn/doc/pages/sponsor/)。
2. **在线演示**：[商业版本演示地址](https://iot.fastbee.cn/)（开源版本暂仅支持 MQTT 协议）。
3. **系统文档**：[https://fastbee.cn/doc/](https://fastbee.cn/doc/)
4. **QQ 交流群**：720136372、946029159、1073236354

---

### 六、部分图片

![部分功能截图](https://oscimg.oschina.net/oscnet/up-972dea7b54eca705dcc8bf2fe0680b12c09.png)
![部分功能截图](https://oscimg.oschina.net/oscnet/up-6d89f1558797a9becf07c20f92c1407a13a.png)

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

---

FastBee 项目代码完全开源，覆盖设备 SDK、后端服务、前端应用和移动端，兼顾成熟度、性能与开发效率，适合中小企业快速构建物联网业务，也便于开发者进行二次开发与学习研究。