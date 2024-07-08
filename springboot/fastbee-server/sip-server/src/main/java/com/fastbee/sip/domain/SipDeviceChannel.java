package com.fastbee.sip.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 监控设备通道信息对象 sip_device_channel
 *
 * @author zhuangpeng.li
 * @date 2023-02-23
 */
@ApiModel(value = "SipDeviceChannel", description = "监控设备通道信息对象 sip_device_channel")
@Data
public class SipDeviceChannel extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @ApiModelProperty("ID")
    private Long id;

    /**
     * 租户ID
     */
    @ApiModelProperty("租户ID")
    @Excel(name = "租户ID")
    private Long tenantId;

    /**
     * 租户名称
     */
    @ApiModelProperty("租户名称")
    @Excel(name = "租户名称")
    private String tenantName;

    /**
     * 产品ID
     */
    @ApiModelProperty("产品ID")
    @Excel(name = "产品ID")
    private Long productId;

    /**
     * 产品名称
     */
    @ApiModelProperty("产品名称")
    @Excel(name = "产品名称")
    private String productName;

    /**
     * 产品ID
     */
    @ApiModelProperty("产品ID")
    @Excel(name = "产品ID")
    private Long userId;

    /**
     * 产品名称
     */
    @ApiModelProperty("产品名称")
    @Excel(name = "产品名称")
    private String userName;

    /**
     * 设备SipID
     */
    @ApiModelProperty("设备SipID")
    private String deviceSipId;

    /**
     * 通道SipID
     */
    @ApiModelProperty("通道SipID")
    @Excel(name = "通道SipID")
    private String channelSipId;

    /**
     * 通道名称
     */
    @ApiModelProperty("通道名称")
    @Excel(name = "通道名称")
    private String channelName;

    /**
     * 注册时间
     */
    @ApiModelProperty("注册时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "注册时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date registerTime;

    /**
     * 设备类型
     */
    @ApiModelProperty("设备类型")
    @Excel(name = "设备类型")
    private String deviceType;

    /**
     * 通道类型
     */
    @ApiModelProperty("通道类型")
    @Excel(name = "通道类型")
    private String channelType;

    /**
     * 城市编码
     */
    @ApiModelProperty("城市编码")
    @Excel(name = "城市编码")
    private String citycode;

    /**
     * 行政区域
     */
    @ApiModelProperty("行政区域")
    @Excel(name = "行政区域")
    private String civilcode;

    /**
     * 厂商名称
     */
    @ApiModelProperty("厂商名称")
    @Excel(name = "厂商名称")
    private String manufacture;

    /**
     * 产品型号
     */
    @ApiModelProperty("产品型号")
    @Excel(name = "产品型号")
    private String model;

    /**
     * 设备归属
     */
    @ApiModelProperty("设备归属")
    @Excel(name = "设备归属")
    private String owner;

    /**
     * 警区
     */
    @ApiModelProperty("警区")
    @Excel(name = "警区")
    private String block;

    /**
     * 安装地址
     */
    @ApiModelProperty("安装地址")
    @Excel(name = "安装地址")
    private String address;

    /** 父级id */
    @ApiModelProperty("父级id")
    @Excel(name = "父级id")
    private String parentid;

    /** 设备入网IP */
    @ApiModelProperty("设备入网IP")
    @Excel(name = "设备入网IP")
    private String ipaddress;

    /** 设备接入端口号 */
    @ApiModelProperty("设备接入端口号")
    @Excel(name = "设备接入端口号")
    private Integer port;

    /** 密码 */
    @ApiModelProperty("密码")
    @Excel(name = "密码")
    private String password;

    /** PTZ类型 */
    @ApiModelProperty("PTZ类型")
    @Excel(name = "PTZ类型")
    private Long ptztype;

    /** PTZ类型描述字符串 */
    @ApiModelProperty("PTZ类型描述字符串")
    @Excel(name = "PTZ类型描述字符串")
    private String ptztypetext;

    /**
     * 设备状态（1=-未使用，2-在线，3-离线，4-禁用）
     */
    @ApiModelProperty("设备状态（1=-未使用，2-在线，3-离线，4-禁用）")
    @Excel(name = "设备状态", readConverterExp = "1=-未使用，2-在线，3-离线，4-禁用")
    private Integer status;
    /**
     * 推流状态（1-未使用，2-录像中）
     */
    @ApiModelProperty("推流状态（1-未使用，2-录像中）")
    @Excel(name = "推流状态", readConverterExp = "1-未使用，2-录像中")
    private Integer streamPush;
    /**
     * 直播录像状态（1=-未使用，2-录像中）
     */
    @ApiModelProperty("直播录像状态（1-未使用，2-录像中）")
    @Excel(name = "直播录像状态", readConverterExp = "1-未使用，2-录像中")
    private Integer streamRecord;

    /**
     * 录像转存状态（1-未使用，2-录像中）
     */
    @ApiModelProperty("录像转存状态（1-未使用，2-录像中）")
    @Excel(name = "录像转存状态", readConverterExp = "1-未使用，2-录像中")
    private Integer videoRecord;

    /**
     * 设备经度
     */
    @ApiModelProperty("设备经度")
    @Excel(name = "设备经度")
    private BigDecimal longitude;

    /**
     * 设备纬度
     */
    @ApiModelProperty("设备纬度")
    @Excel(name = "设备纬度")
    private BigDecimal latitude;

    /**
     * 流媒体ID
     */
    @ApiModelProperty("流媒体ID")
    @Excel(name = "流媒体ID")
    private String streamid;

    /**
     * 子设备数
     */
    @ApiModelProperty("子设备数")
    @Excel(name = "子设备数")
    private Long subcount;

    /**
     * 是否有子设备（1-有, 0-没有）
     */
    @ApiModelProperty("是否有子设备（1-有, 0-没有）")
    @Excel(name = "是否有子设备", readConverterExp = "1=-有,,0=-没有")
    private Integer parental;

    /**
     * 是否含有音频（1-有, 0-没有）
     */
    @ApiModelProperty("是否含有音频（1-有, 0-没有）")
    @Excel(name = "是否含有音频", readConverterExp = "1=-有,,0=-没有")
    private Integer hasaudio;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @ApiModelProperty("删除标志（0代表存在 2代表删除）")
    private String delFlag;
    

}