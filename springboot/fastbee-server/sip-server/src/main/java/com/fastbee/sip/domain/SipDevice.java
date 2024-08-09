package com.fastbee.sip.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

/**
 * 监控设备对象 sip_device
 *
 * @author zhuangpeng.li
 * @date 2023-02-24
 */
@ApiModel(value = "SipDevice", description = "监控设备对象 sip_device")
public class SipDevice extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备ID */
    @ApiModelProperty("设备ID")
    private Long deviceId;

    /** 产品ID */
    @ApiModelProperty("产品ID")
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @ApiModelProperty("产品名称")
    @Excel(name = "产品名称")
    private String productName;

    /** 设备SipID */
    @ApiModelProperty("设备SipID")
    @Excel(name = "设备SipID")
    private String deviceSipId;

    /** 设备名称 */
    @ApiModelProperty("设备名称")
    @Excel(name = "设备名称")
    private String deviceName;

    /** 厂商名称 */
    @ApiModelProperty("厂商名称")
    @Excel(name = "厂商名称")
    private String manufacturer;

    /** 产品型号 */
    @ApiModelProperty("产品型号")
    @Excel(name = "产品型号")
    private String model;

    /** 固件版本 */
    @ApiModelProperty("固件版本")
    @Excel(name = "固件版本")
    private String firmware;

    /** 传输模式 */
    @ApiModelProperty("传输模式")
    @Excel(name = "传输模式")
    private String transport;

    /** 流模式 */
    @ApiModelProperty("流模式")
    @Excel(name = "流模式")
    private String streammode;

    /** 在线状态 */
    @ApiModelProperty("在线状态")
    @Excel(name = "在线状态")
    private String online;

    /** 注册时间 */
    @ApiModelProperty("注册时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "注册时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date registertime;

    /** 最后上线时间 */
    @ApiModelProperty("最后上线时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "最后上线时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date lastconnecttime;

    /** 激活时间 */
    @ApiModelProperty("激活时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "激活时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date activeTime;

    /** 设备入网IP */
    @ApiModelProperty("设备入网IP")
    @Excel(name = "设备入网IP")
    private String ip;

    /** 设备接入端口号 */
    @ApiModelProperty("设备接入端口号")
    @Excel(name = "设备接入端口号")
    private Integer port;

    /** 设备地址 */
    @ApiModelProperty("设备地址")
    @Excel(name = "设备地址")
    private String hostaddress;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;

    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId()
    {
        return deviceId;
    }
    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public Long getProductId()
    {
        return productId;
    }
    public void setProductName(String productName)
    {
        this.productName = productName;
    }

    public String getProductName()
    {
        return productName;
    }
    public void setDeviceSipId(String deviceSipId)
    {
        this.deviceSipId = deviceSipId;
    }

    public String getDeviceSipId()
    {
        return deviceSipId;
    }
    public void setDeviceName(String deviceName)
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName()
    {
        return deviceName;
    }
    public void setManufacturer(String manufacturer)
    {
        this.manufacturer = manufacturer;
    }

    public String getManufacturer()
    {
        return manufacturer;
    }
    public void setModel(String model)
    {
        this.model = model;
    }

    public String getModel()
    {
        return model;
    }
    public void setFirmware(String firmware)
    {
        this.firmware = firmware;
    }

    public String getFirmware()
    {
        return firmware;
    }
    public void setTransport(String transport)
    {
        this.transport = transport;
    }

    public String getTransport()
    {
        return transport;
    }
    public void setStreammode(String streammode)
    {
        this.streammode = streammode;
    }

    public String getStreammode()
    {
        return streammode;
    }
    public void setOnline(String online)
    {
        this.online = online;
    }

    public String getOnline()
    {
        return online;
    }
    public void setRegistertime(Date registertime)
    {
        this.registertime = registertime;
    }

    public Date getRegistertime()
    {
        return registertime;
    }
    public void setLastconnecttime(Date lastconnecttime)
    {
        this.lastconnecttime = lastconnecttime;
    }

    public Date getLastconnecttime()
    {
        return lastconnecttime;
    }
    public void setActiveTime(Date activeTime)
    {
        this.activeTime = activeTime;
    }

    public Date getActiveTime()
    {
        return activeTime;
    }
    public void setIp(String ip)
    {
        this.ip = ip;
    }

    public String getIp()
    {
        return ip;
    }
    public void setPort(Integer port)
    {
        this.port = port;
    }

    public Integer getPort()
    {
        return port;
    }
    public void setHostaddress(String hostaddress)
    {
        this.hostaddress = hostaddress;
    }

    public String getHostaddress()
    {
        return hostaddress;
    }
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("deviceId", getDeviceId())
                .append("productId", getProductId())
                .append("productName", getProductName())
                .append("deviceSipId", getDeviceSipId())
                .append("deviceName", getDeviceName())
                .append("manufacturer", getManufacturer())
                .append("model", getModel())
                .append("firmware", getFirmware())
                .append("transport", getTransport())
                .append("streammode", getStreammode())
                .append("online", getOnline())
                .append("registertime", getRegistertime())
                .append("lastconnecttime", getLastconnecttime())
                .append("activeTime", getActiveTime())
                .append("ip", getIp())
                .append("port", getPort())
                .append("hostaddress", getHostaddress())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }

    public String getHostAndPort() {
        return getIp() + ":" + getPort();
    }
}
