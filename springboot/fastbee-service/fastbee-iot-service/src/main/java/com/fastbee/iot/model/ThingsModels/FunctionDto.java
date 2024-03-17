package com.fastbee.iot.model.ThingsModels;

import com.alibaba.fastjson2.JSONObject;
import lombok.Data;

/**
 * 产品分类的Id和名称输出
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Data
public class FunctionDto
{
    /** 物模型唯一标识符 */
    private String id;
    /** 物模型名称 */
    private String name;
    /** 是否首页显示（0-否，1-是） */
    private Integer isChart;
    /** 是否只读 */
    private Integer isReadonly;
    /** 是否历史存储 */
    private Integer isHistory;
    /** 排序 */
    private Integer order;
    /** 数据定义 */
    private JSONObject datatype;

    /**
     * 从机编号
     */
    private Integer SlaveId;
    /**
     * 计算公式
     */
    private String formula;

    private Integer isParams;

    /**
     * 从机编号
     */
    private Long tempSlaveId;
}
