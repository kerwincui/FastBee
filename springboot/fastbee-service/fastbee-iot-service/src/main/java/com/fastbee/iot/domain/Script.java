package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 规则引擎脚本对象 rule_script
 *
 * @author lizhuangpeng
 * @date 2023-07-01
 */
public class Script extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 脚本ID */
    @Excel(name = "脚本ID")
    private String scriptId;

    /** 用户ID */
    private Long userId;

    /** 用名称 */
    private String userName;

    /** 应用名 */
    @Excel(name = "应用名")
    private String applicationName;

    /** 脚本名 */
    @Excel(name = "脚本名")
    private String scriptName;

    /** 脚本数据 */
    @Excel(name = "脚本数据")
    private String scriptData;

    /** 脚本类型:script=普通脚本，switch_script=选择脚本,if_script=条件脚本，for_script=数量循环脚本，while_script=条件循环，break_script=退出循环脚本 */
    @Excel(name = "脚本类型")
    private String scriptType;

    /** 场景ID */
    private Long sceneId;

    /** 脚本类型(1=设备上报，2=平台下发，3=设备上线，4=设备离线) */
    private Integer scriptEvent;

    /** 脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储) */
    private Integer scriptAction;

    /** 脚本用途(1=数据流，2=触发器，3=执行动作) */
    private Integer scriptPurpose;

    /** 脚本执行顺序，值越大优先级越高 */
    private Integer scriptOrder;

    /** 脚本语言（groovy | qlexpress | js | python | lua | aviator） */
    @Excel(name = "脚本语言", readConverterExp = "groovy,,qlexpress,js,python,lua,aviator")
    private String scriptLanguage;

    /** 产品ID */
    private Long productId;

    /** 产品名称 */

    private String productName;

    /**是否生效*/
    private Integer enable;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Long getSceneId() {
        return sceneId;
    }

    public void setSceneId(Long sceneId) {
        this.sceneId = sceneId;
    }

    public Integer getScriptEvent() {
        return scriptEvent;
    }

    public void setScriptEvent(Integer scriptEvent) {
        this.scriptEvent = scriptEvent;
    }

    public Integer getScriptAction() {
        return scriptAction;
    }

    public void setScriptAction(Integer scriptAction) {
        this.scriptAction = scriptAction;
    }

    public Integer getScriptPurpose() {
        return scriptPurpose;
    }

    public void setScriptPurpose(Integer scriptPurpose) {
        this.scriptPurpose = scriptPurpose;
    }

    public Integer getScriptOrder() {
        return scriptOrder;
    }

    public void setScriptOrder(Integer scriptOrder) {
        this.scriptOrder = scriptOrder;
    }

    public void setApplicationName(String applicationName)
    {
        this.applicationName = applicationName;
    }

    public String getApplicationName()
    {
        return applicationName;
    }
    public void setScriptId(String scriptId)
    {
        this.scriptId = scriptId;
    }

    public String getScriptId()
    {
        return scriptId;
    }
    public void setScriptName(String scriptName)
    {
        this.scriptName = scriptName;
    }

    public String getScriptName()
    {
        return scriptName;
    }
    public void setScriptData(String scriptData)
    {
        this.scriptData = scriptData;
    }

    public String getScriptData()
    {
        return scriptData;
    }
    public void setScriptType(String scriptType)
    {
        this.scriptType = scriptType;
    }

    public String getScriptType()
    {
        return scriptType;
    }
    public void setScriptLanguage(String scriptLanguage)
    {
        this.scriptLanguage = scriptLanguage;
    }

    public String getScriptLanguage()
    {
        return scriptLanguage;
    }
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("applicationName", getApplicationName())
            .append("scriptId", getScriptId())
            .append("scriptName", getScriptName())
            .append("scriptData", getScriptData())
            .append("scriptType", getScriptType())
            .append("scriptLanguage", getScriptLanguage())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
