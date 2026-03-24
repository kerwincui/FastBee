package com.fastbee.system.domain.vo;

import com.fastbee.common.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;


/**
 * APP用户偏好设置对象 app_preferences
 *
 * @author fastbee
 * @date 2024-12-03
 */

@ApiModel(value = "AppPreferencesVO", description = "APP用户偏好设置 app_preferences")
@Data
public class AppPreferencesVO {

    /** 主键id */
    @Excel(name = "主键id")
    @ApiModelProperty("主键id")
    private Long id;

    /** 用户 */
    @Excel(name = "用户")
    @ApiModelProperty("用户")
    private Long userId;

    /** 语言 */
    @Excel(name = "语言")
    @ApiModelProperty("语言")
    private String language;

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

    /** 更新者 */
    @Excel(name = "更新者")
    @ApiModelProperty("更新者")
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("更新时间")
    @Excel(name = "更新时间")
    private Date updateTime;

    /** 备注 */
    @Excel(name = "备注")
    @ApiModelProperty("备注")
    private String remark;


}
