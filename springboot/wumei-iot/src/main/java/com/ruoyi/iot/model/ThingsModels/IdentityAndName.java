package com.ruoyi.iot.model.ThingsModels;

import org.apache.commons.math3.analysis.function.Identity;

/**
 * 物模型值的项
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class IdentityAndName
{
    public IdentityAndName(){

    }

    public IdentityAndName(String id,String value){
        this.id=id;
        this.value=value;
    }

    /** 物模型唯一标识符 */
    private String id;

    /** 物模型值 */
    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

}
