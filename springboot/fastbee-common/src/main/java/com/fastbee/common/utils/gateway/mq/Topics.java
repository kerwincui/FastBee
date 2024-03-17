package com.fastbee.common.utils.gateway.mq;

import lombok.Data;

/**
 * @author bill
 */
@Data
public class Topics {


    private String topicName;
    private Integer qos =0;
    private String desc;

}
