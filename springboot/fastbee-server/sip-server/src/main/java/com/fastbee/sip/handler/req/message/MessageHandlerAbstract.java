package com.fastbee.sip.handler.req.message;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.util.XmlUtil;
import org.dom4j.Element;

import javax.sip.RequestEvent;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


public abstract class MessageHandlerAbstract implements IMessageHandler {
    public Map<String, IMessageHandler> messageHandlerMap = new ConcurrentHashMap<>();

    public void addHandler(String cmdType, IMessageHandler messageHandler) {
        messageHandlerMap.put(cmdType, messageHandler);
    }

    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {
        String cmd = XmlUtil.getText(element, "CmdType");
        IMessageHandler messageHandler = messageHandlerMap.get(cmd);
        if (messageHandler != null) {
            messageHandler.handlerCmdType(evt, device, element);
        }
    }
}
