package com.fastbee.common.core.thingsModel;

import com.fastbee.common.utils.DateUtils;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;

import java.util.Date;

/**
 * 物模型值的项
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@AllArgsConstructor
public class ThingsModelSimpleItem
{
    /** 物模型唯一标识符 */
    private String id;

    /** 物模型值 */
    private String value;

    /**
     * 更新时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ts;

    private Integer slaveId;

    /** 备注 **/
    private String remark;

    private String timestamp;

    private boolean isBit = false;

    public ThingsModelSimpleItem(String id, String value , String remark){
        this.id=id;
        this.value=value;
        this.remark=remark;
    }

    public ThingsModelSimpleItem(String id, String value ,Integer slaveId, String remark){
        this.id=id;
        this.value=value;
        this.slaveId = slaveId;
        this.remark=remark;
    }

    public boolean isBit() {
        return isBit;
    }

    public void setBit(boolean bit) {
        isBit = bit;
    }

    public Integer getSlaveId() {
        return slaveId;
    }

    public void setSlaveId(Integer slaveId) {
        this.slaveId = slaveId;
    }

    public Date getTs() {
        return ts;
    }

    public void setTs(Date ts) {
        this.ts = ts  != null ? ts : DateUtils.getNowDate();
    }

    public ThingsModelSimpleItem(){}

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
