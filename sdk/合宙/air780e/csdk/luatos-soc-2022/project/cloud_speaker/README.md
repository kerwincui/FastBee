# 说明

* 此demo是云喇叭演示demo

## 功能说明
1：设备启动后首先播报：“正在开机”
2：设备连接mqtt服务器并订阅主题成功后，会播报：“服务器连接成功”
3：用另一个mqtt clinet向设备订阅的主题发送固定格式的报文，设备则会播报支付宝收款xxxx元

## 设备订阅的主题
/sub/topic/money/{imei}   {imei}为模块的imei
如模块的imei为：866714xxxx16190

则设备订阅的主题为/sub/topic/money/866714xxxx16190

## 设备连接的服务器
host：lbsmqtt.airm2m.com
port：1884

## 报文下发格式
{"money":"number"}
其中number为一个不大于99999999.99的数字

如：
向主题“/sub/topic/money/866714xxxx16190”下发{"money":"12345678.9"}
设备则会播报 “支付宝收款一千两百三十四万五千六百七十八点九元”