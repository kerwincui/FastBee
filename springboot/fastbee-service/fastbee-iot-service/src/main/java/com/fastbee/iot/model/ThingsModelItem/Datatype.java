package com.fastbee.iot.model.ThingsModelItem;

import java.math.BigDecimal;
import java.util.List;

public class Datatype
{
    /** 数据类型 */
    private String type;

    private String falseText;

    private String trueText;

    private BigDecimal min;

    private BigDecimal max;

    private BigDecimal step;

    private String unit;

    private String arrayType;

    private Integer arrayCount;

    private String showWay;

    private int maxLength;

    private List<EnumItem> enumList;

    private List<ThingsModel> params;

    private List<ThingsModel>[] arrayParams;

    public Datatype(){
        falseText="";
        trueText="";
        min= BigDecimal.valueOf(0);
        max= BigDecimal.valueOf(100);
        step= BigDecimal.valueOf(1);
        unit="";
        arrayType="";
        arrayCount=0;
        maxLength=1024;
    }

    public List<ThingsModel>[] getArrayParams() {
        return arrayParams;
    }

    public void setArrayParams(List<ThingsModel>[] arrayParams) {
        this.arrayParams = arrayParams;
    }

    public List<ThingsModel> getParams() {
        return params;
    }

    public void setParams(List<ThingsModel> params) {
        this.params = params;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFalseText() {
        return falseText;
    }

    public void setFalseText(String falseText) {
        this.falseText = falseText;
    }

    public String getTrueText() {
        return trueText;
    }

    public void setTrueText(String trueText) {
        this.trueText = trueText;
    }

    public BigDecimal getMin() {
        return min;
    }

    public void setMin(BigDecimal min) {
        this.min = min;
    }

    public BigDecimal getMax() {
        return max;
    }

    public void setMax(BigDecimal max) {
        this.max = max;
    }

    public BigDecimal getStep() {
        return step;
    }

    public void setStep(BigDecimal step) {
        this.step = step;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getArrayType() {
        return arrayType;
    }

    public void setArrayType(String arrayType) {
        this.arrayType = arrayType;
    }

    public String getShowWay() {
        return showWay;
    }

    public void setShowWay(String showWay) {
        this.showWay = showWay;
    }

    public Integer getArrayCount() {
        return arrayCount;
    }

    public void setArrayCount(Integer arrayCount) {
        this.arrayCount = arrayCount;
    }

    public int getMaxLength() {
        return maxLength;
    }

    public void setMaxLength(int maxLength) {
        this.maxLength = maxLength;
    }

    public List<EnumItem> getEnumList() {
        return enumList;
    }

    public void setEnumList(List<EnumItem> enumList) {
        this.enumList = enumList;
    }

}
