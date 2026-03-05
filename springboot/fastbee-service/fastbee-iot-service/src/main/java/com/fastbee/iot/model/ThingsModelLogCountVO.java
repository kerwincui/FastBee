package com.fastbee.iot.model;

import lombok.Data;

/**
 * @author fastb
 * @version 1.0
 * @description: 统计物模型日志数量
 * @date 2024-06-17 11:36
 */
@Data
public class ThingsModelLogCountVO {

    private String identifier;

    private String modelName;

    private Integer counts;
}
