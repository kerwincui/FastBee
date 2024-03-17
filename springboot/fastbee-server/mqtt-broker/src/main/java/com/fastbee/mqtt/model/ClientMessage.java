package com.fastbee.mqtt.model;

import io.netty.handler.codec.mqtt.MqttQoS;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author gsb
 * @date 2022/10/7 19:04
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClientMessage {

    /*共享主题客户端id，不为空则指定客户端发送*/
    private String sharedClientId;
    /*客户端id*/
    private String clientId;
    /*消息质量*/
    private MqttQoS qos;
    /*topic*/
    private String topicName;
    /*是否保留消息*/
    private boolean retain;
    /*数据*/
    private byte[] payload;

    private int messageId;
    /*是否是遗嘱消息*/
    private boolean willFlag;
    /*是否是dup消息*/
    private boolean dup;


    public static ClientMessage of(MqttQoS qos,String topicName,boolean retain, byte[] payload){
        return new ClientMessage(null,null,qos,topicName,retain,payload,0,false,false);
    }

    public static ClientMessage of(String clientId,MqttQoS qos,String topicName,boolean retain){
        return new ClientMessage(null,clientId,qos,topicName,retain,null,0,false,false);
    }

}
