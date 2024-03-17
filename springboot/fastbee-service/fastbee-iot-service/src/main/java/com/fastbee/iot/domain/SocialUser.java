package com.fastbee.iot.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 用户第三方用户信息对象 iot_social_user
 *
 * @author json
 * @date 2022-04-18
 */
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "SocialUser", description = "用户第三方用户信息对象 iot_social_user")
@Accessors(chain = true)
@Data
public class SocialUser extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 第三方系统用户表主键 */
    @ApiModelProperty("第三方系统用户表主键")
    private Long socialUserId;

    /** 第三方系统的唯一ID */
    @ApiModelProperty("第三方系统的唯一ID")
    @Excel(name = "第三方系统的唯一ID")
    private String uuid;

    /** 第三方用户来源 */
    @ApiModelProperty("第三方用户来源")
    @Excel(name = "第三方用户来源")
    private String source;

    /** 用户的授权令牌 */
    @ApiModelProperty("用户的授权令牌")
    @Excel(name = "用户的授权令牌")
    private String accessToken;

    /** 第三方用户的授权令牌的有效期（部分平台可能没有） */
    @ApiModelProperty(value = "第三方用户的授权令牌的有效期", notes = "（部分平台可能没有）")
    @Excel(name = "第三方用户的授权令牌的有效期", readConverterExp = "部=分平台可能没有")
    private Long expireIn;

    /** 刷新令牌(部分平台可能没有) */
    @ApiModelProperty(value = "刷新令牌", notes = "（部分平台可能没有）")
    @Excel(name = "刷新令牌(部分平台可能没有)")
    private String refreshToken;

    /** 第三方用户的 open id（部分平台可能没有） */
    @ApiModelProperty(value = "第三方用户的 open id", notes = "（部分平台可能没有）")
    @Excel(name = "第三方用户的 open id", readConverterExp = "部=分平台可能没有")
    private String openId;

    /** 第三方用户的 ID(部分平台可能没有) */
    @ApiModelProperty(value = "第三方用户的 ID", notes = "(部分平台可能没有)")
    @Excel(name = "第三方用户的 ID(部分平台可能没有)")
    private String uid;

    /** 个别平台的授权信息（部分平台可能没有） */
    @ApiModelProperty(value = "个别平台的授权信息", notes = "（部分平台可能没有）")
    @Excel(name = "个别平台的授权信息", readConverterExp = "部=分平台可能没有")
    private String accessCode;

    /** 第三方用户的 union id(部分平台可能没有) */
    @ApiModelProperty(value = "第三方用户的 union id", notes = "(部分平台可能没有)")
    @Excel(name = "第三方用户的 union id(部分平台可能没有)")
    private String unionId;

    /** 第三方用户授予的权限(部分平台可能没有) */
    @ApiModelProperty(value = "第三方用户授予的权限", notes = "(部分平台可能没有)")
    @Excel(name = "第三方用户授予的权限(部分平台可能没有)")
    private String scope;

    /** 个别平台的授权信息（部分平台可能没有） */
    @ApiModelProperty(value = "个别平台的授权信息", notes = "（部分平台可能没有）")
    @Excel(name = "个别平台的授权信息", readConverterExp = "部=分平台可能没有")
    private String tokenType;

    /** id token（部分平台可能没有） */
    @ApiModelProperty(value = "id token", notes = "（部分平台可能没有）")
    @Excel(name = "id token", readConverterExp = "部=分平台可能没有")
    private String idToken;

    /** 小米平台用户的附带属性（部分平台可能没有） */
    @ApiModelProperty(value = "小米平台用户的附带属性", notes = "（部分平台可能没有）")
    @Excel(name = "小米平台用户的附带属性", readConverterExp = "部=分平台可能没有")
    private String macAlgorithm;

    /** 小米平台用户的附带属性(部分平台可能没有) */
    @ApiModelProperty(value = "小米平台用户的附带属性", notes = "(部分平台可能没有) ")
    @Excel(name = "小米平台用户的附带属性(部分平台可能没有)")
    private String macKey;

    /** 用户的授权code（部分平台可能没有） */
    @ApiModelProperty(value = "用户的授权code", notes = "（部分平台可能没有）")
    @Excel(name = "用户的授权code", readConverterExp = "部=分平台可能没有")
    private String code;

    /** Twitter平台用户的附带属性(部分平台可能没有) */
    @ApiModelProperty(value = "Twitter平台用户的附带属性", notes = "(部分平台可能没有) ")
    @Excel(name = "Twitter平台用户的附带属性(部分平台可能没有)")
    private String oauthToken;

    /** Twitter平台用户的附带属性(部分平台可能没有) */
    @ApiModelProperty(value = "Twitter平台用户的附带属性", notes = "(部分平台可能没有)")
    @Excel(name = "Twitter平台用户的附带属性(部分平台可能没有)")
    private String oauthTokenSecret;

    /** 删除标记位(0代表存在,2代表删除) */
    @ApiModelProperty("删除标记位")
    private String delFlag;

    /** 绑定状态(0:未绑定,1:绑定) */
    @ApiModelProperty(value = "绑定状态", notes = "(0:未绑定,1:绑定)")
    @Excel(name = "绑定状态(0:未绑定,1:绑定)")
    private String status;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户ID")
    private Long sysUserId;

    /** 用户名 */
    @ApiModelProperty("用户名")
    @Excel(name = "用户名")
    private String username;

    /** 用户昵称 */
    @ApiModelProperty("用户昵称")
    @Excel(name = "用户昵称")
    private String nickname;

    /** 用户头像 */
    @ApiModelProperty("用户头像")
    @Excel(name = "用户头像")
    private String avatar;

    /** 用户性别 */
    @ApiModelProperty("用户性别")
    @Excel(name = "用户性别")
    private Integer gender;
    /** 三方登录具体来源 */
    @ApiModelProperty("三方登录具体来源")
    @Excel(name = "三方登录具体来源")
    private String sourceClient;

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
