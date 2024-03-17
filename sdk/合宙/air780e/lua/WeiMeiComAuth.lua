--- 模块功能：物美MQTT认证
-- @author 杜兴杰
-- @module 物美MQTT通信
-- @license MIT
-- @copyright 杜兴杰
-- @email 1066950103@qq.com
-- @release 2022.8.4

module(..., package.seeall)

local m_strEncryptionMode
local m_strProductId
local m_strDeviceId
local m_strUserId
local m_strUser
local m_strPassword
local m_nTimeout
local m_strIp
local m_strDeviceAuthorizationCode = nil
local m_strProductPassword = nil
local m_InitCallback = nil

local m_strOutPassword
local m_strClientId
local m_nTimeSyncFlag

local function CreateCommunicationPassword()
    if m_strEncryptionMode == "S" then
        if nil == m_strDeviceAuthorizationCode then
            m_strOutPassword = m_strPassword
        else
            m_strOutPassword = m_strPassword .. "&" .. m_strDeviceAuthorizationCode
        end
        return true
    end

    if m_strEncryptionMode == "E" then
        m_strOutPassword = AesPassword()
        return true
    end
    return false
end

local function Callback(nResult)
    log.info("Callback" .. nResult)
    if m_InitCallback ~= nil then
        m_InitCallback(nResult)
    end
end

local function ParameterCheck()

   return true
end



local function CreatedClientId()
    m_strClientId = m_strEncryptionMode   .. "&" .. m_strDeviceId .. "&" .. m_strProductId .. "&" .. m_strUserId
end

local function httpCallbackFun(result,prompt,head,body)
    log.info("GetTimeHttp.cbFnc",result,prompt)
    if result and body then
        log.info("GetTimeHttp.cbFnc"..body.."bodyLen="..body:len())
        local nDeviceRunTickMs = 1000--rtos.tick() * 5

		local nEnd = string.find(body,'}')
		local outStr= string.sub(body,1,nEnd-4) .. '}'
		log.info("----outStr " .. outStr)

        local jsonObj = json.decode(outStr) --bug json 64 转换不支持
        local nDeviceSendTime = jsonObj["deviceSendTime"]
        local nServerSendTime = jsonObj["serverSendTime"]
        local nServerRecvTime = jsonObj["serverRecvTime"]
        log.info("nDeviceSendTime=" .. nDeviceSendTime)
        log.info("nServerSendTime=" .. nServerSendTime)
        log.info("nServerRecvTime=" .. nServerRecvTime)

        local nSyncTime = nServerRecvTime  --秒为单位 --(nServerRecvTime + nServerSendTime + nDeviceRunTickMs - nDeviceSendTime)/2 --这里运算有问题 可能存在数据移除了
        log.info("nSyncTime=" .. nSyncTime)
		rtc.set(nSyncTime)
        --创建客户端ID
        CreatedClientId()
        --创建密码
        CreateCommunicationPassword()
        Callback(1)
        m_nTimeSyncFlag = 1
    end
end

 function SyncTime()
    local nDeviceRunTickMs = 1000--rtos.tick() * 5
    local strUrl = "http://" .. m_strIp .. ":8080/iot/tool/ntp?deviceSendTime=" .. nDeviceRunTickMs
    log.info("strUrl" .. strUrl)
    --http.request("GET",strUrl,nil,nil,nil,nil,httpCallbackFun)
	local code, headers, body = http.request("GET", strUrl).wait()
	log.info("http.get", code, headers, body)
	httpCallbackFun(code,"NULL",headers,body)
end

local function GetCurrentTime()
    local nCurrentTime = os.time()
    log.info("GetCurrentTime= " .. nCurrentTime)
    return nCurrentTime
end

function AesPassword()
    local nCurrentTime = GetCurrentTime()
    local nExpireTime = m_nTimeout + nCurrentTime --这里存在bug 数据溢出了

    local strAesSource = nil
    if nil == m_strDeviceAuthorizationCode then
        strAesSource = m_strPassword .. "&" .. nExpireTime .. "000"
    else
        strAesSource = m_strPassword .. "&" .. nExpireTime .. "000" .."&" .. m_strDeviceAuthorizationCode
    end
    --加密内容：  mqtt密码 & expireTime & 授权码(可选)
    --加密模式：CBC；填充方式：Pkcs5Padding；密钥：1234567890123456；密钥长度：128 bit；偏移量：1234567890666666
   log.info("strAesSource=".. strAesSource .. " m_strProductPassword=" ..m_strProductPassword)
	local encodeStr = crypto.cipher_encrypt("AES-128-CBC", "PKCS7", strAesSource, m_strProductPassword, "wumei-smart-open") --todo 密码验证
    log.info("AesPassword strAesSource" .. strAesSource .. " encodeStr " .. encodeStr )
    log.info("AES", "aes-128-cbc", encodeStr:toHex())
    encodeStr = crypto.base64_encode(encodeStr)
    log.info("AesPassword strAesSource" .. strAesSource .. " encodeStrbase64 " .. encodeStr )
    return encodeStr

end

--- mqtt认证初始化
-- @string strEncryptionMode,string类型,认证类型：S=简单认证，E=加密认证
-- @string strProductId,string类型，物美里面定义的产品ID
-- @string strDeviceId,string类型，设备ID 一般用imei
-- @string strUserId,string类型，用户ID
-- @string strUser,string类型，用户
-- @string strPassword,string类型，密码
-- @number nTimeout,number类型，延迟秒为单位
-- @string strIp,string类型，Ip
-- @string strDeviceAuthorizationCode,string类型 设备认证码 不用不填
-- @string strProductPassword,string类型 产品密码
-- @return nil
function Init(strEncryptionMode,strProductId,strDeviceId,strUserId,strUser,strPassword,nTimeout,strIp,strDeviceAuthorizationCode,strProductPassword,callback)
    m_strEncryptionMode = strEncryptionMode
    m_strProductId = strProductId
    m_strDeviceId = strDeviceId
    m_strUserId = strUserId
    m_strUser = strUser
    m_strPassword = strPassword
    m_nTimeout = nTimeout
    m_strIp = strIp
    m_strDeviceAuthorizationCode = strDeviceAuthorizationCode
    m_strProductPassword = strProductPassword
    m_nTimeSyncFlag = 0
    m_InitCallback = callback
    --if ParameterCheck() == false then
     --   Callback(0)
   -- end
    SyncTime()
end

function GetUser()
    return m_strUser
end

function GetPassword()
    return m_strOutPassword
end

function GetClientId()
    return m_strClientId
end

function GetIP()
    return m_strIp
end


return {
    GetUser = GetUser,
    GetPassword = GetPassword,
    GetClientId = GetClientId,
    GetIP = GetIP,
    Init=Init
}
