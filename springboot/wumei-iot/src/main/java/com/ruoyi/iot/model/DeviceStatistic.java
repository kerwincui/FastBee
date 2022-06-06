package com.ruoyi.iot.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * id和name
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceStatistic
{
    /** 设备数量 **/
    private Long deviceCount;

    /** 产品数量 **/
    private Long productCount;

    /** 告警 **/
    private Long alertCount;

    /** 属性上报 **/
    private Long propertyCount;

    /** 功能上报 **/
    private Long functionCount;

    /** 事件上报 **/
    private Long eventCount;

    /** 监测数据上报 **/
    private Long monitorCount;

    public Long getMonitorCount() {
        return monitorCount;
    }

    public void setMonitorCount(Long monitorCount) {
        this.monitorCount = monitorCount;
    }

    public Long getDeviceCount() {
        return deviceCount;
    }

    public void setDeviceCount(Long deviceCount) {
        this.deviceCount = deviceCount;
    }

    public Long getProductCount() {
        return productCount;
    }

    public void setProductCount(Long productCount) {
        this.productCount = productCount;
    }

    public Long getAlertCount() {
        return alertCount;
    }

    public void setAlertCount(Long alertCount) {
        this.alertCount = alertCount;
    }

    public Long getPropertyCount() {
        return propertyCount;
    }

    public void setPropertyCount(Long propertyCount) {
        this.propertyCount = propertyCount;
    }

    public Long getFunctionCount() {
        return functionCount;
    }

    public void setFunctionCount(Long functionCount) {
        this.functionCount = functionCount;
    }

    public Long getEventCount() {
        return eventCount;
    }

    public void setEventCount(Long eventCount) {
        this.eventCount = eventCount;
    }
}
