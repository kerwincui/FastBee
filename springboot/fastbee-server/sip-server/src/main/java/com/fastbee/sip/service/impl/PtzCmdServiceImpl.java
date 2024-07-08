package com.fastbee.sip.service.impl;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.enums.Direct;
import com.fastbee.sip.server.MessageInvoker;
import com.fastbee.sip.server.msg.DeviceControl;
import com.fastbee.sip.service.IPtzCmdService;
import com.fastbee.sip.service.ISipDeviceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;


@Slf4j
@Service
public class PtzCmdServiceImpl implements IPtzCmdService {

    @Autowired
    private MessageInvoker messageInvoker;

    @Autowired
    private ISipDeviceService sipDeviceService;


    public boolean directPtzCmd(String deviceId, String channelId, Direct direct, Integer speed) {
        Map<Direct, Integer> directAndSpeed = new HashMap<>();
        directAndSpeed.put(direct, speed);
        SipDevice dev = sipDeviceService.selectSipDeviceBySipId(deviceId);
        if (dev != null) {
            DeviceControl control = new DeviceControl();
            control.setPtzDirect(directAndSpeed);
            control.setDeviceId(channelId);
            messageInvoker.deviceControl(dev, control);
            return true;
        }
        return false;
    }

}
