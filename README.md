
### 一、项目简介

1. **物美智能([wumei-smart](http://www.wumei.live/introduce.html))]是一套开源的软硬件系统，可用于二次开发和学习，快速搭建自己的智能家居系统。** 硬件工程师可以把自己的设备集成到系统；软件工程师可以使用项目中的设备熟悉软硬件交互。<br />
![说明](https://gitee.com/kerwincui/wumei-smart/raw/master/document/desc.png)<br /><br />

2. 服务端使用spring boot、数据库mysql和redis、前端vue、移动端android、硬件端ESP-IDF和Arduino等。软硬件交互基于Mqtt协议，使用EMQ代理服务器。系统架构图如下：
<br /><br />
![图片](https://gitee.com/kerwincui/wumei-smart/raw/master/document/sys.png)  
<br />

3. 硬件端提供接入文档，需要设备支持网络功能，项目里面包含ESP-IDF和Arduino的代码和接入示例。同时制作了智能开关（wifi通断器）板子，可用于学习和生活中。<br />
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case2.gif)  <br />
    * 手机、电脑远程控制
    * 遥控配对、清码和控制
    * 空气温湿度监控
    * 雷达感应和报警
    * 220V和5V电压供电，阻性负载2500W，感性负载250W

<br />


### 二、参考案例
1. NodeMCU开发板制作一个智能开关
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case1.gif)  
2. Wifi开发板制作一个通断器，可控制2500w以下用电设备
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case2.gif)  
3. Wifi控制器和LED灯板制作七彩智能灯
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case3.gif)  
4. 树莓派安装wumei-smart作为服务器，节省成本
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case4.gif)  


<br />
 
### 三、技术栈    
* 后端
    - 相关技术：Spring boot、MyBatis、Spring Security、Jwt、Mysql、Redis、Mongodb、Mqtt等
    - 开发工具：IDEA    
* 前端
    - 相关技术：ES6、Vue、Vuex、Vue-router、Vue-cli、Axios、Element-ui等 
    - 开发工具：Visual Studio Code    
* 安卓
    - 相关技术：XUI、XPage、XAop、XHttp2等
    - 开发工具：Android Studio    
* 硬件端
    - 相关技术： ESP-IDF、Arduino、FreeRTOS等
    - 开发工具：Visual Studio Code

<br />

### 四、快速部署系统
#### 1. 安装docker
#### 2. 命令窗口运行如下命令(完成后端、前端、数据库、EMQX部署)：

```
docker run \
--name wumei-smart \
--publish 80:80 \
--publish 18083:18083 \
--publish 1883:1883 \
--publish 3306:3306 \
--publish 6379:6379 \
--restart always \
--detach \
kerwincui/wumei-smart:1.0
```

#### 3. 扫码下载APP安装,打开APP，跳过登录，配置服务端地址
![APP下载](https://gitee.com/kerwincui/wumei-smart/raw/master/document/download.png)

测试账号：wumei admin123；配置成功后默认账号：admin admin123

#### 4. 硬件代码烧录

<br />

### 五、系统部分图片
![分类](https://gitee.com/kerwincui/wumei-smart/raw/master/document/a.png)
![设备列表](https://gitee.com/kerwincui/wumei-smart/raw/master/document/b.png)
![EMQX](https://gitee.com/kerwincui/wumei-smart/raw/master/document/c.png)
![设备详情](https://gitee.com/kerwincui/wumei-smart/raw/master/document/d.png)
![配置](https://gitee.com/kerwincui/wumei-smart/raw/master/document/e.png) 

<br />

### 六、相关教程

* [项目文档](https://gitee.com/kerwincui/wumei-smart/wikis/pages)
* [物美智能官网](http://wumei.live)
* [若依文档](http://doc.ruoyi.vip/ruoyi-vue/)，前端和后端基于若依前后端分离框架
* [XUI](https://gitee.com/xuexiangjys/XUI)，安卓UI使用XUI
* [ESP-IDF编程指南](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32/index.html)

<br />

##### 加入讨论群：1073236354
<a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=P_oc91N6KC39zp2PEV_-BY3xMnAokeZ8&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="物美智能wumeismart" title="物美智能wumeismart"></a> 
