/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/

package com.kerwin.wumei.entity;

import java.math.BigDecimal;

public class IotDeviceStatus {
    /** 序号 */
    private Long deviceStatusId;

    /** 设备 */
    private Long deviceId;

    /** 设备编号 */
    private String deviceNum;

    /** 继电器 */
    private Integer relayStatus;

    /** 灯状态 */
    private Integer lightStatus;

    /** 在线 */
    private Integer isOnline;

    /** 设备温度 */
    private BigDecimal deviceTemperature;

    /** 设备湿度 */
    private Integer rssi;

    /** 空气温度 */
    private BigDecimal airTemperature;

    /** 空气湿度 */
    private BigDecimal airHumidity;

    /** 触发源 */
    private Integer triggerSource;

    /** 彩灯亮度 */
    private Integer brightness;

    /** 渐变间隔 */
    private Integer lightInterval;

    /** 彩灯模式 */
    private Integer lightMode;

    /** 灯渐变时间 */
    private Integer fadeTime;

    /** 红灯 */
    private Integer red;

    /** 绿灯 */
    private Integer green;

    /** 蓝灯 */
    private Integer blue;

    public void setDeviceStatusId(Long deviceStatusId)
    {
        this.deviceStatusId = deviceStatusId;
    }

    public Long getDeviceStatusId()
    {
        return deviceStatusId;
    }
    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId()
    {
        return deviceId;
    }
    public void setDeviceNum(String deviceNum)
    {
        this.deviceNum = deviceNum;
    }

    public String getDeviceNum()
    {
        return deviceNum;
    }
    public void setRelayStatus(Integer relayStatus)
    {
        this.relayStatus = relayStatus;
    }

    public Integer getRelayStatus()
    {
        return relayStatus;
    }
    public void setLightStatus(Integer lightStatus)
    {
        this.lightStatus = lightStatus;
    }

    public Integer getLightStatus()
    {
        return lightStatus;
    }
    public void setIsOnline(Integer isOnline)
    {
        this.isOnline = isOnline;
    }

    public Integer getIsOnline()
    {
        return isOnline;
    }
    public void setDeviceTemperature(BigDecimal deviceTemperature)
    {
        this.deviceTemperature = deviceTemperature;
    }

    public BigDecimal getDeviceTemperature()
    {
        return deviceTemperature;
    }
    public void setRssi(Integer rssi)
    {
        this.rssi = rssi;
    }

    public Integer getRssi()
    {
        return rssi;
    }
    public void setAirTemperature(BigDecimal airTemperature)
    {
        this.airTemperature = airTemperature;
    }

    public BigDecimal getAirTemperature()
    {
        return airTemperature;
    }
    public void setAirHumidity(BigDecimal airHumidity)
    {
        this.airHumidity = airHumidity;
    }

    public BigDecimal getAirHumidity()
    {
        return airHumidity;
    }
    public void setTriggerSource(Integer triggerSource)
    {
        this.triggerSource = triggerSource;
    }

    public Integer getTriggerSource()
    {
        return triggerSource;
    }
    public void setBrightness(Integer brightness)
    {
        this.brightness = brightness;
    }

    public Integer getBrightness()
    {
        return brightness;
    }
    public void setLightInterval(Integer lightInterval)
    {
        this.lightInterval = lightInterval;
    }

    public Integer getLightInterval()
    {
        return lightInterval;
    }
    public void setLightMode(Integer lightMode)
    {
        this.lightMode = lightMode;
    }

    public Integer getLightMode()
    {
        return lightMode;
    }
    public void setRed(Integer red)
    {
        this.red = red;
    }

    public Integer getRed()
    {
        return red;
    }
    public void setGreen(Integer green)
    {
        this.green = green;
    }

    public Integer getGreen()
    {
        return green;
    }
    public void setBlue(Integer blue)
    {
        this.blue = blue;
    }

    public Integer getBlue()
    {
        return blue;
    }

    public void setFadeTime(Integer fadeTime)
    {
        this.fadeTime = fadeTime;
    }
    public Integer getFadeTime()
    {
        return fadeTime;
    }

}
