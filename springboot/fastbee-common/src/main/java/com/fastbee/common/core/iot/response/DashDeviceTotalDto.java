package com.fastbee.common.core.iot.response;

import lombok.Data;

/**
 * 大屏设备总览数据
 * @author bill
 */
@Data
public class DashDeviceTotalDto {

    /*设备总数*/
    private Integer total;
    /*在线设备总数*/
    private Integer onlineCount;
    /*离线设备总数*/
    private Integer OfflineCount;
    /*未激活设备数*/
    private Integer unActiveCount;


}
