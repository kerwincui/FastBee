package com.fastbee.mqtt.model;

import lombok.Data;

import java.io.Serializable;

/**
 * @author bill
 */
@Data
public class PushMessageBo implements Serializable {

    /*主题*/
    private String topic;
    /*数据*/
    private String message;
    /*消息质量*/
    private int qos;

    private Integer value;
    private Integer address;
    private Integer slaveId;
}
