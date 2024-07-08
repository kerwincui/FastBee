package com.fastbee.sip.service;

import com.fastbee.sip.enums.Direct;

public interface IPtzCmdService {
    public boolean directPtzCmd(String deviceId, String channelId, Direct direct, Integer speed);
}
