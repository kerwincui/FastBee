package com.ruoyi.iot.model;

/**
 * 动作
 * @author kerwincui
 * @date 2021-12-16
 */
public class Action
{
    /** 标识符 */
    private String id;

    /** 名称 */
    private String name;

    /** 值 */
    private String value;

    /** 类型：1=属性，2=功能，3=事件，5=设备上线，6=设备下线 */
    private int type;

    /** 源：1=设备，2=定时，3=告警输出 */
    private int source;

    /** 设备ID */
    private Long deviceId;

    /** 设备名称 */
    private String deviceName;

    /** 告警名称 */
    private String alertName;

    /** 告警级别 */
    private int alertLevel;

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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getSource() {
        return source;
    }

    public void setSource(int source) {
        this.source = source;
    }

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getAlertName() {
        return alertName;
    }

    public void setAlertName(String alertName) {
        this.alertName = alertName;
    }

    public int getAlertLevel() {
        return alertLevel;
    }

    public void setAlertLevel(int alertLevel) {
        this.alertLevel = alertLevel;
    }
}
