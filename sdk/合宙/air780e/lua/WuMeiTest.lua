--- 模块功能：物美MQTT测试
-- @author 杜兴杰
-- @module 物美MQTT通信测试
-- @license MIT
-- @copyright 杜兴杰
-- @email 1066950103@qq.com
-- @release 2022.8.5
module(..., package.seeall)
WeiMeiComAuth = require"WeiMeiComAuth"
WeiMeiComInteraction = require"WeiMeiComInteraction"
WeiMeiApp = require"WeiMeiApp"
--require"misc"
--require"mqtt"

--[[特别注意, 使用mqtt库需要下列语句]]
_G.sysplus = require("sysplus")

local ready = false

--物美配置参数相关配置
local m_strEncryptionMode = "E"
local m_strProductId = 253
local m_strDeviceId = nil
local m_strUserId = "1" -- admin
local m_strMqttUser = "FastBee"
local m_strMqttPassword = "P77A4MMCA20V0D0K"
local m_strProductPassword = "K4PAICCX042H88E6" --产品密码
local m_nMqttAuthenticationTimeout = 24*60*60*1 --24小时
local m_strMqttIp = "www.fastbee.cn"
local m_strDeviceAuthorizationCode = nill--= "A25040D2E34B483DA371B5F9A315BB43" --设备授权码

local mqttc = nil
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
		mqttc:subscribe(ouSubscriber.topic,ouSubscriber.qos) --todo 可能订阅数量有限
        --if m_mqttClient:subscribe({[ouSubscriber.topic]=ouSubscriber.qos}) == nil then
         --   log.info("subscribe eeror ")
         --   return false
        --end
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
		sys.waitUntil("IP_READY", 50000)

		--创建一个MQTT客户端
		m_strDeviceId = mobile.imei()
		MqttInit()
		while m_mqttFlag == 0 do
			sys.wait(50)
		end
		log.info("ClientId=" .. WeiMeiComAuth.GetClientId() )
		log.info("User=" .. WeiMeiComAuth.GetUser() )
		log.info("Password=" .. WeiMeiComAuth.GetPassword() )
		log.info("Ip=" .. WeiMeiComAuth.GetIP() )

		mqttc = mqtt.create(nil,WeiMeiComAuth.GetIP(), 1883, false, ca_file)
		mqttc:auth(WeiMeiComAuth.GetClientId(),WeiMeiComAuth.GetUser(),WeiMeiComAuth.GetPassword()) -- client_id必填,其余选填
		mqttc:keepalive(30) -- 默认值240s
		mqttc:autoreconn(true, 3000) -- 自动重连机制

		mqttc:on(function(mqtt_client, event, data, payload)
			-- 用户自定义代码
			log.info("mqtt", "event", event, mqtt_client, data, payload)
			if event == "conack" then
				--连接成功
				sys.publish("mqtt_conack")
				if GetSubscriberAll() == true then
					WeiMeiComInteraction.SetCallbackInformationData(WeiMeiApp.InformationData)
					WeiMeiComInteraction.SetCallbackPropertyData(WeiMeiApp.PropertyData)
					WeiMeiComInteraction.SetPropertyPush(1000*30) --30秒钟定时上传一次属性
					WeiMeiComInteraction.DelayInit()
				end
			elseif event == "recv" then
				log.info("mqtt", "downlink", "topic", data, "payload", payload)
				WeiMeiComInteraction.OnRecvData(data,payload);
			elseif event == "sent" then
				log.info("mqtt", "sent", "pkgid", data)
				-- elseif event == "disconnect" then
				-- 非自动重连时,按需重启mqttc
				-- mqtt_client:connect()
			end
		end)

		mqttc:connect()
		sys.waitUntil("mqtt_conack") --todo 超时重启
		while true do
			-- mqttc自动处理重连
			result,strMessage,strTopic,nQos = WeiMeiComInteraction.GetData()
			if result == true then
				local mqttResult = mqttc:publish(strTopic,strMessage,nQos)
				if not mqttResult  then
					break
				end
			end
			sys.wait(50)
		end
		mqttc:close()
		mqttc = nil
    end
)
