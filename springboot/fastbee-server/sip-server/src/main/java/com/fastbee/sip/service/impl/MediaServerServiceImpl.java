package com.fastbee.sip.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.mapper.DeviceMapper;
import com.fastbee.sip.domain.MediaServer;
import com.fastbee.sip.domain.SipConfig;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.mapper.MediaServerMapper;
import com.fastbee.sip.model.VideoSessionInfo;
import com.fastbee.sip.model.ZlmMediaServer;
import com.fastbee.sip.server.VideoSessionManager;
import com.fastbee.sip.service.IMediaServerService;
import com.fastbee.sip.util.ZlmApiUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.util.*;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;
import static com.fastbee.common.utils.SecurityUtils.isAdmin;

/**
 * 流媒体服务器配置Service业务层处理
 *
 * @author zhuangpeng.li
 * @date 2022-11-30
 */
@Slf4j
@Service
public class MediaServerServiceImpl implements IMediaServerService {
    @Autowired
    private MediaServerMapper mediaServerMapper;
    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private ZlmApiUtils zlmApiUtils;

    @Autowired
    private VideoSessionManager streamSession;

    @Override
    public MediaServer selectMediaServerById(Long id) {
        return mediaServerMapper.selectMediaServerById(id);
    }

    /**
     * 查询流媒体服务器配置
     *
     * @return 流媒体服务器配置
     */
    @Override
    public List<MediaServer> selectMediaServer() {
        MediaServer mediaServer = new MediaServer();
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("tenant")) {
                // 租户查看第一条流媒体服务器配置
                mediaServer.setTenantId(user.getUserId());
            }
        }
        return mediaServerMapper.selectMediaServer(mediaServer);
    }

    @Override
    public MediaServer selectMediaServerBytenantId(Long tenantId) {
        List<MediaServer> list = mediaServerMapper.selectMediaServerBytenantId(tenantId);
        if (list.size() == 0) {
            return selectMediaServerBytenantId(1L);
        } else if (list.size() == 1) {
            return list.get(0);
        } else {
            //随机选择一个流媒体节点
            Random random = new Random();
            int index = random.nextInt(list.size());
            return list.get(index);
        }
    }

    @Override
    public MediaServer selectMediaServerBydeviceSipId(String deviceSipId) {
        Device device = deviceMapper.selectDeviceBySerialNumber(deviceSipId);
        if (device != null) {
            List<MediaServer> list = mediaServerMapper.selectMediaServerBytenantId(device.getTenantId());
            if (list.size() == 0) {
                return selectMediaServerBytenantId(1L);
            } else if (list.size() == 1) {
                return list.get(0);
            } else {
                //随机选择一个流媒体节点
                Random random = new Random();
                int index = random.nextInt(list.size());
                return list.get(index);
            }
        } else {
            return selectMediaServerBytenantId(1L);
        }

    }

    /**
     * 查询流媒体服务器配置列表
     *
     * @param mediaServer 流媒体服务器配置
     * @return 流媒体服务器配置
     */
    @Override
    public List<MediaServer> selectMediaServerList(MediaServer mediaServer) {
        SysUser user = getLoginUser().getUser();
//        List<SysRole> roles=user.getRoles();
//        // 租户
//        if(roles.stream().anyMatch(a->a.getRoleKey().equals("tenant"))){
//            mediaServer.setTenantId(user.getUserId());
//        }
        mediaServer.setTenantId(user.getUserId());
        return mediaServerMapper.selectMediaServerList(mediaServer);
    }

    /**
     * 新增流媒体服务器配置
     *
     * @param mediaServer 流媒体服务器配置
     * @return 结果
     */
    @Override
    public int insertMediaServer(MediaServer mediaServer) {
        // 判断是否为管理员
        mediaServer.setIsSys(1);
        SysUser user = getLoginUser().getUser();
//        List<SysRole> roles=user.getRoles();
//        for(int i=0;i<roles.size();i++){
//            if(roles.get(i).getRoleKey().equals("tenant") || roles.get(i).getRoleKey().equals("general")){
//                mediaServer.setIsSys(0);
//                break;
//            }
//        }
        if (null == user.getDeptId()) {
            throw new ServiceException("只允许租户配置");
        }
        if (!isAdmin(user.getUserId())) {
            mediaServer.setIsSys(0);
        }
        mediaServer.setTenantId(user.getUserId());
        mediaServer.setTenantName(user.getUserName());
        //判断相同ip服务器是否存在
        MediaServer temp = new MediaServer();
        temp.setIp(mediaServer.getIp());
        List<MediaServer> list = mediaServerMapper.selectMediaServerList(temp);
        if (list.size() > 0) {
            return 0;
        }
        mediaServer.setCreateTime(DateUtils.getNowDate());
        boolean ret = syncMediaServer(mediaServer, mediaServer.getSecret());
        if (ret) {
            return mediaServerMapper.insertMediaServer(mediaServer);
        } else {
            return 0;
        }
    }

    /**
     * 修改流媒体服务器配置
     *
     * @param mediaServer 流媒体服务器配置
     * @return 结果
     */
    @Override
    public int updateMediaServer(MediaServer mediaServer) {
        if (mediaServer.getId() != null) {
            String newSecret = mediaServer.getSecret();
            mediaServer.setSecret(mediaServerMapper.selectMediaServerById(mediaServer.getId()).getSecret());
            boolean ret = syncMediaServer(mediaServer, newSecret);
            if (ret) {
                mediaServer.setSecret(newSecret);
                mediaServer.setUpdateTime(DateUtils.getNowDate());
                return mediaServerMapper.updateMediaServer(mediaServer);
            }
        }
        return 0;
    }

    @Override
    public boolean syncMediaServer(MediaServer mediaServer, String secret) {
        String hookPrex = String.format("http://%s/zlmhook", mediaServer.getHookurl());
        Map<String, Object> param = new HashMap<>();
        param.put("api.secret", secret);

        param.put("hook.enable", "1");
        param.put("general.mediaServerId", mediaServer.getServerId());
        param.put("general.flowThreshold", "64");
        param.put("hook.on_play", String.format("%s/on_play", hookPrex));
        param.put("hook.on_http_access", String.format("%s/on_http_access", hookPrex));
        param.put("hook.on_publish", String.format("%s/on_publish", hookPrex));
        param.put("hook.on_server_started", String.format("%s/on_server_started", hookPrex));
        param.put("hook.on_stream_changed", String.format("%s/on_stream_changed", hookPrex));
        param.put("hook.on_stream_none_reader", String.format("%s/on_stream_none_reader", hookPrex));
        param.put("hook.on_stream_not_found", String.format("%s/on_stream_not_found", hookPrex));
        param.put("hook.on_send_rtp_stopped", String.format("%s/on_send_rtp_stopped", hookPrex));
        param.put("hook.on_rtp_server_timeout", String.format("%s/on_rtp_server_timeout", hookPrex));
        param.put("hook.on_flow_report", String.format("%s/on_flow_report", hookPrex));
        param.put("hook.on_server_keepalive", String.format("%s/on_server_keepalive", hookPrex));
        param.put("hook.on_server_exited", String.format("%s/on_server_exited", hookPrex));
        if (Objects.equals(mediaServer.getProtocol(), "http")) {
            param.put("hook.on_record_mp4", String.format("http://127.0.0.1:%s/zlmhook/on_record_mp4", mediaServer.getRecordPort()));
        } else if (Objects.equals(mediaServer.getProtocol(), "https")) {
            param.put("hook.on_record_mp4", String.format("https://%s:%s/zlmhook/on_record_mp4", mediaServer.getDomain(), mediaServer.getRecordPort()));
        }
        param.put("hook.on_record_ts", "");
        param.put("hook.on_rtsp_auth", "");
        param.put("hook.on_rtsp_realm", "");
        param.put("hook.on_shell_login", "");
        param.put("hook.timeoutSec", "20");
        param.put("hook.alive_interval", "60.0");

        param.put("rtsp.port", mediaServer.getPortRtsp().toString());
        param.put("rtmp.port", mediaServer.getPortRtmp().toString());

        param.put("record.appName", "record");
        param.put("record.filePath", "./record");
        if (!ObjectUtils.isEmpty(mediaServer.getRtpPortRange())) {
            param.put("rtp_proxy.port_range", mediaServer.getRtpPortRange().replace(",", "-"));
            log.warn("[ZLM] 修改RTP推流端口时，请同步Docker端口映射");
        }
        JSONObject responseJSON = zlmApiUtils.setServerConfig(mediaServer, param);
        if (responseJSON != null && responseJSON.getInteger("code") == 0) {
            log.info("[ZLM] 设置成功,开始重启以保证配置生效");
            zlmApiUtils.restartServer(mediaServer);
            return true;
        } else {
            log.info("[ZLM] 设置zlm失败 {}", responseJSON);
            return false;
        }
    }

    /**
     * 批量删除流媒体服务器配置
     *
     * @param ids 需要删除的流媒体服务器配置主键
     * @return 结果
     */
    @Override
    public int deleteMediaServerByIds(Long[] ids) {
        return mediaServerMapper.deleteMediaServerByIds(ids);
    }

    /**
     * 删除流媒体服务器配置信息
     *
     * @param id 流媒体服务器配置主键
     * @return 结果
     */
    @Override
    public int deleteMediaServerById(Long id) {
        return mediaServerMapper.deleteMediaServerById(id);
    }

    @Override
    public JSONObject getMediaList(String schema, String stream) {
        SysUser user = getLoginUser().getUser();
        MediaServer media = selectMediaServerBytenantId(user.getUserId());
        if (media != null) {
            return zlmApiUtils.getMediaList(media, "live", schema, stream).getJSONObject("data");
        }
        return null;
    }

    @Override
    public JSONObject listRtpServer() {
        SysUser user = getLoginUser().getUser();
        MediaServer media = selectMediaServerBytenantId(user.getUserId());
        if (media != null) {
            return zlmApiUtils.listRtpServer(media).getJSONObject("data");
        }
        return null;
    }

    @Override
    public VideoSessionInfo createRTPServer(SipConfig sipConfig, MediaServer mediaInfo, SipDevice device, VideoSessionInfo videoSessionInfo) {
        switch (videoSessionInfo.getType()) {
            case play:
                videoSessionInfo.setSsrc(streamSession.createPlaySsrc(sipConfig.getDomain()));
                videoSessionInfo.setStream(String.format("gb_play_%s_%s", device.getDeviceSipId(), videoSessionInfo.getChannelId()));
                break;
            case playrecord:
                videoSessionInfo.setSsrc(streamSession.createPlaySsrc(sipConfig.getDomain()));
                videoSessionInfo.setStream(String.format("gb_playrecord_%s_%s", device.getDeviceSipId(), videoSessionInfo.getChannelId()));
                break;
            case playback:
                videoSessionInfo.setSsrc(streamSession.createPlayBackSsrc(sipConfig.getDomain()));
                videoSessionInfo.setStream(videoSessionInfo.getSsrc());
                break;
            case download:
                videoSessionInfo.setSsrc(streamSession.createPlayBackSsrc(sipConfig.getDomain()));
                videoSessionInfo.setStream(videoSessionInfo.getSsrc());
                break;
        }

        int mediaPort = zlmApiUtils.createRTPServer(mediaInfo, videoSessionInfo.getStream(), videoSessionInfo.getSsrc(), false, false, 0);
        videoSessionInfo.setPort(mediaPort);
        return videoSessionInfo;
    }

    @Override
    public MediaServer checkMediaServer(String ip, Long port, String secret) {
        MediaServer mediaServerItem = new MediaServer();
        mediaServerItem.setIp(ip);
        mediaServerItem.setPortHttp(port);
        mediaServerItem.setSecret(secret);
        ZlmMediaServer zlmServerConfig = zlmApiUtils.getMediaServerConfig(mediaServerItem);
        if (zlmServerConfig == null) {
            return null;
        }
        mediaServerItem.setServerId(zlmServerConfig.getMediaServerId());
        mediaServerItem.setPortRtmp(Long.valueOf(zlmServerConfig.getRtmpPort()));
        mediaServerItem.setPortRtsp(Long.valueOf(zlmServerConfig.getRtspPort()));
        mediaServerItem.setRtpProxyPort(Long.valueOf(zlmServerConfig.getRtpProxyPort()));
        mediaServerItem.setHookurl("java:8080");
        return mediaServerItem;
    }
}
