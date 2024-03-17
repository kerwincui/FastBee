package com.fastbee.iot.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 变量模板设备从机对象 iot_var_temp_salve
 *
 * @author kerwincui
 * @date 2022-12-12
 */
@ApiModel(value = "VarTempSalve", description = "变量模板设备从机对象 iot_var_temp_salve")
@EqualsAndHashCode(callSuper = true)
@Data
public class VarTempSalve extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    @ApiModelProperty("主键id")
    private Long id;

    /** 关联的模板id */
    @ApiModelProperty("关联的模板id")
    @Excel(name = "关联的模板id")
    private Long deviceTempId;

    /** 从机编号 */
    @ApiModelProperty("从机编号")
    @Excel(name = "从机编号")
    private Integer slaveAddr;

    /**
     * 功能编码
     */
    @ApiModelProperty("功能编码")
    private Integer code;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Integer slaveIndex;

    /** 从机ip地址 */
    @ApiModelProperty("从机ip地址")
    @Excel(name = "从机ip地址")
    private String slaveIp;

    /** 从机名称 */
    @ApiModelProperty("从机名称")
    @Excel(name = "从机名称")
    private String slaveName;

    /** 从机端口 */
    @ApiModelProperty("从机端口")
    @Excel(name = "从机端口")
    private Integer slavePort;

    /** 寄存器起始地址(10进制) */
    @ApiModelProperty("寄存器起始地址(10进制)")
    @Excel(name = "寄存器起始地址(10进制)")
    private Long addrStart;

    /** 寄存器结束地址(10进制) */
    @ApiModelProperty("寄存器结束地址(10进制)")
    @Excel(name = "寄存器结束地址(10进制)")
    private Long addrEnd;

    /** 寄存器批量读取个数*/
    @ApiModelProperty("寄存器批量读取个数")
    private Integer packetLength;

    /** 批量获取轮询时间(默认5分钟) */
    @ApiModelProperty("批量获取轮询时间(默认5分钟)")
    @Excel(name = "批量获取轮询时间(默认300s)")
    private Long timer;

    /** 状态 0-启动 1-失效 */
    @ApiModelProperty("状态 0-启动 1-失效")
    @Excel(name = "状态 0-启动 1-失效")
    private Integer status;


    /**
     * 轮询方式
     */
    private Integer pollingMethod;

}
