package com.fastbee.iot.model;

/**
 *
 * @author kerwincui
 * @date 2023-01-14
 */
public class ThingsModelPerm
{
    /** 物模型名称 */
    private String modelName;

    /** 标识符，产品下唯一 */
    private String identifier;

    /** 备注信息 */
    private String remark;

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
