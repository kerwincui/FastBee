package com.fastbee.mqttclient;

import com.fastbee.common.utils.uuid.UUID;
import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * mqtt配置信息
 */

@Data
@Component
public class MqttClientConfig {
    public MqttClientConfig() {
        this.username = "fastbee";
        this.password = "fastbee";
        this.hostUrl = "tcp://127.0.0.1:1884";
        this.clientId = UUID.randomUUID().toString();
        this.defaultTopic = "test";
        this.timeout = 30;
        this.keepalive = 30;
        this.clearSession = true;
    }

    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 连接地址
     */
    private String hostUrl;
    /**
     * 客户Id
     */
    private String clientId;
    /**
     * 默认连接话题
     */
    private String defaultTopic;
    /**
     * 超时时间
     */
    private int timeout;
    /**
     * 保持连接数
     */
    private int keepalive;

    /**
     * 是否清除session
     */
    private boolean clearSession;
    /**
     * 是否共享订阅
     */
    private boolean isShared;
    /**
     * 分组共享订阅
     */
    private boolean isSharedGroup;

    /**
     * true: 使用netty搭建的mqttBroker  false: 使用emq
     */
    @Value("${server.broker.enabled}")
    private Boolean enabled;

}

