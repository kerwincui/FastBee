## 硬件端合宙SDK说明

#### 一、运行环境
- vs code 仿真
- air724板子 在选择底层库pac文件时注意 支持float 类型

1. 在vs code 里面安装 luatIDE 

2. 安装air724 usb 相关驱动

3. 使用luatools
    
   以上均参考 https://doc.openluat.com/wiki/26?wiki_page_id=3063

#### 二、运行代码

1. 在vs code 下仿真调试
    mainVscode.lua 复制为 main.lua 
    注释掉 WeiMeiApp.lua 里面与硬件相关的代码 如adc 温度等
    在WuMeiTest.lua 文件里面 配置 产品ID MQTT 等信息
    仿真调试
2. 在air724硬件上运行代码
   mainAir724.lua 复制为 main.lua 
   取消 WeiMeiApp.lua 里面与硬件相关的代码注释 如adc 温度等
   在WuMeiTest.lua 文件里面 配置 产品ID MQTT 等信息
   用luatools 建立工程 需要加载 main.lua WeiMeiApp.lua WeiMeiComAuth.lua  WeiMeiComInteraction.lua WuMeiTest.lua 文件 以及带float 类型的底层库

#### 三、代码文件说明

1. WeiMeiComAuth.lua 用于认证处理
        支持 简单认证和加密认证
2. WeiMeiComInteraction.lua  用户交互
        支持 信息 属性 功能 事件 监控 
        支持 设置定时上传 属性 功能 事件
3. WeiMeiApp.lua
        主要开发在这个文件里面
        对外提供 信息 属性 功能 事件 数据函数 改函数直接返回打包好的json 字符串
