package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 云云对接对象 oauth_client_details
 * 
 * @author kerwincui
 * @date 2022-02-07
 */
public class OauthClientDetails extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 客户端ID */
    @Excel(name = "客户端ID")
    private String clientId;

    /** 资源 */
    @Excel(name = "资源")
    private String resourceIds;

    /** 客户端秘钥 */
    private String clientSecret;

    /** 权限范围 */
    @Excel(name = "权限范围")
    private String scope;

    /** 授权模式 */
    @Excel(name = "授权模式")
    private String authorizedGrantTypes;

    /** 回调地址 */
    @Excel(name = "回调地址")
    private String webServerRedirectUri;

    /** 权限 */
    @Excel(name = "权限")
    private String authorities;

    /** access token有效时间 */
    @Excel(name = "access token有效时间")
    private Long accessTokenValidity;

    /** refresh token有效时间 */
    @Excel(name = "refresh token有效时间")
    private Long refreshTokenValidity;

    /** 预留的字段 */
    @Excel(name = "预留的字段")
    private String additionalInformation;

    /** 自动授权 */
    @Excel(name = "自动授权")
    private String autoapprove;

    /** 平台 */
    @Excel(name = "平台")
    private Integer type;

    public void setClientId(String clientId) 
    {
        this.clientId = clientId;
    }

    public String getClientId() 
    {
        return clientId;
    }
    public void setResourceIds(String resourceIds) 
    {
        this.resourceIds = resourceIds;
    }

    public String getResourceIds() 
    {
        return resourceIds;
    }
    public void setClientSecret(String clientSecret) 
    {
        this.clientSecret = clientSecret;
    }

    public String getClientSecret() 
    {
        return clientSecret;
    }
    public void setScope(String scope) 
    {
        this.scope = scope;
    }

    public String getScope() 
    {
        return scope;
    }
    public void setAuthorizedGrantTypes(String authorizedGrantTypes) 
    {
        this.authorizedGrantTypes = authorizedGrantTypes;
    }

    public String getAuthorizedGrantTypes() 
    {
        return authorizedGrantTypes;
    }
    public void setWebServerRedirectUri(String webServerRedirectUri) 
    {
        this.webServerRedirectUri = webServerRedirectUri;
    }

    public String getWebServerRedirectUri() 
    {
        return webServerRedirectUri;
    }
    public void setAuthorities(String authorities) 
    {
        this.authorities = authorities;
    }

    public String getAuthorities() 
    {
        return authorities;
    }
    public void setAccessTokenValidity(Long accessTokenValidity) 
    {
        this.accessTokenValidity = accessTokenValidity;
    }

    public Long getAccessTokenValidity() 
    {
        return accessTokenValidity;
    }
    public void setRefreshTokenValidity(Long refreshTokenValidity) 
    {
        this.refreshTokenValidity = refreshTokenValidity;
    }

    public Long getRefreshTokenValidity() 
    {
        return refreshTokenValidity;
    }
    public void setAdditionalInformation(String additionalInformation) 
    {
        this.additionalInformation = additionalInformation;
    }

    public String getAdditionalInformation() 
    {
        return additionalInformation;
    }
    public void setAutoapprove(String autoapprove) 
    {
        this.autoapprove = autoapprove;
    }

    public String getAutoapprove() 
    {
        return autoapprove;
    }
    public void setType(Integer type) 
    {
        this.type = type;
    }

    public Integer getType() 
    {
        return type;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("clientId", getClientId())
            .append("resourceIds", getResourceIds())
            .append("clientSecret", getClientSecret())
            .append("scope", getScope())
            .append("authorizedGrantTypes", getAuthorizedGrantTypes())
            .append("webServerRedirectUri", getWebServerRedirectUri())
            .append("authorities", getAuthorities())
            .append("accessTokenValidity", getAccessTokenValidity())
            .append("refreshTokenValidity", getRefreshTokenValidity())
            .append("additionalInformation", getAdditionalInformation())
            .append("autoapprove", getAutoapprove())
            .append("type", getType())
            .toString();
    }
}
