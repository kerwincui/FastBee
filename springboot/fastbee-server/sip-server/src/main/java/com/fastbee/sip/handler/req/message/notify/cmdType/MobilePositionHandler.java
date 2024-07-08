package com.fastbee.sip.handler.req.message.notify.cmdType;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.notify.NotifyMessageHandler;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;

import javax.sip.RequestEvent;

public class MobilePositionHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private NotifyMessageHandler notifyMessageHandler;

    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {

    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "MobilePosition";
        notifyMessageHandler.addHandler(cmdType, this);
    }
}
