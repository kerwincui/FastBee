package com.fastbee.iot.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 设备服务下发日志对象 iot_function_log
 * 
 * @author kerwincui
 * @date 2022-10-22
 */
@ApiModel(value = "FunctionLog", description = "设备服务下发日志对象 iot_function_log")
@Data
public class FunctionLog
{
    private static final long serialVersionUID = 1L;

    /** 设备日志ID */
    @ApiModelProperty("设备日志ID")
    private Long id;

    /** 标识符 */
    @ApiModelProperty("标识符")
    @Excel(name = "标识符")
    private String identify;

    /** 仅用于查询时筛选条件 */
    private String prefixIdentify;

    @ApiModelProperty("物模型名称")
    private String modelName;


    /** 类型（1=服务下发，2=属性获取，3.OTA升级） */
    @ApiModelProperty(value = "类型", notes = "（1=服务下发，2=属性获取，3.OTA升级）")
    @Excel(name = "类型", readConverterExp = "1==服务下发，2=属性获取，3.OTA升级")
    private Integer funType;

    /** 日志值 */
    @ApiModelProperty("日志值")
    @Excel(name = "日志值")
    private String funValue;
    /**
     * 显示值
     */
    @ApiModelProperty("显示值")
    private String showValue;

    /** 消息id */
    @ApiModelProperty("消息id")
    @Excel(name = "消息id")
    private String messageId;

    /** 设备名称 */
    @ApiModelProperty("设备名称")
    @Excel(name = "设备名称")
    private String deviceName;

    /** 设备编号 */
    @ApiModelProperty("设备编号")
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 模式(1=影子模式，2=在线模式，3=其他) */
    @ApiModelProperty(value = "模式", notes = "(1=影子模式，2=在线模式，3=其他)")
    @Excel(name = "模式(1=影子模式，2=在线模式，3=其他)")
    private Integer mode;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户ID")
    private Long userId;

    /** 下发结果描述 */
    @ApiModelProperty("下发结果描述")
    @Excel(name = "下发结果描述")
    private String resultMsg;

    /** 下发结果代码 */
    @ApiModelProperty("下发结果代码")
    @Excel(name = "下发结果代码")
    private Integer resultCode;

    /**
     * 设备回复时间
     */
    @ApiModelProperty("设备回复时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date replyTime;

    /** 创建者 */
    @ApiModelProperty("创建者")
    private String createBy;

    /** 创建时间 */
    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date beginTime;
    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
    private List<Long> list;
    /** 备注 */
    private String remark;

}
