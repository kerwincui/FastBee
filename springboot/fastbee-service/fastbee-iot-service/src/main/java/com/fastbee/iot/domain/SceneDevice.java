package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 场景设备对象 iot_scene_device
 * 
 * @author kerwincui
 * @date 2023-12-28
 */
public class SceneDevice
{
    private static final long serialVersionUID = 1L;

    /** 场景设备ID */
    private Long sceneDeviceId;

    /** 设备编号（产品触发的没有设备编号） */
    @Excel(name = "设备编号", readConverterExp = "产=品触发的没有设备编号")
    private String serialNumber;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品ID */
    @Excel(name = "产品名称")
    private String productName;

    /** 场景脚本ID */
    @Excel(name = "场景脚本ID")
    private String scriptId;

    /** 场景ID */
    @Excel(name = "场景ID")
    private Long sceneId;

    /** 触发源（1=设备触发，3=产品触发） */
    @Excel(name = "触发源", readConverterExp = "1==设备触发，3=产品触发")
    private Integer source;

    /** 类型（2=触发器，3=执行动作） */
    private Integer type;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setSceneDeviceId(Long sceneDeviceId)
    {
        this.sceneDeviceId = sceneDeviceId;
    }

    public Long getSceneDeviceId() 
    {
        return sceneDeviceId;
    }
    public void setSerialNumber(String serialNumber) 
    {
        this.serialNumber = serialNumber;
    }

    public String getSerialNumber() 
    {
        return serialNumber;
    }
    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }
    public void setScriptId(String scriptId)
    {
        this.scriptId = scriptId;
    }

    public String getScriptId()
    {
        return scriptId;
    }
    public void setSceneId(Long sceneId) 
    {
        this.sceneId = sceneId;
    }

    public Long getSceneId() 
    {
        return sceneId;
    }
    public void setSource(Integer source) 
    {
        this.source = source;
    }

    public Integer getSource() 
    {
        return source;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("sceneDeviceId", getSceneDeviceId())
            .append("serialNumber", getSerialNumber())
            .append("productId", getProductId())
            .append("scriptId", getScriptId())
            .append("sceneId", getSceneId())
            .append("source", getSource())
            .toString();
    }
}
