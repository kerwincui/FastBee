package com.ruoyi.system.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备状态对象 iot_device_status
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
public class IotDeviceStatus extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    private Long deviceStatusId;

    /** 设备 */
    @Excel(name = "设备")
    private Long deviceId;

    /** 设备编号 */
    @Excel(name = "设备编号")
    private String deviceNum;

    /** 继电器 */
    @Excel(name = "继电器")
    private Integer relayStatus;

    /** 灯状态 */
    @Excel(name = "灯状态")
    private Integer lightStatus;

    /** 在线 */
    @Excel(name = "在线")
    private Integer isOnline;

    /** 设备温度 */
    @Excel(name = "设备温度")
    private BigDecimal deviceTemperature;

    /** 设备湿度 */
    @Excel(name = "设备湿度")
    private BigDecimal deviceHumidity;

    /** 空气温度 */
    @Excel(name = "空气温度")
    private BigDecimal airTemperature;

    /** 空气湿度 */
    @Excel(name = "空气湿度")
    private BigDecimal airHumidity;

    /** 触发源 */
    @Excel(name = "触发源")
    private Integer triggerSource;

    /** 彩灯亮度 */
    @Excel(name = "彩灯亮度")
    private Integer brightness;

    /** 渐变间隔 */
    @Excel(name = "渐变间隔")
    private Integer lightInterval;

    /** 彩灯模式 */
    @Excel(name = "彩灯模式")
    private Integer lightMode;

    /** 红灯 */
    @Excel(name = "红灯")
    private Long red;

    /** 绿灯 */
    @Excel(name = "绿灯")
    private Long green;

    /** 蓝灯 */
    @Excel(name = "蓝灯")
    private Long blue;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

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
    public void setDeviceHumidity(BigDecimal deviceHumidity) 
    {
        this.deviceHumidity = deviceHumidity;
    }

    public BigDecimal getDeviceHumidity() 
    {
        return deviceHumidity;
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
    public void setRed(Long red) 
    {
        this.red = red;
    }

    public Long getRed() 
    {
        return red;
    }
    public void setGreen(Long green) 
    {
        this.green = green;
    }

    public Long getGreen() 
    {
        return green;
    }
    public void setBlue(Long blue) 
    {
        this.blue = blue;
    }

    public Long getBlue() 
    {
        return blue;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("deviceStatusId", getDeviceStatusId())
            .append("deviceId", getDeviceId())
            .append("deviceNum", getDeviceNum())
            .append("relayStatus", getRelayStatus())
            .append("lightStatus", getLightStatus())
            .append("isOnline", getIsOnline())
            .append("deviceTemperature", getDeviceTemperature())
            .append("deviceHumidity", getDeviceHumidity())
            .append("airTemperature", getAirTemperature())
            .append("airHumidity", getAirHumidity())
            .append("triggerSource", getTriggerSource())
            .append("brightness", getBrightness())
            .append("lightInterval", getLightInterval())
            .append("lightMode", getLightMode())
            .append("red", getRed())
            .append("green", getGreen())
            .append("blue", getBlue())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
