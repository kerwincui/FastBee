# /***********************************************************
#  * author: xiaoY [物美智能 wumei-smart]
#  * create: 2022-05-10
#  * email：qimint@outlook.com
#  * source:https://github.com/kerwincui/wumei-smart
#  * board:raspberry 4b
#  ***********************************************************/

import time
import requests
import json
from aes import AEScryptor,AES
import paho.mqtt.client as mqtt
import random
import threading #导入线程模块，用作定时器

#################################################################
# 需要连接好外部网络
#################################################################

# 作为python的AES的iv,应该为16位，字节型数据
wumei_iv = b"wumei-smart-open"
#发布监测数据的最大次数
monitorCount =5
#  发布监测数据的间隔，默认5秒。 使用esp8266单片机时，服务器传来的间隔单位为毫秒，本程序由于定时运行需要的是秒，将转化为秒，如需毫秒运行，自行更改程序
monitorInterval  =5
# NTP地址（用于获取时间,可选的修改为自己部署项目的地址）
ntpServer = "http://120.24.218.158:8080/iot/tool/ntp?deviceSendTime="
# 连接成功标志位
g_rc=-1 
#全局变量，管理定时监测
global t2 

# 设备信息配置
deviceNum = "DW43CI6RM8GMG23H"
userId = "1"
productId = "4"
firmwareVersion = "1.0"
# 经度和纬度可选，如果产品使用设备定位，则必须传
latitude=0
longitude=0

# Mqtt配置
mqttHost = "120.24.218.158"
mqttPort = 1883
mqttUserName = "wumei-smart"
mqttPwd = "P261I5G3RY3MCIGG"
# 作为python的AES的key,应该为16位，字节型数据
mqttSecret = b"K2IB784BM0O01GG6"
# 产品启用授权码则authCode不能为空
authCode=""

# 订阅的主题
prefix = "/" + productId + "/" + deviceNum
sInfoTopic = prefix + "/info/get"
sOtaTopic = prefix + "/ota/get"
sNtpTopic = prefix + "/ntp/get"
sPropertyTopic = prefix + "/property/get"
sFunctionTopic = prefix + "/function/get"
sPropertyOnline = prefix + "/property-online/get"
sFunctionOnline = prefix + "/function-online/get"
sMonitorTopic = prefix + "/monitor/get"
# 发布的主题
pInfoTopic = prefix + "/info/post"
pNtpTopic = prefix + "/ntp/post"
pPropertyTopic = prefix + "/property/post"
pFunctionTopic = prefix + "/function/post"
pMonitorTopic = prefix + "/monitor/post"
pEventTopic = prefix + "/event/post"

# 初始化，连接 设备mqtt客户端Id格式为：认证类型(E=加密、S=简单) & 设备编号 & 产品ID & 用户ID
clientId = "E&" + deviceNum + "&" + productId +"&" + userId
client=mqtt.Client(clientId)

#加密 (AES-CBC-128-pkcs5padding)
def encrypt(plain_data,wumei_key,wumei_iv):
    aes=AEScryptor(wumei_key,AES.MODE_CBC,wumei_iv,paddingMode="PKCS5Padding",characterSet='utf-8')
    rData=aes.encryptFromString(plain_data)
    printMsg("密码(已加密)："+rData.toBase64())
    return rData.toBase64()

#回调函数。当尝试与MQTT broker 建立连接时，触发该函数。
#client 是本次连接的客户端实例。
#userdata 是用户的信息，一般为空。但如果有需要，也可以通过 user_data_set 函数设置。
#flags 保存服务器响应标志的字典
#rc 是响应码。
# 0: 连接成功
# 1: 连接失败-不正确的协议版本
# 2: 连接失败-无效的客户端标识符
# 3: 连接失败-服务器不可用
# 4: 连接失败-错误的用户名或密码
# 5: 连接失败-未授权
# 6-255: 未定义.
#一般情况下，我们只需要关注rc响应码是否为0就可以了。
def on_connect(client,userdata,flags,rc):
    if rc==0:
        printMsg("连接成功")
        # 放在on_connect下可以保证重连重新订阅
        # 订阅(OTA、NTP、属性、功能、实时监测)
        client.subscribe(sInfoTopic, 1)
        client.subscribe(sOtaTopic, 1)
        client.subscribe(sNtpTopic, 1)
        client.subscribe(sPropertyTopic, 1)
        client.subscribe(sFunctionTopic, 1)
        client.subscribe(sPropertyOnline, 1)
        client.subscribe(sFunctionOnline, 1)
        client.subscribe(sMonitorTopic, 1)

        printMsg("订阅主题：" + sInfoTopic)
        printMsg("订阅主题：" + sOtaTopic)
        printMsg("订阅主题：" + sNtpTopic)
        printMsg("订阅主题：" + sPropertyTopic)
        printMsg("订阅主题：" + sFunctionTopic)
        printMsg("订阅主题：" + sPropertyOnline)
        printMsg("订阅主题：" + sFunctionOnline)
        printMsg("订阅主题：" + sMonitorTopic)
        # 发布设备信息
        publishInfo()
        global g_rc
        g_rc=0
    else:
        printMsg("连接失败，rc="+str(rc))
        printMsg("3秒后重连...")
        time.sleep(3)
        connectMqtt()

