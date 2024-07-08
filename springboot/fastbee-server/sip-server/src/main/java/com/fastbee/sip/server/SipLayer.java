package com.fastbee.sip.server;

import com.fastbee.sip.conf.SysSipConfig;
import com.fastbee.sip.domain.MediaServer;
import com.fastbee.sip.model.ZlmMediaServer;
import com.fastbee.sip.service.IMediaServerService;
import com.fastbee.sip.service.ISipCacheService;
import com.fastbee.sip.service.ISipConfigService;
import com.fastbee.sip.util.ZlmApiUtils;
import gov.nist.javax.sip.SipStackImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import javax.sip.*;
import java.util.Properties;


@Slf4j
@Configuration
public class SipLayer {
    @Autowired
    private SysSipConfig sipConfig;

    @Autowired
    private IGBListener gbSIPListener;

    @Autowired
    private ZlmApiUtils zlmApiUtils;

    @Autowired
    private ISipCacheService sipCacheService;

    @Autowired
    private ISipConfigService sipConfigService;

    @Autowired
    private IMediaServerService mediaServerService;
    private SipStack sipStack;
    private SipFactory sipFactory;


    @Bean("sipFactory")
    SipFactory createSipFactory() {
        sipFactory = SipFactory.getInstance();
        sipFactory.setPathName("gov.nist");
        if (sipConfig.isEnabled()) {
            //缓存zlm服务器配置
            MediaServer media = mediaServerService.selectMediaServerBytenantId(1L);
            ZlmMediaServer mediaServer = zlmApiUtils.getMediaServerConfig(media);
            if (mediaServer != null) {
                log.info("zlm配置获取成功成功...");
                sipCacheService.updateMediaInfo(mediaServer);
                mediaServerService.syncMediaServer(media, media.getSecret());
            }
        }
        return sipFactory;
    }

    @Bean("sipStack")
    @DependsOn("sipFactory")
    SipStack createSipStack() throws PeerUnavailableException {
        Properties properties = new Properties();
        properties.setProperty("javax.sip.STACK_NAME", "GB28181_SIP");
        properties.setProperty("javax.sip.IP_ADDRESS", sipConfig.getIp());
        properties.setProperty("gov.nist.javax.sip.LOG_MESSAGE_CONTENT", "false");
        properties.setProperty("gov.nist.javax.sip.TRACE_LEVEL", "0");
        properties.setProperty("gov.nist.javax.sip.SERVER_LOG", "sip_server_log");
        properties.setProperty("gov.nist.javax.sip.DEBUG_LOG", "sip_debug_log");
        sipStack = (SipStackImpl) sipFactory.createSipStack(properties);
        return sipStack;
    }

    @Bean("udpSipServer")
    @DependsOn("sipStack")
    SipProvider startUdpListener() throws Exception {
        if (sipConfig.isEnabled()) {
            log.info("startUdpListener");
            ListeningPoint udpListeningPoint = sipStack.createListeningPoint(sipConfig.getIp(), sipConfig.getPort(), "UDP");
            SipProvider udpSipProvider = sipStack.createSipProvider(udpListeningPoint);
            udpSipProvider.addSipListener(gbSIPListener);
            log.info("Sip Server UDP 启动成功 port {}", sipConfig.getPort());
            sipConfigService.syncSipConfig(sipConfig);
            return udpSipProvider;
        } else {
            return new NullSipProvider();
        }

    }

}
