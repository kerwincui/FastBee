package com.fastbee.mqtt.handler;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.mqtt.annotation.Process;
import com.fastbee.mqtt.auth.AuthService;
import com.fastbee.mqtt.handler.adapter.MqttHandler;
import com.fastbee.mqtt.manager.ResponseManager;
import com.fastbee.mqtt.manager.SessionManger;
import com.fastbee.mqtt.manager.WillMessageManager;
import com.fastbee.mqtt.model.WillMessage;
import com.fastbee.base.session.Session;
import com.fastbee.base.util.AttributeUtils;
import com.fastbee.mqtt.utils.MqttMessageUtils;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.*;
import io.netty.util.CharsetUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.net.InetSocketAddress;


@Slf4j
@Process(type = MqttMessageType.CONNECT)
public class MqttConnect implements MqttHandler {

    @Autowired
    private AuthService authService;
    @Resource
    private RedisCache redisCache;

    @Override
    public void handler(ChannelHandlerContext ctx, MqttMessage message) {
        MqttConnectMessage connectMessage = (MqttConnectMessage) message;
        /*获取客户端Id*/
        String clientId = connectMessage.payload().clientIdentifier();
        if (clientId.contains("&")){
            clientId =  clientId.split("&")[1];
        }
        log.debug("=>客户端:{} 连接:{}", clientId, message);
        /*获取session*/
        Session session = new Session();
        /*mqtt版本*/
        MqttVersion version = MqttVersion.fromProtocolNameAndLevel(connectMessage.variableHeader().name(), (byte) connectMessage.variableHeader().version());
        boolean cleanSession = connectMessage.variableHeader().isCleanSession();
        session.setHandlerContext(ctx);
        session.setVersion(version);
        session.setClientId(clientId);
        session.setCleanSession(cleanSession);
        session.setUsername(connectMessage.payload().userName());
        session.setConnected_at(DateUtils.getNowDate());
        InetSocketAddress socketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        session.setIp(socketAddress.getAddress().getHostAddress());
        session.setServerType(ServerType.MQTT);
        /*设置客户端ping时间*/
        MqttConnectVariableHeader header = connectMessage.variableHeader();
        if (header.keepAliveTimeSeconds() > 0 && session.getKeepAliveMax() >= header.keepAliveTimeSeconds()) {
            session.setKeepAlive(header.keepAliveTimeSeconds());
        }
        /*mqtt客户端登录校验*/
        if (!check(session, connectMessage)) {
            log.error("=>客户端:{},连接异常", clientId);
            session.getHandlerContext().close();
            return;
        }

        /*保存ClientId 和 session 到Attribute*/
        AttributeUtils.setClientId(ctx.channel(), clientId);
        AttributeUtils.setSession(ctx.channel(), session);
        SessionManger.removeClient(clientId);
        session.setConnected(true);

        SessionManger.buildSession(clientId, session);
        handleWill(connectMessage);
        ResponseManager.responseMessage(session,
                MqttMessageFactory.newMessage(
                        new MqttFixedHeader(MqttMessageType.CONNACK, false, MqttQoS.AT_MOST_ONCE, false, 0x02),
                        new MqttConnAckVariableHeader(MqttConnectReturnCode.CONNECTION_ACCEPTED, false),
                        null),
                true
        );
    }

    /**
     * 遗嘱消息处理
     *
     * @param message 连接消息
     */
    private void handleWill(MqttConnectMessage message) {
        /*如果没有设置处理遗嘱消息，返回*/
        if (!message.variableHeader().isWillFlag()) {
            return;
        }
        /*生成客户端model*/
        MqttPublishMessage publishMessage = (MqttPublishMessage) MqttMessageFactory.newMessage(
                new MqttFixedHeader(MqttMessageType.PUBLISH, false,
                        MqttQoS.valueOf(message.variableHeader().willQos()),
                        message.variableHeader().isWillRetain(), 0),
                new MqttPublishVariableHeader(message.payload().willTopic(), 0),
                Unpooled.buffer().writeBytes(message.payload().willMessageInBytes()));

        WillMessage msg = new WillMessage(message.payload().clientIdentifier(),
                message.variableHeader().isCleanSession(), message.payload().willTopic(), publishMessage);
        WillMessageManager.push(msg);
    }

    /**
     * 客户端连接校验
     *
     * @param session 客户端
     * @param message 连接消息
     * @return 结果
     */
    private boolean check(Session session, MqttConnectMessage message) {
        /*获取客户端连接地址*/
        InetSocketAddress address = (InetSocketAddress) session.getHandlerContext().channel().remoteAddress();
        String host = address.getAddress().getHostAddress();
        /*webSocket客户端 系统内部客户端不校验*/
        String clientId = message.payload().clientIdentifier();
        /*根据用户名，密码校验*/
        String username = message.payload().userName();
        String password = message.payload().passwordInBytes() == null ? null : new String(message.payload().passwordInBytes(), CharsetUtil.UTF_8);
        /*验证失败，应答客户端*/
        if (!authService.auth(clientId, username, password)) {
            MqttConnAckMessage connAckMessage = MqttMessageUtils.buildConntAckMessage(MqttConnectReturnCode.CONNECTION_REFUSED_BAD_USER_NAME_OR_PASSWORD, false);
            ResponseManager.responseMessage(session, connAckMessage, true);
            return false;
        }
        return true;
    }

}
