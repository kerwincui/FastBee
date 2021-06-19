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

import java.util.List;

public class User {

    private String remark;

    private int userId;

    private int deptId;

    private String userName;

    private String nickName;

    private String email;

    private String phonenumber;

    private String sex;

    private String avatar;

    private String status;

    private String loginIp;

    private String loginDate;

    private Dept dept;

    private List<Roles> roles ;

    private String roleIds;

    private String postIds;

    private boolean admin;

    private String createTime;

    public void setRemark(String remark){
        this.remark = remark;
    }
    public String getRemark(){
        return this.remark;
    }
    public void setUserId(int userId){
        this.userId = userId;
    }
    public int getUserId(){
        return this.userId;
    }
    public void setDeptId(int deptId){
        this.deptId = deptId;
    }
    public int getDeptId(){
        return this.deptId;
    }
    public void setUserName(String userName){
        this.userName = userName;
    }
    public String getUserName(){
        return this.userName;
    }
    public void setNickName(String nickName){
        this.nickName = nickName;
    }
    public String getNickName(){
        return this.nickName;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public String getEmail(){
        return this.email;
    }
    public void setPhonenumber(String phonenumber){
        this.phonenumber = phonenumber;
    }
    public String getPhonenumber(){
        return this.phonenumber;
    }
    public void setSex(String sex){
        this.sex = sex;
    }
    public String getSex(){
        return this.sex;
    }
    public void setAvatar(String avatar){
        this.avatar = avatar;
    }
    public String getAvatar(){
        return this.avatar;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public String getStatus(){
        return this.status;
    }
    public void setLoginIp(String loginIp){
        this.loginIp = loginIp;
    }
    public String getLoginIp(){
        return this.loginIp;
    }
    public void setLoginDate(String loginDate){
        this.loginDate = loginDate;
    }
    public String getLoginDate(){
        return this.loginDate;
    }
    public void setDept(Dept dept){
        this.dept = dept;
    }
    public Dept getDept(){
        return this.dept;
    }
    public void setRoles(List<Roles> roles){
        this.roles = roles;
    }
    public List<Roles> getRoles(){
        return this.roles;
    }
    public void setRoleIds(String roleIds){
        this.roleIds = roleIds;
    }
    public String getRoleIds(){
        return this.roleIds;
    }
    public void setPostIds(String postIds){
        this.postIds = postIds;
    }
    public String getPostIds(){
        return this.postIds;
    }
    public void setAdmin(boolean admin){
        this.admin = admin;
    }
    public boolean getAdmin(){
        return this.admin;
    }
    public void setCreateTime(String createTime){
        this.createTime = createTime;
    }
    public String getCreateTime(){
        return this.createTime;
    }
}
