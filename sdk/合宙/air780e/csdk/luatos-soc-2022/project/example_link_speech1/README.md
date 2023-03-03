### 阿里云千里传音演示
## 注意事项！！！
1 此demo仅供演示阿里云千里传音功能，没有太好的异常处理，请勿用作其他用途
2 需要更换为自己的设备三元组
3 此demo的金额播报演示音频格式为amr
4 此demo未启用tts功能，只有音频文件播报

## 演示项目
1 语料推送和金额播报
2 动态音频播报

## 演示准备
# 语料推送和金额播报
首先下发金额播报需要的语料，阿里云自带的常用语料，文件需为amr格式
1 数字语料包
2 量词语料包
3 货币单位语料包

其次通过阿里云千里传音SpeechByCombination API 下发格式为"{$number}"，不包括双引号
其中number是一个不大于99999999.99的字符串
如"{$10000.11}",设备会播报一万点一一元 
https://help.aliyun.com/document_detail/223764.html

# 动态音频播报
通过里云千里传音SpeechBySynthesis API 动态下发音频文件，设备播放，
https://help.aliyun.com/document_detail/369398.html



