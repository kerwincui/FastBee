package com.fastbee.iot.model.ThingsModelItem;

public class ArrayModelOutput extends ThingsModelItemBase
{
    private String arrayType;

    private Integer arrayCount;

    public Integer getArrayCount() {
        return arrayCount;
    }

    public void setArrayCount(Integer arrayCount) {
        this.arrayCount = arrayCount;
    }

    public String getArrayType() {
        return arrayType;
    }

    public void setArrayType(String arrayType) {
        this.arrayType = arrayType;
    }
}
