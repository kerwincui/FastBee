package com.fastbee.mq.redischannel.producer;

import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.mqttclient.IEmqxMessageProducer;
import org.springframework.stereotype.Component;

/**
 * @author bill
 */
@Component
public class EmqxMessageProducer implements IEmqxMessageProducer {
    @Override
    public void sendEmqxMessage(String topicName, DeviceReportBo deviceReportBo) {
        MessageProducer.sendOtherMsg(deviceReportBo);
    }
}
