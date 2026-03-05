package com.fastbee.iot.model;

import lombok.Data;

import java.util.List;

/**
 * @author fastb
 * @version 1.0
 * @description: 设备历史数据参数
 * @date 2024-06-13 15:15
 */
@Data
public class DeviceHistoryParam {

    /**
     * 设备id
     */
    private Long deviceId;

    /**
     * 设备编号
     */
    private String serialNumber;


    private List<IdentifierVO> identifierList;

    private String identifierStr;

    /** 查询用的开始时间 */
    private String beginTime;

    /** 查询用的结束时间 */
    private String endTime;

    @Data
    public static class IdentifierVO {

        private String identifier;

        private Integer type;

    }
}
