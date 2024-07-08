package com.fastbee.sip.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * sip系统配置对象 sip_config
 *
 * @author zhuangpeng.li
 * @date 2023-02-21
 */
@ApiModel(value = "SipConfig", description = "sip系统配置对象 sip_config")
@Data
public class SipConfig extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 配置ID */
    @ApiModelProperty("配置ID")
    private Long id;

    /** 是否系统通用（0-否，1-是） */
    @ApiModelProperty(value = "是否系统通用", notes = "（0-否，1-是）")
    @Excel(name = "是否系统通用", readConverterExp = "0=-否，1-是")
    private Integer isSys;

    /** 产品ID */
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
     * 使能开关
     */
    @ApiModelProperty("使能开关")
    @Excel(name = "使能开关")
    private Integer enabled;

    /**
     * 系统默认配置
     */
    @ApiModelProperty("系统默认配置")
    @Excel(name = "系统默认配置")
    private Integer isdefault;

    /**
     * 拓展sdp
     */
    @ApiModelProperty("拓展sdp")
    @Excel(name = "拓展sdp")
    private Integer seniorsdp;

    /**
     * 服务器域
     */
    @ApiModelProperty("服务器域")
    @Excel(name = "服务器域")
    private String domain;

    /**
     * 服务器sipid
     */
    @ApiModelProperty("服务器sipid")
    @Excel(name = "服务器sipid")
    private String serverSipid;

    /** sip认证密码 */
    @ApiModelProperty("sip认证密码")
    @Excel(name = "sip认证密码")
    private String password;

    /** sip接入IP */
    @ApiModelProperty("sip接入IP")
    @Excel(name = "sip接入IP")
    private String ip;

    /** sip接入端口号 */
    @ApiModelProperty("sip接入端口号")
    @Excel(name = "sip接入端口号")
    private Integer port;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;
}
