<br />

* 项目可用于个人学习；商业使用请赞助该项目，获得授权；
* 赞助后还提供了小程序、APP源码。[详情](https://wumei.live/doc/pages/sponsor/)


#### 移动端介绍

|安卓/Android|苹果/IOS|微信小程序| 网页/H5|Vue2.0
| :---: | :---: | :---: | :---: |:---: |
| √ | √| √ | √ | √ |


1. 项目使用uniapp开发，适配小程序、安卓、苹果和H5，其他平台未测试。
2. UI框架使用uView2.0
3. 组件使用easycom模式，只要组件安装在项目的components目录下或uni_modules目录下，并符合components/组件名称/组件名称.vue目录结构。就可以不用引用、注册，直接在页面中使用。
4. 开发工具为Hbuilder3.3版本，版本不易过低。


###### 项目结构

```
├─apis                  // 接口管理
│  ├─modules            // api模块化目录
│  │  └─device.js       // 设备接口地址
│  ├─http.api.js        // 接口定义文件
│  └─http.interceptor   // 拦截器
├─common                // 公共文件
│  ├─config             // 环境配置 (设置baseurl等)
│  ├─extend             // 扩展原型方法
│  ├─filters            // 全局过滤器
│  └─tools              // 全局公共方法
├─components            // 项目组件库，组件放置这里，其他页面可直接使用
│  ├─cl-test            // easycom测试组件
│  └─cl-icon            // iconfont图标组件
├─pages                 // 页面目录
│  ├─public             // 公共页面
│  └─tarbar             // 底部导航栏页面
├─static                // 图片目录
├─store                 // vuex
│  ├─$u.mixin           // store全局混入方法
│  └─index              // vuex 组件全局状态管理
├─uni_modules           // 插件市场插件目录
│  └─uview-ui           // uview-ui	
```

<br /><br />