package com.fastbee.iot.ruleEngine;

import com.fastbee.common.core.redis.RedisCache;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 规则引擎上下文执行方法
 * @author gsb
 * @date 2024/2/2 14:19
 */
@Component
@Slf4j
public class MsgContextService {

    private final RedisCache redisCache;

    public MsgContextService(RedisCache redisCache){
        this.redisCache = redisCache;
    }

    private void process(String serialNumber){
        //执行的业务逻辑
    }
}
