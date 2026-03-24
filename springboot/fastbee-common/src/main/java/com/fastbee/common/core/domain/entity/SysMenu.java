package com.fastbee.common.core.domain.entity;

import java.util.ArrayList;
import java.util.List;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 菜单权限表 sys_menu
 *
 * @author ruoyi
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel(value = "SysMenu", description = "菜单权限表 sys_menu")
public class SysMenu extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 菜单ID */
    @ApiModelProperty("菜单ID")
    private Long menuId;

    /** 菜单名称 */
    @ApiModelProperty("菜单名称")
    private String menuName;

    /** 父菜单名称 */
    @ApiModelProperty("父菜单名称")
    private String parentName;

    /** 父菜单ID */
    @ApiModelProperty("父菜单ID")
    private Long parentId;

    /** 显示顺序 */
    @ApiModelProperty("显示顺序")
    private Integer orderNum;

    /** 路由地址 */
    @ApiModelProperty("路由地址")
    private String path;

    /** 组件路径 */
    @ApiModelProperty("组件路径")
    private String component;

    /** 路由参数 */
    @ApiModelProperty("路由参数")
    private String query;

    /** 路由名称，默认和路由地址相同的驼峰格式（注意：因为vue3版本的router会删除名称相同路由，为避免名字的冲突，特殊情况可以自定义） */
    private String routeName;

    /** 是否为外链（0是 1否） */
    @ApiModelProperty("是否为外链（0是 1否）")
    private String isFrame;

    /** 是否缓存（0缓存 1不缓存） */
    @ApiModelProperty("是否缓存（0缓存 1不缓存）")
    private String isCache;

    /** 类型（M目录 C菜单 F按钮） */
    @ApiModelProperty("类型（M目录 C菜单 F按钮）")
    private String menuType;

    /** 显示状态（0显示 1隐藏） */
    @ApiModelProperty("显示状态（0显示 1隐藏）")
    private String visible;

    /** 菜单状态（0正常 1停用） */
    @ApiModelProperty("菜单状态（0正常 1停用）")
    private String status;

    /** 权限字符串 */
    @ApiModelProperty("权限字符串")
    private String perms;

    /** 菜单图标 */
    @ApiModelProperty("菜单图标")
    private String icon;

    /** 子菜单 */
    @ApiModelProperty("子菜单")
    private List<SysMenu> children = new ArrayList<SysMenu>();

    @Deprecated
    @TableField(exist = false)
    private String language;

    /** 菜单名称 */
    @TableField(exist = false)
    @ApiModelProperty("中文菜单名称")
    private String menuName_zh_CN;

    /** 菜单名称 */
    @TableField(exist = false)
    @ApiModelProperty("英文菜单名称")
    private String menuName_en_US;

}
