--- 模块功能：物美MQTT测试
-- @author 杜兴杰
-- @module 物美MQTT通信测试
-- @license MIT
-- @copyright 杜兴杰
-- @email 1066950103@qq.com
-- @release 2022.8.5
module(..., package.seeall)
require"WeiMeiComAuth"
require"WeiMeiComInteraction"
require"WeiMeiApp"
require"misc"
require"mqtt"

local ready = false

--物美配置参数相关配置
local m_strEncryptionMode = "S"
local m_strProductId = 220 
local m_strDeviceId = nil
local m_strUserId = "1" -- admin
local m_strMqttUser = "wumei-smart"
local m_strMqttPassword = "PVMXS6V46205CAQ5"
local m_strProductPassword = "KC3169JOU816X5C0" --产品密码
local m_nMqttAuthenticationTimeout = 24*60*60*1000 --24小时
local m_strMqttIp = "wumei.live"
local m_strDeviceAuthorizationCode = "A25040D2E34B483DA371B5F9A315BB43" --设备授权码

local m_mqttClient = nil
local m_mqttFlag = 0

function AuthenticationResultCallback(nResult)
    if nResult == 1 then 
        log.info("---AuthenticationResultCallback---ok")
        WeiMeiComInteraction.Init(m_strProductId,m_strDeviceId)
        m_mqttFlag = 1
    end
end

local function MqttInit()
    WeiMeiComAuth.Init(m_strEncryptionMode,m_strProductId,m_strDeviceId,m_strUserId,m_strMqttUser,m_strMqttPassword,m_nMqttAuthenticationTimeout,m_strMqttIp,m_strDeviceAuthorizationCode,m_strProductPassword,AuthenticationResultCallback)
end

-- 订阅所有主题
local function GetSubscriberAll()
    local tSubscriber = WeiMeiComInteraction.GetSubscriberAll()
    while #tSubscriber > 0 do
        local ouSubscriber  = table.remove(tSubscriber,1)
        if m_mqttClient:subscribe({[ouSubscriber.topic]=ouSubscriber.qos}) == nil then
            log.info("subscribe eeror ")
            return false
        end
    end
    return true
end

--- MQTT连接是否处于激活状态
-- @return 激活状态返回true，非激活状态返回false
-- @usage mqttTask.isReady()
function isReady()
    return ready
end

--启动MQTT客户端任务
sys.taskInit(
    function()
        local retryConnectCnt = 0
        while true do
            if not socket.isReady() then
                retryConnectCnt = 0
                --等待网络环境准备就绪，超时时间是5分钟
                sys.waitUntil("IP_READY_IND",300000)
            end
            
            if socket.isReady() then
                m_strDeviceId = misc.getImei()
                MqttInit() 
                while m_mqttFlag == 0 do 
                    sys.wait(50)
                end
                 --创建一个MQTT客户端
                 log.info("ClientId=" .. WeiMeiComAuth.GetClientId() )
                 log.info("User=" .. WeiMeiComAuth.GetUser() )
                 log.info("Password=" .. WeiMeiComAuth.GetPassword() )
                 log.info("Ip=" .. WeiMeiComAuth.GetIP() )
                m_mqttClient = mqtt.client(WeiMeiComAuth.GetClientId(),600,WeiMeiComAuth.GetUser(),WeiMeiComAuth.GetPassword())
                if m_mqttClient:connect(WeiMeiComAuth.GetIP(),1883,"tcp") then
                    retryConnectCnt = 0
                    ready = true
                    --订阅主题
                    if GetSubscriberAll() == true then
                        WeiMeiComInteraction.SetCallbackInformationData(WeiMeiApp.InformationData)
                        WeiMeiComInteraction.SetCallbackPropertyData(WeiMeiApp.PropertyData)
                        WeiMeiComInteraction.SetPropertyPush(1000*30) --30秒钟定时上传一次属性
                        WeiMeiComInteraction.DelayInit()
                        --循环处理接收和发送的数据
                        while true do
                            local result,data = m_mqttClient:receive(300,"APP_SOCKET_SEND_DATA")
                            if result or data=="timeout" or data=="APP_SOCKET_SEND_DATA" then
                                if result then
                                    log.info("data.topic" .. data.topic .. "data.payload" .. data.payload)
                                    WeiMeiComInteraction.OnRecvData(data.topic,data.payload);
                                end
                            else
                                break -- 出错了
                            end
                            result,strMessage,strTopic,nQos = WeiMeiComInteraction.GetData()
                            if result == true then
                                local mqttResult = m_mqttClient:publish(strTopic,strMessage,nQos)
                                if not mqttResult  then 
                                    break 
                                end
                            end
                        end
  
                    end
                    ready = false
                else
                    retryConnectCnt = retryConnectCnt+1
                end
                --断开MQTT连接
                m_mqttClient:disconnect()
                if retryConnectCnt>=5 then link.shut() retryConnectCnt=0 end
                sys.wait(5000)
            else
                --进入飞行模式，20秒之后，退出飞行模式
                net.switchFly(true)
                sys.wait(20000)
                net.switchFly(false)
            end
        end
    end
)
