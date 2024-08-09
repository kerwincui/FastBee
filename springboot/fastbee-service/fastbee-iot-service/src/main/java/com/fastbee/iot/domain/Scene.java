package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.List;

/**
 * 场景联动对象 iot_scene
 *
 * @author kerwincui
 * @date 2023-12-27
 */
public class Scene extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 场景ID */
    private Long sceneId;

    /** 场景名称 */
    @Excel(name = "场景名称")
    private String sceneName;

    /** 规则名称 */
    private String chainName;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户名称 */
    @Excel(name = "用户名称")
    private String userName;

    /** 执行条件（1=或、任一条件，2=且、所有条件，3=非，不满足） */
    @Excel(name = "执行条件", readConverterExp = "1==或、任一条件，2=且、所有条件，3=非，不满足")
    private Integer cond;

    /** 静默周期（分钟） */
    @Excel(name = "静默周期", readConverterExp = "分=钟")
    private Integer silentPeriod;

    /** 执行方式（1=串行，顺序执行，2=并行，同时执行） */
    @Excel(name = "执行方式", readConverterExp = "1==串行，顺序执行，2=并行，同时执行")
    private Integer executeMode;

    /** 延时执行（秒钟） */
    @Excel(name = "延时执行", readConverterExp = "秒=钟")
    private Integer executeDelay;

    /** 是否包含告警推送（1=包含，2=不包含） */
    @Excel(name = "是否包含告警推送", readConverterExp = "1==包含，2=不包含")
    private Integer hasAlert;

    /** 场景状态（1-启动，2-停止） */
    @Excel(name = "场景状态", readConverterExp = "1=-启动，2-停止")
    private Integer enable;

    /** 规则数据 */
    @Excel(name = "规则数据")
    private String elData;

    /** 应用名称 */
    @Excel(name = "应用名称")
    private String applicationName;

    /** 接收的触发器列表 */
    private List<SceneScript> triggers;

    /** 接收的执行动作列表 */
    private List<SceneScript> actions;

    /**
     * 执行动作数量
     */
    private Integer actionCount = 0;

    public Integer getActionCount() {
        return actionCount;
    }

    public void setActionCount(Integer actionCount) {
        this.actionCount = actionCount;
    }

    public String getChainName() {
        return chainName;
    }

    public void setChainName(String chainName) {
        this.chainName = chainName;
    }

    public List<SceneScript> getTriggers() {
        return triggers;
    }

    public void setTriggers(List<SceneScript> triggers) {
        this.triggers = triggers;
    }

    public List<SceneScript> getActions() {
        return actions;
    }

    public void setActions(List<SceneScript> actions) {
        this.actions = actions;
    }

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
    public void setCond(Integer cond)
    {
        this.cond = cond;
    }

    public Integer getCond()
    {
        return cond;
    }
    public void setSilentPeriod(Integer silentPeriod)
    {
        this.silentPeriod = silentPeriod;
    }

    public Integer getSilentPeriod()
    {
        return silentPeriod;
    }
    public void setExecuteMode(Integer executeMode)
    {
        this.executeMode = executeMode;
    }

    public Integer getExecuteMode()
    {
        return executeMode;
    }
    public void setExecuteDelay(Integer executeDelay)
    {
        this.executeDelay = executeDelay;
    }

    public Integer getExecuteDelay()
    {
        return executeDelay;
    }
    public void setHasAlert(Integer hasAlert)
    {
        this.hasAlert = hasAlert;
    }

    public Integer getHasAlert()
    {
        return hasAlert;
    }
    public void setEnable(Integer enable)
    {
        this.enable = enable;
    }

    public Integer getEnable()
    {
        return enable;
    }
    public void setElData(String elData)
    {
        this.elData = elData;
    }

    public String getElData()
    {
        return elData;
    }
    public void setApplicationName(String applicationName)
    {
        this.applicationName = applicationName;
    }

    public String getApplicationName()
    {
        return applicationName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("sceneId", getSceneId())
                .append("sceneName", getSceneName())
                .append("userId", getUserId())
                .append("userName", getUserName())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .append("cond", getCond())
                .append("silentPeriod", getSilentPeriod())
                .append("executeMode", getExecuteMode())
                .append("executeDelay", getExecuteDelay())
                .append("hasAlert", getHasAlert())
                .append("enable", getEnable())
                .append("elData", getElData())
                .append("applicationName", getApplicationName())
                .toString();
    }
}
