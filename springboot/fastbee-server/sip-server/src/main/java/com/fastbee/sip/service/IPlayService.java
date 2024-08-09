package com.fastbee.sip.service;

import com.fastbee.sip.model.Stream;

public interface IPlayService {
    Stream play(String deviceId, String channelId, boolean record);
    String closeStream(String deviceId, String channelId, String streamId);
}
