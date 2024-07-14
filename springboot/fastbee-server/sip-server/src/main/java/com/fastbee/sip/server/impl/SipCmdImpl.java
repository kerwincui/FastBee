package com.fastbee.sip.server.impl;

import com.fastbee.sip.domain.MediaServer;
import com.fastbee.sip.domain.SipConfig;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.enums.SessionType;
import com.fastbee.sip.model.InviteInfo;
import com.fastbee.sip.model.VideoSessionInfo;
import com.fastbee.sip.server.ISipCmd;
import com.fastbee.sip.server.ReqMsgHeaderBuilder;
import com.fastbee.sip.server.VideoSessionManager;
import com.fastbee.sip.service.IInviteService;
import com.fastbee.sip.service.IMediaServerService;
import com.fastbee.sip.service.ISipConfigService;
import com.fastbee.sip.service.ISipDeviceService;
import com.fastbee.sip.util.SipUtil;
import com.fastbee.sip.util.ZlmApiUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import javax.sip.*;
import javax.sip.message.Request;
import java.text.ParseException;
import java.util.List;


@Slf4j
@Component
public class SipCmdImpl implements ISipCmd {

    @Autowired
    private VideoSessionManager streamSession;

    @Autowired
    private ReqMsgHeaderBuilder headerBuilder;

    @Autowired
    private ISipConfigService sipConfigService;

    @Autowired
    private IMediaServerService mediaServerService;

    @Autowired
    private ISipDeviceService sipDeviceService;

    @Autowired
    private ZlmApiUtils zlmApiUtils;

    @Autowired
    private VideoSessionManager videoSessionManager;

    @Autowired
    private IInviteService inviteService;

    @Autowired
    @Qualifier(value = "udpSipServer")
    private SipProvider sipserver;