#  物模型-属性处理
def processProperty(payload):
    data=json.loads(payload)
    for item in data:
        #  匹配云端定义的属性（不包含属性中的监测数据）
        id = item["id"]
        value=item["value"]
        printMsg(str(id)+":"+str(value))
    #  最后发布属性，服务端订阅存储（重要）
    publishProperty(json.dumps(data))

#  物模型-功能处理
def processFunction(payload):
    data=json.loads(payload)
    for item in data:
        # 匹配云端定义的功能
        id = item["id"]
        value=item["value"]
        if(id=="switch"):
            printMsg("开关 switch："+ str(value))
        elif(id=="gear"):
            printMsg("档位 gear："+ str(value))
        elif(id=="light_color"):
            printMsg("灯光颜色 light_color："+ str(value))
        elif(id=="message"):
            printMsg("屏显消息 message："+ str(value))
        elif(id=="report_monitor"):
            msg=randomPropertyData();
            printMsg("订阅到上报监测数据指令，上报数据：")
            printMsg(msg)
            publishProperty(msg)
    #  最后发布属性，服务端订阅存储（重要）
    publishProperty(json.dumps(data))

# 回调函数，在客户端订阅的主题上接收到消息时调用，“message”变量是一个MQTT消息描述所有消息特征
def on_message(client,userdata,msg):
    printMsg("接收数据:"+msg.topic+" "+str(msg.payload))
    if(msg.topic==sOtaTopic):
        printMsg("订阅到设备升级指令...")
        jsonData=json.loads(msg.payload)
        newVersion = jsonData["version"]
        downloadUrl = jsonData["downloadUrl"]
        printMsg("固件版本："+newVersion)
        printMsg("下载地址："+downloadUrl)
    elif(msg.topic==sInfoTopic):
        printMsg("订阅到设备信息指令...")
        # 发布设备信息
        publishInfo()
    elif(msg.topic==sNtpTopic):
        printMsg("订阅到NTP时间..."); 
        jsonData=json.loads(msg.payload)
        deviceSendTime = jsonData["deviceSendTime"]
        serverSendTime = jsonData["serverSendTime"]
        serverRecvTime = jsonData["serverRecvTime"]
        deviceRecvTime = round(time.time()*1000)
        now = (serverSendTime + serverRecvTime + deviceRecvTime - deviceSendTime) / 2
        printMsg("当前时间："+str(round(now)))
    elif(msg.topic==sPropertyTopic or msg.topic==sPropertyOnline):
        printMsg("订阅到属性指令...")
        processProperty(msg.payload)
    elif(msg.topic==sFunctionTopic or msg.topic==sFunctionOnline):
        printMsg("订阅到功能指令...")
        processFunction(msg.payload)
    elif(msg.topic==sMonitorTopic):
        # python全局变量的使用
        global t2
        global monitorCount
        global monitorInterval
        printMsg("订阅到实时监测指令...")
        jsonData=json.loads(msg.payload)
        monitorCount = jsonData["count"]
        monitorInterval = jsonData["interval"]/1000
        t2.cancel()
        t2=threading.Timer(monitorInterval,timing_publishMonitor)
        t2.start()

# 1.发布设备信息
def publishInfo():
    # rssi值 树莓派中暂时不处理wifi信号问题
    #  信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）
    # status值 （1-未激活，2-禁用，3-在线，4-离线）
    doc={"rssi":1,"firmwareVersion":firmwareVersion,"status":3,"userId":userId,"longitude":longitude,"latitude":latitude,"summary":{"name":"device","chip":"esp8266","author":"kerwincui","version":1.6,"create":"2022 - 06 - 06"}}
    #     client.publish('raspberry/topic',payload=i,qos=0,retain=False) 
    jsonData=json.dumps(doc)
    printMsg("发布设备信息："+pInfoTopic+" "+jsonData)
    client.publish(pInfoTopic,jsonData)

#  2.发布时钟同步信，用于获取当前时间(可选) 
def publishNtp():
    data={"deviceSendTime":round(time.time()*1000)}
    jsonData=json.dumps(data)
    printMsg("发布NTP信息"+jsonData)
    client.publish(pNtpTopic,jsonData)

# 3.发布属性
# msg 接收格式json
def publishProperty(msg):
    printMsg("发布属性:" + msg)
    client.publish(pPropertyTopic, msg)

