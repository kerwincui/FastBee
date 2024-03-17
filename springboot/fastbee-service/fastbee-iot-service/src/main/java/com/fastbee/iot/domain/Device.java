package com.fastbee.iot.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 设备对象 iot_device
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@ApiModel(value = "Device", description = "设备对象 iot_device")
public class Device extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备ID */
    @ApiModelProperty("设备ID")
    private Long deviceId;

    /** 设备名称 */
    @ApiModelProperty("设备名称")
    @Excel(name = "设备名称")
    private String deviceName;

    /** 产品ID */
    @ApiModelProperty("产品ID")
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @ApiModelProperty("产品名称")
    @Excel(name = "产品名称")
    private String productName;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户昵称 */
    @ApiModelProperty("用户昵称")
    @Excel(name = "用户昵称")
    private String userName;

    /** 租户ID */
    @ApiModelProperty("租户ID")
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @ApiModelProperty("租户名称")
    @Excel(name = "租户名称")
    private String tenantName;

    /** 设备编号 */
    @ApiModelProperty("设备编号")
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 固件版本 */
    @ApiModelProperty("固件版本")
    @Excel(name = "固件版本")
    private BigDecimal firmwareVersion;

    /** 设备类型（1-直连设备、2-网关设备、3-监控设备） */
    @ApiModelProperty("设备类型（1-直连设备、2-网关设备、3-监控设备）")
    private Integer deviceType;

    /** 设备状态（1-未激活，2-禁用，3-在线，4-离线） */
    @ApiModelProperty("设备状态（1-未激活，2-禁用，3-在线，4-离线）")
    @Excel(name = "设备状态")
    private Integer status;

    /** wifi信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]） */
    @ApiModelProperty("wifi信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]）")
    @Excel(name = "wifi信号强度")
    private Integer rssi;

    /** 设备影子 */
    @ApiModelProperty("是否启用设备影子(0=禁用，1=启用)")
    private Integer isShadow;

    /** 设备所在地址 */
    @ApiModelProperty("设备所在地址")
    @Excel(name = "设备所在地址")
    private String networkAddress;

    /** 设备入网IP */
    @ApiModelProperty("设备入网IP")
    @Excel(name = "设备入网IP")
    private String networkIp;

    /** 设备经度 */
    @ApiModelProperty("设备经度")
    @Excel(name = "设备经度")
    private BigDecimal longitude;

    /** 设备纬度 */
    @ApiModelProperty("设备纬度")
    @Excel(name = "设备纬度")
    private BigDecimal latitude;

    /** 激活时间 */
    @ApiModelProperty("激活时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "激活时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date activeTime;

    /** 子设备网关编号 */
    @ApiModelProperty("子设备网关编号")
    @Excel(name = "网关设备编号(子设备使用)")
    private String gwDevCode;

    /** 物模型值 */
    @ApiModelProperty("物模型值")
    @Excel(name = "物模型")
    private String thingsModelValue;

    /** 图片地址 */
    @ApiModelProperty("图片地址")
    private String imgUrl;

    /** 是否自定义位置 **/
    @ApiModelProperty("定位方式(1=ip自动定位，2=设备定位，3=自定义)")
    private Integer locationWay;

    /** 设备摘要 **/
    @ApiModelProperty("设备摘要")
    private String summary;

    /** 分组ID，用于分组查询 **/
    @ApiModelProperty("分组ID，用于分组查询")
    private Long groupId;

    /** 是否设备所有者，用于查询 **/
    @ApiModelProperty("是否设备所有者，用于查询")
    private Integer isOwner;
    /**子设备数量*/
    @ApiModelProperty("子设备数量")
    private Integer subDeviceCount;
    /**是否是模拟设备*/
    @ApiModelProperty("是否是模拟设备")
    private Integer isSimulate;
    /**子设备地址*/
    @ApiModelProperty("子设备地址")
    private Integer slaveId;
    /**设备传输协议*/
    @ApiModelProperty("设备传输协议")
    private String transport;

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public Integer getSlaveId() {
        return slaveId;
    }

    public void setSlaveId(Integer slaveId) {
        this.slaveId = slaveId;
    }

    public Integer getIsSimulate() {
        return isSimulate;
    }

    public void setIsSimulate(Integer isSimulate) {
        this.isSimulate = isSimulate;
    }

    private List<Device> subDeviceList;

    public List<Device> getSubDeviceList() {
        return subDeviceList;
    }

    public void setSubDeviceList(List<Device> subDeviceList) {
        this.subDeviceList = subDeviceList;
    }

    public Integer getSubDeviceCount() {
        return subDeviceCount;
    }

    public void setSubDeviceCount(Integer subDeviceCount) {
        this.subDeviceCount = subDeviceCount;
    }

    public String getGwDevCode() {
        return gwDevCode;
    }

    public void setGwDevCode(String gwDevCode) {
        this.gwDevCode = gwDevCode;
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

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getIsShadow() {
        return isShadow;
    }

    public void setIsShadow(Integer isShadow) {
        this.isShadow = isShadow;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
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
    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public Long getProductId()
    {
        return productId;
    }
    public void setProductName(String productName)
    {
        this.productName = productName;
    }

    public String getProductName()
    {
        return productName;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserName()
    {
        return userName;
    }
    public void setTenantId(Long tenantId)
    {
        this.tenantId = tenantId;
    }

    public Long getTenantId()
    {
        return tenantId;
    }
    public void setTenantName(String tenantName)
    {
        this.tenantName = tenantName;
    }

    public String getTenantName()
    {
        return tenantName;
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
    public void setStatus(Integer status)
    {
        this.status = status;
    }
    public void setDeviceType(Integer deviceType)
    {
        this.deviceType = deviceType;
    }

    public Integer getDeviceType()
    {
        return deviceType;
    }
    public Integer getStatus()
    {
        return status;
    }
    public void setRssi(Integer rssi)
    {
        this.rssi = rssi;
    }

    public Integer getRssi()
    {
        return rssi;
    }
    public void setThingsModelValue(String thingsModelValue)
    {
        this.thingsModelValue = thingsModelValue;
    }

    public String getThingsModelValue()
    {
        return thingsModelValue;
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
    public void setLongitude(BigDecimal longitude)
    {
        this.longitude = longitude;
    }

    public BigDecimal getLongitude()
    {
        return longitude;
    }
    public void setLatitude(BigDecimal latitude)
    {
        this.latitude = latitude;
    }

    public BigDecimal getLatitude()
    {
        return latitude;
    }
    public void setActiveTime(Date activeTime)
    {
        this.activeTime = activeTime;
    }

    public Date getActiveTime()
    {
        return activeTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("deviceId", getDeviceId())
            .append("deviceName", getDeviceName())
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("tenantId", getTenantId())
            .append("tenantName", getTenantName())
            .append("serialNumber", getSerialNumber())
            .append("firmwareVersion", getFirmwareVersion())
            .append("status", getStatus())
            .append("rssi", getRssi())
            .append("networkAddress", getNetworkAddress())
            .append("networkIp", getNetworkIp())
            .append("longitude", getLongitude())
            .append("latitude", getLatitude())
            .append("activeTime", getActiveTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
