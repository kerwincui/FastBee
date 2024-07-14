package com.fastbee.sip.server.impl;

import com.fastbee.sip.domain.SipConfig;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.server.MessageInvoker;
import com.fastbee.sip.server.SipMessage;
import com.fastbee.sip.server.msg.*;
import com.fastbee.sip.service.ISipConfigService;
import com.fastbee.sip.util.SipUtil;
import com.fasterxml.jackson.core.json.JsonReadFeature;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import javax.sip.*;
import javax.sip.header.EventHeader;
import javax.sip.header.ExpiresHeader;
import javax.sip.header.Header;
import javax.sip.message.Request;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

@Slf4j
@Component
public class MessageInvokerImpl implements MessageInvoker {
    @Autowired
    private SipFactory sipFactory;
    @Autowired
    private ISipConfigService sipConfigService;
    @Autowired
    @Qualifier(value = "udpSipServer")
    private SipProvider sipserver;

    public final static XmlMapper mapper = new XmlMapper();

    private void sendRequest(Function<Integer, String> bodyBuilder,
                             String requestMethod,
                             SipDevice device,
                             String viaTag,
                             String fromTag,
                             String toTag,
                             Header... headers) {
        int id = (int) ((Math.random() * 9 + 1) * 100000);
        createTransaction(requestMethod, bodyBuilder.apply(id), device.getDeviceSipId(), device, viaTag, fromTag, toTag, headers);
    }

    @SneakyThrows
    private ClientTransaction createTransaction(String method,
                                                String xml,
                                                String deviceId,
                                                SipDevice device,
                                                String viaTag,
                                                String fromTag,
                                                String toTag,
                                                Header... headers) {
        SipConfig sipConfig = sipConfigService.selectSipConfigBydeviceSipId(device.getDeviceSipId());
        Request request = new RequestBuilderImpl(sipFactory)
                .requestLine(deviceId, device.getIp(), device.getPort())
                .method(method)
                .user(device.getDeviceSipId())
                .via(sipConfig.getIp(), sipConfig.getPort(), device.getTransport(), viaTag)
                .from(sipConfig.getServerSipid(), sipConfig.getIp() + ":" + sipConfig.getPort(), fromTag)
                .to(deviceId, device.getHostAndPort(), toTag)
                .contentxml(xml.getBytes("GB2312"))
                .contact(sipConfig.getServerSipid(), sipConfig.getPort())
                .build(sipserver.getNewCallId());
        log.debug("prepare SIP request \n{}", request);
        for (Header header : headers) {
            request.addHeader(header);
        }
        return transmitRequest(request);
    }

    static Map<String, Function<String, SipMessage>> valueConverter = new ConcurrentHashMap<>();

    static {
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        mapper.configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
        mapper.configure(DeserializationFeature.ACCEPT_EMPTY_ARRAY_AS_NULL_OBJECT, true);
        mapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
        mapper.configure(JsonReadFeature.ALLOW_UNESCAPED_CONTROL_CHARS.mappedFeature(), true);
        valueConverter.put("DeviceInfo", xml -> jsonNodeToObject(xml, GB28181Device.class));
        valueConverter.put("Keepalive", xml -> jsonNodeToObject(xml, KeepaliveMessage.class));
        valueConverter.put("Catalog", xml -> jsonNodeToObject(xml, CatalogInfo.class));
        valueConverter.put("Alarm", xml -> jsonNodeToObject(xml, Alarm.class));
        valueConverter.put("ConfigDownload", xml -> jsonNodeToObject(xml, ConfigDownload.class));
        valueConverter.put("DeviceControl", xml -> jsonNodeToObject(xml, DeviceControl.class));

    }

    @SneakyThrows
    private static <T> T jsonNodeToObject(String xml, Class<T> tClass) {
        return mapper.readValue(xml.replace("\r\n", "").replace("\n", ""), tClass);
    }

