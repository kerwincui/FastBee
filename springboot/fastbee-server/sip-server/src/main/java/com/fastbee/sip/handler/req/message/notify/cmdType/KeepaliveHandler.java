package com.fastbee.sip.handler.req.message.notify.cmdType;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.handler.req.ReqAbstractHandler;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.notify.NotifyMessageHandler;
import com.fastbee.sip.server.MessageInvoker;
import com.fastbee.sip.service.IMqttService;
import com.fastbee.sip.service.ISipDeviceService;
import com.fastbee.sip.util.XmlUtil;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.sip.InvalidArgumentException;
import javax.sip.RequestEvent;
import javax.sip.SipException;
import javax.sip.header.ViaHeader;
import java.text.ParseException;

@Slf4j
@Component
public class KeepaliveHandler extends ReqAbstractHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private NotifyMessageHandler notifyMessageHandler;

    @Autowired
    private ISipDeviceService sipDeviceService;

    @Autowired
    private MessageInvoker messageInvoker;

    @Autowired
    private IMqttService mqttService;
    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {
        try {
            Element rootElement = getRootElement(evt);
            String deviceId = XmlUtil.getText(rootElement, "DeviceID");
            if (sipDeviceService.exists(deviceId)) {
                ViaHeader viaHeader = (ViaHeader) evt.getRequest().getHeader(ViaHeader.NAME);
                String received = viaHeader.getReceived();
                int rPort = viaHeader.getRPort();
                if (StringUtils.isEmpty(received) || rPort == -1) {
                    log.warn("本地地址替代! received:{},rPort:{} [{}:{}]", received, rPort, viaHeader.getHost(), viaHeader.getPort());
                    received = viaHeader.getHost();
                    rPort = viaHeader.getPort();
                }
                device.setLastconnecttime(DateUtils.getNowDate());
                device.setIp(received);
                device.setPort(rPort);
                device.setHostaddress(received.concat(":").concat(String.valueOf(rPort)));
                log.info("设备:{} 心跳上报时间:{}",deviceId,device.getLastconnecttime());
                //log.warn("设备:{} 心跳上报时间:{}",deviceId,device.getLastconnecttime());
                // 更新在线状态
                sipDeviceService.updateSipDeviceStatus(device);
                // 更新在线状态到emqx
                // mqttService.publishStatus(device, 3);
                // 更新通道状态
                messageInvoker.catalogQuery(device);
                // 回复200 OK
                responseAck(evt);
            }

        } catch (ParseException | SipException | InvalidArgumentException | DocumentException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "Keepalive";
        notifyMessageHandler.addHandler(cmdType, this);
    }
}
