package com.fastbee.iot.model.ThingsModels;

import com.fastbee.iot.model.ThingsModelItem.Datatype;

/**
 * 物模型值的项
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModelValueItem {
    /**
     * 物模型唯一标识符
     */
    private String id;

    /**
     * 物模型值
     */
    private String value;

    /**
     * 影子值
     **/
    private String shadow;

    /**
     * 是否为监测值
     **/
    private int isMonitor;

    /**
     * 是否为历史存储
     **/
    private int isHistory;

    /**
     * 是否为图表展示
     **/
    private int isChart;

    /**
     * 是否只读数据
     **/
    private int isReadonly;

    /**
     * 物模型名称
     **/
    private String name;

    private Datatype datatype;

    private String ts;

    private Integer tempSlaveId;

    public Integer getTempSlaveId() {
        return tempSlaveId;
    }

    public void setTempSlaveId(Integer tempSlaveId) {
        this.tempSlaveId = tempSlaveId;
    }

    public int getIsHistory() {
        return isHistory;
    }

    public void setIsHistory(int isHistory) {
        this.isHistory = isHistory;
    }

    public int getIsChart() {
        return isChart;
    }

    public void setIsChart(int isChart) {
        this.isChart = isChart;
    }

    public int getIsReadonly() {
        return isReadonly;
    }

    public void setIsReadonly(int isReadonly) {
        this.isReadonly = isReadonly;
    }

    public Datatype getDatatype() {
        return datatype;
    }

    public void setDatatype(Datatype datatype) {
        this.datatype = datatype;
    }

    public int getIsMonitor() {
        return isMonitor;
    }

    public void setIsMonitor(int isMonitor) {
        this.isMonitor = isMonitor;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

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

    public String getTs() {
        return ts;
    }

    public void setTs(String ts) {
        this.ts = ts;
    }
}