    @Override
    public VideoSessionInfo playStreamCmd(SipDevice device, String channelId, boolean record) {
        try {
            SipConfig sipConfig = sipConfigService.selectSipConfigBydeviceSipId(device.getDeviceSipId());
            if (sipConfig == null) {
                log.error("playStreamCmd sipConfig is null");
                return null;
            }
            MediaServer mediaInfo = mediaServerService.selectMediaServerBydeviceSipId(device.getDeviceSipId());
            if (mediaInfo == null) {
                log.error("playStreamCmd mediaInfo is null");
                return null;
            }
            VideoSessionInfo info = VideoSessionInfo.builder()
                    .mediaServerId(mediaInfo.getServerId())
                    .deviceId(device.getDeviceSipId())
                    .channelId(channelId)
                    .streamMode(device.getStreammode().toUpperCase())
                    .build();
            String fromTag;
            if (record) {
                info.setType(SessionType.playrecord);
                fromTag = "playrecord";
            } else {
                info.setType(SessionType.play);
                fromTag = "play";
            }
            //创建rtp服务器
            info = mediaServerService.createRTPServer(sipConfig, mediaInfo, device, info);
            //创建Invite会话
            String content = buildRequestContent(sipConfig, mediaInfo, info);
            Request request = headerBuilder.createInviteRequest(device, sipConfig, channelId, content, info.getSsrc(), fromTag);
            //发送消息
            ClientTransaction transaction = transmitRequest(request);
            log.info("playStreamCmd streamSession: {}", info);
            InviteInfo invite = InviteInfo.builder()
                    .ssrc(info.getSsrc())
                    .fromTag(fromTag)
                    .callId(transaction.getDialog().getCallId().getCallId())
                    .port(info.getPort()).build();
            log.warn("playStreamCmd invite: {}", invite);
            inviteService.updateInviteInfo(info, invite);
            streamSession.put(info, transaction);
            return info;
        } catch (SipException | ParseException | InvalidArgumentException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void streamByeCmd(SipDevice device, String channelId, String stream, String ssrc) {
        SipConfig sipConfig = sipConfigService.selectSipConfigBydeviceSipId(device.getDeviceSipId());
        if (sipConfig == null) {
            log.error("[发送BYE] sipConfig is null");
            return;
        }
        MediaServer mediaInfo = mediaServerService.selectMediaServerBydeviceSipId(device.getDeviceSipId());
        if (mediaInfo == null) {
            log.error("[发送BYE] mediaInfo is null");
            return;
        }
        List<VideoSessionInfo> SessionInfoList = streamSession.getSessionInfoForAll(device.getDeviceSipId(), channelId, stream, ssrc);
        if (SessionInfoList == null || SessionInfoList.isEmpty()) {
            log.warn("[发送BYE] 未找到事务信息,设备： device: {}, channel: {}", device.getDeviceSipId(), channelId);
            return;
        }
        for (VideoSessionInfo info : SessionInfoList) {
            try {
                log.warn("[发送BYE] 设备： device: {}, channel: {}, stream: {}, ssrc: {}", device.getDeviceSipId(),
                        info.getChannelId(), info.getStream(), info.getSsrc());
                List<InviteInfo> list = inviteService.getInviteInfoAll(info.getType(), info.getDeviceId(), info.getChannelId(), info.getStream());
                if (list.isEmpty()) {
                    log.warn("[发送BYE] 未找到invite信息,设备： Stream: {}", info.getStream());
                } else {
                    for (InviteInfo invite : list) {
                        // 发送bye消息
                        Request request = headerBuilder.createByeRequest(device, sipConfig, channelId, invite);
                        //获取缓存会话
                        ClientTransaction transaction = videoSessionManager.getclientTransaction(info);
                        if (transaction == null) {
                            log.warn("[发送BYE] transaction is null");
                            continue;
                        }
                        Dialog dialog = transaction.getDialog();
                        if (dialog == null) {
                            log.warn("[发送BYE] transaction is dialog");
                            continue;
                        }
                        //创建客户端，发送请求
                        ClientTransaction clientTransaction = sipserver.getNewClientTransaction(request);
                        dialog.sendRequest(clientTransaction);
                        // 释放ssrc
                        SipUtil.releaseSsrc(info.getSsrc());
                        // 关闭rtp服务器
                        zlmApiUtils.closeRTPServer(mediaInfo, stream);
                        log.warn("closeRTPServer Port:{}", info.getPort());
                        if (info.isPushing()) {
                            info.setPushing(false);
                        }
                        if (info.isRecording()) {
                            info.setPushing(false);
                        }
                        streamSession.put(info, null);
                        // 删除会话缓存
                        streamSession.remove(info.getDeviceId(), info.getChannelId(), stream, info.getSsrc());
                        // 删除invite缓存
                        inviteService.removeInviteInfo(info.getType(), info.getDeviceId(), info.getChannelId(), info.getStream());
                    }
                }
            } catch (ParseException | SipException | InvalidArgumentException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void streamByeCmd(String deviceId, String channelId, String stream, String ssrc) {
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        if (dev == null) {
            log.error("[发送BYE] device is null");
            return;
        }
        streamByeCmd(dev, channelId, stream, ssrc);
    }

    private ClientTransaction transmitRequest(Request request) throws SipException {
        log.info("transmitRequest:{}", request);
        ClientTransaction clientTransaction = sipserver.getNewClientTransaction(request);
        clientTransaction.sendRequest();
        return clientTransaction;
    }

    private String buildRequestContent(SipConfig sipConfig, MediaServer mediaInfo, VideoSessionInfo info) {
        String streamMode = info.getStreamMode();
        StringBuilder content = new StringBuilder(200);
        content.append("v=0\r\n");
        switch (info.getType()) {
            case play:
                content.append("o=").append(info.getChannelId()).append(" 0 0 IN IP4 ").append(mediaInfo.getIp()).append("\r\n");
                content.append("s=Play\r\n");
                content.append("c=IN IP4 ").append(mediaInfo.getIp()).append("\r\n");
                content.append("t=0 0\r\n");
                break;
        }
        if (sipConfig.getSeniorsdp() != null && sipConfig.getSeniorsdp() == 1) {
            if ("TCP-PASSIVE".equals(streamMode)) {
                content.append("m=video ").append(info.getPort()).append(" TCP/RTP/AVP 96 126 125 99 34 98 97\r\n");
            } else if ("TCP-ACTIVE".equals(streamMode)) {
                content.append("m=video ").append(info.getPort()).append(" TCP/RTP/AVP 96 126 125 99 34 98 97\r\n");
            } else if ("UDP".equals(streamMode)) {
                content.append("m=video ").append(info.getPort()).append(" RTP/AVP 96 126 125 99 34 98 97\r\n");
            }
            content.append("a=recvonly\r\n");
            content.append("a=rtpmap:96 PS/90000\r\n");
            content.append("a=fmtp:126 profile-level-id=42e01e\r\n");
            content.append("a=rtpmap:126 H264/90000\r\n");
            content.append("a=rtpmap:125 H264S/90000\r\n");
            content.append("a=fmtp:125 profile-level-id=42e01e\r\n");
            content.append("a=rtpmap:99 MP4V-ES/90000\r\n");
            content.append("a=fmtp:99 profile-level-id=3\r\n");
            content.append("a=rtpmap:98 H264/90000\r\n");
            content.append("a=rtpmap:97 MPEG4/90000\r\n");
            if ("TCP-PASSIVE".equals(streamMode)) { // tcp被动模式
                content.append("a=setup:passive\r\n");
                content.append("a=connection:new\r\n");
            } else if ("TCP-ACTIVE".equals(streamMode)) { // tcp主动模式
                content.append("a=setup:active\r\n");
                content.append("a=connection:new\r\n");
            }
        } else {
            switch (streamMode) {
                case "TCP-PASSIVE":
                    content.append("m=video ").append(info.getPort()).append(" TCP/RTP/AVP 96 97 98 99\r\n");
                    break;
                case "TCP-ACTIVE":
                    content.append("m=video ").append(info.getPort()).append(" TCP/RTP/AVP 96 97 98 99\r\n");
                    break;
                case "UDP":
                    //content.append("m=video ").append(info.getPort()).append(" RTP/AVP 96 97 98 99\r\n");
                    content.append("m=video ").append(info.getPort()).append(" RTP/AVP 96 97 98\r\n");
                    break;
            }
            content.append("a=recvonly\r\n");
            content.append("a=rtpmap:96 PS/90000\r\n");
            content.append("a=rtpmap:97 MPEG4/90000\r\n");
            content.append("a=rtpmap:98 H264/90000\r\n");
            //content.append("a=rtpmap:99 H265/90000\r\n");
            if ("TCP-PASSIVE".equals(streamMode)) { // tcp被动模式
                content.append("a=setup:passive\r\n");
                content.append("a=connection:new\r\n");
            } else if ("TCP-ACTIVE".equals(streamMode)) { // tcp主动模式
                content.append("a=setup:active\r\n");
                content.append("a=connection:new\r\n");
            }
        }
        if (info.getType() == SessionType.download) {
            content.append("a=downloadspeed:").append(info.getDownloadSpeed()).append("\r\n");
        }
        content.append("y=").append(info.getSsrc()).append("\r\n");// ssrc
        return content.toString();
    }
}
