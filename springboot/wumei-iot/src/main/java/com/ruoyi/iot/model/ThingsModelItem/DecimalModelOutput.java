package com.ruoyi.iot.model.ThingsModelItem;

import java.math.BigDecimal;

public class DecimalModelOutput extends ThingsModelItemBase
{
    private BigDecimal min;
    private BigDecimal max;
    private BigDecimal step;
    private String unit;

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
