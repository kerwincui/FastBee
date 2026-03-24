package com.fastbee.common.core.domain.entity;

import javax.validation.constraints.NotBlank;
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
import com.fastbee.common.constant.UserConstants;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 字典数据表 sys_dict_data
 * 
 * @author ruoyi
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel(value = "SysDictData", description = "字典数据表 sys_dict_data")
public class SysDictData extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 字典编码 */
    @ApiModelProperty("字典编码")
    @Excel(name = "字典编码", cellType = ColumnType.NUMERIC)
    private Long dictCode;

    /** 字典排序 */
    @ApiModelProperty("字典排序")
    @Excel(name = "字典排序", cellType = ColumnType.NUMERIC)
    private Long dictSort;

    /** 字典标签 */
    @ApiModelProperty("字典标签")
    @Excel(name = "字典标签")
    private String dictLabel;

    /** 字典键值 */
    @ApiModelProperty("字典键值")
    @Excel(name = "字典键值")
    private String dictValue;

    /** 字典类型 */
    @ApiModelProperty("字典类型")
    @Excel(name = "字典类型")
    private String dictType;

    /** 样式属性（其他样式扩展） */
    @ApiModelProperty("样式属性（其他样式扩展）")
    private String cssClass;

    /** 表格字典样式 */
    @ApiModelProperty("表格字典样式")
    private String listClass;

    /** 是否默认（Y是 N否） */
    @ApiModelProperty("是否默认（Y是 N否）")
    @Excel(name = "是否默认", readConverterExp = "Y=是,N=否")
    private String isDefault;

    /** 状态（0正常 1停用） */
    @ApiModelProperty("状态（0正常 1停用）")
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 字典标签 */
    @TableField(exist = false)
    @ApiModelProperty("中文字典标签")
    private String dictLabel_zh_CN;

    /** 字典标签 */
    @TableField(exist = false)
    @ApiModelProperty("英文字典标签")
    private String dictLabel_en_US;

    @TableField(exist = false)
    @Deprecated
    private String language;

}
