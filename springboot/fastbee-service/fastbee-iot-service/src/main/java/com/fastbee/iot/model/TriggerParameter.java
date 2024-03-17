package com.fastbee.iot.model;

import com.fastbee.common.annotation.Excel;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.ibatis.annotations.Param;

/**
 * TriggerParameter
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class TriggerParameter
{
    /** 物模型标识符数组 */
    private String[] ids;

    /** 产品ID */
    private Long productId;

    /** 设备ID */
    private Long deviceId;

    /** 设备编号 */
    private String serialNumber;

    /** 触发源（1=设备触发，2=定时触发） */
    private Integer source;

    /** 类型：1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线**/
    private Integer type;

    /**场景状态 （1-启动，2-停止） **/
    private Integer status;

    public Integer getSource() {
        return source;
    }

    public void setSource(Integer source) {
        this.source = source;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String[] getIds() {
        return ids;
    }

    public void setIds(String[] ids) {
        this.ids = ids;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
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
}
