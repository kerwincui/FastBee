package com.fastbee.sip.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;

/**
 * 监控设备对象 sip_device
 *
 * @author zhuangpeng.li
 * @date 2023-02-24
 */
@EqualsAndHashCode(callSuper = true)
@Data
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
    private String streamMode;

    /** 在线状态 */
    @ApiModelProperty("在线状态")
    @Excel(name = "在线状态")
    private String online;

    /** 注册时间 */
    @ApiModelProperty("注册时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "注册时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date registerTime;

    /** 最后上线时间 */
    @ApiModelProperty("最后上线时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "最后上线时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date lastConnectTime;

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
    private String hostAddress;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;


    public String getHostAndPort() {
        return getIp() + ":" + getPort();
    }
}
