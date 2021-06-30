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
package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 分组对象 iot_group
 * 
 * @author kerwincui
 * @date 2021-05-18
 */
public class IotGroup extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备分组 */
    private Long groupId;

    /** 用户 */
    @Excel(name = "用户")
    private Long userId;

    /** 分组名称 */
    @Excel(name = "分组名称")
    private String groupName;

    /** 排序 */
    @Excel(name = "排序")
    private Integer groupOrder;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public void setGroupId(Long groupId) 
    {
        this.groupId = groupId;
    }

    public Long getGroupId() 
    {
        return groupId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setGroupName(String groupName) 
    {
        this.groupName = groupName;
    }

    public String getGroupName() 
    {
        return groupName;
    }
    public void setGroupOrder(Integer groupOrder) 
    {
        this.groupOrder = groupOrder;
    }

    public Integer getGroupOrder() 
    {
        return groupOrder;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("groupId", getGroupId())
            .append("userId", getUserId())
            .append("groupName", getGroupName())
            .append("groupOrder", getGroupOrder())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
