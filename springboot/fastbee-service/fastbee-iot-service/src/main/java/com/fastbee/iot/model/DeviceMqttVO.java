package com.fastbee.iot.model;

/**
 * MQTT连接相关参数实体类
 * @author fastb
 * @date 2023-08-02 17:09
 */
public class DeviceMqttVO {

    /**
     * 设备主键id
     */
    private Long deviceId;

    /**
     * 设备编号
     */
    private String serialNumber;

    /**
     * 产品id
     */
    private Long productId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * mqtt连接账号
     */
    private String mqttAccount;

    /**
     * mqtt连接密码
     */
    private String mqttPassword;

    /**
     * 产品密匙
     */
    private String mqttSecret;

    /**
     * 是否启用授权码（0-否，1-是）
     */
    private Integer isAuthorize;

    /**
     * 认证方式
     */
    private Integer vertificateMethod;

    public Integer getVertificateMethod() {
        return vertificateMethod;
    }

    public void setVertificateMethod(Integer vertificateMethod) {
        this.vertificateMethod = vertificateMethod;
    }

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public Integer getIsAuthorize() {
        return isAuthorize;
    }

    public void setIsAuthorize(Integer isAuthorize) {
        this.isAuthorize = isAuthorize;
    }
}