    @SneakyThrows
    public SipMessage messageToObj(RequestEvent event) {
        try {
            Request request = event.getRequest();
            if ((!Request.MESSAGE.equals(request.getMethod())
                    && !Request.NOTIFY.equals(request.getMethod())
                    && !Request.SUBSCRIBE.equals(request.getMethod()))
                    || request.getRawContent() == null) {
                return null;
            }
            String content = new String(request.getRawContent(), "GB2312");
            JsonNode jsonNode = mapper.readTree(content);
            String cmdType = jsonNode.get("CmdType").asText();
            Function<String, SipMessage> converter = valueConverter.get(cmdType);
            if (null != converter) {
                return converter.apply(content);
            }
        } catch (Throwable error) {
            log.error("handle SIP message error \n{}", event.getRequest(), error);
        }
        return null;
    }

    private ClientTransaction transmitRequest(Request request) throws SipException {
        ClientTransaction clientTransaction = sipserver.getNewClientTransaction(request);
        clientTransaction.sendRequest();
        return clientTransaction;
    }

    @Override
    @SneakyThrows
    public void subscribe(@Nonnull SipDevice device, int startAlarmPriority, int endAlarmPriority, int expires, @Nonnull String alarmMethod, @Nullable Date startAlarmTime, @Nullable Date endAlarmTime) {
        String startAlarmTimeString = startAlarmTime == null ? "" : SipUtil.dateToISO8601(startAlarmTime);
        String endAlarmTimeString = endAlarmTime == null ? "" : SipUtil.dateToISO8601(endAlarmTime);
        ExpiresHeader expiresHeader = sipFactory.createHeaderFactory().createExpiresHeader(expires);
        EventHeader eventHeader = sipFactory.createHeaderFactory().createEventHeader("presemce");
        this.sendRequest(sn ->
                        "<?xml version=\"1.0\" encoding=\"GB2312\"?>\r\n" +
                                "<Query>\r\n" +
                                "<CmdType>Alarm</CmdType>\r\n" +
                                "<SN>" + sn + "</SN>\r\n" +
                                "<DeviceID>" + device.getDeviceSipId() + "</DeviceID>\r\n" +
                                "<StartAlarmPriority>" + startAlarmPriority + "</StartAlarmPriority>\n" +
                                "<EndAlarmPriority>" + endAlarmPriority + "</EndAlarmPriority>\n" +
                                "<AlarmMethod>" + alarmMethod + "</AlarmMethod>\n" +
                                "<StartTime>" + startAlarmTimeString + "</StartTime>\n" +
                                "<EndTime>" + endAlarmTimeString + "</EndTime>\n" +
                                "</Query>\r\n",
                Request.SUBSCRIBE,
                device,
                null,
                "AK32B1U8DKDrA",
                null,
                expiresHeader,
                eventHeader
        );
    }

    @Override
    public void deviceControl(SipDevice device, DeviceControl command) {
        this.sendRequest(sn -> command.toXml(sn, "GB2312"),
                Request.MESSAGE,
                device,
                "ViaPtzBranch",
                "FromPtzTag",
                null
        );
    }


    @Override
    public boolean deviceInfoQuery(SipDevice device) {
        this.sendRequest(sn ->
                        "<?xml version=\"1.0\" encoding=\"GB2312\"?>\r\n" +
                                "<Query>\r\n" +
                                "<CmdType>DeviceInfo</CmdType>\r\n" +
                                "<SN>" + sn + "</SN>\r\n" +
                                "<DeviceID>" + device.getDeviceSipId() + "</DeviceID>\r\n" +
                                "</Query>\r\n",
                Request.MESSAGE,
                device,
                "ViaDeviceInfoBranch",
                "FromDeviceInfoTag",
                "ToDeviceInfoTag"
        );
        return true;
    }

    @Override
    public boolean catalogQuery(SipDevice device) {
        this.sendRequest(sn ->
                        "<?xml version=\"1.0\" encoding=\"GB2312\"?>\r\n" +
                                "<Query>\r\n" +
                                "<CmdType>Catalog</CmdType>\r\n" +
                                "<SN>" + sn + "</SN>\r\n" +
                                "<DeviceID>" + device.getDeviceSipId() + "</DeviceID>\r\n" +
                                "</Query>\r\n",
                Request.MESSAGE,
                device,
                "ViaCatalogBranch",
                "FromCatalogTag",
                null
        );
        return true;
    }
}

