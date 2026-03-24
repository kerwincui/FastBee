package com.fastbee.common.core.domain.entity;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.annotation.Excel.ColumnType;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 字典类型表 sys_dict_type
 * 
 * @author ruoyi
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel(value = "SysDictType", description = "字典类型表 sys_dict_type")
public class SysDictType extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 字典主键 */
    @ApiModelProperty("字典主键")
    @Excel(name = "字典主键", cellType = ColumnType.NUMERIC)
    private Long dictId;

    /** 字典名称 */
    @ApiModelProperty("字典名称")
    @Excel(name = "字典名称")
    private String dictName;

    /** 字典类型 */
    @ApiModelProperty("字典类型")
    @Excel(name = "字典类型")
    private String dictType;

    /** 状态（0正常 1停用） */
    @ApiModelProperty("状态（0正常 1停用）")
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 字典类型标签 */
    @ApiModelProperty("中文字典标签")
    @TableField(exist = false)
    private String dictName_zh_CN;

    /** 字典类型标签 */
    @ApiModelProperty("英文字典标签")
    @TableField(exist = false)
    private String dictName_en_US;

    @TableField(exist = false)
    @Deprecated
    private String language;

}
