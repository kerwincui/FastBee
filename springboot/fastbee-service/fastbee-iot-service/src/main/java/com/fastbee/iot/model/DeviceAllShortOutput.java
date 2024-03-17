package com.fastbee.iot.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 设备对象 iot_device
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceAllShortOutput
{
    private static final long serialVersionUID = 1L;

    /** 产品分类ID */
    private Long deviceId;

    /** 产品分类名称 */
    private String deviceName;

    /** 产品名称 */
    private String productName;

    /** 设备类型（1-直连设备、2-网关子设备、3-网关设备） */
    private Integer deviceType;

    /** 用户昵称 */
    private String userName;

    /** 设备编号 */
    private String serialNumber;

    /** 固件版本 */
    private BigDecimal firmwareVersion;

    /** 设备状态（1-未激活，2-禁用，3-在线，4-离线） */
    private Integer status;

    /** 设备影子 */
    private Integer isShadow;

    /** wifi信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]） */
    private Integer rssi;

    /** 激活时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date activeTime;

    /** 是否自定义位置 **/
    private Integer locationWay;

    /** 设备地址 */
    private String networkAddress;

    /** 经度 */
    private BigDecimal longitude;

    /** 纬度 */
    private BigDecimal latitude;

    /** 是否设备所有者，用于查询 **/
    private Integer isOwner;

    private Integer subDeviceCount;

    public Integer getSubDeviceCount() {
        return subDeviceCount;
    }

    public void setSubDeviceCount(Integer subDeviceCount) {
        this.subDeviceCount = subDeviceCount;
    }

    public Integer getLocationWay() {
        return locationWay;
    }

    public void setLocationWay(Integer locationWay) {
        this.locationWay = locationWay;
    }

    public Integer getIsOwner() {
        return isOwner;
    }

    public void setIsOwner(Integer isOwner) {
        this.isOwner = isOwner;
    }

    public String getNetworkAddress() {
        return networkAddress;
    }

    public void setNetworkAddress(String networkAddress) {
        this.networkAddress = networkAddress;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public void setLongitude(BigDecimal longitude) {
        this.longitude = longitude;
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public void setLatitude(BigDecimal latitude) {
        this.latitude = latitude;
    }

    public Integer getIsShadow() {
        return isShadow;
    }

    public void setIsShadow(Integer isShadow) {
        this.isShadow = isShadow;
    }

    public void setRssi(Integer rssi)
    {
        this.rssi = rssi;
    }

    public Integer getRssi()
    {
        return rssi;
    }

    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId()
    {
        return deviceId;
    }
    public void setDeviceName(String deviceName)
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName()
    {
        return deviceName;
    }

    public void setProductName(String productName)
    {
        this.productName = productName;
    }

    public String getProductName()
    {
        return productName;
    }
    public void setDeviceType(Integer deviceType)
    {
        this.deviceType = deviceType;
    }

    public Integer getDeviceType()
    {
        return deviceType;
    }
    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }
    public Integer getStatus()
    {
        return status;
    }

    public void setSerialNumber(String serialNumber)
    {
        this.serialNumber = serialNumber;
    }

    public String getSerialNumber()
    {
        return serialNumber;
    }
    public void setFirmwareVersion(BigDecimal firmwareVersion)
    {
        this.firmwareVersion = firmwareVersion;
    }

    public BigDecimal getFirmwareVersion()
    {
        return firmwareVersion;
    }

    public void setActiveTime(Date activeTime)
    {
        this.activeTime = activeTime;
    }

    public Date getActiveTime()
    {
        return activeTime;
    }

}
