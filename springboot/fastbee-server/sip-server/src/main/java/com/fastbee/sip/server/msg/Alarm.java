package com.fastbee.sip.server.msg;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fastbee.sip.enums.AlarmMethod;
import com.fastbee.sip.enums.AlarmType;
import com.fastbee.sip.server.SipMessage;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Optional;

@Getter
@Setter
@ToString
public class Alarm implements SipMessage {
    @JacksonXmlProperty(localName = "DeviceID")
    private String deviceId;

    @JacksonXmlProperty(localName = "AlarmPriority")
    private String alarmPriority;

    @JacksonXmlProperty(localName = "AlarmTime")
    private String alarmTime;

    @JacksonXmlProperty(localName = "AlarmMethod")
    private AlarmMethod alarmMethod;

    @JacksonXmlProperty(localName = "Longitude")
    private Float longitude;

    @JacksonXmlProperty(localName = "Latitude")
    private Float latitude;

    @JacksonXmlProperty(localName = "AlarmDescription")
    private String description;

    @JacksonXmlProperty(localName = "Info")
    private Info info;

    @JacksonXmlProperty(localName = "SN")
    private String sn;

    @Getter
    @Setter
    public static class Info {

        @JacksonXmlProperty(localName = "AlarmType")
        private String alarmType;

        @JacksonXmlProperty(localName = "AlarmTypeParam")
        private AlarmTypeParam alarmTypeParam;

        public Optional<AlarmType> getAlarmTypeEnum(AlarmMethod method) {
            return AlarmType.of(method, alarmType);
        }
    }

    @Getter
    @Setter
    public static class AlarmTypeParam {
        //1-进入区域;2-离开区域
        @JacksonXmlProperty(localName = "EventType")
        private String eventType;
    }

    @Override
    public String getDeviceId() {
        return this.deviceId;
    }

    @Override
    public String getSn() {
        return this.sn;
    }
}
