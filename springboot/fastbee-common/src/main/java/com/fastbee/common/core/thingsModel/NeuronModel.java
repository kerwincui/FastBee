package com.fastbee.common.core.thingsModel;

import com.alibaba.fastjson2.JSONObject;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * Neuron-JSON格式协议
 * @author gsb
 * @date 2023/5/31 16:36
 */
@Data
public class NeuronModel {

    /**
     * 产品节点
     */
    private String node;

    /**
     * 网关编号
     */
    private String group;
    /**
     * 上报时间
     */
    private Date timestamp;

    /**
     * 上报JSON
     */
    private JSONObject values;
    /**
     * 错误集合
     */
    private JSONObject errors;
    /**
     * 上报属性值集合
     */
    private List<ThingsModelSimpleItem> items;

}
