package com.fastbee.iot.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 设备采集变量模板对象 iot_var_temp
 * 
 * @author kerwincui
 * @date 2022-11-30
 */
@ApiModel(value = "VarTemp", description = "设备采集变量模板对象 iot_var_temp")
public class VarTemp extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键id */
    @ApiModelProperty("主键id")
    private Long templateId;

    /** 模板名称 */
    @ApiModelProperty("模板名称")
    @Excel(name = "模板名称")
    private String templateName;

    /** $column.columnComment */
    @ApiModelProperty("类型")
    private Integer type;

    /** 采集方式 1.云端轮询 2.云端边缘计算 */
    @ApiModelProperty(value = "采集方式", notes = "1.云端轮询 2.云端边缘计算")
    @Excel(name = "采集方式 1.云端轮询 2.云端边缘计算")
    private Integer pollingMethod;

    /** 从机总数 */
    @ApiModelProperty("从机总数")
    @Excel(name = "从机总数")
    private Long slaveTotal;

    /** 总采集点数 */
    @ApiModelProperty("总采集点数")
    @Excel(name = "总采集点数")
    private Long pointTotal;

    /** 是否分享 */
    @ApiModelProperty("是否分享")
    @Excel(name = "是否分享")
    private Integer share;

    /** 模板所属用户 */
    @ApiModelProperty("模板所属用户")
    @Excel(name = "模板所属用户")
    private Long userId;

    public void setTemplateId(Long templateId) 
    {
        this.templateId = templateId;
    }

    public Long getTemplateId() 
    {
        return templateId;
    }
    public void setTemplateName(String templateName) 
    {
        this.templateName = templateName;
    }

    public String getTemplateName() 
    {
        return templateName;
    }
    public void setType(Integer type) 
    {
        this.type = type;
    }

    public Integer getType() 
    {
        return type;
    }
    public void setPollingMethod(Integer pollingMethod) 
    {
        this.pollingMethod = pollingMethod;
    }

    public Integer getPollingMethod() 
    {
        return pollingMethod;
    }
    public void setSlaveTotal(Long slaveTotal) 
    {
        this.slaveTotal = slaveTotal;
    }

    public Long getSlaveTotal() 
    {
        return slaveTotal;
    }
    public void setPointTotal(Long pointTotal) 
    {
        this.pointTotal = pointTotal;
    }

    public Long getPointTotal() 
    {
        return pointTotal;
    }
    public void setShare(Integer share) 
    {
        this.share = share;
    }

    public Integer getShare() 
    {
        return share;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("templateId", getTemplateId())
            .append("templateName", getTemplateName())
            .append("type", getType())
            .append("pollingMethod", getPollingMethod())
            .append("slaveTotal", getSlaveTotal())
            .append("pointTotal", getPointTotal())
            .append("share", getShare())
            .append("createTime", getCreateTime())
            .append("createBy", getCreateBy())
            .append("updateTime", getUpdateTime())
            .append("updateBy", getUpdateBy())
            .append("userId", getUserId())
            .toString();
    }
}
