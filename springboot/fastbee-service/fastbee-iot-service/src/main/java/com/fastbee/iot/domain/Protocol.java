package com.fastbee.iot.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * 协议管理model
 * @author gsb
 * @date 2022/10/19 15:35
 */
@ApiModel(value = "Protocol", description = "协议管理对象 iot_protocol")
@Data
public class Protocol {

    @ApiModelProperty("主键ID")
    private Long id;
    /*协议编码*/
    @ApiModelProperty("协议编码")
    private String protocolCode;
    /*协议名称*/
    @ApiModelProperty("协议名称")
    private String protocolName;
    /*协议jar包,js包 c程序上传地址*/
    @ApiModelProperty("协议jar包,js包 c程序上传地址")
    private String protocolFileUrl;
    /*协议类型 0:未知 1:jar 2:js 3:C*/
    @ApiModelProperty("协议类型 0:未知 1:jar 2:js 3:C")
    private Integer protocolType;
    /*协议文件摘要(文件的md5)*/
    @ApiModelProperty("协议文件摘要(文件的md5)")
    private String jarSign;
    /*创建时间*/
    @ApiModelProperty("创建时间")
    private Date createTime;
    /*更新时间*/
    @ApiModelProperty("更新时间")
    private Date updateTime;
    /*0:草稿 1:启用 2:停用*/
    @ApiModelProperty("0:草稿 1:启用 2:停用")
    private Integer protocolStatus;
    /*'0:正常 1:删除*/
    @ApiModelProperty("'0:正常 1:删除")
    private Integer delFlag;
}
