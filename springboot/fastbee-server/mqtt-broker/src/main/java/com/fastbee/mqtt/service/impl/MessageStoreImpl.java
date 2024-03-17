package com.fastbee.mqtt.service.impl;

import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.mqtt.model.ClientMessage;
import com.fastbee.mqtt.service.IMessageStore;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Retain will Qos12消息存储接口 -TODO 后续Redis处理
 *
 * @author gsb
 * @date 2022/10/14 14:35
 */
@Service
public class MessageStoreImpl implements IMessageStore {


    /**
     * 存储消息,保留消息，遗留消息
     */
    private final Map<String, ClientMessage> willOrRetainMap = new ConcurrentHashMap<>();

    /**
     * Qos2 Pub消息
     */
    private final Map<Integer, ClientMessage> publishMap = new ConcurrentHashMap<>();
    /**
     * Qos2 REL IN消息
      */
    private final Set<Integer> outRelSet = new HashSet<>();

    /**
     * Qos2 REL out
     */
    private final Set<Integer> inRelSet = new HashSet<>();

    /**
     * 存储控制包
     *
     * @param topic:         控制包所属主题
     * @param clientMessage: 需要存储的消息
     */
    @Override
    public void storeMessage(String topic, ClientMessage clientMessage) {
        willOrRetainMap.put(topic, clientMessage);
    }

    /**
     * 清除topic下的所有消息
     *
     * @param topic: 主题
     */
    @Override
    public void cleanTopic(String topic) {
        willOrRetainMap.remove(topic);
    }

    /**
     * 根据clientId清除消息
     *
     * @param clientId: 客户端唯一标识
     */
    @Override
    public void removeMessage(String clientId) {
        for (Map.Entry<String, ClientMessage> entry : willOrRetainMap.entrySet()) {
            if (entry.getValue().getClientId().equals(clientId)) {
                willOrRetainMap.remove(entry.getKey());
            }
        }
    }

    /**
     * 匹配主题过滤器，匹配消息
     *
     * @param topicFilter: 主题过滤器
     */
    @Override
    public List<ClientMessage> searchMessages(String topicFilter) {
        List<ClientMessage> messageList = new ArrayList<>();
        for (String topic : willOrRetainMap.keySet()) {
            if (TopicsUtils.matchTopic(topic, topicFilter)) {
                messageList.add(willOrRetainMap.get(topic));
            }
        }
        return messageList;
    }

    /**
     * 保存 clientMessage
     *
     * @param messageId 消息id
     */
    @Override
    public void savePubMsg(Integer messageId, ClientMessage clientMessage){
        publishMap.put(messageId,clientMessage);
    }

    /**
     * 移除
     *
     * @param messageId 消息id
     */
    @Override
    public void removePubMsg(int messageId){
        publishMap.remove(messageId);
    }

    /**
     * 保存 REL IN
     *
     * @param messageId 消息id
     */
    @Override
    public void saveRelInMsg(int messageId){
        inRelSet.add(messageId);
    }

    /**
     * 保存 REL OUT
     *
     * @param messageId 消息id
     */
    @Override
    public void saveRelOutMsg(int messageId){
        outRelSet.add(messageId);
    }

    /**
     * 移除
     *
     * @param messageId 消息id
     */
    @Override
    public void removeRelInMsg(int messageId){
        inRelSet.remove(messageId);
    }

    /**
     * 移除
     *
     * @param messageId 消息id
     */
    @Override
    public void removeRelOutMsg(int messageId){
        outRelSet.remove(messageId);
    }

    /**
     * 判断Rel out是否包含消息id
     */
    @Override
    public boolean outRelContains(int messageId){
       return outRelSet.contains(messageId);
    }

}
