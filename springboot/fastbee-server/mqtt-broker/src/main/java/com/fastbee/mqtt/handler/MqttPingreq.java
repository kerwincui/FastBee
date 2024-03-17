package com.fastbee.mqtt.handler;

import com.fastbee.mqtt.annotation.Process;
import com.fastbee.mqtt.handler.adapter.MqttHandler;
import com.fastbee.mqtt.manager.ClientManager;
import com.fastbee.mqtt.manager.ResponseManager;
import com.fastbee.base.util.AttributeUtils;
import com.fastbee.mqtt.utils.MqttMessageUtils;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.*;
import lombok.extern.slf4j.Slf4j;

/**
 * 客户端Ping消息应答
 *
 * @author bill
 */
@Slf4j
@Process(type = MqttMessageType.PINGREQ)
public class MqttPingreq implements MqttHandler {

    @Override
    public void handler(ChannelHandlerContext ctx, MqttMessage message) {
        /*获取客户端id*/
        String clientId = AttributeUtils.getClientId(ctx.channel());
        try {
            // log.debug("=>客户端:{},心跳信息", clientId);
            /*更新客户端ping时间*/
            ClientManager.updatePing(clientId);
            /*响应设备的ping消息*/
            MqttMessage pingResp = MqttMessageUtils.buildPingResp();
            ResponseManager.sendMessage(pingResp, clientId, true);
        } catch (Exception e) {
            log.error("=>客户端:{},ping异常:{}", clientId, e);
        }
    }
}
