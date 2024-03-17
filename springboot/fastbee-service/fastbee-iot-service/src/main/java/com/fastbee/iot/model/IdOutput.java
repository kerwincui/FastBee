package com.fastbee.iot.model;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 产品分类的Id和名称输出
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class IdOutput
{
    private Long id;

    public void setId(Long id)
    {
        this.id = id;
    }
    public Long getId()
    {
        return id;
    }
}
