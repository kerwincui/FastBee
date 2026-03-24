package com.fastbee.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;


/**
 * APP用户偏好设置对象 app_preferences
 *
 * @author fastbee
 * @date 2024-12-03
 */
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "AppPreferences", description = "APP用户偏好设置 app_preferences")
@Data
@TableName("app_preferences" )
public class AppPreferences extends BaseEntity implements Serializable{
    private static final long serialVersionUID=1L;

    /** 主键id */
    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty("主键id")
    private Long id;

    /** 用户 */
    @ApiModelProperty("用户")
    private Long userId;

    /** 语言 */
    @ApiModelProperty("语言")
    private String language;

    /** 时区 */
    @ApiModelProperty("时区")
    private String timeZone;
}
