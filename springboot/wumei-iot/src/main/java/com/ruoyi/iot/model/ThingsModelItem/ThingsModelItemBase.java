package com.ruoyi.iot.model.ThingsModelItem;

import com.ruoyi.common.annotation.Excel;

public class ThingsModelItemBase
{
    /** 物模型唯一标识符 */
    private String id;
    /** 物模型名称 */
    private String name;
    /** 物模型值 */
    private String value;
    /** 是否首页显示（0-否，1-是） */
    private Integer isTop;
    /** 是否实时监测（0-否，1-是） */
    private Integer isMonitor;
    /** 数据类型 */
    private String type;
    /** 影子值 */
    private String shadow;

    public String getShadow() {
        return shadow;
    }

    public void setShadow(String shadow) {
        this.shadow = shadow;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getIsTop() {
        return isTop;
    }

    public void setIsTop(Integer isTop) {
        this.isTop = isTop;
    }

    public Integer getIsMonitor() {
        return isMonitor;
    }

    public void setIsMonitor(Integer isMonitor) {
        this.isMonitor = isMonitor;
    }

}
