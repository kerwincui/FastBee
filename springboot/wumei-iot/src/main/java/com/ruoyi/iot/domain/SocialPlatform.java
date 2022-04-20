package com.ruoyi.iot.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 第三方登录平台控制对象 iot_social_platform
 *
 * @author kerwincui
 * @date 2022-04-11
 */
public class SocialPlatform extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 第三方登录平台主键
     */
    private Long socialPlatformId;

    /**
     * 第三方登录平台
     */
    @Excel(name = "第三方登录平台")
    private String platform;

    /**
     * 0、内部上线 1、上线 2、下线
     */
    @Excel(name = "0、内部上线 1、上线 2、下线")
    private String status;

    /**
     * 第三方平台申请Id
     */
    @Excel(name = "第三方平台申请Id")
    private String clientId;

    /**
     * 第三方平台密钥
     */
    @Excel(name = "第三方平台密钥")
    private String secretKey;

    /**
     * 用户认证后跳转地址
     */
    @Excel(name = "用户认证后跳转地址")
    private String redirectUri;

    /**
     * 删除标记位(0代表存在，2代表删除)
     */
    private String delFlag;

    /**
     * 绑定注册登录uri
     */
    @Excel(name = "绑定注册登录uri")
    private String bindUri;

    /**
     * 跳转登录uri
     */
    @Excel(name = "跳转登录uri")
    private String redirectLoginUri;

    /**
     * 错误提示uri
     */
    @Excel(name = "错误提示uri")
    private String errorMsgUri;

    public Long getSocialPlatformId() {
        return socialPlatformId;
    }

    public void setSocialPlatformId(Long socialPlatformId) {
        this.socialPlatformId = socialPlatformId;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getSecretKey() {
        return secretKey;
    }

    public void setSecretKey(String secretKey) {
        this.secretKey = secretKey;
    }

    public String getRedirectUri() {
        return redirectUri;
    }

    public void setRedirectUri(String redirectUri) {
        this.redirectUri = redirectUri;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public String getBindUri() {
        return bindUri;
    }

    public void setBindUri(String bindUri) {
        this.bindUri = bindUri;
    }

    public String getRedirectLoginUri() {
        return redirectLoginUri;
    }

    public void setRedirectLoginUri(String redirectLoginUri) {
        this.redirectLoginUri = redirectLoginUri;
    }

    public String getErrorMsgUri() {
        return errorMsgUri;
    }

    public void setErrorMsgUri(String errorMsgUri) {
        this.errorMsgUri = errorMsgUri;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("socialPlatformId", getSocialPlatformId())
                .append("platform", getPlatform())
                .append("status", getStatus())
                .append("clientId", getClientId())
                .append("secretKey", getSecretKey())
                .append("redirectUri", getRedirectUri())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .append("updateBy", getUpdateBy())
                .append("remark", getRemark())
                .append("bindUri", getBindUri())
                .append("redirectLoginUri", getRedirectLoginUri())
                .append("errorMsgUri", getErrorMsgUri())
                .toString();
    }

}
