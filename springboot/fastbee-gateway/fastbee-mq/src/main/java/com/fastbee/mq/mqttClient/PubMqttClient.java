package com.fastbee.mq.mqttClient;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.enums.FunctionReplyStatus;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.iot.domain.FunctionLog;
import com.fastbee.iot.service.IFunctionLogService;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 发布服务mqtt客户端
 */
@Component
@Slf4j
public class PubMqttClient {

    @Resource
    private MqttClientConfig mqttConfig;
    @Resource(name = "pubMqttCallBack")
    private PubMqttCallBack mqttCallBack;
    /**
     * 连接配置
     */
    private MqttConnectOptions options;
    /**
     * MQTT异步客户端
     */
    private MqttAsyncClient client;
    /**
     * 是否连接标记
     */
    private boolean isConnected = false;
    @Resource
    private RedisCache redisCache;
    @Resource
    private IFunctionLogService functionLogService;

    /**
     * 启动MQTT客户端
     */
    public synchronized void initialize() {

        try {
            setOptions();
            createClient();
            while (!client.isConnected()) {
                IMqttToken token = client.connect(options);
                if(token != null && token.isComplete()) {
                    log.debug("=>内部MQTT客户端启动成功");
                    this.isConnected = true;
                    break;
                }
                log.debug("=>内部mqtt客户端连接中...");
                Thread.sleep(20000);
            }
        } catch (MqttException ex) {
            log.error("=>MQTT客户端初始化异常", ex);
        } catch (Exception e) {
            log.error("=>连接MQTT服务器异常", e);
            this.isConnected = false;
        }

    }

    public boolean isConnected() {
        return this.isConnected;
    }

    private void createClient() {
        try {
            if (client == null) {
                /*host为主机名，clientId是连接MQTT的客户端ID*/
                client = new MqttAsyncClient(mqttConfig.getHostUrl(), getClientId(), new MemoryPersistence());
                //设置回调函数
                client.setCallback(mqttCallBack);
                mqttCallBack.setClient(client);
                mqttCallBack.setOptions(this.options);
                mqttCallBack.setEnabled(mqttConfig.getEnabled());
            }
        } catch (Exception e) {
            log.error("=>mqtt客户端创建错误");
        }
    }

    /**
     * 设置连接属性
     */
    private void setOptions() {

        if (options != null) {
            options = null;
        }
        options = new MqttConnectOptions();
        options.setConnectionTimeout(mqttConfig.getTimeout());
        options.setKeepAliveInterval(mqttConfig.getKeepalive());
        options.setUserName(mqttConfig.getUsername());
        options.setPassword(mqttConfig.getPassword().toCharArray());
        //设置自动重新连接
        options.setAutomaticReconnect(true);
            /*设置为false，断开连接，不清除session，重连后还是原来的session
              保留订阅的主题，能接收离线期间的消息*/
        options.setCleanSession(true);
    }

    /**
     * 断开与mqtt的连接
     */
    public synchronized void disconnect() {
        //判断客户端是否null 是否连接
        if (client != null && client.isConnected()) {
            try {
                IMqttToken token = client.disconnect();
                token.waitForCompletion();
            } catch (MqttException e) {
                log.error("=>断开mqtt连接发生错误 message={}", e.getMessage());
                throw new ServiceException("断开mqtt连接发生错误" + e.getMessage());
            }
        }
        client = null;
    }

    /**
     * 重新连接MQTT
     */
    public synchronized void refresh() {
        disconnect();
        initialize();
    }

    /**
     * 拼接客户端id
     */
    public final String getClientId() {
        return FastBeeConstant.SERVER.WM_PREFIX + System.currentTimeMillis();
    }

    /**
     * 发布qos=1，非持久化
     */
    public void publish(String topic, byte[] pushMessage, FunctionLog log) {
        try {
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SEND_TOTAL, -1L);
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SEND_TODAY, 60 * 60 * 24);
            publish(pushMessage, topic, false, 0);
            if (null != log) {
                //存储服务下发成功
                log.setResultMsg(FunctionReplyStatus.NORELY.getMessage());
                log.setResultCode(FunctionReplyStatus.NORELY.getCode());
                functionLogService.insertFunctionLog(log);
            }
        } catch (Exception e) {
            if (null != log) {
                //服务下发失败存储
                log.setResultMsg(FunctionReplyStatus.FAIl.getMessage() + "原因: " + e.getMessage());
                log.setResultCode(FunctionReplyStatus.FAIl.getCode());
                functionLogService.insertFunctionLog(log);
            }
        }
    }

    /**
     * 发布主题
     *
     * @param message  payload消息体
     * @param topic    主题
     * @param retained 是否保留消息
     * @param qos      消息质量
     *                 Qos1：消息发送一次，不确保
     *                 Qos2：至少分发一次，服务器确保接收消息进行确认
     *                 Qos3：只分发一次，确保消息送达和只传递一次
     */
    public void publish(byte[] message, String topic, boolean retained, int qos) {
        //设置mqtt消息
        MqttMessage mqttMessage = new MqttMessage();
        mqttMessage.setQos(qos);
        mqttMessage.setRetained(retained);
        mqttMessage.setPayload(message);

        IMqttDeliveryToken token;
        try {
            token = client.publish(topic, mqttMessage);
            token.waitForCompletion();
        } catch (MqttPersistenceException e) {
            log.error("=>发布主题时发生错误 topic={},message={}", topic, e.getMessage());
            throw new ServiceException(e.getMessage());
        } catch (MqttException ex) {
            throw new ServiceException(ex.getMessage());
        }
    }


    /**
     * 发布
     *
     * @param qos         连接方式
     * @param retained    是否保留
     * @param topic       主题
     * @param pushMessage 消息体
     */
    public void publish(int qos, boolean retained, String topic, String pushMessage) {
        redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SEND_TOTAL, -1L);
        redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SEND_TODAY, 60 * 60 * 24);
        log.info("发布主题[{}],发布消息[{}]" + topic,pushMessage);
        MqttMessage message = new MqttMessage();
        message.setQos(qos);
        message.setRetained(retained);
        message.setPayload(pushMessage.getBytes());

        try {
            IMqttDeliveryToken token = client.publish(topic, message);
            token.waitForCompletion();
        } catch (MqttPersistenceException e) {
            e.printStackTrace();
        } catch (MqttException e) {
            log.error("=>发布主题时发生错误 topic={},message={}", topic, e.getMessage());
        }
    }

}
