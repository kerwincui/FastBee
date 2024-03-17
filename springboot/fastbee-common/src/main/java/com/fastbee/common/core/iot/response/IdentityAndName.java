package com.fastbee.common.core.iot.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 物模型值的项
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class IdentityAndName
{

    public IdentityAndName(String id,String value){
        this.id=id;
        this.value=value;
    }

    public IdentityAndName(String id,Integer isHistory){
        this.id=id;
        this.isHistory=isHistory;
    }

    public IdentityAndName(String id, Integer isHistory, String specs, String name, Integer type){
        this.id = id;
        this.isHistory = isHistory;
        this.dataType = specs;
        this.name = name;
        this.type = type;
    }

    /** 物模型唯一标识符 */
    private String id;
    /** 物模型值 */
    private Object value;

    private Integer isChart;

    /**是否监控*/
    private Integer isHistory;
    /**
     * 数据定义
     */
    private String dataType;
    /**物模型名称*/
    private String name;
    /**
     * 物模型类型
     */
    private Integer type;
    /**
     * 是否是参数
     */
    private Integer isParams;

    private String formula;

    private Integer slaveId;

    private Integer tempSlaveId;

    private Integer quantity;

    private String code;
}