#  4.发布功能
def publishFunction( msg):
    printMsg("发布功能:" + msg)
    client.publish(pFunctionTopic, msg)

# 5.发布事件
def publishEvent():
    objTmeperature={"id":"height_temperature","value":40,"remark":"温度过高警告"}
    objException={"id":"exception","value":"异常消息，消息内容XXXXXXXX","remark":"设备发生错误"}
    data=[objTmeperature,objException]
    jsonData=json.dumps(data)
    printMsg("发布事件:"+jsonData)
    client.publish(pEventTopic,jsonData)

# 6.发布实时监测数据
def publishMonitor():
    msg=randomPropertyData()
    # 发布为实时监测数据，不会存储
    printMsg("发布实时监测数据："+msg)
    client.publish(pMonitorTopic,msg)

# 随机生成监测值
def randomPropertyData():
    # 匹配云端定义的监测数据，随机数代替监测结果
    # random.randint(0,10) #生成数据包括0,10 
    # random.uniform(30,60)生成数据为浮点型
    objTmeperature={"id":"temperature","value":str(round(random.uniform(10,30),2)),"remark":""}
    objHumidity={"id":"humidity","value":str(round(random.uniform(30,60),2)),"remark":""}
    objCo2={"id":"co2","value":str(random.randint(400,1000)),"remark":""}
    objBrightness={"id":"brightness","value":str(random.randint(1000,10000)),"remark":""}
    printMsg("随机生成监测数据值:")
    data=[objTmeperature,objHumidity,objCo2,objBrightness]
    print(json.dumps(data))
    return json.dumps(data)

#连接mqtt
def connectMqtt():
    printMsg("连接Mqtt服务器")
    # 生成mqtt认证密码(设备加密认证，密码加密格式为：mqtt密码 & 过期时间 & 授权码，其中授权码为可选)
    password = generationPwd()
    encryptPassword=encrypt(password,mqttSecret,wumei_iv)
    client.username_pw_set(mqttUserName,encryptPassword)
    client.on_connect=on_connect
    client.on_message=on_message
    client.connect(mqttHost,mqttPort,10)

#打印提示信息
def printMsg(msg):
    print("[{}] {}".format(time.strftime("%Y-%m-%d %H:%M:%S"),msg))

# 生成密码
def generationPwd():
    try:
        doc=json.loads(getTime())
    except:
        printMsg("Json解析失败")
        exit()
    deviceSendTime = doc["deviceSendTime"]
    serverSendTime = doc["serverSendTime"]
    serverRecvTime = doc["serverRecvTime"]
    deviceRecvTime = round(time.time()*1000)
    now = (serverSendTime + serverRecvTime + deviceRecvTime - deviceSendTime) / 2
    expireTime = int(now + 1 * 60 * 60 * 1000)
    # 密码加密格式为：mqtt密码 & 过期时间 & 授权码（可选），如果产品启用了授权码就必须加上
    password=""
    if(authCode == ""):
        password = mqttPwd + "&" + str(expireTime, 0)
    else:
        password = mqttPwd + "&" + str(expireTime, 0) + "&" + authCode
    printMsg("密码(未加密):" + password)
    return password

# HTTP获取时间
def getTime():
    try:
        r=requests.get(ntpServer+str(round(time.time()*1000)))
        if(r.status_code>0):
            if(r.status_code==200 or r.status_code==301):
                printMsg("获取时间成功，data:"+r.text)
                return r.text
        else:
            printMsg("获取时间失败，error:"+r.status_code)
    except:
        printMsg("连接Http失败")
        
# 定时上报属性
def timing_publishProperty():
    printMsg("执行定时上报")
    #发布事件
    publishEvent()
    #发布时钟同步
    publishNtp()
    #  发布属性(监测值)
    msg=randomPropertyData()
    publishProperty(msg)
    t1=threading.Timer(60,timing_publishProperty)
    t1.start()

# 定时上报监测数据
def timing_publishMonitor():
    global monitorCount
    monitorCount=monitorCount-1
    printMsg("执行监测")
    publishMonitor()
    if(monitorCount>0):
        t2=threading.Timer(monitorInterval,timing_publishMonitor)
        t2.start()
        
if __name__ == '__main__':
    connectMqtt()
    client.loop_start()
    printMsg("等待连接MQTT")
    while(g_rc!=0):
        print("-",end=" ")
        time.sleep(1)
    t1=threading.Timer(60,timing_publishProperty)
    t1.setDaemon(True) #当主线程被关闭后，子线程也关闭
    t1.start()
    t2=threading.Timer(monitorInterval,timing_publishMonitor)
    t2.setDaemon(True) #当主线程被关闭后，子线程也关闭
    t2.start()

    while True:
        time.sleep(10) #定时上报、检测上报都是线程执行，主线程可以做自己的任务
  
