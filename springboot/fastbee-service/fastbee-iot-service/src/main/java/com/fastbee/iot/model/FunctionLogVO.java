package com.fastbee.iot.model;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.PageEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import java.util.List;


/**
 * 设备服务下发日志对象 iot_function_log
 *
 * @author zhuangpeng.li
 * @date 2024-11-13
 */

@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "FunctionLogVO", description = "设备服务下发日志 iot_function_log")
@Data
public class FunctionLogVO extends PageEntity {

    /** 设备功能日志ID */
    @Excel(name = "设备功能日志ID")
    @ApiModelProperty("设备功能日志ID")
    private Long id;

    /** 标识符 */
    @Excel(name = "标识符")
    @ApiModelProperty("标识符")
    private String identify;

    /** 1==服务下发，2=属性获取，3.OTA升级 */
    @Excel(name = "1==服务下发，2=属性获取，3.OTA升级")
    @ApiModelProperty("1==服务下发，2=属性获取，3.OTA升级")
    private Integer funType;

    /** 日志值 */
    @Excel(name = "日志值")
    @ApiModelProperty("日志值")
    private String funValue;

    /** 消息id */
    @Excel(name = "消息id")
    @ApiModelProperty("消息id")
    private String messageId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    @ApiModelProperty("设备名称")
    private String deviceName;

    /** 设备编号 */
    @Excel(name = "设备编号")
    @ApiModelProperty("设备编号")
    private String serialNumber;

    /** 模式(1=影子模式，2=在线模式，3=其他) */
    @Excel(name = "模式(1=影子模式，2=在线模式，3=其他)")
    @ApiModelProperty("模式(1=影子模式，2=在线模式，3=其他)")
    private Integer mode;

    /** 用户id */
    @Excel(name = "用户id")
    @ApiModelProperty("用户id")
    private Long userId;

    /** 下发结果描述 */
    @Excel(name = "下发结果描述")
    @ApiModelProperty("下发结果描述")
    private String resultMsg;

    /** 下发结果代码 */
    @Excel(name = "下发结果代码")
    @ApiModelProperty("下发结果代码")
    private Integer resultCode;

    /** 创建者 */
    @Excel(name = "创建者")
    @ApiModelProperty("创建者")
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间")
    private Date createTime;

    /** 备注 */
    @Excel(name = "备注")
    @ApiModelProperty("备注")
    private String remark;

    /** 显示值 */
    @Excel(name = "显示值")
    @ApiModelProperty("显示值")
    private String showValue;

    /** 物模型名称 */
    @Excel(name = "物模型名称")
    @ApiModelProperty("物模型名称")
    private String modelName;

    /** 设备回复时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("设备回复时间")
    @Excel(name = "设备回复时间")
    private Date replyTime;

    /** 仅用于查询时筛选条件 */
    private String prefixIdentify;

    private String dataType;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date beginTime;
    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
    private List<Long> list;

    private List<String> identifyList;

}
