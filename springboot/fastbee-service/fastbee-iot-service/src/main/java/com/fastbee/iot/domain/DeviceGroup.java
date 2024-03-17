package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 设备分组对象 iot_device_group
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@ApiModel(value = "DeviceGroup", description = "设备分组对象 iot_device_group")
public class DeviceGroup
{
    private static final long serialVersionUID = 1L;

    /** 分组ID */
    @ApiModelProperty("分组ID")
    private Long groupId;

    /** 设备ID */
    @ApiModelProperty("设备ID")
    private Long deviceId;

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }


}
