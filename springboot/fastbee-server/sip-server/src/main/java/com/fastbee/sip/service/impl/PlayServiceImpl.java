package com.fastbee.sip.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.fastbee.sip.domain.MediaServer;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.model.Stream;
import com.fastbee.sip.model.VideoSessionInfo;
import com.fastbee.sip.server.IRtspCmd;
import com.fastbee.sip.server.ISipCmd;
import com.fastbee.sip.server.VideoSessionManager;
import com.fastbee.sip.service.*;
import com.fastbee.sip.util.ZlmApiUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class PlayServiceImpl implements IPlayService {

    @Autowired
    private ISipCmd sipCmd;

    @Autowired
    private IRtspCmd rtspCmd;

    @Autowired
    private IZmlHookService zmlHookService;

    @Autowired
    private VideoSessionManager streamSession;

    @Autowired
    private ISipDeviceService sipDeviceService;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private ZlmApiUtils zlmApiUtils;

    @Override
    public Stream play(String deviceId, String channelId, boolean record) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        if (dev == null) {
            log.error("play dev is null,deviceId:{},channelId:{}", deviceId, channelId);
            return null;
        }
        String streamid;
        if (record) {
            streamid = String.format("gb_playrecord_%s_%s", deviceId, channelId);
        } else {
            streamid = String.format("gb_play_%s_%s", deviceId, channelId);
        }
        VideoSessionInfo sinfo = streamSession.getSessionInfo(deviceId, channelId, streamid, null);
        if (sinfo == null) {
            VideoSessionInfo info = sipCmd.playStreamCmd(dev, channelId, record);
            return zmlHookService.updateStream(info);
        } else {
            log.info("sinfo： {}", sinfo);
            MediaServer mediaInfo = mediaServerService.selectMediaServerBydeviceSipId(deviceId);
            JSONObject rtpInfo = zlmApiUtils.getRtpInfo(mediaInfo, streamid);
            if (rtpInfo.getInteger("code") == 0) {
                if (rtpInfo.getBoolean("exist") && rtpInfo.getInteger("local_port") != 0) {
                    //直播
                    if (sinfo.isPushing() && !record) {
                        return zmlHookService.updateStream(sinfo);
                    }
                    //直播录像
                    if (sinfo.isRecording() && record) {
                        return zmlHookService.updateStream(sinfo);
                    }
                }
            }
            //清理会话后 重新发起播放
            sipCmd.streamByeCmd(dev, channelId, streamid, null);
            VideoSessionInfo info = sipCmd.playStreamCmd(dev, channelId, record);
            return zmlHookService.updateStream(info);
        }
    }

    @Override
    public String closeStream(String deviceId, String channelId, String streamId) {
        MediaServer mediaInfo = mediaServerService.selectMediaServerBydeviceSipId(deviceId);
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        JSONObject ret = zlmApiUtils.getMediaList(mediaInfo, "rtp", "rtmp", streamId);
        int code = ret.getInteger("code");
        if (code == 0) {
            int readerCount = ret.getInteger("readerCount");
            log.info("还有{}位用户正在观看该流！", readerCount);
            if (readerCount < 2) {
                sipCmd.streamByeCmd(dev, channelId, streamId, null);
            }
        } else {
            log.info("流详细信息：{}，错误码：{}", ret, code);
        }
        return "";
    }

    @Override
    public Stream playback(String deviceId, String channelId, String startTime, String endTime) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        VideoSessionInfo info = sipCmd.playbackStreamCmd(dev, channelId, startTime, endTime);
        return zmlHookService.updateStream(info);
    }

    @Override
    public String playbackPause(String deviceId, String channelId, String streamId) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        VideoSessionInfo sinfo = streamSession.getSessionInfo(deviceId, channelId, streamId, null);
        if (null == sinfo) {
            return "streamId不存在";
        }
        rtspCmd.setCseq(sinfo.getStream());
        rtspCmd.playPause(dev, channelId, streamId);
        return null;
    }

    @Override
    public String playbackReplay(String deviceId, String channelId, String streamId) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        VideoSessionInfo sinfo = streamSession.getSessionInfo(deviceId, channelId, streamId, null);
        if (null == sinfo) {
            return "streamId不存在";
        }
        rtspCmd.setCseq(streamId);
        rtspCmd.playReplay(dev, channelId, streamId);
        return null;
    }

    @Override
    public String playbackSeek(String deviceId, String channelId, String streamId, long seektime) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        VideoSessionInfo sinfo = streamSession.getSessionInfo(deviceId, channelId, streamId, null);
        if (null == sinfo) {
            return "streamId不存在";
        }
        rtspCmd.setCseq(streamId);
        rtspCmd.playBackSeek(dev, channelId, streamId, seektime);
        return null;
    }

    @Override
    public String playbackSpeed(String deviceId, String channelId, String streamId, Integer speed) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        VideoSessionInfo sinfo = streamSession.getSessionInfo(deviceId, channelId, streamId, null);
        if (null == sinfo) {
            return "streamId不存在";
        }
        rtspCmd.setCseq(streamId);
        rtspCmd.playBackSpeed(dev, channelId, streamId, speed);
        return null;
    }
}
