package com.fastbee.mqtt.handler;

import com.fastbee.mqtt.annotation.Process;
import com.fastbee.mqtt.handler.adapter.MqttHandler;
import com.fastbee.mqtt.manager.ClientManager;
import com.fastbee.mqtt.service.IMessageStore;
import com.fastbee.base.session.Session;
import com.fastbee.base.util.AttributeUtils;
import com.fastbee.mqtt.utils.MqttMessageUtils;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.MqttMessage;
import io.netty.handler.codec.mqtt.MqttMessageIdVariableHeader;
import io.netty.handler.codec.mqtt.MqttMessageType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 消息等级=Qos2 发布消息完成
 * @author bill
 */
@Process(type = MqttMessageType.PUBCOMP)
@Slf4j
public class MqttPubcomp implements MqttHandler {

    @Autowired
    private IMessageStore messageStore;

    @Override
    public void handler(ChannelHandlerContext ctx, MqttMessage message){
        MqttMessageIdVariableHeader variableHeader = MqttMessageUtils.getIdVariableHeader(message);
        Session session = AttributeUtils.getSession(ctx.channel());
        //获取packetId
        int messageId = variableHeader.messageId();
        messageStore.removeRelOutMsg(messageId);
        /*更新平台ping*/
        ClientManager.updatePing(session.getClientId());
    }
}
