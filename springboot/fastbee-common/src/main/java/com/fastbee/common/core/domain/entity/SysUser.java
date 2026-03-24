package com.fastbee.common.core.domain.entity;

import java.util.Date;
import java.util.List;
import javax.validation.constraints.*;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.annotation.Excel.ColumnType;
import com.fastbee.common.annotation.Excel.Type;
import com.fastbee.common.annotation.Excels;
import com.fastbee.common.core.domain.BaseEntity;
import com.fastbee.common.xss.Xss;

/**
 * 用户对象 sys_user
 *
 * @author ruoyi
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel(value = "SysUser", description = "用户对象 sys_user")
public class SysUser extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户序号", type = Type.EXPORT, cellType = ColumnType.NUMERIC, prompt = "用户编号")
    private Long userId;

    /** 部门ID */
    @ApiModelProperty("部门ID")
    @Excel(name = "部门编号", type = Type.IMPORT)
    private Long deptId;

    /** 用户账号 */
    @ApiModelProperty("用户账号")
    @Excel(name = "登录名称")
    private String userName;

    /** 用户昵称 */
    @ApiModelProperty("用户昵称")
    @Excel(name = "用户名称")
    private String nickName;

    /** 用户邮箱 */
    @ApiModelProperty("用户邮箱")
    @Excel(name = "用户邮箱")
    private String email;

    /** 手机号码 */
    @ApiModelProperty("手机号码")
    @Excel(name = "手机号码", cellType = ColumnType.TEXT)
    private String phonenumber;

    /** 用户性别 */
    @ApiModelProperty("用户性别")
    @Excel(name = "用户性别", readConverterExp = "0=男,1=女,2=未知")
    private String sex;

    /** 用户头像 */
    @ApiModelProperty("用户头像")
    private String avatar;

    /** 密码 */
    @ApiModelProperty("密码")
    private String password;

    /** 帐号状态（0正常 1停用） */
    @ApiModelProperty("帐号状态（0正常 1停用）")
    @Excel(name = "帐号状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;

    /** 最后登录IP */
    @ApiModelProperty("最后登录IP")
    @Excel(name = "最后登录IP", type = Type.EXPORT)
    private String loginIp;

    /** 最后登录时间 */
    @ApiModelProperty("最后登录时间")
    @Excel(name = "最后登录时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Type.EXPORT)
    private Date loginDate;

    /** 部门对象 */
    @ApiModelProperty("部门对象")
    @Excels({
        @Excel(name = "部门名称", targetAttr = "deptName", type = Type.EXPORT),
        @Excel(name = "部门负责人", targetAttr = "leader", type = Type.EXPORT)
    })
    private SysDept dept;

    /** 角色对象 */
    @ApiModelProperty("角色对象")
    private List<SysRole> roles;

    /** 角色组 */
    @ApiModelProperty("角色组")
    private Long[] roleIds;

    /** 岗位组 */
    @ApiModelProperty("岗位组")
    private Long[] postIds;

    /** 角色ID */
    @ApiModelProperty("角色ID")
    private Long roleId;

    @TableField(exist = false)
    private String language;

    @TableField(exist = false)
    private String timeZone;

    public SysUser() {

    }

    public SysUser(Long userId) {
        this.userId = userId;
    }

    public boolean isAdmin() {
        return isAdmin(this.userId);
    }

    public static boolean isAdmin(Long userId) {
        return userId != null && 1L == userId;
    }

}
