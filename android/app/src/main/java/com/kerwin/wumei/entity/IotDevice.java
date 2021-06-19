/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/

package com.kerwin.wumei.entity;

import java.math.BigDecimal;
import java.util.Date;

public class IotDevice {
    /** 序号 */
    private Long deviceId;

    /** 编号 */
    private String deviceNum;

    /** 分类 */
    private String categoryName;

    /** 名称 */
    private String deviceName;

    /** 固件版本 */
    private String firmwareVersion;

    /** 用户 */
    private String ownerId;

    /** 备注 */
    private String remark;

    /** 设备温度 */
    private String deviceTemp;

    /** 创建时间 */
    private String createTime;

    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId()
    {
        return deviceId;
    }
    public void setDeviceNum(String deviceNum)
    {
        this.deviceNum = deviceNum;
    }

    public String getDeviceNum()
    {
        return deviceNum;
    }
    public void setCategoryId(String categoryId)
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName()
    {
        return categoryName;
    }
    public void setDeviceName(String deviceName)
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName()
    {
        return deviceName;
    }
    public void setFirmwareVersion(String firmwareVersion)
    {
        this.firmwareVersion = firmwareVersion;
    }

    public String getFirmwareVersion()
    {
        return firmwareVersion;
    }
    public void setOwnerId(String ownerId)
    {
        this.ownerId = ownerId;
    }

    public String getOwnerId()
    {
        return ownerId;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    public String getRemark()
    {
        return remark;
    }

    public void setDeviceTemp(String deviceTemperature)
    {
        this.deviceTemp = deviceTemperature;
    }
    public String getDeviceTemp()
    {
        return deviceTemp;
    }

    public void setCreateTime(String createTime)
    {
        this.createTime = createTime;
    }
    public String getCreateTime()
    {
        return createTime;
    }
}
