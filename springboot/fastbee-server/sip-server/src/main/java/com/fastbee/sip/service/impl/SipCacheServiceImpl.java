package com.fastbee.sip.service.impl;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.sip.model.RecordList;
import com.fastbee.sip.model.Stream;
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
    public Stream queryStreamByStreamId(String streamId) {
        String key = RedisKeyBuilder.buildStreamCacheKey(streamId);
        return (Stream) redisCache.getCacheObject(key);
    }

    @Override
    public void startPlay(Stream stream) {
        String key = RedisKeyBuilder.buildStreamCacheKey(stream.getStreamId());
        redisCache.setCacheObject(key, stream);
    }

    @Override
    public boolean stopStream(String streamId) {
        String key = RedisKeyBuilder.buildStreamCacheKey(streamId);
        return redisCache.deleteObject(key);
    }

    @Override
    public Stream queryPlayByDevice(String deviceId, String channelId, boolean record) {
        String streamId;
        streamId = String.format("gb_play_%s_%s", deviceId, channelId);
        String key = RedisKeyBuilder.buildStreamCacheKey(streamId);
        return (Stream) redisCache.getCacheObject(key);
    }

    @Override
    public void startPlayback(Stream stream) {
        String key = RedisKeyBuilder.buildStreamCacheKey(stream.getStreamId());
        redisCache.setCacheObject(key, stream);
    }

    @Override
    public Stream queryPlaybackByStreamId(String streamId) {
        String key = RedisKeyBuilder.buildStreamCacheKey(streamId);
        return (Stream) redisCache.getCacheObject(key);
    }

    @Override
    public Stream queryPlaybackByDevice(String deviceId, String channelId) {
        return null;
    }

    @Override
    public void startDownload(Stream stream) {
        String key = RedisKeyBuilder.buildStreamCacheKey(stream.getStreamId());
        redisCache.setCacheObject(key, stream);
    }

    @Override
    public Stream queryDownloadByStreamId(String streamId) {
        String key = RedisKeyBuilder.buildStreamCacheKey(streamId);
        return (Stream) redisCache.getCacheObject(key);
    }

    @Override
    public Stream queryDownloadByDevice(String deviceId, String channelId) {
        return null;
    }

    @Override
    public void updateMediaInfo(ZlmMediaServer mediaServerConfig) {
        redisCache.setCacheObject(FastBeeConstant.REDIS.DEFAULT_MEDIA_CONFIG, mediaServerConfig);
    }

    @Override
    public void setRecordList(String key, RecordList recordList) {
        String catchkey = RedisKeyBuilder.buildSipRecordinfoCacheKey(key);
        redisCache.setCacheObject(catchkey, recordList);
    }
}
