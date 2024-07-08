package com.fastbee.sip.model;

import lombok.Data;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Data
public class RecordItem implements Comparable<RecordItem>{
    long start;
    long end;
    @Override
    public int compareTo(RecordItem item) {
        Date startTime_now = new Date(start*1000);
        Date startTime_param = new Date(item.getStart()*1000);
        if (startTime_param.compareTo(startTime_now) > 0) {
            return -1;
        }else {
            return 1;
        }
    }
}
