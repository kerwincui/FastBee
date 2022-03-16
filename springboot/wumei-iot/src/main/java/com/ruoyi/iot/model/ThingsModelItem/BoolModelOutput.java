package com.ruoyi.iot.model.ThingsModelItem;

public class BoolModelOutput extends ThingsModelItemBase
{
    private String falseText;
    private String trueText;

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
}
