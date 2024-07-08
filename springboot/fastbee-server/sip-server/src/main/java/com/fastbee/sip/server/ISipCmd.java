package com.fastbee.sip.server;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.model.VideoSessionInfo;

public interface ISipCmd {
    VideoSessionInfo playStreamCmd(SipDevice device, String channelId, boolean record);
    VideoSessionInfo playbackStreamCmd(SipDevice device, String channelId, String startTime, String endTime);
    VideoSessionInfo downloadStreamCmd(SipDevice device, String channelId, String startTime, String endTime, int downloadSpeed);
    void streamByeCmd(SipDevice device, String channelId, String stream, String ssrc);
    void streamByeCmd(String deviceId, String channelId, String stream, String ssrc);
}
