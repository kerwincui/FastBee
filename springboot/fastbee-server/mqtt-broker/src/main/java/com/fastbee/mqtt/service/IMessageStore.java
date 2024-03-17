package com.fastbee.mqtt.service;

import com.fastbee.mqtt.model.ClientMessage;

import java.util.List;
import java.util.Map;

/**
 * @author gsb
 * @date 2022/10/14 14:35
 */
public interface IMessageStore {

    /**
     * 存储控制包
     *
     * @param topic:         控制包所属主题
     * @param clientMessage: 需要存储的消息
     */
    void storeMessage(String topic, ClientMessage clientMessage);

    /**
     * 清除topic下的所有消息
     *
     * @param topic: 主题
     */
    void cleanTopic(String topic);

    /**
     * 根据clientId清除消息
     *
     * @param clientId: 客户端唯一标识
     */
    void removeMessage(String clientId);

    /**
     * 匹配主题过滤器，寻找对应消息
     *
     * @param topicFilter: 主题过滤器
     */
    List<ClientMessage> searchMessages(String topicFilter);

    /**
     * 保存 clientMessage
     *
     * @param messageId 消息id
     */
    public void savePubMsg(Integer messageId, ClientMessage clientMessage);

    /**
     * 移除
     *
     * @param messageId 消息id
     */
    public void removePubMsg(int messageId);

    /**
     * 保存 REL IN
     *
     * @param messageId 消息id
     */
    public void saveRelInMsg(int messageId);

    /**
     * 保存 REL OUT
     *
     * @param messageId 消息id
     */
    public void saveRelOutMsg(int messageId);

    /**
     * 移除
     *
     * @param messageId 消息id
     */
    public void removeRelInMsg(int messageId);

    /**
     * 移除
     *
     * @param messageId 消息id
     */
    public void removeRelOutMsg(int messageId);

    /**
     * 判断Rel out是否包含消息id
     */
    public boolean outRelContains(int messageId);

}
