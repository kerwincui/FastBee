package com.fastbee.sip.model;

import com.alibaba.fastjson.JSONArray;
import lombok.Data;

@Data
public class Stream {
    private String app;
    private String deviceID;
    private String channelId;
    private String ssrc;
    private String streamId;
    private String ip;
    private String playurl;
    private String mediaServerId;
    private JSONArray tracks;
    private String startTime;
    private String endTime;
    private boolean pause;

    private String flv;
    private String https_flv;
    private String ws_flv;
    private String fmp4;
    private String https_fmp4;
    private String ws_fmp4;
    private String hls;
    private String https_hls;
    private String ws_hls;
    private String rtmp;
    private String rtsp;
    private String rtc;

    public Stream(String deviceSipId, String channelId, String streamId, String ssrc) {
        this.deviceID = deviceSipId;
        this.channelId = channelId;
        this.streamId = streamId;
        this.ssrc = ssrc;
    }
    public Stream() {}
}
