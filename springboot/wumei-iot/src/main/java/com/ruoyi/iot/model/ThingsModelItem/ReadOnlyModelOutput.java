package com.ruoyi.iot.model.ThingsModelItem;

import java.math.BigDecimal;
import java.util.List;

public class ReadOnlyModelOutput extends ThingsModelItemBase
{
    private BigDecimal min;
    private BigDecimal max;
    private BigDecimal step;
    private String unit;
    private String arrayType;
    private String falseText;
    private String trueText;
    private int maxLength;
    private List<EnumItemOutput> enumList;

    public List<EnumItemOutput> getEnumList() {
        return enumList;
    }

    public void setEnumList(List<EnumItemOutput> enumList) {
        this.enumList = enumList;
    }

    public int getMaxLength() {
        return maxLength;
    }

    public void setMaxLength(int maxLength) {
        this.maxLength = maxLength;
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

    public String getArrayType() {
        return arrayType;
    }

    public void setArrayType(String arrayType) {
        this.arrayType = arrayType;
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
}
