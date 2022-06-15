package com.ruoyi.iot.model;

/**
 * 用户ID和设备ID模型
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class UserIdDeviceIdModel
{
    private Long userId;

    private Long deviceId;

    public UserIdDeviceIdModel(Long userId, Long deviceId){
        this.userId=userId;
        this.deviceId=deviceId;
    }


    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }
}
