package com.ruoyi.iot.model.ThingsModels;

/**
 * 物模型值的项
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModelValueItem
{
    /** 物模型唯一标识符 */
    private String id;

    /** 物模型值 */
    private String value;

    /** 影子值 **/
    private String shadow;

    public String getShadow() {
        return shadow;
    }

    public void setShadow(String shadow) {
        this.shadow = shadow;
    }

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
