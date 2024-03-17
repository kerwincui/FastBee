--- 模块功能：物美MQTT应用
-- @author 杜兴杰
-- @module 物美MQTT应用
-- @license MIT
-- @copyright 杜兴杰
-- @email 1066950103@qq.com
-- @release 2022.8.5

module(..., package.seeall)

local VERSION = "0.1"
local m_strUserId = "1"
local m_strLongitude = "0"
local m_strLatitude = "0"

local m_nTemperature = 25
--local m_nVoltval = 4.0


local rtos_bsp = rtos.bsp()
function adc_pin() -- 根据不同开发板，设置ADC编号
    if rtos_bsp == "AIR101" then -- Air101开发板ADC编号
        return 0,1,255,255,adc.CH_CPU ,adc.CH_VBAT
    elseif rtos_bsp == "AIR103" then -- Air103开发板ADC编号
        return 0,1,2,3,adc.CH_CPU ,adc.CH_VBAT
    elseif rtos_bsp == "AIR105" then -- Air105开发板ADC编号
        return 0,5,6,255,255,255
    elseif rtos_bsp == "ESP32C3" then -- ESP32C3开发板ADC编号
        return 0,1,2,3,adc.CH_CPU , 255
    elseif rtos_bsp == "ESP32C2" then -- ESP32C2开发板ADC编号
        return 0,1,2,3,adc.CH_CPU , 255
    elseif rtos_bsp == "ESP32S3" then -- ESP32S3开发板ADC编号
        return 0,1,2,3,adc.CH_CPU , 255
    elseif rtos_bsp == "EC618" then --Air780E开发板ADC编号
        return 0,1,255,255,adc.CH_CPU ,adc.CH_VBAT
    else
        log.info("main", "define ADC pin in main.lua")
        return 0, 0,0,0,0,0
    end
end
local adc_pin_0,adc_pin_1,adc_pin_2,adc_pin_3,adc_pin_temp,adc_pin_vbat=adc_pin()

--模块温度返回回调函数
--@temp温度，srting类型，如果要对该值进行运算，可以使用带float的固件将该值转为number
local function getTemperatureCb(temp)
    m_nTemperature = temp
end

--- ADC读取测试
-- @return 无
-- @usage read()
local function read0()
    --ADC0接口用来读取电压
    local ADC_ID = 0
    local adcval,voltval = adc.get(adc_pin_0)
    log.info("testAdc0.read",adcval,(voltval-(voltval%3))/3,voltval)
    -- 输出计算得出的原始电压值
    m_nVoltval = voltval/3 * 3127 / 1000
    log.info("testAdc0.Vbat", m_nVoltval)
end

--2秒循环查询模块温度
--sys.timerLoopStart(misc.getTemperature,1000,getTemperatureCb)
--sys.timerLoopStart(read0,1000)

-- 开启对应的adc通道
adc.open(adc_pin_0)



function FunctionData()
    local jsonStr = ""
end

function PropertyData()
    local jsonData = {{
        id= "temperature",
        value= m_nTemperature ,
        remark="温度信息"
    },{
        id= "voltage",
        value= m_nVoltval,
        remark="电压信息"
    }}
    local jsonStr = json.encode(jsonData)
    return jsonStr
end

function InformationData()
    local jsonData = {
        rssi = mobile.rssi(),
        firmwareVersion = VERSION,
        status = 3 ,
        userId = m_strUserId ,
        longitude = m_strLongitude ,
        latitude = m_strLatitude,
        summary = {
            name= "device",
            chip = "air724",
            author = "duxingjie",
            version=0.1,
            create = "2022-08-07"
        }
    }
    local jsonStr = json.encode(jsonData)
    return jsonStr
end

return {
    InformationData = InformationData,
    PropertyData = PropertyData,
    FunctionData = FunctionData
}
