package com.fastbee.iot.service.cache.impl;

import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.iot.service.cache.IFirmwareCache;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * 固件版本缓存
 * @author gsb
 * @date 2022/10/25 11:37
 */
@Service
@Slf4j
public class FirmwareCacheImpl implements IFirmwareCache {

    @Autowired
    private RedisCache redisCache;

    /**
     * 固件版本缓存
     * @param firmwareId 固件ID
     * @param urlName 升级URL
     * @return
     */
    @Override
    public void setFirmwareCache(Long firmwareId,String urlName){
        String cachedKey = RedisKeyBuilder.buildFirmwareCachedKey(firmwareId);
        redisCache.setCacheObject(cachedKey,urlName,60*60*12, TimeUnit.SECONDS);
    }

    /**
     * 获取固件版本信息
     * @param firmwareId 固件ID
     * @return 升级URL
     */
    @Override
    public String getFirmwareCache(Long firmwareId){
        String cachedKey = RedisKeyBuilder.buildFirmwareCachedKey(firmwareId);
        return redisCache.getCacheObject(cachedKey);
    }

    /**
     * 移除固件版本
     * @param firmwareId 固件id
     */
    @Override
    public void remove(Long firmwareId){
        String cachedKey = RedisKeyBuilder.buildFirmwareCachedKey(firmwareId);
        redisCache.deleteObject(cachedKey);
    }
}
