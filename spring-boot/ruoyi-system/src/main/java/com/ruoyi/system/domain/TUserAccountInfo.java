package com.ruoyi.system.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 小程序用户对象 t_user_account_info
 *
 * @author wxy
 * @date 2021-08-26
 */
public class TUserAccountInfo extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * $column.columnComment
     */
    private Long id;

    /**
     * sessionKey
     */
    @Excel(name = "sessionKey")
    private String sessionkey;

    /**
     * accessToken
     */
    @Excel(name = "accessToken")
    private String accessToken;

    /**
     * $column.columnComment
     */
    @Excel(name = "accessToken")
    private String openId;

    /**
     * $column.columnComment
     */
    @Excel(name = "accessToken")
    private String unionId;

    /**
     * 昵称
     */
    @Excel(name = "昵称")
    private String nickName;

    /**
     * 头像
     */
    @Excel(name = "头像")
    private String avatar;

    /**
     * 手机号
     */
    @Excel(name = "手机号")
    private String phone;

    /**
     * 生日
     */
    @Excel(name = "生日")
    private String birthday;

    /**
     * 用户状态：0-冻结，1-正常
     */
    @Excel(name = "用户状态：0-冻结，1-正常")
    private Long status;

    /**
     * 国家
     */
    @Excel(name = "国家")
    private String country;

    /**
     * 省份
     */
    @Excel(name = "省份")
    private String province;

    /**
     * 城市
     */
    @Excel(name = "城市")
    private String city;

    /**
     * 地址
     */
    @Excel(name = "地址")
    private String address;

    /**
     * 用户类型：0-未授权用户，1-消费者，2-商家
     */
    @Excel(name = "用户类型：0-未授权用户，1-消费者，2-商家")
    private Long userType;

    /**
     * 绑定的管理员编号
     */
    @Excel(name = "绑定的管理员编号")
    private Long adminId;

    /**
     * $column.columnComment
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "绑定的管理员编号", width = 30, dateFormat = "yyyy-MM-dd")
    private Date lastLoginTime;

    /**
     * $column.columnComment
     */
    @Excel(name = "绑定的管理员编号")
    private String lastLoginIp;

    /**
     * $column.columnComment
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "绑定的管理员编号", width = 30, dateFormat = "yyyy-MM-dd")
    private Date gmtTime;

    /**
     * $column.columnComment
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "绑定的管理员编号", width = 30, dateFormat = "yyyy-MM-dd")
    private Date gmtUpdate;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setSessionkey(String sessionkey) {
        this.sessionkey = sessionkey;
    }

    public String getSessionkey() {
        return sessionkey;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getOpenId() {
        return openId;
    }

    public void setUnionId(String unionId) {
        this.unionId = unionId;
    }

    public String getUnionId() {
        return unionId;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPhone() {
        return phone;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public Long getStatus() {
        return status;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCountry() {
        return country;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getProvince() {
        return province;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddress() {
        return address;
    }

    public void setUserType(Long userType) {
        this.userType = userType;
    }

    public Long getUserType() {
        return userType;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setGmtTime(Date gmtTime) {
        this.gmtTime = gmtTime;
    }

    public Date getGmtTime() {
        return gmtTime;
    }

    public void setGmtUpdate(Date gmtUpdate) {
        this.gmtUpdate = gmtUpdate;
    }

    public Date getGmtUpdate() {
        return gmtUpdate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("sessionkey", getSessionkey())
                .append("accessToken", getAccessToken())
                .append("openId", getOpenId())
                .append("unionId", getUnionId())
                .append("nickName", getNickName())
                .append("avatar", getAvatar())
                .append("phone", getPhone())
                .append("birthday", getBirthday())
                .append("status", getStatus())
                .append("country", getCountry())
                .append("province", getProvince())
                .append("city", getCity())
                .append("address", getAddress())
                .append("userType", getUserType())
                .append("adminId", getAdminId())
                .append("lastLoginTime", getLastLoginTime())
                .append("lastLoginIp", getLastLoginIp())
                .append("gmtTime", getGmtTime())
                .append("gmtUpdate", getGmtUpdate())
                .toString();
    }
}
