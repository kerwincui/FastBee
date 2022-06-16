package com.ruoyi.iot.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 产品固件对象 iot_firmware
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class Firmware extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 固件ID */
    private Long firmwareId;

    /** 固件名称 */
    @Excel(name = "固件名称")
    private String firmwareName;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    /** 是否系统通用（0-否，1-是） */
    @Excel(name = "是否系统通用", readConverterExp = "0=-否，1-是")
    private Integer isSys;

    /** 是否最新版（0-否，1-是） */
    @Excel(name = "是否系统通用", readConverterExp = "0=-否，1-是")
    private Integer isLatest;

    /** 固件版本 */
    @Excel(name = "固件版本")
    private BigDecimal version;

    /** 文件路径 */
    @Excel(name = "文件路径")
    private String filePath;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public Integer getIsLatest() {
        return isLatest;
    }

    public void setIsLatest(Integer isLatest) {
        this.isLatest = isLatest;
    }

    public void setFirmwareId(Long firmwareId)
    {
        this.firmwareId = firmwareId;
    }

    public Long getFirmwareId() 
    {
        return firmwareId;
    }
    public void setFirmwareName(String firmwareName) 
    {
        this.firmwareName = firmwareName;
    }

    public String getFirmwareName() 
    {
        return firmwareName;
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
    public void setVersion(BigDecimal version) 
    {
        this.version = version;
    }

    public BigDecimal getVersion() 
    {
        return version;
    }
    public void setFilePath(String filePath) 
    {
        this.filePath = filePath;
    }

    public String getFilePath() 
    {
        return filePath;
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
            .append("firmwareId", getFirmwareId())
            .append("firmwareName", getFirmwareName())
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("tenantId", getTenantId())
            .append("tenantName", getTenantName())
            .append("isSys", getIsSys())
            .append("version", getVersion())
            .append("filePath", getFilePath())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
