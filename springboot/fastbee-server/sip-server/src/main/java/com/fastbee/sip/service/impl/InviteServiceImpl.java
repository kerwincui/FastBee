package com.fastbee.sip.service.impl;

import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.sip.enums.SessionType;
import com.fastbee.sip.model.InviteInfo;
import com.fastbee.sip.model.VideoSessionInfo;
import com.fastbee.sip.service.IInviteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Slf4j
@Service
public class InviteServiceImpl implements IInviteService {
    @Autowired
    private RedisCache redisCache;

    @Override
    public void updateInviteInfo(VideoSessionInfo sinfo, InviteInfo inviteInfo) {
        InviteInfo invite = getInviteInfo(sinfo.getType(), sinfo.getDeviceId(),
                sinfo.getChannelId(), sinfo.getStream());
        if (invite == null) {
            log.info("[更新Invite信息]，未从缓存中读取到Invite信息： deviceId: {}, channel: {}, stream: {}",
                    sinfo.getDeviceId(), sinfo.getChannelId(), sinfo.getStream());
            invite = inviteInfo;
        }
        if (inviteInfo.getSsrc() != null) {
            invite.setSsrc(inviteInfo.getSsrc());
        }
        if (inviteInfo.getCallId() != null) {
            invite.setCallId(inviteInfo.getCallId());
        }
        if (inviteInfo.getPort() != 0) {
            invite.setPort(inviteInfo.getPort());
        }

        String key = RedisKeyBuilder.buildInviteCacheKey(
                sinfo.getType() != null ? sinfo.getType().name() : "*",
                sinfo.getDeviceId() != null ? sinfo.getDeviceId() : "*",
                sinfo.getChannelId() != null ? sinfo.getChannelId() : "*",
                sinfo.getStream() != null ? sinfo.getStream() : "*",
                inviteInfo.getSsrc() != null ? inviteInfo.getSsrc() : "*");
        redisCache.setCacheObject(key, invite);
    }

    @Override
    public InviteInfo getInviteInfo(SessionType type, String deviceId, String channelId, String stream) {
        String key = RedisKeyBuilder.buildInviteCacheKey(
                type != null ? type.name() : "*",
                deviceId != null ? deviceId : "*",
                channelId != null ? channelId : "*",
                stream != null ? stream : "*",
                "*");
        List<Object> scanResult = redisCache.scan(key);
        if (scanResult.isEmpty()) {
            return null;
        }
        if (scanResult.size() != 1) {
            log.warn("[获取InviteInfo] 发现 key: {}存在多条", key);
        }

        return (InviteInfo) redisCache.getCacheObject((String) scanResult.get(0));
    }

    @Override
    public List<InviteInfo> getInviteInfoAll(SessionType type, String deviceId, String channelId, String stream) {
        String key = RedisKeyBuilder.buildInviteCacheKey(
                type != null ? type.name() : "*",
                deviceId != null ? deviceId : "*",
                channelId != null ? channelId : "*",
                stream != null ? stream : "*",
                "*");
        List<Object> scanResult = redisCache.scan(key);
        if (scanResult.size() != 1) {
            log.warn("[获取InviteInfo] 发现 key: {}存在多条", key);
        }
        if (scanResult.size() > 0) {
            List<InviteInfo> list = new ArrayList<>();
            for (Object keyObj : scanResult) {
                list.add((InviteInfo) redisCache.getCacheObject((String) keyObj));
            }
            return list;
        } else {
            return Collections.emptyList();
        }
    }

    @Override
    public InviteInfo getInviteInfoBySSRC(String ssrc) {
        String key = RedisKeyBuilder.buildInviteCacheKey("*",
                "*",
                "*",
                "*",
                ssrc);
        List<Object> scanResult = redisCache.scan(key);
        if (scanResult.size() != 1) {
            return null;
        }
        return (InviteInfo) redisCache.getCacheObject((String) scanResult.get(0));
    }

    @Override
    public void removeInviteInfo(SessionType type, String deviceId, String channelId, String stream) {
        String scanKey = RedisKeyBuilder.buildInviteCacheKey(
                type != null ? type.name() : "*",
                deviceId != null ? deviceId : "*",
                channelId != null ? channelId : "*",
                stream != null ? stream : "*",
                "*");
        List<Object> scanResult = redisCache.scan(scanKey);
        if (scanResult.size() > 0) {
            for (Object keyObj : scanResult) {
                String key = (String) keyObj;
                InviteInfo inviteInfo = (InviteInfo) redisCache.getCacheObject(key);
                if (inviteInfo == null) {
                    continue;
                }
                redisCache.deleteObject(key);
            }
        }
    }
}
