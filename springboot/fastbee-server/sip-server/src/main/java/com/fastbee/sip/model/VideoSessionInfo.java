package com.fastbee.sip.model;

import com.fastbee.sip.enums.SessionType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class VideoSessionInfo {
    //流基本信息
    private String mediaServerId;
    private String deviceId;
    private String channelId;
    private String stream;
    private String ssrc;
    private int port;
    private String streamMode;
    private SessionType type;
    //流状态
    private boolean pushing;
    private boolean recording;
    private int onPlaytime;
    private int player;
    private boolean videoRecord;
    private boolean enable_fmp4;
    private boolean enable_hls;
    private boolean enable_rtmp;
    private boolean enable_rtsp;

    //录像信息
    String startTime;
    String endTime;
    int downloadSpeed;
}
