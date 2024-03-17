package com.fastbee.iot.model.dto;

import lombok.Data;

/**
 * 设备实时数据dto
 * @author gsb
 * @date 2023/2/1 15:55
 */
@Data
public class DeviceRtDto {

    /**物模型名称*/
    private String modelName;
    /**值*/
    private String value;
    /**标识符*/
    private String identifier;
    /**数据定义*/
    private String specs;
    /**寄存器地址*/
    private String regAddr;
    /**数据类型*/
    private String dataType;
    /**更新时间*/
    private String platformTime;


}
