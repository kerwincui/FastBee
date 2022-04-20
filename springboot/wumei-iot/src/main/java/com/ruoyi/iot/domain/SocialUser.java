package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 用户第三方用户信息对象 iot_social_user
 * 
 * @author json
 * @date 2022-04-18
 */
public class SocialUser extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 第三方系统用户表主键 */
    private Long socialUserId;

    /** 第三方系统的唯一ID */
    @Excel(name = "第三方系统的唯一ID")
    private String uuid;

    /** 第三方用户来源 */
    @Excel(name = "第三方用户来源")
    private String source;

    /** 用户的授权令牌 */
    @Excel(name = "用户的授权令牌")
    private String accessToken;

    /** 第三方用户的授权令牌的有效期（部分平台可能没有） */
    @Excel(name = "第三方用户的授权令牌的有效期", readConverterExp = "部=分平台可能没有")
    private Long expireIn;

    /** 刷新令牌(部分平台可能没有) */
    @Excel(name = "刷新令牌(部分平台可能没有)")
    private String refreshToken;

    /** 第三方用户的 open id（部分平台可能没有） */
    @Excel(name = "第三方用户的 open id", readConverterExp = "部=分平台可能没有")
    private String openId;

    /** 第三方用户的 ID(部分平台可能没有) */
    @Excel(name = "第三方用户的 ID(部分平台可能没有)")
    private String uid;

    /** 个别平台的授权信息（部分平台可能没有） */
    @Excel(name = "个别平台的授权信息", readConverterExp = "部=分平台可能没有")
    private String accessCode;

    /** 第三方用户的 union id(部分平台可能没有) */
    @Excel(name = "第三方用户的 union id(部分平台可能没有)")
    private String unionId;

    /** 第三方用户授予的权限(部分平台可能没有) */
    @Excel(name = "第三方用户授予的权限(部分平台可能没有)")
    private String scope;

    /** 个别平台的授权信息（部分平台可能没有） */
    @Excel(name = "个别平台的授权信息", readConverterExp = "部=分平台可能没有")
    private String tokenType;

    /** id token（部分平台可能没有） */
    @Excel(name = "id token", readConverterExp = "部=分平台可能没有")
    private String idToken;

    /** 小米平台用户的附带属性（部分平台可能没有） */
    @Excel(name = "小米平台用户的附带属性", readConverterExp = "部=分平台可能没有")
    private String macAlgorithm;

    /** 小米平台用户的附带属性(部分平台可能没有) */
    @Excel(name = "小米平台用户的附带属性(部分平台可能没有)")
    private String macKey;

    /** 用户的授权code（部分平台可能没有） */
    @Excel(name = "用户的授权code", readConverterExp = "部=分平台可能没有")
    private String code;

    /** Twitter平台用户的附带属性(部分平台可能没有) */
    @Excel(name = "Twitter平台用户的附带属性(部分平台可能没有)")
    private String oauthToken;

    /** Twitter平台用户的附带属性(部分平台可能没有) */
    @Excel(name = "Twitter平台用户的附带属性(部分平台可能没有)")
    private String oauthTokenSecret;

    /** 删除标记位(0代表存在,2代表删除) */
    private String delFlag;

    /** 绑定状态(0:未绑定,1:绑定) */
    @Excel(name = "绑定状态(0:未绑定,1:绑定)")
    private String status;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long sysUserId;

    /** 用户名 */
    @Excel(name = "用户名")
    private String username;

    /** 用户昵称 */
    @Excel(name = "用户昵称")
    private String nickname;

    /** 用户头像 */
    @Excel(name = "用户头像")
    private String avatar;

    /** 用户性别 */
    @Excel(name = "用户性别")
    private Integer gender;

    public void setSocialUserId(Long socialUserId)
    {
        this.socialUserId = socialUserId;
    }

    public Long getSocialUserId()
    {
        return socialUserId;
    }
    public void setUuid(String uuid)
    {
        this.uuid = uuid;
    }

    public String getUuid()
    {
        return uuid;
    }
    public void setSource(String source)
    {
        this.source = source;
    }

    public String getSource()
    {
        return source;
    }
    public void setAccessToken(String accessToken)
    {
        this.accessToken = accessToken;
    }

    public String getAccessToken()
    {
        return accessToken;
    }
    public void setExpireIn(Long expireIn)
    {
        this.expireIn = expireIn;
    }

    public Long getExpireIn()
    {
        return expireIn;
    }
    public void setRefreshToken(String refreshToken)
    {
        this.refreshToken = refreshToken;
    }

    public String getRefreshToken()
    {
        return refreshToken;
    }
    public void setOpenId(String openId)
    {
        this.openId = openId;
    }

    public String getOpenId()
    {
        return openId;
    }
    public void setUid(String uid)
    {
        this.uid = uid;
    }

    public String getUid()
    {
        return uid;
    }
    public void setAccessCode(String accessCode)
    {
        this.accessCode = accessCode;
    }

    public String getAccessCode()
    {
        return accessCode;
    }
    public void setUnionId(String unionId)
    {
        this.unionId = unionId;
    }

    public String getUnionId()
    {
        return unionId;
    }
    public void setScope(String scope)
    {
        this.scope = scope;
    }

    public String getScope()
    {
        return scope;
    }
    public void setTokenType(String tokenType)
    {
        this.tokenType = tokenType;
    }

    public String getTokenType()
    {
        return tokenType;
    }
    public void setIdToken(String idToken)
    {
        this.idToken = idToken;
    }

    public String getIdToken()
    {
        return idToken;
    }
    public void setMacAlgorithm(String macAlgorithm)
    {
        this.macAlgorithm = macAlgorithm;
    }

    public String getMacAlgorithm()
    {
        return macAlgorithm;
    }
    public void setMacKey(String macKey)
    {
        this.macKey = macKey;
    }

    public String getMacKey()
    {
        return macKey;
    }
    public void setCode(String code)
    {
        this.code = code;
    }

    public String getCode()
    {
        return code;
    }
    public void setOauthToken(String oauthToken)
    {
        this.oauthToken = oauthToken;
    }

    public String getOauthToken()
    {
        return oauthToken;
    }
    public void setOauthTokenSecret(String oauthTokenSecret)
    {
        this.oauthTokenSecret = oauthTokenSecret;
    }

    public String getOauthTokenSecret()
    {
        return oauthTokenSecret;
    }
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag()
    {
        return delFlag;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getStatus()
    {
        return status;
    }
    public void setSysUserId(Long sysUserId)
    {
        this.sysUserId = sysUserId;
    }

    public Long getSysUserId()
    {
        return sysUserId;
    }
    public void setUsername(String username)
    {
        this.username = username;
    }

    public String getUsername()
    {
        return username;
    }
    public void setNickname(String nickname)
    {
        this.nickname = nickname;
    }

    public String getNickname()
    {
        return nickname;
    }
    public void setAvatar(String avatar)
    {
        this.avatar = avatar;
    }

    public String getAvatar()
    {
        return avatar;
    }
    public void setGender(Integer gender)
    {
        this.gender = gender;
    }

    public Integer getGender()
    {
        return gender;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("socialUserId", getSocialUserId())
                .append("uuid", getUuid())
                .append("source", getSource())
                .append("accessToken", getAccessToken())
                .append("expireIn", getExpireIn())
                .append("refreshToken", getRefreshToken())
                .append("openId", getOpenId())
                .append("uid", getUid())
                .append("accessCode", getAccessCode())
                .append("unionId", getUnionId())
                .append("scope", getScope())
                .append("tokenType", getTokenType())
                .append("idToken", getIdToken())
                .append("macAlgorithm", getMacAlgorithm())
                .append("macKey", getMacKey())
                .append("code", getCode())
                .append("oauthToken", getOauthToken())
                .append("oauthTokenSecret", getOauthTokenSecret())
                .append("createTime", getCreateTime())
                .append("createBy", getCreateBy())
                .append("updateTime", getUpdateTime())
                .append("updateBy", getUpdateBy())
                .append("delFlag", getDelFlag())
                .append("status", getStatus())
                .append("sysUserId", getSysUserId())
                .append("username", getUsername())
                .append("nickname", getNickname())
                .append("avatar", getAvatar())
                .append("gender", getGender())
                .toString();
    }
}