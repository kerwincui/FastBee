--- 模块功能：物美MQTT交互
-- @author 杜兴杰
-- @module 物美MQTT通信
-- @license MIT
-- @copyright 杜兴杰
-- @email 1066950103@qq.com
-- @release 2022.8.5

module(..., package.seeall)

local m_strProductId
local m_strDeviceNum

local m_tMessageQueue = {}

local m_callbackPropertyData = nil
local m_callbackFunctionData = nil
local m_callbackEventData = nil
local m_callbackDeviceInformationData = nil

local m_timePropertyId = 0
local m_timeFunctionId = 0
local m_timeEventId = 0

local m_nMonitorCount = 0
local m_nMonitorTime = 0
local m_timeMonitorId = 0

local function GetSubscriberDeviceInformation()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/info/get"
end

local function GetSubscriberDeviceInOta()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/ota/get"
end

local function GetSubscriberDeviceProperty()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/property/get"
end

local function GetSubscriberDevicePropertyOnline()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/property-online/get"
end

local function GetSubscriberDeviceFunction()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/function/get"
end

local function GetSubscriberDeviceFunctionOnline()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/function-online/get"
end

local function GetSubscriberDeviceMonitor()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/monitor/get"
end

local function GetSubscriberDeviceNtp()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/ntp/get"
end

local function GetPublishDeviceInformation()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/info/post"
end

local function GetPublishDeviceProperty()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/property/post"
end

local function GetPublishDeviceFunction()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/function/post"
end

local function GetPublishDeviceEvent()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/event/post"
end

local function GetPublishDeviceNtp()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/ntp/post"
end

local function GetPublishMonitorProperty()
    return "/" .. m_strProductId .. "/" .. m_strDeviceNum .. "/monitor/post"
end

local function PropertyPush()
    if m_callbackPropertyData ~= nil then
        local strTopic = GetPublishDeviceProperty()
        local strMessage = m_callbackPropertyData()
        local nQos = 1
        table.insert(m_tMessageQueue,{topic=strTopic,payload=strMessage,qosr=nQos})
        log.info("------------------PropertyPush---------------")
    end
end

local function FunctionPush()
    if m_callbackFunctionData ~= nil then
        local strTopic = GetPublishDeviceFunction()
        local strMessage = m_callbackFunctionData()
        local nQos = 1
        table.insert(m_tMessageQueue,{topic=strTopic,payload=strMessage,qosr=nQos})
        log.info("------------------FunctionPush---------------")
    end
end

local function EventPush()
    if m_callbackEventData ~= nil then
        local strTopic = GetPublishDeviceEvent()
        local strMessage = m_callbackEventData()
        local nQos = 1
        table.insert(m_tMessageQueue,{topic=strTopic,payload=strMessage,qosr=nQos})
        log.info("------------------EventPush---------------")
    end
end

local function MonitorPush()
    if m_callbackPropertyData ~= nil then
        local strTopic = GetPublishMonitorProperty()
        local strMessage = m_callbackPropertyData()
        local nQos = 1
        table.insert(m_tMessageQueue,{topic=strTopic,payload=strMessage,qosr=nQos})
        log.info("------------------MonitorPush---------------")
    end
end

local function DeviceMonitorTimeCallback()
    MonitorPush()
    if m_nMonitorCount ~= 0 then
    m_nMonitorCount = m_nMonitorCount -1
    m_timeMonitorId = sys.timerStart(
        DeviceMonitorTimeCallback
        ,m_nMonitorTime)
    else
        sys.timerStop(m_timeMonitorId)
        m_timeMonitorId= 0
    end
    log.info("----m_nMonitorCount=" .. m_nMonitorCount)
end

local function DeviceInformationPush()
    if m_callbackDeviceInformationData ~= nil then
        local strTopic = GetPublishDeviceInformation()
        local strMessage = m_callbackDeviceInformationData()
        local nQos = 1
        table.insert(m_tMessageQueue,{topic=strTopic,payload=strMessage,qosr=nQos})
    end
end

--- mqtt交互初始化
-- @string strProductId,string类型,产品ID
-- @string strDeviceNum,string类型，设备号 IMEI
-- @return nil
function  Init(strProductId,strDeviceNum)
    m_strProductId = strProductId
    m_strDeviceNum = strDeviceNum
end

--- mqtt交互延时初始化
-- @return nil
function DelayInit()
    DeviceInformationPush();
end
--- mqtt 获取待发送数据 一次取出一天且删除
-- @return bResult false 没有数据 true 有数据
-- @return strMessage 要发送的数据
-- @return strTopic 要发送的主题
-- @return nQos 发送消息级别
function GetData()
    local bResult = false
    local strMessage =""
    local strTopic =""
    local nQos = 0
    if #m_tMessageQueue>0 then
        local outMsg = table.remove(m_tMessageQueue,1)
        bResult = true
        strMessage = outMsg.payload
        strTopic = outMsg.topic
        nQos = outMsg.qosr
    end
    return bResult,strMessage,strTopic,nQos
end

