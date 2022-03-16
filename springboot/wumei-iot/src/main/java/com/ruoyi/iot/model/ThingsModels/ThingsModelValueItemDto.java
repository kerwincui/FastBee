package com.ruoyi.iot.model.ThingsModels;

import org.springframework.data.redis.connection.DataType;

import java.math.BigDecimal;
import java.util.List;

/**
 * 物模型
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModelValueItemDto
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

    private DataType dataType;

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

    public DataType getDataType() {
        return dataType;
    }

    public void setDataType(DataType dataType) {
        this.dataType = dataType;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public static class DataType{
        private String type;
        private String falseText;
        private String trueText;
        private Integer maxLength;
        private String arrayType;
        private String unit;
        private BigDecimal min;
        private BigDecimal max;
        private BigDecimal step;
        private List<EnumItem> enumList;

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

        public Integer getMaxLength() {
            return maxLength;
        }

        public void setMaxLength(Integer maxLength) {
            this.maxLength = maxLength;
        }

        public String getArrayType() {
            return arrayType;
        }

        public void setArrayType(String arrayType) {
            this.arrayType = arrayType;
        }

        public String getUnit() {
            return unit;
        }

        public void setUnit(String unit) {
            this.unit = unit;
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

        public List<EnumItem> getEnumList() {
            return enumList;
        }

        public void setEnumList(List<EnumItem> enumList) {
            this.enumList = enumList;
        }
    }

    public static class EnumItem
    {
        private String text;
        private String value;

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }
    }

}
