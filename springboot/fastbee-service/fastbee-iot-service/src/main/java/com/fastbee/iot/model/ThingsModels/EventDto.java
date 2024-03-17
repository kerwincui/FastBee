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
public class EventDto {
    /**
     * 物模型唯一标识符
     */
    private String id;
    /**
     * 物模型名称
     */
    private String name;
    /**
     * 数据定义
     */
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

    private Integer isHistory;

    /**
     * 从机编号
     */
    private Long tempSlaveId;

}
