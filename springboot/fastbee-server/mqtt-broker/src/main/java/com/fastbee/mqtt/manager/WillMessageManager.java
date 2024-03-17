package com.fastbee.mqtt.manager;

import com.fastbee.mqtt.model.WillMessage;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@Slf4j
public class WillMessageManager {

    private static Map<String, WillMessage> map = new ConcurrentHashMap<>();

    public static void push(WillMessage message){
        map.put(message.getClientId(),message);
    }

    public static void pop(String clientId){
        try {
            WillMessage message = map.get(clientId);
            if (null == message){
                return;
            }
            ClientManager.pubTopic(message.getMessage());
        }catch (Exception e){
            log.error("=>发送客户端[{}],遗嘱消息异常",e.getMessage(),e);
        }
    }
}
