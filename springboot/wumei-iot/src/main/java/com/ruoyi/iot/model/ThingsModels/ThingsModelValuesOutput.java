package com.ruoyi.iot.model.ThingsModels;

import com.ruoyi.common.annotation.Excel;

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

    /** 用户ID */
    private Long userId;

    /** 用户昵称 */
    private String userName;

    /** 租户ID */
    private Long tenantId;

    /** 租户名称 */
    private String tenantName;

    /** 设备物模型值 **/
    private String thingsModelValue;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Long getTenantId() {
        return tenantId;
    }

    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

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
