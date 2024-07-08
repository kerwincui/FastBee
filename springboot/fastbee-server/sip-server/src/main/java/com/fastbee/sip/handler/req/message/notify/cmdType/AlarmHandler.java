package com.fastbee.sip.handler.req.message.notify.cmdType;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.notify.NotifyMessageHandler;
import com.fastbee.sip.server.MessageInvoker;
import com.fastbee.sip.server.SipMessage;
import com.fastbee.sip.server.msg.Alarm;
import com.fastbee.sip.service.IMqttService;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sip.RequestEvent;
@Slf4j
@Component
public class AlarmHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private NotifyMessageHandler notifyMessageHandler;

    @Autowired
    private MessageInvoker messageInvoker;

    @Autowired
    private IMqttService mqttService;

    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {
        log.info("设备报警：{}", device.getDeviceId());
        SipMessage message = messageInvoker.messageToObj(evt);
        if (message instanceof Alarm) {
            log.info("报警内容：{}", message);
            mqttService.publishEvent((Alarm) message);
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "Alarm";
        notifyMessageHandler.addHandler(cmdType, this);
    }
}
