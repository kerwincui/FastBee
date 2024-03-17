package com.fastbee.iot.model.ThingsModelItem;

import com.fastbee.common.annotation.Excel;

public class ThingsModelItemBase
{
    /** 物模型唯一标识符 */
    private String id;
    /** 物模型名称 */
    private String name;
    /** 物模型值 */
    private String value;
    /** 是否首页显示（0-否，1-是） */
    private Integer isChart;
    /** 是否实时监测（0-否，1-是） */
    private Integer isMonitor;
    /** 类型 1=属性，2=功能，3=事件 */
    private Integer type;
    /** 数据类型 */
    private String dataType;
    /** 影子值 */
    private String shadow;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getShadow() {
        return shadow;
    }

    public void setShadow(String shadow) {
        this.shadow = shadow;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
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

    public Integer getIsChart() {
        return isChart;
    }

    public void setIsChart(Integer isChart) {
        this.isChart = isChart;
    }

    public Integer getIsMonitor() {
        return isMonitor;
    }

    public void setIsMonitor(Integer isMonitor) {
        this.isMonitor = isMonitor;
    }

}
