package com.fastbee.sip.service.impl;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.sip.model.ZlmMediaServer;
import com.fastbee.sip.service.ISipCacheService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class SipCacheServiceImpl implements ISipCacheService {

    @Autowired
    private RedisCache redisCache;

    @Override
    public Long getCSEQ(String serverSipId) {
        String key = RedisKeyBuilder.buildSipCSEQCacheKey(serverSipId);
        long result = redisCache.incr(key, 1L);
        if (result > Integer.MAX_VALUE) {
            redisCache.setCacheObject(key, 1);
            result = 1;
        }
        return result;
    }

    @Override
    public void updateMediaInfo(ZlmMediaServer mediaServerConfig) {
        redisCache.setCacheObject(FastBeeConstant.REDIS.DEFAULT_MEDIA_CONFIG, mediaServerConfig);
    }
}
