package com.ruoyi.iot.model;

/**
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceNumberAndProductId
{
    /** 产品ID，用于自动添加设备 */
    private Long productId;

    /** 设备编号集合 */
    private String deviceNumber;

    public DeviceNumberAndProductId(){}

    public DeviceNumberAndProductId(Long productId, String deviceNumber){
        this.productId=productId;
        this.deviceNumber=deviceNumber;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getDeviceNumber() {
        return deviceNumber;
    }

    public void setDeviceNumber(String deviceNumber) {
        this.deviceNumber = deviceNumber;
    }
}
