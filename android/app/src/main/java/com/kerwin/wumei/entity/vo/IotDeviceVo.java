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

package com.kerwin.wumei.entity.vo;

import java.math.BigDecimal;

public class IotDeviceVo {
    private Long deviceId;

    /** 编号 */
    private String deviceNum;

    /** 分类 */
    private Long categoryId;

    /** 分类名称 */
    private String categoryName;

    /** 名称 */
    private String deviceName;

    /** 固件版本 */
    private String firmwareVersion;

    /** 用户 */
    private String ownerId;

    private String nickName;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    /** 报警 */
    private Integer isAlarm;

    /** 雷达感应 */
    private Integer isRadar;

    /** 射频遥控 */
    private Integer isRfControl;

    /** 配网地址 */
    private String networkAddress;

    /** 配网IP */
    private String networkIp;

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
    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }
    public Long getCategoryId()
    {
        return categoryId;
    }
    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }
    public String getCategoryName()
    {
        return categoryName;
    }
    public void setDeviceName(String deviceName)
    {
        this.deviceName = deviceName;
    }
    public String getDeviceName()
    {
        return deviceName;
    }
    public void setFirmwareVersion(String firmwareVersion) { this.firmwareVersion = firmwareVersion; }
    public String getFirmwareVersion()
    {
        return firmwareVersion;
    }
    public void setOwnerId(String ownerId)
    {
        this.ownerId = ownerId;
    }
    public String getOwnerId()
    {
        return ownerId;
    }
    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }
    public String getNickName()
    {
        return nickName;
    }
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }
    public String getDelFlag()
    {
        return delFlag;
    }

    public void setIsAlarm(Integer isAlarm)
    {
        this.isAlarm = isAlarm;
    }
    public Integer getIsAlarm()
    {
        return isAlarm;
    }
    public void setIsRadar(Integer isRadar)
    {
        this.isRadar = isRadar;
    }
    public Integer getIsRadar()
    {
        return isRadar;
    }
    public void setIsRfControl(Integer isRfControl)
    {
        this.isRfControl = isRfControl;
    }
    public Integer getIsRfControl()
    {
        return isRfControl;
    }
    public void setNetworkAddress(String networkAddress)
    {
        this.networkAddress = networkAddress;
    }
    public String getNetworkAddress()
    {
        return networkAddress;
    }
    public void setNetworkIp(String networkIp)
    {
        this.networkIp = networkIp;
    }
    public String getNetworkIp()
    {
        return networkIp;
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
    public void setDeviceTemperature(BigDecimal deviceTemperature) { this.deviceTemperature = deviceTemperature; }
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
}
