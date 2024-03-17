package com.fastbee.mqtt.service;

import com.fastbee.mqtt.model.Subscribe;

import java.util.List;

/**
 * 订阅缓存
 * @author gsb
 * @date 2022/10/14 8:24
 */
public interface ISubscriptionService {

    /**
     * 保存客户订阅的主题
     *
     * @param subscribeList 客户订阅
     */
    void subscribe(List<Subscribe> subscribeList, String clientId);

    /**
     * 解除订阅
     *
     * @param clientId 客户id
     * @param topicName   主题
     */
    void unsubscribe(String clientId, String topicName);

    /**
     * 获取订阅了 topic 的客户id
     *
     * @param topic 主题
     * @return 订阅了主题的客户id列表
     */
    List<Subscribe> searchSubscribeClientList(String topic);




}
