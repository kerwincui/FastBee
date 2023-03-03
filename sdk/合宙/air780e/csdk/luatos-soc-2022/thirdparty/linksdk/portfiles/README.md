`Portfiles`的概念是一组接口, 这些接口描述SDK如何使用当前设备的底层软硬件资源, 这些资源包括

+ 互斥锁
+ 时钟
+ 内存
+ 随机数生成器

---
当SDK被移植到运行不同OS的嵌入式设备上时, 需要变动的代码都只有`portfiles`目录下的C文件, 以下我们提供了一些移植的实例文档

基于MCU(运行FreeRTOS) + 4G模组的MQTT连云:
+ [STM32+合宙Air724UG模组移植](https://help.aliyun.com/document_detail/254820.html?spm=a2c4g.11174283.6.1045.11b14c07U31eqg)
