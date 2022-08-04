package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 产品对象 iot_product
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class Product extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 产品ID */
    private Long productId;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 产品分类ID */
    @Excel(name = "产品分类ID")
    private Long categoryId;

    /** 产品分类名称 */
    @Excel(name = "产品分类名称")
    private String categoryName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    /** 是否系统通用（0-否，1-是） */
    @Excel(name = "是否系统通用", readConverterExp = "0=-否，1-是")
    private Integer isSys;

    /** 是否启用授权码（0-否，1-是） */
    @Excel(name = "是否启用授权码", readConverterExp = "0=-否，1-是")
    private Integer isAuthorize;

    /** mqtt账号 */
    private String mqttAccount;

    /** mqtt密码 */
    private String mqttPassword;

    /** 产品秘钥 */
    private String mqttSecret;

    public String getMqttSecret() {
        return mqttSecret;
    }

    public void setMqttSecret(String mqttSecret) {
        this.mqttSecret = mqttSecret;
    }

    /** 状态（1-未发布，2-已发布，不能修改） */
    @Excel(name = "状态", readConverterExp = "1==未发布，2=已发布，不能修改")
    private Integer status;

    /** 设备类型（1-直连设备、2-网关子设备、3-网关设备） */
    @Excel(name = "设备类型", readConverterExp = "1=直连设备、2=网关子设备、3=网关设备")
    private Integer deviceType;

    /** 联网方式（1=-wifi、2-蜂窝(2G/3G/4G/5G)、3-以太网、4-其他） */
    @Excel(name = "联网方式", readConverterExp = "1=-wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他")
    private Integer networkMethod;

    /** 认证方式（1-账号密码、2-证书、3-Http） */
    @Excel(name = "认证方式", readConverterExp = "1=账号密码、2=证书、3=Http")
    private Integer vertificateMethod;

    /** 图片地址 */
    private String imgUrl;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    /** 物模型Json **/
    private String thingsModelsJson;

    public String getThingsModelsJson() {
        return thingsModelsJson;
    }

    public void setThingsModelsJson(String thingsModelsJson) {
        this.thingsModelsJson = thingsModelsJson;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }
    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }
    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }
    public void setCategoryName(String categoryName) 
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName() 
    {
        return categoryName;
    }
    public void setTenantId(Long tenantId) 
    {
        this.tenantId = tenantId;
    }

    public Long getTenantId() 
    {
        return tenantId;
    }

    public void setTenantName(String tenantName) 
    {
        this.tenantName = tenantName;
    }
    public String getTenantName() 
    {
        return tenantName;
    }

    public void setIsSys(Integer isSys) 
    {
        this.isSys = isSys;
    }
    public Integer getIsSys() 
    {
        return isSys;
    }

    public void setIsAuthorize(Integer isAuthorize) {this.isAuthorize = isAuthorize;}
    public Integer getIsAuthorize() {return isAuthorize;}

    public void setMqttAccount(String mqttAccount)
    {
        this.mqttAccount = mqttAccount;
    }
    public String getMqttAccount()
    {
        return mqttAccount;
    }

    public void setMqttPassword(String mqttPassword)
    {
        this.mqttPassword = mqttPassword;
    }
    public String getMqttPassword()
    {
        return mqttPassword;
    }

    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }
    public void setDeviceType(Integer deviceType) 
    {
        this.deviceType = deviceType;
    }

    public Integer getDeviceType() 
    {
        return deviceType;
    }
    public void setNetworkMethod(Integer networkMethod) 
    {
        this.networkMethod = networkMethod;
    }

    public Integer getNetworkMethod() 
    {
        return networkMethod;
    }
    public void setVertificateMethod(Integer vertificateMethod) 
    {
        this.vertificateMethod = vertificateMethod;
    }

    public Integer getVertificateMethod() 
    {
        return vertificateMethod;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("categoryId", getCategoryId())
            .append("categoryName", getCategoryName())
            .append("tenantId", getTenantId())
            .append("tenantName", getTenantName())
            .append("isSys", getIsSys())
            .append("isAuthorize", getIsAuthorize())
            .append("status", getStatus())
            .append("deviceType", getDeviceType())
            .append("networkMethod", getNetworkMethod())
            .append("vertificateMethod", getVertificateMethod())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
