package com.fastbee.sip.server.msg;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fastbee.sip.server.SipMessage;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class KeepaliveMessage implements SipMessage {
    @JacksonXmlProperty(localName = "DeviceID")
    private String deviceId;

    @JacksonXmlProperty(localName = "Status")
    private String status;

    @JacksonXmlProperty(localName = "SN")
    private String sn;

    @Override
    public String getDeviceId() {
        return null;
    }

    @Override
    public String getSn() {
        return null;
    }
}
