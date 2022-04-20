package com.ruoyi.iot.service.impl;

import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.sign.Md5Utils;
import me.zhyd.oauth.cache.AuthCacheConfig;
import me.zhyd.oauth.cache.AuthStateCache;
import me.zhyd.oauth.utils.AuthStateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * 扩展Redis版的state缓存
 *
 * @author json
 * @date 2022/04/12
 */
@Component
public class AuthStateRedisCache implements AuthStateCache {

    @Autowired
    private RedisCache redisCache;

    @Override
    public void cache(String key, String value) {
        redisCache.setCacheObject(key, getValue(value), (int) AuthCacheConfig.timeout, TimeUnit.MILLISECONDS);
    }

    @Override
    public void cache(String key, String value, long timeout) {
        redisCache.setCacheObject(key, getValue(value), (int) timeout, TimeUnit.MILLISECONDS);
    }

    @Override
    public String get(String key) {
        return redisCache.getCacheObject(key);
    }

    @Override
    public boolean containsKey(String key) {
        return redisCache.containsKey(key);
    }

    /**
     *  自定义state
     * @param oldState
     * @return state
     */
    private String getValue(String oldState) {
        return Md5Utils.hash(oldState + System.currentTimeMillis());
    }
}