--- mqtt 设置属性的获取获取函数，内部调用发送的时候会执行这个函数 这个函数外部实现
-- @function callback,函数类型, 数据函
function  SetCallbackPropertyData(callback)
    m_callbackPropertyData = callback
end

--- mqtt 设置功能的获取获取函数，内部调用发送的时候会执行这个函数 这个函数外部实现
-- @function callback,函数类型, 数据函
function  SetCallbackFunctionData(callback)
    m_callbackFunctionData = callback
end

--- mqtt 设置事件的获取获取函数，内部调用发送的时候会执行这个函数 这个函数外部实现
-- @function callback,函数类型, 数据函
function  SetCallbackEventData(callback)
    m_callbackEventData = callback
end

--- mqtt 设置设备信息获取函数，这个函数外部实现
-- @function callback,函数类型, 数据函
function  SetCallbackInformationData(callback)
    m_callbackDeviceInformationData = callback
end

--- mqtt 设置属性发布
-- @number nTime,数字类型, 0停止定时器 其他值开启定时器
function SetPropertyPush(nTime)
    if m_timePropertyId ~= 0 then
        sys.timerStop(m_timePropertyId)
        m_timePropertyId  = 0
    end
    if nTime~= 0 then
        m_timePropertyId = sys.timerLoopStart(PropertyPush,nTime)
    end
end

--- mqtt 设置功能发布
-- @number nTime,数字类型, 0停止定时器 其他值开启定时器
function SetFunctionPush(nTime)
    if m_timeFunctionId ~= 0 then
        sys.timerStop(m_timeFunctionId)
        m_timeFunctionId  = 0
    end
    if nTime~= 0 then
        m_timeFunctionId = sys.timerLoopStart(FunctionPush,nTime)
    end
end

--- mqtt 设置事件发布
-- @number nTime,数字类型, 0停止定时器 其他值开启定时器
function SetEventPush(nTime)
    if m_timeEventId ~= 0 then
        sys.timerStop(m_timeEventId)
        m_timeEventId  = 0
    end
    if nTime~= 0 then
        m_timeEventId = sys.timerLoopStart(EventPush,nTime)
    end
end

--- mqtt 获取要订阅的所有主题
-- @return tSubscriber,表类型, topic 主题 qos级别
function  GetSubscriberAll()
    local tSubscriber ={}
    table.insert(tSubscriber,{topic=GetSubscriberDeviceInformation(),qos=1})
    table.insert(tSubscriber,{topic=GetSubscriberDeviceProperty(),qos=1})
    table.insert(tSubscriber,{topic=GetSubscriberDevicePropertyOnline(),qos=1})
    table.insert(tSubscriber,{topic=GetSubscriberDeviceFunction(),qos=1})
    table.insert(tSubscriber,{topic=GetSubscriberDeviceFunctionOnline(),qos=1})
    table.insert(tSubscriber,{topic=GetSubscriberDeviceMonitor(),qos=1})
    table.insert(tSubscriber,{topic=GetSubscriberDeviceNtp(),qos=1})
    return tSubscriber
end

--- mqtt接受数据
-- @string topic,string类型,接收到的主题
-- @string message,string类型，消息内容
-- @return nil
function OnRecvData(topic , message)
    if topic == GetSubscriberDeviceInformation() then
        DeviceInformationPush();
    elseif topic == GetSubscriberDeviceInOta() then
        local jsonObj =  json.decode(message)
        local strVersion = jsonObj["version"]
        local strUrl = jsonObj["downloadUrl"]
	elseif topic == GetSubscriberDeviceProperty() then
        PropertyPush();
	elseif topic == GetSubscriberDevicePropertyOnline() then
        PropertyPush();
    elseif topic == GetSubscriberDeviceFunction() then
        FunctionPush();
	elseif topic == GetSubscriberDeviceFunctionOnline() then
        FunctionPush();
	elseif topic == GetSubscriberDeviceMonitor() then
        local jsonObj =  json.decode(message)
        m_nMonitorCount = jsonObj["count"]
        m_nMonitorTime = jsonObj["interval"]
        if m_timeMonitorId ~= 0 then
            sys.timerStop(m_timeMonitorId)
            m_timeMonitorId = 0
        end
        m_timeMonitorId = sys.timerStart(
            DeviceMonitorTimeCallback
            ,m_nMonitorTime)
	elseif topic == GetSubscriberDeviceNtp() then
        log.info("--DeviceNtp---" .. message)
    end
end

return {
    Init = Init,
    DelayInit = DelayInit,
    SetCallbackPropertyData = SetCallbackPropertyData,
    SetCallbackFunctionData = SetCallbackFunctionData,
    SetCallbackEventData=SetCallbackEventData,
    SetCallbackInformationData=SetCallbackInformationData,
    SetPropertyPush =SetPropertyPush,
    SetFunctionPush =SetFunctionPush,
    SetEventPush=SetEventPush,
    GetSubscriberAll=GetSubscriberAll,
    OnRecvData=OnRecvData,
    GetData = GetData
}
