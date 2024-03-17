package com.fastbee.bootstrap.mqtt;

import com.fastbee.mqtt.server.MqttServer;
import com.fastbee.mqtt.server.WebSocketServer;
import com.fastbee.server.Server;
import com.fastbee.server.config.NettyConfig;
import com.fastbee.common.enums.ServerType;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

/**
 * MQTT-BROKER启动
 * @author gsb
 * @date 2022/9/17 17:25
 */
@Order(10)
@Configuration
@ConfigurationProperties(value = "server.broker")
@Data
public class MQTTBootStrap {

    @Autowired
    private MqttServer mqttServer;
    @Autowired
    private WebSocketServer webSocketServer;
    /*服务器集群节点*/
    private String brokerNode;
    /*端口*/
    private int port;
    /*心跳时间*/
    private int keepAlive;
    /*webSocket端口*/
    private int websocketPort;
    /*webSocket路由*/
    private String websocketPath;


    /**
     * 启动mqttBroker
     * @return server
     */
    @ConditionalOnProperty(value = "server.broker.enabled", havingValue = "true")
    @Bean(initMethod = "start", destroyMethod = "stop")
    public Server mqttBroker() {
        return NettyConfig.custom()
                .setIdleStateTime(0,0,keepAlive)
                .setName(ServerType.MQTT.getDes())
                .setType(ServerType.MQTT)
                .setPort(port)
                .setServer(mqttServer)
                .build();
    }

    @ConditionalOnProperty(value = "server.broker.enabled", havingValue = "true")
    @Bean(initMethod = "start",destroyMethod = "stop")
    public Server webSocket(){
        return NettyConfig.custom()
                .setIdleStateTime(0,0,keepAlive)
                .setName(ServerType.WEBSOCKET.getDes())
                .setType(ServerType.WEBSOCKET)
                .setPort(websocketPort)
                .setServer(webSocketServer)
                .build();
    }
}
