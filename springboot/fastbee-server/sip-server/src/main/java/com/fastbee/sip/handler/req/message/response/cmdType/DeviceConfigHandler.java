package com.fastbee.sip.handler.req.message.response.cmdType;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.response.ResponseMessageHandler;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sip.RequestEvent;

@Component
public class DeviceConfigHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private ResponseMessageHandler responseMessageHandler;
    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {

    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "DeviceConfig";
        responseMessageHandler.addHandler(cmdType, this);
    }
}
