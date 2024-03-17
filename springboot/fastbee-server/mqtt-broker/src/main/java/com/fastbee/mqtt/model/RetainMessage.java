package com.fastbee.mqtt.model;

import lombok.Builder;
import lombok.Data;

import java.io.Serializable;

/**
 * 保留消息bo
 * @author gsb
 * @date 2022/9/16 14:05
 */
@Data
@Builder
public class RetainMessage implements Serializable {

    /*主题*/
    private String topic;
    /*数据*/
    private byte[] message;
    /*消息质量*/
    private int qos;
}
