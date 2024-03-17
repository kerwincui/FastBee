package com.fastbee.iot.model;


import com.fastbee.common.annotation.Excel;

public class ProductAuthenticateModel {
    /** 产品分类ID */
    private Long deviceId;

    /** 产品分类名称 */
    private String deviceName;

    /**设备状态（1-未激活，2-禁用，3-在线，4-离线）**/
    private int status;

    /** 产品ID */
    private Long productId;

    /** 产品名称 */
    private String productName;

    /** 产品状态 1-未发布，2-已发布 */
    private int productStatus;

    /** 是否启用授权码（0-否，1-是） */
    private Integer isAuthorize;

    /** 设备编号 */
    private String serialNumber;

    /** mqtt账号 */
    private String mqttAccount;

    /** mqtt密码 */
    private String mqttPassword;

    /** 产品秘钥 */
    private String mqttSecret;

    private int vertificateMethod;

    public int getVertificateMethod() {
        return vertificateMethod;
    }

    public void setVertificateMethod(int vertificateMethod) {
        this.vertificateMethod = vertificateMethod;
    }

    public Integer getIsAuthorize() {
        return isAuthorize;
    }

    public void setIsAuthorize(Integer isAuthorize) {
        this.isAuthorize = isAuthorize;
    }

    public int getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(int productStatus) {
        this.productStatus = productStatus;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getMqttAccount() {
        return mqttAccount;
    }

    public void setMqttAccount(String mqttAccount) {
        this.mqttAccount = mqttAccount;
    }

    public String getMqttPassword() {
        return mqttPassword;
    }

    public void setMqttPassword(String mqttPassword) {
        this.mqttPassword = mqttPassword;
    }

    public String getMqttSecret() {
        return mqttSecret;
    }

    public void setMqttSecret(String mqttSecret) {
        this.mqttSecret = mqttSecret;
    }
}
