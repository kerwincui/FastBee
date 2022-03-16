package com.ruoyi.iot.model.ThingsModels;

import java.util.List;

/**
 * 设备输入物模型值参数
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModelValuesInput
{
    /** 产品ID **/
    private Long productId;

    private Long deviceId;

    /** 设备ID **/
    private String deviceNumber;

    /** 设备物模型值的字符串格式 **/
    private String stringValue;

    /** 设备物模型值的集合 **/
    private List<ThingsModelValueRemarkItem> thingsModelValueRemarkItem;

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getStringValue() {
        return stringValue;
    }

    public void setStringValue(String stringValue) {
        this.stringValue = stringValue;
    }

    public String getDeviceNumber() {
        return deviceNumber;
    }

    public void setDeviceNumber(String deviceNumber) {
        this.deviceNumber = deviceNumber;
    }

    public List<ThingsModelValueRemarkItem> getThingsModelValueRemarkItem() {
        return thingsModelValueRemarkItem;
    }

    public void setThingsModelValueRemarkItem(List<ThingsModelValueRemarkItem> thingsModelValueRemarkItem) {
        this.thingsModelValueRemarkItem = thingsModelValueRemarkItem;
    }
}
