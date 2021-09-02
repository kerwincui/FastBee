package com.ruoyi.system.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 【请填写功能名称】对象 t_user_login_log
 *
 * @author wxy
 * @date 2021-08-26
 */
public class TUserLoginLog extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * $column.columnComment
     */
    private Long id;

    /**
     * 用户类型
     */
    @Excel(name = "用户类型")
    private String userType;

    /**
     * $column.columnComment
     */
    @Excel(name = "用户类型")
    private Long userId;

    /**
     * $column.columnComment
     */
    @Excel(name = "用户类型")
    private String code;

    /**
     * $column.columnComment
     */
    @Excel(name = "用户类型")
    private String openId;

    /**
     * IP地址
     */
    @Excel(name = "IP地址")
    private String ip;

    /**
     * $column.columnComment
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "IP地址", width = 30, dateFormat = "yyyy-MM-dd")
    private Date gmtTime;

    /**
     * $column.columnComment
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "IP地址", width = 30, dateFormat = "yyyy-MM-dd")
    private Date gmtUpdate;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getOpenId() {
        return openId;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getIp() {
        return ip;
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
                .append("userType", getUserType())
                .append("userId", getUserId())
                .append("code", getCode())
                .append("openId", getOpenId())
                .append("ip", getIp())
                .append("gmtTime", getGmtTime())
                .append("gmtUpdate", getGmtUpdate())
                .toString();
    }
}
