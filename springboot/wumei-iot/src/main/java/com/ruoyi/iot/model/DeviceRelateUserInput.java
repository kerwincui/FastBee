package com.ruoyi.iot.model;

import java.util.List;

/**
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceRelateUserInput
{

    /** 用户Id */
    private Long userId;

    /** 设备编号和产品ID集合 */
    private List<DeviceNumberAndProductId> deviceNumberAndProductIds;

    public DeviceRelateUserInput(){}

    public DeviceRelateUserInput(Long userId,List<DeviceNumberAndProductId> deviceNumberAndProductIds){
        this.userId=userId;
        this.deviceNumberAndProductIds=deviceNumberAndProductIds;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public List<DeviceNumberAndProductId> getDeviceNumberAndProductIds() {
        return deviceNumberAndProductIds;
    }

    public void setDeviceNumberAndProductIds(List<DeviceNumberAndProductId> deviceNumberAndProductIds) {
        this.deviceNumberAndProductIds = deviceNumberAndProductIds;
    }
}
