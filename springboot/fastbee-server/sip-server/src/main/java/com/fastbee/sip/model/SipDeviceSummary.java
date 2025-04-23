package com.fastbee.sip.model;

import com.fastbee.sip.domain.SipDevice;
import lombok.Data;

@Data
public class SipDeviceSummary {
    public SipDeviceSummary(SipDevice device) {
        this.manufacturer = device.getManufacturer();
        this.firmware = device.getFirmware();
        this.transport = device.getTransport();
        this.streammode = device.getStreamMode();
        this.port = device.getPort();
        this.hostaddress = device.getHostAddress();
    }
    public SipDeviceSummary() {

    }
    private String manufacturer;
    private String firmware;
    private String transport;
    private String streammode;
    private Integer port;
    private String hostaddress;
}
