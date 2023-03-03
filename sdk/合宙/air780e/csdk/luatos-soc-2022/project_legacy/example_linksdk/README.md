### example_sysdep_api_test.c

linksdk自带的适配接口测试代码，用于测试接口适配是否有问题



### example_mqtt_basic.c

linksdk自带的连接阿里云服务器mqtt基础功能测试demo





### 在xmake.lua中通过如下两行代码来切换编译demo

```lua
add_files("/src/example_sysdep_api_test.c",{public = true})
-- add_files("/src/example_mqtt_basic.c",{public = true})
```



