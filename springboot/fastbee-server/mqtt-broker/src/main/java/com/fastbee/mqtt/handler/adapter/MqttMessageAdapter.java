package com.fastbee.mqtt.handler.adapter;

import com.fastbee.common.exception.iot.MqttAuthorizationException;
import com.fastbee.common.exception.iot.MqttClientUserNameOrPassException;
import com.fastbee.mqtt.manager.SessionManger;
import com.fastbee.base.util.AttributeUtils;
import com.fastbee.mqtt.utils.MqttMessageUtils;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.mqtt.*;
import io.netty.handler.timeout.IdleState;
import io.netty.handler.timeout.IdleStateEvent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.Optional;

/**
 * @author gsb
 * @date 2022/9/15 10:34
 */
@Slf4j
@Component
@ChannelHandler.Sharable
public class MqttMessageAdapter extends SimpleChannelInboundHandler<MqttMessage> {


    //    @Autowired
    private MqttMessageDelegate messageDelegate;

    public MqttMessageAdapter(MqttMessageDelegate delegate) {
        this.messageDelegate = delegate;
    }

    /**
     * 客户端上报消息处理
     *
     * @param context 上下文
     * @param message 消息
     */
    @Override
    @SuppressWarnings("ThrowableResultOfMethodCallIgnored")
    protected void channelRead0(ChannelHandlerContext context, MqttMessage message) {
        try {
            /*校验消息*/
            if (message.decoderResult().isFailure()) {
                exceptionCaught(context, message.decoderResult().cause());
                return;
            }
            messageDelegate.process(context, message);
        }catch (Exception e){
            log.error("=>数据进栈异常",e);
        }
    }

    /**
     * 客户端心跳处理
     */
    @Override
    public void userEventTriggered(ChannelHandlerContext ctx, Object evt) throws Exception {
        InetSocketAddress socketAddress = (InetSocketAddress) ctx.channel().remoteAddress();
        String host = socketAddress.getAddress().getHostAddress();
        int port = socketAddress.getPort();
        String clientId = AttributeUtils.getClientId(ctx.channel());
        if (evt instanceof IdleStateEvent) {
            IdleStateEvent idleStateEvent = (IdleStateEvent) evt;
            IdleState state = idleStateEvent.state();
            if (state == IdleState.ALL_IDLE || state == IdleState.READER_IDLE || state == IdleState.WRITER_IDLE) {
                log.error("客户端id[{}] 客户端[{}]port:[{}]心跳超时!",clientId, host, port);
                /*关闭通道*/
                ctx.close();
            }
        } else {
            super.userEventTriggered(ctx, evt);
        }
    }

    /**
     * 处理消息异常情况
     */
    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        log.error("=>mqtt连接异常",cause);
    }

}
