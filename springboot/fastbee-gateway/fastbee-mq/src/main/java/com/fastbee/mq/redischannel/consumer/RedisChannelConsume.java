package com.fastbee.mq.redischannel.consumer;

import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.stereotype.Component;

/**
 * redisChannel消息监听
 *
 * @author gsb
 * @date 2022/10/10 9:17
 */
@Component
@Slf4j
public class RedisChannelConsume implements MessageListener {

    /**
     * 监听推送消息
     */
    @Override
    public void onMessage(Message message, byte[] pattern) {
        try {
            /*获取channel*/
            String channel = new String(message.getChannel());
            /*获取消息*/
            String body = new String(message.getBody());

        } catch (Exception e) {
            log.error("=>redisChannel处理消息异常,e", e);
        }
    }
}
