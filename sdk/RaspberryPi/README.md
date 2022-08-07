## 硬件端树莓派SDK说明

#### 一、运行环境
- Python 3.7.2 (其他python3的版本一般也可以)
- 开发板：树莓派4b（没有加入硬件相关代码，安装好python3环境，win下，linux下都能运行）
- 库 需要安装库

1. mqtt库
   
   ```
   pip install paho-mqtt
   ```
   
2. ase加密库

   ```
   # 前面两个卸载命令是为了防止一些安装环境问题
   pip uninstall crypto
   pip uninstall pycryptodome 
   pip install pycryptodome
   ```


3. 报错缺少xx库，命令

   ```
   pip install xx
   ```


#### 二、运行程序

```
python3 main_sdk.py

# 备注：程序运行依赖aes.py文件，保证该文件和main_sdk.py在同一目录
```



#### 三、开发参考资料：

- [Eclipse Paho MQTT Python Client 使用手册](https://www.cooooder.com/archives/20210303)
- [Python 实现AES加密](https://zhuanlan.zhihu.com/p/261694311) 
- [python实现AES加密解密](https://blog.csdn.net/chouzhou9701/article/details/122019967)
- [使用python time()方法](http://www.py.cn/jishu/jichu/20424.html)
- [python 线程定时器Timer](https://zhuanlan.zhihu.com/p/91412537)
- [浅谈Python的格式化输出](https://www.jb51.net/article/225609.htm)
- [Python Request库入门](https://www.jianshu.com/p/d78982126318)
- [Python JSON ](https://www.runoob.com/python/python-json.html)
- [Python random() 函数 ](https://www.runoob.com/python/func-number-random.html)
