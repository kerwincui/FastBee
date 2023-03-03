# 第三方库

存放的均为可选的组件

## 目录介绍

|目录|用途|依赖|
|---|----|----|
|cJSON|json解析和合成| 无|
|httpclient|http客户端|若使用https,依赖mbedtls|
|mbedtls|加密解码库|若使用fota,就需要依赖mbedtls|
|mqtt|mqtt客户端|若使用mqtts,mbedtls|
|sntp|对时客户端|无|
|unity|单元测试|无|
|fal|flash抽象层|无|
|flashdb|Flash数据库|依赖fal|
