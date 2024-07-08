package com.fastbee.sip.handler.req.message.response;

import com.fastbee.sip.handler.req.message.MessageHandlerAbstract;
import com.fastbee.sip.handler.req.message.MessageRequestProcessor;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ResponseMessageHandler extends MessageHandlerAbstract implements InitializingBean {

    @Autowired
    private MessageRequestProcessor messageRequestProcessor;

    @Override
    public void afterPropertiesSet() throws Exception {
        String messageType = "Response";
        messageRequestProcessor.addHandler(messageType, this);
    }
}
