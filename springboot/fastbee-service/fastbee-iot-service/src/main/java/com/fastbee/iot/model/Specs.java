package com.fastbee.iot.model;

import lombok.Data;

/**
 * 数据定义
 *
 * @author bill
 */
@Data
public class Specs {

    private String id;
    private String name;
    private Integer isMonitor;
    private Integer slaveId;
    private Integer isChart;
    private Integer isHistory;
    private String datatype;
   /**
     * 计算公式
     */
    private String formula;


    @Data
    static class Datatype {

        private String unit;
        private Long min;
        private Long max;
        private Integer step;
        private String type;
        private String trueText;
        private String falseText;
        private EnumList enumList;
    }

    @Data
    static class EnumList{
        private String text;
        private String value;
    }
}
