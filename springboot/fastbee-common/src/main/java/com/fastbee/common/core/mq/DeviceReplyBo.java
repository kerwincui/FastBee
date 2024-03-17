package com.fastbee.common.core.mq;

import lombok.Data;

/**
 * @author bill
 */
@Data
public class DeviceReplyBo {

    /*设备下发消息id*/
    private String messageId;
    /*标识符*/
    private String id;
    /**下发值*/
    private String value;
}
