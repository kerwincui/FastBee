package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 场景联动对象 iot_scene
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
public class Scene extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 场景ID */
    private Long sceneId;

    /** 场景名称 */
    @Excel(name = "场景名称")
    private String sceneName;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户名称 */
    @Excel(name = "用户名称")
    private String userName;

    /** 触发器 */
    @Excel(name = "触发器")
    private String triggers;

    /** 执行动作 */
    @Excel(name = "执行动作")
    private String actions;

    public void setSceneId(Long sceneId) 
    {
        this.sceneId = sceneId;
    }

    public Long getSceneId() 
    {
        return sceneId;
    }
    public void setSceneName(String sceneName) 
    {
        this.sceneName = sceneName;
    }

    public String getSceneName() 
    {
        return sceneName;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setUserName(String userName) 
    {
        this.userName = userName;
    }

    public String getUserName() 
    {
        return userName;
    }
    public void setTriggers(String triggers) 
    {
        this.triggers = triggers;
    }

    public String getTriggers() 
    {
        return triggers;
    }
    public void setActions(String actions) 
    {
        this.actions = actions;
    }

    public String getActions() 
    {
        return actions;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("sceneId", getSceneId())
            .append("sceneName", getSceneName())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("triggers", getTriggers())
            .append("actions", getActions())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
