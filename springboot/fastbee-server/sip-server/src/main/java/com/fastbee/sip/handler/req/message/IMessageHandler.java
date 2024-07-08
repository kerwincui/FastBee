package com.fastbee.sip.handler.req.message;

import com.fastbee.sip.domain.SipDevice;
import org.dom4j.Element;

import javax.sip.RequestEvent;

public interface IMessageHandler {
    /**
     * 处理来自设备的信息
     * @param evt
     * @param device
     */
    void handlerCmdType(RequestEvent evt, SipDevice device, Element element);
}
