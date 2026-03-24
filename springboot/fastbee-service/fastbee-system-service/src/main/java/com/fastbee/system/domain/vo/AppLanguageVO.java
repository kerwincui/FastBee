package com.fastbee.system.domain.vo;

import com.fastbee.common.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;


/**
 * app语言对象 app_language
 *
 * @author zhuangpeng.li
 * @date 2024-11-25
 */

@ApiModel(value = "AppLanguageVO", description = "app语言 app_language")
@Data
public class AppLanguageVO {

    /** 主键ID */
    @Excel(name = "主键ID")
    @ApiModelProperty("主键ID")
    private Long id;

    /** 语言 */
    @Excel(name = "语言")
    @ApiModelProperty("语言")
    private String language;

    /** 国家 */
    @Excel(name = "国家")
    @ApiModelProperty("国家")
    private String country;

    /** 时区 */
    @Excel(name = "时区")
    @ApiModelProperty("时区")
    private String timeZone;

    /** 创建者 */
    @Excel(name = "创建者")
    @ApiModelProperty("创建者")
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间")
    private Date createTime;

    /** 语言名称 */
    @Excel(name = "语言名称")
    @ApiModelProperty("语言名称")
    private String langName;


}
