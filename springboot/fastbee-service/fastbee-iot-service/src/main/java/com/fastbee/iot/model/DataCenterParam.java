package com.fastbee.iot.model;

import lombok.Data;

/**
 * @author fastb
 * @version 1.0
 * @description: 数据中心统一传参类
 * @date 2024-06-19 17:07
 */
@Data
public class DataCenterParam {

    /**
     * 设备编号
     */
    private String serialNumber;

    /**
     * 开始时间
     */
    private String beginTime;

    /**
     * 结束时间
     */
    private String endTime;

}
