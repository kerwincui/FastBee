package com.fastbee.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fastbee.common.core.domain.PageEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * app语言对象 app_language
 */
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "AppLanguage", description = "app语言 app_language")
@Data
@TableName("app_language" )
public class AppLanguage extends PageEntity implements Serializable {
    private static final long serialVersionUID=1L;

    /** 主键ID */
    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty("主键ID")
    private Long id;

    /** 语言 */
    @ApiModelProperty("语言")
    private String language;

    /** 国家 */
    @ApiModelProperty("国家")
    private String country;

    /** 时区 */
    @ApiModelProperty("时区")
    private String timeZone;

    /** 创建者 */
    @ApiModelProperty("创建者")
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @ApiModelProperty("创建时间")
    private Date createTime;

    /** 语言名称 */
    @ApiModelProperty("语言名称")
    private String langName;

}
