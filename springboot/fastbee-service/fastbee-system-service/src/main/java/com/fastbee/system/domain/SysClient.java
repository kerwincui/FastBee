package com.fastbee.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 系统授权对象 sys_client
 *
 * @author zhuangpeng.li
 * @date 2024-12-12
 */
@EqualsAndHashCode(callSuper = true)
@ApiModel(value = "SysClient", description = "系统授权 sys_client")
@Data
@TableName("sys_client" )
public class SysClient extends BaseEntity {
    private static final long serialVersionUID=1L;

    /** id唯一标识 */
    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty("id唯一标识")
    private Long id;

    /** 客户端key */
    @ApiModelProperty("客户端key")
    private String clientKey;

    /** 客户端秘钥 */
    @ApiModelProperty("客户端秘钥")
    private String clientSecret;

    /** 客户端token */
    @ApiModelProperty("客户端token")
    private String token;

    /** 授权类型 */
    @ApiModelProperty("授权类型")
    private String grantType;

    /** 设备类型 */
    @ApiModelProperty("设备类型")
    private String deviceType;

    /** token固定超时 */
    @ApiModelProperty("token固定超时")
    private Long timeout;

    /** 是否生效（0-不生效，1-生效） */
    @ApiModelProperty("是否生效")
    private String enable;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    @TableLogic
    private String delFlag;

}
