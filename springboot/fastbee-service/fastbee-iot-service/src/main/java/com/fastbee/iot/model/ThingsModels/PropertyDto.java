package com.fastbee.iot.model.ThingsModels;

import com.alibaba.fastjson2.JSONObject;
import lombok.Data;

import java.util.List;

/**
 * 产品分类的Id和名称输出
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Data
public class PropertyDto
{
    /** 物模型唯一标识符 */
    private String id;
    /** 物模型名称 */
    private String name;
    /** 是否图表展示（0-否，1-是） */
    private Integer isChart;
    /** 是否历史存储（0-否，1-是） */
    private Integer isHistory;
    /** 是否实时监测（0-否，1-是） */
    private Integer isMonitor;
    /** 是否只读 */
    private Integer isReadonly;
    /** 排序 */
    private Integer order;
    /** 数据定义 */
    private JSONObject datatype;
    /**
     * 计算公式
     */
    private String formula;

    private Integer isParams;
    /**
     * 从机编号
     */
    private Integer tempSlaveId;

    private Integer type;
    /**
     * 读取寄存器数量
     */
    private Integer quantity;
    /**
     *  寄存器#从机
     */
    private String regId;
    /**
     * 功能码
     */
    private String code;
    /**
     *
     */
    private String parseType;
}
