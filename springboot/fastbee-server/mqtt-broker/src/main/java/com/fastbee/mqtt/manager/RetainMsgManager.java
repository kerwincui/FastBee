package com.fastbee.mqtt.manager;

import com.fastbee.mqtt.model.RetainMessage;
import io.netty.handler.codec.mqtt.MqttPublishMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@Slf4j
@Component
public class RetainMsgManager {

    /*保存topic的retain消息*/
    private static Map<String, RetainMessage> retainMap = new ConcurrentHashMap<>();

    /**
     * 推送保留信息到订阅客户端
     *
     * @param message 推送消息
     */
    public static void pushMessage(MqttPublishMessage message) {
        if (null == message || !message.fixedHeader().isRetain()) {
            return;
        }
        byte[] bytes = new byte[message.payload().readableBytes()];
        if (bytes.length > 0) {
            RetainMessage retainMsg = RetainMessage.builder()
                    .topic(message.variableHeader().topicName())
                    .qos(message.fixedHeader().qosLevel().value()).message(bytes).build();
            retainMap.put(message.variableHeader().topicName(), retainMsg);
        } else {
            retainMap.remove(message.variableHeader().topicName());
        }
    }

    public static Integer getSize() {
        return retainMap.size();
    }

    /**
     * 获取消息
     *
     * @param topic 主题
     * @return 消息
     */
    public static RetainMessage getRetain(String topic) {
        return retainMap.get(topic);
    }

}
