package com.fastbee.mqtt.manager;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.base.session.Session;
import io.netty.handler.codec.mqtt.MqttPublishMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 客户端管理
 *
 * @author gsb
 * @date 2022/9/15 16:02
 */
@Slf4j
public class ClientManager {

    /*topic本地缓存*/
    public static Map<String, Map<String, Session>> topicMap = new ConcurrentHashMap<>();
    /*客户端最后一次ping时间，设备不正常断开判断*/
    private static Map<String, Long> pingMap = new ConcurrentHashMap<>();
    /*客户端与topic关联本地缓存*/
    public static Map<String, Map<String, Boolean>> clientTopicMap = new ConcurrentHashMap<>();

    /**
     * 将client的上下文相关信息添加到映射关系表中
     * @param topic 主题
     * @param session
     */
    public static void push(String topic, Session session) {
        try {
            /*处理topic对应的topic*/
            Map<String, Session> clientMap = topicMap.get(topic);
            if (StringUtils.isEmpty(clientMap)) {
                clientMap = new ConcurrentHashMap<>();
            }
            clientMap.put(session.getClientId(), session);
            topicMap.put(topic, clientMap);

            /*处理client对应的所有topic*/
            Map<String, Boolean> topicsMap = null;
            if (clientTopicMap.containsKey(session.getClientId())) {
                topicsMap = clientTopicMap.get(session.getClientId());
                if (!topicsMap.containsKey(topic)) {
                    topicsMap.put(topic, true);
                }
            } else {
                topicsMap = new HashMap<>();
                topicsMap.put(topic, true);
                clientTopicMap.put(session.getClientId(), topicsMap);
            }
        } catch (Exception e) {
            log.error("=>clientId映射topic出现异常:{},e=", e.getMessage(), e);
        }
    }

    /**
     * 清理对应client下的所有数据
     *
     * @param clientId 客户端id
     */
    public static void remove(String clientId) {
        try {
            /*移除client对应的topic*/
            Map<String, Boolean> topics = clientTopicMap.get(clientId);
            if (null != topics) {
                /*从topic中移除client*/
                for (String key : topics.keySet()) {
                    Map<String, Session> clientMap = topicMap.get(key);
                    if (CollectionUtils.isEmpty(clientMap)) {
                        continue;
                    }
                    clientMap.remove(clientId);
                }
                clientTopicMap.remove(clientId);
            }
            pingMap.remove(clientId);
        } catch (Exception e) {
            log.warn("=>移除client[{}]异常", e.getMessage());
        }
    }

    /**
     * 客户端取消订阅
     * 删除指定topic下的指定client
     *
     * @param topic   主题
     * @param session 客户端
     */
    public static void unsubscribe(String topic, Session session) {
        try {
            Map<String, Session> clientMap = topicMap.get(topic);
            if (StringUtils.isEmpty(clientMap)) {
                return;
            }
            Session s = clientMap.get(session.getClientId());
            if (null == s) {
                return;
            }
            clientMap.remove(session.getClientId());
        } catch (Exception e) {
            log.error("=>客户端取消订阅异常:{}", e.getMessage());
        }
    }

    /**
     * 将消息发送到指定topic下的所有client上去
     *
     * @param msg 推送消息
     */
    public static void pubTopic(MqttPublishMessage msg) {
        String topic = msg.variableHeader().topicName();
        List<String> topicList = TopicsUtils.searchTopic(topic);
        for (String itemTopic : topicList) {
            Map<String, Session> clientMap = topicMap.get(itemTopic);
            if (StringUtils.isEmpty(clientMap)) {
                continue;
            }
            for (Session session : clientMap.values()) {
                String clientId = session.getClientId();
                if (!validClient(clientId)) {
                    ///*ws的客户端不正常断开连接后，直接移除所有信息*/
                    //if (session.getClientId().startsWith(FastBeeConstant.SERVER.WS_PREFIX)) {
                    //    log.debug("=>移除ws客户端,clientId={}", session);
                    //    remove(clientId);
                    //}
                    log.warn("=>{}不在线", clientId);
                    continue;
                }
                ResponseManager.publishClients(msg, session);
            }
        }
    }

    /**
     * 更新客户端在线时间，给客户端发送消息时用这个看客户端最近是否在线
     * 用来判断设备不正常掉线没有应答服务器的情况
     *
     * @param clientId 客户端id
     */
    public static void updatePing(String clientId) {
        pingMap.put(clientId, DateUtils.getTimestamp());
    }

    /**
     * 平台判定设备状态 Ping客户端是否在线
     *
     * @param clientId 客户端id
     * @return 结果
     */
    public static Boolean validClient(String clientId) {
        long currTime = DateUtils.getTimestamp();
        /*获取客户端连接时，时间*/
        Long timestamp = pingMap.get(clientId);
        if (null == timestamp) {
            return false;
        }
        //当设备缓存的心跳时间大于 平台判断时间 1.5f  表示设备不正常断开了服务器
        if (currTime - timestamp > FastBeeConstant.SERVER.DEVICE_PING_EXPIRED) {
            //pingMap.remove(clientId);
            //SessionManger.removeClient(clientId);
            return false;
        }
        return true;
    }
}
