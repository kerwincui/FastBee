
### 一、项目简介

1. **物美智能([wumei-smart](http://www.wumei.live/introduce.html))]是一套开源的软硬件系统，可用于二次开发和学习，快速搭建自己的智能家居系统。** 硬件工程师可以把自己的设备集成到系统；软件工程师可以使用项目中的设备熟悉软硬件交互。[演示视频 >>](https://space.bilibili.com/471004321)<br />
![说明](https://gitee.com/kerwincui/wumei-smart/raw/master/document/desc.png)<br /><br />

2. 服务端使用spring boot、数据库mysql和redis、前端vue、移动端android、硬件端ESP-IDF和Arduino等。软硬件交互基于Mqtt协议，使用EMQ代理服务器。系统架构图如下：
<br /><br />
![图片](https://gitee.com/kerwincui/wumei-smart/raw/master/document/sys.png)  
![图片](https://gitee.com/kerwincui/wumei-smart/raw/master/document/directory.png)  

3. 硬件端提供接入文档，需要设备支持网络功能，项目里面包含ESP-IDF和Arduino的硬件代码和接入示例。同时制作了智能开关（wifi通断器）板子，可用于学习和生活中，控制2500W以下的用电设备。硬件完整示例代码采用ESP-IDF框架4.2版本，基于乐鑫ESP32S2芯片，安信可ESP-12K模组。[详情和购买方式 >> ](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4233922&doc_id=1506495)<br /><br />
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case2.gif)  <br />
    * 手机、电脑远程控制
    * 遥控配对、清码和控制
    * 空气温湿度监控
    * 雷达感应和报警
    * 220V和5V电压供电，阻性负载2500W，感性负载250W

<br />


### 二、相关开发板
1. NodeMCU开发板制作一个智能开关
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case1.gif)  
2. 七彩智能灯 [灯控板和灯板的PCB文件以及Bom清单，免费赠送，用于自己制作硬件](https://gitee.com/kerwincui/wumei-smart/tree/master/document/%E6%99%BA%E8%83%BD%E4%B8%83%E5%BD%A9%E7%81%AF)
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case3.gif)  
3. 物联网开发板 [详情和购买方式 >>](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4233922&doc_id=1506495)
![案例](https://gitee.com/kerwincui/wumei-smart/raw/master/document/case5.gif)  
4. 物联网入门学习套件 [详情和购买方式 >>](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4233922&doc_id=1506495)
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
    - 开发工具：Visual Studio Code 和 Arduino

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
registry.cn-chengdu.aliyuncs.com/kerwincui/wumei-smart:1.0
```

#### 3. 扫码下载APP安装,打开APP，跳过登录，配置服务端地址
![APP下载](https://gitee.com/kerwincui/wumei-smart/raw/master/document/download.png)

测试账号：wumei admin123；配置成功后默认账号：admin admin123

#### 4. 硬件代码烧录到设备
* [Arduino接入Demo](https://gitee.com/kerwincui/wumei-smart/tree/master/firmware/arduino)
* [ESP-IDF接入Demo](https://gitee.com/kerwincui/wumei-smart/tree/master/firmware/esp-idf)

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
* [ESP-IDF完整固件代码](https://gitee.com/kerwincui/wumei-smart/tree/master/firmware/esp-idf/wumei-smart-firmware)
* [演示视频](https://space.bilibili.com/471004321)
* [硬件详情和购买方式](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4233922&doc_id=1506495)
* [物美智能官网](http://wumei.live)
* [若依文档](http://doc.ruoyi.vip/ruoyi-vue/)，前端和后端基于Ruoyi-Vue，前后端分离权限管理系统
* [XUI](https://gitee.com/xuexiangjys/XUI)，Android基于XUI开发，是一个简洁而优雅的原生UI框架
* [ESP-IDF编程指南](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32/index.html)
* [EMQ文档](https://docs.emqx.cn)

<br />

### 七、加入互助交流群:1073236354
<a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=P_oc91N6KC39zp2PEV_-BY3xMnAokeZ8&jump_from=webapi"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="物美智能wumeismart" title="物美智能wumeismart"></a> 
<br />
[新版本开发中，详情 >>](https://gitee.com/kerwincui/wumei-smart/tree/dev/)
<br />

### 八、APP和管理端登录 &emsp;&emsp;测试账号：wumei &emsp;密码：admin123
* APP：[进入下载界面>>>](https://gitee.com/kerwincui/wumei-smart/wikis/pages?sort_id=4203153&doc_id=1506495)
* 管理端：[进入登录界面>>>](http://iot.wumei.live/)
