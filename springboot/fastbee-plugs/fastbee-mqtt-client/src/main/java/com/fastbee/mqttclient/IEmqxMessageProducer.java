package com.fastbee.mqttclient;

import com.fastbee.common.core.mq.DeviceReportBo;

/**
 * @author bill
 */
public interface IEmqxMessageProducer {

    public void sendEmqxMessage(String topicName, DeviceReportBo deviceReportBo);
}
