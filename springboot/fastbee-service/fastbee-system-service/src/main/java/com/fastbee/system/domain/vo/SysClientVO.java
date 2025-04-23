package com.fastbee.system.domain.vo;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.PageEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;


/**
 * 系统授权对象 sys_client
 *
 * @author zhuangpeng.li
 * @date 2024-12-12
 */

@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "SysClientVO", description = "系统授权 sys_client")
@Data
public class SysClientVO extends PageEntity {
    /** 代码生成区域 可直接覆盖**/
    /** id唯一标识 */
    @Excel(name = "id唯一标识")
    @ApiModelProperty("id唯一标识")
    private Long id;

    /** 客户端key */
    @Excel(name = "客户端key")
    @ApiModelProperty("客户端key")
    private String clientKey;

    /** 客户端秘钥 */
    @Excel(name = "客户端秘钥")
    @ApiModelProperty("客户端秘钥")
    private String clientSecret;

    /** 客户端token */
    @Excel(name = "客户端token")
    @ApiModelProperty("客户端token")
    private String token;

    /** 授权类型 */
    @Excel(name = "授权类型")
    @ApiModelProperty("授权类型")
    private String grantType;

    /** 设备类型 */
    @Excel(name = "设备类型")
    @ApiModelProperty("设备类型")
    private String deviceType;

    /** token固定超时 */
    @Excel(name = "token固定超时")
    @ApiModelProperty("token固定超时")
    private Long timeout;

    /** 是否生效（0-不生效，1-生效） */
    @ApiModelProperty("是否生效")
    @Excel(name = "是否生效")
    private String enable;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    @Excel(name = "删除标志")
    private String delFlag;

    /** 创建者 */
    @Excel(name = "创建者")
    @ApiModelProperty("创建者")
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    @Excel(name = "创建时间")
    private Date createTime;

    /** 更新者 */
    @Excel(name = "更新者")
    @ApiModelProperty("更新者")
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("更新时间")
    @Excel(name = "更新时间")
    private Date updateTime;

    /** 备注 */
    @Excel(name = "备注")
    @ApiModelProperty("备注")
    private String remark;


    /** 代码生成区域 可直接覆盖END**/

    /** 自定义代码区域 **/


    /** 自定义代码区域 END**/
}
