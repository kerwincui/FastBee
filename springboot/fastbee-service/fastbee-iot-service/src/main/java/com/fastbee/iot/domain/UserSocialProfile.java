package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class UserSocialProfile {
    /**
     * 第三方系统用户表主键
     */
    private Long socialUserId;

    /**
     * 第三方用户来源
     */
    @Excel(name = "第三方用户来源")
    private String source;

    /**
     * 用户名
     */
    @Excel(name = "用户名")
    private String username;

    /**
     * 用户昵称
     */
    @Excel(name = "用户昵称")
    private String nickname;

    /**
     * 用户头像
     */
    @Excel(name = "用户头像")
    private String avatar;

    /**
     * 绑定状态(0:未绑定,1:绑定)
     */
    @Excel(name = "绑定状态(0:未绑定,1:绑定)")
    private String status;

    /**
     * 第三方具体来源
     */
    private String sourceClient;

    public String getSourceClient() {
        return sourceClient;
    }

    public void setSourceClient(String sourceClient) {
        this.sourceClient = sourceClient;
    }

    public Long getSocialUserId() {
        return socialUserId;
    }

    public void setSocialUserId(Long socialUserId) {
        this.socialUserId = socialUserId;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("socialUserId", getSocialUserId())
                .append("source", getSource())
                .append("status", getStatus())
                .append("username", getUsername())
                .append("nickname", getNickname())
                .append("avatar", getAvatar())
                .toString();
    }

}
