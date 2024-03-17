package com.fastbee.iot.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.annotation.Excel;
import com.fastbee.iot.model.ThingsModelItem.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 设备对象 iot_device
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceShortOutput
{
    public DeviceShortOutput(){
        this.stringList=new ArrayList<>();
        this.integerList=new ArrayList<>();
        this.decimalList=new ArrayList<>();
        this.enumList=new ArrayList<>();
        this.arrayList=new ArrayList<>();
        this.readOnlyList =new ArrayList<>();
        this.boolList=new ArrayList<>();
    }

    private static final long serialVersionUID = 1L;

    /** 产品分类ID */
    private Long deviceId;

    /** 产品分类名称 */
    @Excel(name = "设备名称")
    private String deviceName;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 设备类型（1-直连设备、2-网关子设备、3-网关设备） */
    private Integer deviceType;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户昵称 */
    @Excel(name = "用户昵称")
    private String userName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    /** 设备编号 */
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 固件版本 */
    @Excel(name = "固件版本")
    private BigDecimal firmwareVersion;

    /** 设备状态（1-未激活，2-禁用，3-在线，4-离线） */
    @Excel(name = "设备状态")
    private Integer status;

    /** 设备影子 */
    private Integer isShadow;

    private Integer isSimulate;

    /** wifi信号强度（信号极好4格[-55— 0]，信号好3格[-70— -55]，信号一般2格[-85— -70]，信号差1格[-100— -85]） */
    @Excel(name = "wifi信号强度")
    private Integer rssi;

    @Excel(name = "物模型")
    private String thingsModelValue;

    /** 激活时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "激活时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date activeTime;

    /** 激活时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createTime;

    @Excel(name = "网关设备编号(子设备使用)")
    private String gwDevCode;

    /** 是否自定义位置 **/
    private Integer locationWay;

    /** 图片地址 */
    private String imgUrl;

    /** 是否设备所有者，用于查询 **/
    private Integer isOwner;


    /**子设备数量*/
    private Integer subDeviceCount;

    /**子设备地址*/
    private Integer slaveId;
    /*传输协议*/
    private String transport;
    /*设备通讯协议*/
    private String protocolCode;

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public String getProtocolCode() {
        return protocolCode;
    }

    public void setProtocolCode(String protocolCode) {
        this.protocolCode = protocolCode;
    }

    public Integer getSlaveId() {
        return slaveId;
    }

    public void setSlaveId(Integer slaveId) {
        this.slaveId = slaveId;
    }

    public Integer getSubDeviceCount() {
        return subDeviceCount;
    }

    public void setSubDeviceCount(Integer subDeviceCount) {
        this.subDeviceCount = subDeviceCount;
    }

    private List<ThingsModel> thingsModels;

    public List<ThingsModel> getThingsModels() {
        return thingsModels;
    }

    public void setThingsModels(List<ThingsModel> thingsModels) {
        this.thingsModels = thingsModels;
    }

    private List<StringModelOutput> stringList;
    private List<IntegerModelOutput> integerList;
    private List<DecimalModelOutput> decimalList;
    private List<EnumModelOutput> enumList;
    private List<ArrayModelOutput> arrayList;
    private List<BoolModelOutput> boolList;
    private List<ReadOnlyModelOutput> readOnlyList;

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
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

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Integer getIsSimulate() {
        return isSimulate;
    }

    public void setIsSimulate(Integer isSimulate) {
        this.isSimulate = isSimulate;
    }

    public Integer getIsShadow() {
        return isShadow;
    }

    public void setIsShadow(Integer isShadow) {
        this.isShadow = isShadow;
    }

    public List<BoolModelOutput> getBoolList() {
        return boolList;
    }

    public void setBoolList(List<BoolModelOutput> boolList) {
        this.boolList = boolList;
    }

    public List<ReadOnlyModelOutput> getReadOnlyList() {
        return readOnlyList;
    }

    public void setReadOnlyList(List<ReadOnlyModelOutput> readOnlyList) {
        this.readOnlyList = readOnlyList;
    }

    public List<StringModelOutput> getStringList() {
        return stringList;
    }

    public void setStringList(List<StringModelOutput> stringList) {
        this.stringList = stringList;
    }

    public List<IntegerModelOutput> getIntegerList() {
        return integerList;
    }

    public void setIntegerList(List<IntegerModelOutput> integerList) {
        this.integerList = integerList;
    }

    public List<DecimalModelOutput> getDecimalList() {
        return decimalList;
    }

    public void setDecimalList(List<DecimalModelOutput> decimalList) {
        this.decimalList = decimalList;
    }

    public List<EnumModelOutput> getEnumList() {
        return enumList;
    }

    public void setEnumList(List<EnumModelOutput> enumList) {
        this.enumList = enumList;
    }

    public List<ArrayModelOutput> getArrayList() {
        return arrayList;
    }

    public void setArrayList(List<ArrayModelOutput> arrayList) {
        this.arrayList = arrayList;
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
    public void setDeviceType(Integer deviceType)
    {
        this.deviceType = deviceType;
    }

    public Integer getDeviceType()
    {
        return deviceType;
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

    public void setStatus(Integer status)
    {
        this.status = status;
    }
    public Integer getStatus()
    {
        return status;
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

    public void setActiveTime(Date activeTime) 
    {
        this.activeTime = activeTime;
    }

    public Date getActiveTime() 
    {
        return activeTime;
    }

}
