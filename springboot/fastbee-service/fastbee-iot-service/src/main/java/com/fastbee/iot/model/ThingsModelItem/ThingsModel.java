package com.fastbee.iot.model.ThingsModelItem;

public class ThingsModel
{
    /** 物模型唯一标识符 */
    private String id;
    /** 物模型名称 */
    private String name;
    /** 物模型值 */
    private String value;
    /** 影子值 */
    private String shadow;
    /** 是否首页显示（0-否，1-是） */
    private Integer isChart;
    /** 是否实时监测（0-否，1-是） */
    private Integer isMonitor;
    /** 是否实时监测（0-否，1-是） */
    private Integer isReadonly;
    /** 是否历史存储（0-否，1-是） */
    private Integer isHistory;
    /** 是否设备分享权限（0-否，1-是） */
    private Integer isSharePerm;
    /** 类型 1=属性，2=功能，3=事件 */
    private Integer type;
    /** 排序 */
    private Integer order;
    /** 数据类型 */
    private Datatype datatype;

    /**子设备编号*/
    private Integer slaveId;

    private String regId;

    private String ts;

    public ThingsModel(){
        value="";
        shadow="";
        order=0;
        isMonitor=0;
        isHistory=0;
        isReadonly=0;
        isChart=0;
        isSharePerm=0;
    }

    public String getTs() {
        return ts;
    }

    public void setTs(String ts) {
        this.ts = ts;
    }

    public String getRegId() {
        return regId;
    }

    public void setRegId(String regId) {
        this.regId = regId;
    }

    public Integer getSlaveId() {
        return slaveId;
    }

    public void setSlaveId(Integer slaveId) {
        this.slaveId = slaveId;
    }

    public Integer getIsReadonly() {
        return isReadonly;
    }

    public void setIsReadonly(Integer isReadonly) {
        this.isReadonly = isReadonly;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
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

    public String getShadow() {
        return shadow;
    }

    public void setShadow(String shadow) {
        this.shadow = shadow;
    }

    public Integer getIsHistory() {
        return isHistory;
    }

    public void setIsHistory(Integer isHistory) {
        this.isHistory = isHistory;
    }

    public Integer getIsSharePerm() {
        return isSharePerm;
    }

    public void setIsSharePerm(Integer isSharePerm) {
        this.isSharePerm = isSharePerm;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Datatype getDatatype() {
        return datatype;
    }

    public void setDatatype(Datatype datatype) {
        this.datatype = datatype;
    }
}
