package com.fastbee.mqtt.server;

import com.fastbee.server.Server;
import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.mqtt.codec.WebSocketMqttCodec;
import com.fastbee.mqtt.handler.adapter.MqttMessageAdapter;
import io.netty.bootstrap.AbstractBootstrap;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.codec.http.HttpContentCompressor;
import io.netty.handler.codec.http.HttpObjectAggregator;
import io.netty.handler.codec.http.HttpServerCodec;
import io.netty.handler.codec.http.websocketx.WebSocketServerProtocolHandler;
import io.netty.handler.codec.mqtt.MqttDecoder;
import io.netty.handler.codec.mqtt.MqttEncoder;
import io.netty.handler.timeout.IdleStateHandler;
import io.netty.util.concurrent.DefaultThreadFactory;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author gsb
 * @date 2022/9/15 14:23
 */
@Component
@Slf4j
public class WebSocketServer extends Server {

    @Autowired
    private WebSocketMqttCodec webSocketMqttCodec;
    @Autowired
    private MqttMessageAdapter mqttMessageAdapter;


    @Override
    protected AbstractBootstrap initialize() {
        bossGroup = new NioEventLoopGroup();
        workerGroup = new NioEventLoopGroup();
        return new ServerBootstrap()
                .group(bossGroup, workerGroup)
                .channel(NioServerSocketChannel.class)
                .childHandler(new ChannelInitializer<SocketChannel>() {

                    @Override
                    public void initChannel(SocketChannel ch) {
                        ch.pipeline()
                                .addFirst(FastBeeConstant.WS.HEART_BEAT
                                        , new IdleStateHandler(0, 0, 70))
                                /*http请求响应*/
                                .addLast(FastBeeConstant.WS.HTTP_SERVER_CODEC, new HttpServerCodec())
                                /*聚合header与body组成完整的Http请求，最大数据量为1Mb*/
                                .addLast(FastBeeConstant.WS.AGGREGATOR, new HttpObjectAggregator(1024 * 1024))
                                /*压缩出站数据*/
                                .addLast(FastBeeConstant.WS.COMPRESSOR, new HttpContentCompressor())
                                /*WebSocket协议配置mqtt*/
                                .addLast(FastBeeConstant.WS.PROTOCOL, new WebSocketServerProtocolHandler("/mqtt",
                                        "mqtt,mqttv3.1,mqttv3.1.1,mqttv5.0", true, 65536))
                                .addLast(FastBeeConstant.WS.MQTT_WEBSOCKET, webSocketMqttCodec)
                                .addLast(FastBeeConstant.WS.DECODER, new MqttDecoder())
                                .addLast(FastBeeConstant.WS.ENCODER, MqttEncoder.INSTANCE)
                                .addLast(FastBeeConstant.WS.BROKER_HANDLER, mqttMessageAdapter);
                    }
                });
    }
}
