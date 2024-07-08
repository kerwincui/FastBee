package com.fastbee.sip.handler.req.message.response.cmdType;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.handler.req.ReqAbstractHandler;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.response.ResponseMessageHandler;
import com.fastbee.sip.service.IMqttService;
import com.fastbee.sip.service.ISipDeviceService;
import com.fastbee.sip.util.XmlUtil;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.sip.InvalidArgumentException;
import javax.sip.RequestEvent;
import javax.sip.SipException;
import java.text.ParseException;

@Component
public class DeviceInfoHandler extends ReqAbstractHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private ResponseMessageHandler responseMessageHandler;

    @Autowired
    private ISipDeviceService sipDeviceService;

    @Autowired
    private IMqttService mqttService;
    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {
        try {
            Element rootElement = getRootElement(evt);
            device.setDeviceName(XmlUtil.getText(rootElement, "DeviceName"));
            device.setManufacturer(XmlUtil.getText(rootElement, "Manufacturer"));
            device.setModel(XmlUtil.getText(rootElement, "Model"));
            device.setFirmware(XmlUtil.getText(rootElement, "Firmware"));
            if (StringUtils.isEmpty(device.getStreammode())) {
                device.setStreammode("UDP");
            }
            // 更新到数据库
            sipDeviceService.updateDevice(device);
            // 发布设备info到emqx
            mqttService.publishInfo(device);
            // 回复200 OK
            responseAck(evt);

        } catch (DocumentException | SipException | InvalidArgumentException | ParseException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "DeviceInfo";
        responseMessageHandler.addHandler(cmdType, this);
    }
}
