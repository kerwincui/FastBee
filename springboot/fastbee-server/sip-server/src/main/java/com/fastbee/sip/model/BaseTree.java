package com.fastbee.sip.model;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.text.Collator;
import java.util.Comparator;
@Data
public class BaseTree<T> implements Comparable<BaseTree>{
    private String id;
    private String deviceId;
    private String pid;
    private String name;
    private boolean parent;
    private T basicData;
    @Override
    public int compareTo(@NotNull BaseTree treeNode) {
        if (this.parent || treeNode.isParent()) {
            if (!this.parent && !treeNode.isParent()) {
                Comparator<Object> cmp = Collator.getInstance(java.util.Locale.CHINA);
                return cmp.compare(treeNode.getName(), this.getName());
            }else {
                if (this.isParent()) {
                    return 1;
                }else {
                    return -1;
                }
            }
        }else{
            Comparator<Object> cmp = Collator.getInstance(java.util.Locale.CHINA);
            return cmp.compare(treeNode.getName(), this.getName());
        }
    }

}
