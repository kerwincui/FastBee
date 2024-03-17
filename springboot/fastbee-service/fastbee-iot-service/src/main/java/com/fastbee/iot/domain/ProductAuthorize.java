package com.fastbee.iot.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 产品授权码对象 iot_product_authorize
 * 
 * @author kami
 * @date 2022-04-11
 */
@ApiModel(value = "ProductAuthorize", description = "产品授权码对象 iot_product_authorize")
public class ProductAuthorize extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 授权码ID */
    @ApiModelProperty("授权码ID")
    private Long authorizeId;

    /** 授权码 */
    @ApiModelProperty("授权码")
    @Excel(name = "授权码")
    private String authorizeCode;

    /** 产品ID */
    @ApiModelProperty("产品ID")
    @Excel(name = "产品ID")
    private Long productId;

    /** 设备ID */
    @ApiModelProperty("设备ID")
    @Excel(name = "设备ID")
    private Long deviceId;

    /** 设备编号 */
    @ApiModelProperty("设备编号")
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户名称 */
    @ApiModelProperty("用户名称")
    @Excel(name = "用户名称")
    private String userName;

    /** 状态（1-未发布，2-已发布，不能修改） */
    @ApiModelProperty(value = "状态", notes = "（1-未发布，2-已发布，不能修改）")
    @Excel(name = "状态", readConverterExp = "1=未使用,2=已使用")
    private Integer status;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;

    public ProductAuthorize() {
    }

    public ProductAuthorize(String authorizeCode, Long productId) {
        this.authorizeCode = authorizeCode;
        this.productId = productId;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }
    public Integer getStatus()
    {
        return status;
    }
    public void setAuthorizeId(Long authorizeId)
    {
        this.authorizeId = authorizeId;
    }

    public Long getAuthorizeId() 
    {
        return authorizeId;
    }
    public void setAuthorizeCode(String authorizeCode) 
    {
        this.authorizeCode = authorizeCode;
    }

    public String getAuthorizeCode() 
    {
        return authorizeCode;
    }
    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }
    public void setDeviceId(Long deviceId) 
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId() 
    {
        return deviceId;
    }
    public void setSerialNumber(String serialNumber) 
    {
        this.serialNumber = serialNumber;
    }

    public String getSerialNumber() 
    {
        return serialNumber;
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
            .append("authorizeId", getAuthorizeId())
            .append("authorizeCode", getAuthorizeCode())
            .append("productId", getProductId())
            .append("deviceId", getDeviceId())
            .append("serialNumber", getSerialNumber())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
