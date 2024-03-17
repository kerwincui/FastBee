package com.fastbee.iot.model.dashBoard;

import lombok.Builder;
import lombok.Data;

/**
 * @author gsb
 * @date 2023/3/27 17:05
 */
@Data
@Builder
public class DashMqttStat {

    /**当前连接数*/
    private Integer connection_count;
    /**连接总数*/
    private Integer connection_total;
    /**会话数量*/
    private Integer session_count;
    /**会话总数*/
    private Integer session_total;
    /**当前订阅主题总数*/
    private Integer subscription_count;
    /**总订阅总数*/
    private Integer subscription_total;
    /**当前保留消息*/
    private Integer retain_count;
    /**总保留信息数*/
    private Integer retain_total;

}
