## Translations

English | [简体中文](./README.md)

---

#### Disclaimer and Notice: This project is for personal learning and use only. Please comply with cybersecurity regulations, update source code in time to fix vulnerabilities, strengthen server protection, and prevent security incidents. [Reference for vertical privilege escalation fix >>](https://fastbee.cn/doc/relate/bug.html)

<br /><br />

FastBee is a **lightweight**, **easy-to-use**, and **full-stack** open-source IoT platform for SMEs and individual developers.

---

### 1. Project Introduction

FastBee integrates device management, data monitoring, and multi-end applications. It supports [one-click containerized deployment](https://fastbee.cn/doc/install/docker.html) and is suitable for smart home, smart office, smart community, agricultural monitoring, water conservancy monitoring, industrial control, and many other scenarios. The platform is built on Spring Boot, and **comes with a built-in MQTT server, so no extra EMQX or other MQTT server is required**. The frontend uses Vue + ElementUI. The mobile side supports WeChat Mini Program, Android, iOS, and H5. Device-side access is compatible with common hardware such as ESP32, ESP8266, Raspberry Pi, and AirM2M.

---

### 2. System Features

| Feature | Description |
|---------|-------------|
| Product Management | Create products, define device models, configure authentication methods, and manage categories and firmware versions |
| Device Management | Device registration, grouping, real-time status monitoring, remote control, operation log tracing, and device sharing |
| Device Model Management | Standardized definition of properties, functions, and events to unify data semantics between devices and platform |
| Rule Scripts | Process raw device uplink/platform downlink data and forward it after matching interaction formats |
| MQTT Access | Built-in MQTT Broker developed on Netty, no third-party deployment required |
| Video Monitoring Access | Supports GB/T 28181 national standard protocol for live video and device management |
| Permission Management | Based on mature RuoYi permission framework for fine-grained control of users, roles, departments, posts, and operation logs |
| Multi Data Sources | Supports relational databases such as MySQL, PostgreSQL, and MSSQL |
| Time-Series Databases | Supports TDengine, ioTDB, influxDB, and more |
| Hardware SDK | Provides SDKs and access examples for ESP-IDF, Arduino, Raspberry Pi, AirM2M, and other common hardware platforms |
| Multi-End Application Support | Provides Web console (Vue + ElementUI), WeChat Mini Program, Android/iOS App, and H5 interfaces |
| One-Click Deployment | Docker containerized deployment is recommended for [quick setup](https://fastbee.cn/doc/install/docker.html) |

[![](https://gitee.com/beecue/fastbee-sdk/raw/master/Arduino/FastBeeEsp32/device.png)](https://gitee.com/beecue/FastBee-Arduino)

---

### 3. Quick Start

1. **Prerequisites**: Make sure `Docker` and `Docker Compose` are installed on your server.
2. **Run command**:
   ```bash
   sudo wget -c https://hub.fastbee.cn/resource/install.sh && bash ./install.sh
   ```
   Select the "Open Source Version" as prompted. The script will automatically pull and start all services.
3. **Access system**: After deployment, open `http://your-server-ip:port` in a browser. Default account is `admin` and password is `admin123`.
4. **Detailed guide**: Please refer to the [official installation documentation](https://fastbee.cn/doc/install/docker.html).

---

### 4. Tech Stack
##### Backend
- Technologies: Spring Boot, MyBatis, Spring Security, JWT, MySQL, Redis, TDengine, Netty, etc.
- Development tool: IDEA
- Source directory: under `spring-boot` folder

##### Web
- Technologies: ES6, Vue, Vuex, Vue-router, Vue-cli, Axios, Element-ui, Echart, etc.
- Development tool: Visual Studio Code
- Source directory: under `vue` folder

##### Mobile (WeChat Mini Program / Android / iOS / H5)
- Technologies: uniapp, [uView](https://www.uviewui.com/), [uChart](https://www.ucharts.cn/)
- Development tool: HBuilder
- Source repository: [https://gitee.com/beecue/fastbee-app](https://gitee.com/beecue/fastbee-app)

##### Hardware
- Technologies: ESP-IDF, Arduino, FreeRTOS, Python, Lua, etc.
- Development tools: Visual Studio Code and Arduino, etc.
- Source repository: [https://gitee.com/beecue/fastbee-sdk](https://gitee.com/beecue/fastbee-sdk)

##### Deployment and O&M
- Technologies: docker, docker-compose, shell
- [Quick deployment](https://fastbee.cn/doc/install/docker.html): after installing docker and docker-compose, run `sudo wget -c https://hub.fastbee.cn/resource/install.sh && bash ./install.sh`, then select the open-source version and wait for deployment to finish.

| Air Detector | IoT Dev Board | Air724 Dev Board | Smart Switch | [More >>](https://fastbee.cn/doc/device/) |
|:------------:|:-------------:|:----------------:|:------------:|:------------------------------------------:|
| ![](https://oscimg.oschina.net/oscnet/up-ad98a81677e5e68d660866770e3266ca4cf.png) | ![](https://oscimg.oschina.net/oscnet/up-68caf860d0659444e73f42717a03d2fdf72.png) | ![](https://oscimg.oschina.net/oscnet/up-cf690f6058042dccb567ff382ea9432ebab.png) | ![](https://oscimg.oschina.net/oscnet/up-c4a7971510127324d6566dd6ea95d571483.jpg) | ![](https://oscimg.oschina.net/oscnet/up-4ce09be3599e3ff7ed91fe182572abd258b.jpg) |

---

### 5. More Information

1. **Commercial License**: The open-source edition is licensed under AGPL3 for personal learning and use. For commercial use, purchasing a [commercial license](https://fastbee.cn/doc/pages/sponsor/) is recommended.
2. **Online Demo**: [Commercial version demo](https://iot.fastbee.cn/) (open-source version currently supports MQTT protocol only).
3. **Documentation**: [https://fastbee.cn/doc/](https://fastbee.cn/doc/)
4. **QQ Groups**: 720136372, 946029159, 1073236354

---

### 6. Screenshots

![Feature Screenshot](https://oscimg.oschina.net/oscnet/up-972dea7b54eca705dcc8bf2fe0680b12c09.png)
![Feature Screenshot](https://oscimg.oschina.net/oscnet/up-6d89f1558797a9becf07c20f92c1407a13a.png)

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

FastBee is fully open source across device SDK, backend services, web frontend, and mobile applications. It balances maturity, performance, and development efficiency, making it suitable for SMEs to quickly build IoT businesses and for developers to customize, learn, and research.
