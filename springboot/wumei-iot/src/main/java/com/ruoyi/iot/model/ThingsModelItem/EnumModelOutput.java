package com.ruoyi.iot.model.ThingsModelItem;

import java.util.List;

public class EnumModelOutput extends ThingsModelItemBase
{
    private List<EnumItemOutput> enumList;

    public List<EnumItemOutput> getEnumList() {
        return enumList;
    }

    public void setEnumList(List<EnumItemOutput> enumList) {
        this.enumList = enumList;
    }
}
