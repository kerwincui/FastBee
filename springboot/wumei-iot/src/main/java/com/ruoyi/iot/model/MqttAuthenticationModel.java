package com.ruoyi.iot.model;

/**
 * 动作
 * @author kerwincui
 * @date 2021-12-16
 */
public class MqttAuthenticationModel
{
    /** Mqtt客户端ID */
    String clientId;

    /** Mqtt用户名 */
    String userName;

    /** Mqtt密码 */
    String password;

    /** 设备编号 */
    String deviceNumber;

    /** 产品ID */
    Long productId;

    /** 设备关联的用户ID */
    Long userId;

    public MqttAuthenticationModel(String clientid,String username,String password,String deviceNumber ,Long productId,Long userId){
        this.clientId=clientid;
        this.userName=username;
        this.password=password;
        this.deviceNumber=deviceNumber;
        this.productId=productId;
        this.userId=userId;
    }
    public MqttAuthenticationModel(String clientid,String username,String password){
        this.clientId=clientid;
        this.userName=username;
        this.password=password;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDeviceNumber() {
        return deviceNumber;
    }

    public void setDeviceNumber(String deviceNumber) {
        this.deviceNumber = deviceNumber;
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
}
