package com.fastbee.sip.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fastbee.sip.enums.ChannelStatus;
import com.fastbee.sip.enums.PTZType;
import com.fastbee.sip.util.SipUtil;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.StringJoiner;

@Data
public class GB28181DeviceChannel {
    /**
     * 通道对应的设备ID
     */
    @JsonIgnore
    private String deviceId;

    /**
     * 通道类型
     */
    @JacksonXmlProperty(isAttribute = true, localName = "itemType")
    private String type;

    /**
     * 通道id
     */
    @JacksonXmlProperty(localName = "DeviceID")
    private String channelId;

    /**
     * 通道名
     */
    @JacksonXmlProperty(localName = "Name")
    private String name;

    /**
     * 生产厂商
     */
    @JacksonXmlProperty(localName = "Manufacturer")
    private String manufacturer;

    /**
     * 型号
     */
    @JacksonXmlProperty(localName = "Model")
    private String model;

    /**
     * 设备归属
     */
    @JacksonXmlProperty(localName = "Owner")
    private String owner;

    /**
     * 行政区域
     */
    @JacksonXmlProperty(localName = "CivilCode")
    private String civilCode;

    /**
     * 警区
     */
    @JacksonXmlProperty(localName = "Block")
    private String block;

    /**
     * 安装地址
     */
    @JacksonXmlProperty(localName = "Address")
    private String address;

    /**
     * 是否有子设备 1有, 0没有
     */
    @JacksonXmlProperty(localName = "Parental")
    private int parental;

    /**
     * 父级id
     */
    @JacksonXmlProperty(localName = "ParentID")
    private String parentId;

    /**
     * 信令安全模式  缺省为0; 0:不采用; 2: S/MIME签名方式; 3: S/ MIME加密签名同时采用方式; 4:数字摘要方式
     */
    @JacksonXmlProperty(localName = "SafetyWay")
    private int safetyWay;

    /**
     * 注册方式 缺省为1;1:符合IETF RFC3261标准的认证注册模 式; 2:基于口令的双向认证注册模式; 3:基于数字证书的双向认证注册模式
     */
    @JacksonXmlProperty(localName = "RegisterWay")
    private String registerWay;

    /**
     * 证书序列号
     */
    @JacksonXmlProperty(localName = "CertNum")
    private String certNum;

    /**
     * 证书有效标识 缺省为0;证书有效标识:0:无效1: 有效
     */
    @JacksonXmlProperty(localName = "Certifiable")
    private int certifiable;

    /**
     * 证书无效原因码
     */
    @JacksonXmlProperty(localName = "ErrCode")
    private int errCode;

    /**
     * 证书终止有效期
     */
    @JacksonXmlProperty(localName = "EndTime")
    private String endTime;

    /**
     * 保密属性 缺省为0; 0:不涉密, 1:涉密
     */
    @JacksonXmlProperty(localName = "Secrecy")
    private String secrecy;

    /**
     * IP地址
     */
    @JacksonXmlProperty(localName = "IpAddress")
    private String ipAddress;

    /**
     * 端口号
     */
    @JacksonXmlProperty(localName = "Port")
    private int port;

    /**
     * 密码
     */
    @JacksonXmlProperty(localName = "Password")
    private String password;

    /**
     * 详情信息
     */
    @JacksonXmlProperty(localName = "Info")
    private Info info;

    /**
     * 经度
     */
    @JacksonXmlProperty(localName = "Longitude")
    private double longitude;

    /**
     * 纬度
     */
    @JacksonXmlProperty(localName = "Latitude")
    private double latitude;

    /**
     * 子设备数
     */
    @JacksonXmlProperty(localName = "SubCount")
    private int subCount;

    @JacksonXmlProperty(localName = "Status")
    private ChannelStatus status;

    //目录类型: 0目录,1设备通道?
    @JacksonXmlProperty(localName = "CatalogType")
    private String catalogType;

    @JacksonXmlProperty(localName = "Event")
    private String event;

    @JacksonXmlProperty(localName = "BusinessGroupID")
    private String businessGroupId;

    @Getter
    @Setter
    public static class Info {

        /**
         * 云台类型
         */
        @JacksonXmlProperty(localName = "PTZType")
        private PTZType PTZType;

        @JacksonXmlProperty(localName = "DownloadSpeed")
        private String downloadSpeed;

        public String toXML() {
            StringJoiner joiner = new StringJoiner("");
            joiner
                    .add("<PTZType>")
                    .add(PTZType == null ? "0" : String.valueOf(getPTZType().getValue()))
                    .add("</PTZType>\n");
            joiner.add("<DownloadSpeed>").add(SipUtil.safeString(downloadSpeed)).add("</DownloadSpeed>\n");

            return joiner.toString();
        }
    }
}
