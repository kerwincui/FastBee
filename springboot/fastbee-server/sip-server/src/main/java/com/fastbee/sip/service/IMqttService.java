package com.fastbee.sip.service;

import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.model.RecordList;
import com.fastbee.sip.server.msg.Alarm;

import java.util.List;

public interface IMqttService {
    void publishInfo(SipDevice device);
    void publishStatus(SipDevice device, int deviceStatus);
    void publishEvent(Alarm alarm);
    void publishProperty(Long productId, String deviceNum, List<ThingsModelSimpleItem> thingsList, int delay);
    void publishChannelsProperty(String DeviceSipId, List<SipDeviceChannel> channels);
    void publishRecordsProperty(String DeviceSipId, RecordList recordList);
}
