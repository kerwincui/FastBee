package com.fastbee.sip.server.msg;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fastbee.sip.enums.Direct;
import com.fastbee.sip.server.SipMessage;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.util.StringUtils;

import java.util.Map;
import java.util.StringJoiner;

@Getter
@Setter
@ToString
public class DeviceControl implements SipMessage {
    @JacksonXmlProperty(localName = "DeviceID")
    private String deviceId;

    @JacksonXmlProperty(localName = "SN")
    private String sn;

    @JacksonXmlProperty(localName = "PTZCmd")
    private String ptzCmd;

    @JacksonXmlProperty(localName = "RecordCmd")
    private String recordCmd;

    @JacksonXmlProperty(localName = "GuardCmd")
    private String guardCmd;

    @JacksonXmlProperty(localName = "AlarmCmd")
    private String alarmCmd;

    @JacksonXmlProperty(localName = "IFameCmd")
    private String iFameCmd;

    @JacksonXmlProperty(localName = "DragZoomIn")
    private DragZoom dragZoomIn;

    @JacksonXmlProperty(localName = "DragZoomOut")
    private DragZoom dragZoomOut;

    @Getter
    @Setter
    public static class DragZoom {
        //播放窗口长度像素值
        @JacksonXmlProperty(localName = "Length")
        private int length;

        //播放窗口宽度像素值
        @JacksonXmlProperty(localName = "Width")
        private int width;

        //拉框中心的横轴坐标像素值
        @JacksonXmlProperty(localName = "MidPointX")
        private int midPointX;

        //拉框中心的纵轴坐标像素值
        @JacksonXmlProperty(localName = "MidPointY")
        private int midPointY;

        //拉框长度像素值
        @JacksonXmlProperty(localName = "LengthX")
        private int lengthX;

        //拉框宽度像素值
        @JacksonXmlProperty(localName = "LengthY")
        private int lengthY;

    }

    //看守位控制命令
    @Getter
    @Setter
    public static class HomePosition {

        //看守位使能1:开启,0:关闭
        @JacksonXmlProperty(localName = "Enabled")
        private int enabled;

        //自动归位时间间隔,开启看守位时使用,单位:秒(s)
        @JacksonXmlProperty(localName = "ResetTime")
        private Integer resetTime;

        //调用预置位编号,开启看守位时使用,取值范围0~255
        @JacksonXmlProperty(localName = "PresetIndex")
        private Integer presetIndex;
    }

    @Getter
    @Setter
    public static class AlarmCmdInfo {

        //复位报警的报警方式属性
        @JacksonXmlProperty(localName = "AlarmMethod")
        private String alarmMethod;

        @JacksonXmlProperty(localName = "AlarmType")
        private String alarmType;
    }

    public DeviceControl setPtzDirect(Map<Direct, Integer> directAndSpeed) {
        int code = 0;
        StringBuilder cmd = new StringBuilder("A50F4D");
        for (Map.Entry<Direct, Integer> entry : directAndSpeed.entrySet()) {
            code = entry.getKey().merge(code);
        }
        //控制码
        cmd.append(String.format("%02X", code), 0, 2);
        //水平控制速度
        int lrSpeed = directAndSpeed.getOrDefault(Direct.LEFT, directAndSpeed.getOrDefault(Direct.RIGHT, 0));
        cmd.append(String.format("%02X", lrSpeed), 0, 2);
        //垂直控制速度
        int udSpeed = directAndSpeed.getOrDefault(Direct.UP, directAndSpeed.getOrDefault(Direct.DOWN, 0));
        cmd.append(String.format("%02X", udSpeed), 0, 2);
        //缩放控制速度
        int zoomSpeed = directAndSpeed.getOrDefault(Direct.ZOOM_IN, directAndSpeed.getOrDefault(Direct.ZOOM_OUT, 0)) & 0xF;
        cmd.append(String.format("%X", zoomSpeed), 0, 1)
                .append("0");

        //校验码
        int checkCode = (0XA5 + 0X0F + 0X4D + code + lrSpeed + udSpeed + (zoomSpeed << 4)) % 256;
        cmd.append(String.format("%02X", checkCode), 0, 2);
        setPtzCmd(cmd.toString());
        return this;
    }

    public String toXml(int sn, String charset) {
        StringJoiner joiner = new StringJoiner("\n");
        joiner.add("<?xml version=\"1.0\" encoding=\"" + charset + "\"?>");
        joiner.add("<Control>");
        joiner.add("<CmdType>DeviceControl</CmdType>");
        joiner.add("<SN>" + sn + "</SN>");
        joiner.add("<DeviceID>" + deviceId + "</DeviceID>");

        if (isPtzControl()) {
            joiner.add("<PTZCmd>" + getPtzCmd() + "</PTZCmd>");
        }

        joiner.add("<Info>");
        joiner.add("<ControlPriority>10</ControlPriority>");
        joiner.add("</Info>");
        joiner.add("</Control>");

        return joiner.toString();
    }

    @Override
    public String getDeviceId() {
        return null;
    }

    @Override
    public String getSn() {
        return null;
    }

    public boolean isPtzControl() {
        return StringUtils.hasText(ptzCmd);
    }
}
