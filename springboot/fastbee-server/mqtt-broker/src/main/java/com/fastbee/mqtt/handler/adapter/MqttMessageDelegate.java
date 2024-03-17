package com.fastbee.mqtt.handler.adapter;

import com.fastbee.common.exception.ServiceException;
import com.fastbee.mqtt.annotation.Process;
import com.fastbee.base.util.AttributeUtils;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.MqttMessage;
import io.netty.handler.codec.mqtt.MqttMessageType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * 消息代理类,根据注解{@link com.fastbee.mqtt.annotation.Process} 分发处理类
 * @author gsb
 * @date 2022/10/8 11:50
 */
@Component
@Slf4j
public class MqttMessageDelegate {
    /**mqtt报文类型为key，报文处理类为值*/
    private final Map<MqttMessageType, MqttHandler> processor = new HashMap<>();

    public MqttMessageDelegate(List<MqttHandler> handlers){
        if (CollectionUtils.isEmpty(handlers)){
            throw new ServiceException("报文处理类为空");
        }
        /*将处理类缓存到map*/
        handlers.forEach(handler ->{
            Process annotation = handler.getClass().getAnnotation(Process.class);
            Optional.ofNullable(annotation)
                    .map(Process::type)
                    .ifPresent(messageType ->processor.put(messageType,handler));
        });
    }

    /**
     * 匹配报文处理类
     */
    public void process(ChannelHandlerContext ctx, MqttMessage message){
        /*获取固定头的报文类型*/
        MqttMessageType messageType = message.fixedHeader().messageType();

        /*处理客户端连接时，先判断Attribute是否存储Session*/
        if (MqttMessageType.CONNECT != messageType &&
           AttributeUtils.getSession(ctx.channel()) == null){
            log.error("=>客户端未连接");
            throw new ServiceException("客户端未连接");
        }
        Optional.of(processor.get(messageType))
                .ifPresent(mqttHandler -> mqttHandler.handler(ctx,message));
    }
}
