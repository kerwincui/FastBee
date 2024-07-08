package com.fastbee.sip.server;

import com.fastbee.sip.domain.SipDevice;

public interface IRtspCmd {
    void playPause(SipDevice device, String channelId, String streamId);
    void playReplay(SipDevice device, String channelId, String streamId);
    void playBackSeek(SipDevice device, String channelId, String streamId, long seektime);
    void playBackSpeed(SipDevice device, String channelId, String streamId, Integer speed);
    void setCseq(String streamId);
}
