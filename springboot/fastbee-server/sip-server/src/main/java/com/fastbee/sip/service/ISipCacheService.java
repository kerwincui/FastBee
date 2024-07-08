package com.fastbee.sip.service;

import com.fastbee.sip.model.RecordList;
import com.fastbee.sip.model.Stream;
import com.fastbee.sip.model.ZlmMediaServer;

public interface ISipCacheService {
    Long getCSEQ(String serverSipId);

    void startPlay(Stream stream);

    Stream queryStreamByStreamId(String streamId);

    Stream queryPlayByDevice(String deviceId, String channelId, boolean record);

    void startPlayback(Stream stream);

    Stream queryPlaybackByStreamId(String streamId);
    Stream queryPlaybackByDevice(String deviceId, String channelId);

    void startDownload(Stream stream);

    Stream queryDownloadByStreamId(String streamId);
    Stream queryDownloadByDevice(String deviceId, String channelId);

    boolean stopStream(String streamId);

    void updateMediaInfo(ZlmMediaServer mediaServerConfig);

    void setRecordList(String key, RecordList recordList);
}
