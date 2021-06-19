/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/

package com.kerwin.wumei.entity;

public class Roles {
    private String remark;

    private int roleId;

    private String roleName;

    private String roleKey;

    private String roleSort;

    private String dataScope;

    private boolean menuCheckStrictly;

    private boolean deptCheckStrictly;

    private String status;

    private boolean flag;

    private String menuIds;

    private String deptIds;

    private boolean admin;

    public void setRemark(String remark){
        this.remark = remark;
    }
    public String getRemark(){
        return this.remark;
    }
    public void setRoleId(int roleId){
        this.roleId = roleId;
    }
    public int getRoleId(){
        return this.roleId;
    }
    public void setRoleName(String roleName){
        this.roleName = roleName;
    }
    public String getRoleName(){
        return this.roleName;
    }
    public void setRoleKey(String roleKey){
        this.roleKey = roleKey;
    }
    public String getRoleKey(){
        return this.roleKey;
    }
    public void setRoleSort(String roleSort){
        this.roleSort = roleSort;
    }
    public String getRoleSort(){
        return this.roleSort;
    }
    public void setDataScope(String dataScope){
        this.dataScope = dataScope;
    }
    public String getDataScope(){
        return this.dataScope;
    }
    public void setMenuCheckStrictly(boolean menuCheckStrictly){
        this.menuCheckStrictly = menuCheckStrictly;
    }
    public boolean getMenuCheckStrictly(){
        return this.menuCheckStrictly;
    }
    public void setDeptCheckStrictly(boolean deptCheckStrictly){
        this.deptCheckStrictly = deptCheckStrictly;
    }
    public boolean getDeptCheckStrictly(){
        return this.deptCheckStrictly;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public String getStatus(){
        return this.status;
    }
    public void setFlag(boolean flag){
        this.flag = flag;
    }
    public boolean getFlag(){
        return this.flag;
    }
    public void setMenuIds(String menuIds){
        this.menuIds = menuIds;
    }
    public String getMenuIds(){
        return this.menuIds;
    }
    public void setDeptIds(String deptIds){
        this.deptIds = deptIds;
    }
    public String getDeptIds(){
        return this.deptIds;
    }
    public void setAdmin(boolean admin){
        this.admin = admin;
    }
    public boolean getAdmin(){
        return this.admin;
    }
}
