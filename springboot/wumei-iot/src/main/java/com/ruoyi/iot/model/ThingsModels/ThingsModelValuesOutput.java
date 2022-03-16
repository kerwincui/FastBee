package com.ruoyi.iot.model.ThingsModels;

/**
 * 设备输入物模型值参数
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModelValuesOutput
{
    /** 产品ID **/
    private Long productId;

    private String productName;

    private Long deviceId;

    private String deviceName;

    private int status;

    private int isShadow;

    /** 设备ID **/
    private String serialNumber;

    /** 设备物模型值 **/
    private String thingsModelValue;

    public int getIsShadow() {
        return isShadow;
    }

    public void setIsShadow(int isShadow) {
        this.isShadow = isShadow;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getThingsModelValue() {
        return thingsModelValue;
    }

    public void setThingsModelValue(String thingsModelValue) {
        this.thingsModelValue = thingsModelValue;
    }
}
