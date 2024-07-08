package com.fastbee.sip.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Data
public class RecordList {
    String deviceID;
    int sumNum;
    private List<RecordItem> recordItems = new ArrayList<>();

    public void addItem(RecordItem item) {
        this.recordItems.add(item);
    }

    public void mergeItems() {
        recordItems.sort(Comparator.naturalOrder());
        List<RecordItem> temp = new ArrayList<>();
        long start = 0;
        long end = 0;
        for (int i = 0; i < recordItems.size(); i++) {
            RecordItem item = recordItems.get(i);
            if (i == recordItems.size() - 1) {
                if (end >= item.getStart()) {
                    RecordItem titem = new RecordItem();
                    titem.setStart(start);
                    titem.setEnd(item.getEnd());
                    temp.add(titem);
                } else {
                    RecordItem titem = new RecordItem();
                    titem.setStart(start);
                    titem.setEnd(end);
                    temp.add(titem);
                    temp.add(item);
                }
            }
            if (start == 0 && end == 0) {
                start = item.getStart();
                end = item.getEnd();
            } else if (end >= item.getStart()) {
                end = item.getEnd();
            } else {
                RecordItem titem = new RecordItem();
                titem.setStart(start);
                titem.setEnd(end);
                temp.add(titem);
                start = item.getStart();
                end = item.getEnd();
            }
        }
        this.recordItems = temp;
    }
}
