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

public class Dept {
    private String remark;

    private int deptId;

    private int parentId;

    private String ancestors;

    private String deptName;

    private String orderNum;

    private String leader;

    private String phone;

    private String email;

    private String status;

    private String delFlag;

    private String parentName;

    private List<Dept> children ;

    public void setRemark(String remark){
        this.remark = remark;
    }
    public String getRemark(){
        return this.remark;
    }
    public void setDeptId(int deptId){
        this.deptId = deptId;
    }
    public int getDeptId(){
        return this.deptId;
    }
    public void setParentId(int parentId){
        this.parentId = parentId;
    }
    public int getParentId(){
        return this.parentId;
    }
    public void setAncestors(String ancestors){
        this.ancestors = ancestors;
    }
    public String getAncestors(){
        return this.ancestors;
    }
    public void setDeptName(String deptName){
        this.deptName = deptName;
    }
    public String getDeptName(){
        return this.deptName;
    }
    public void setOrderNum(String orderNum){
        this.orderNum = orderNum;
    }
    public String getOrderNum(){
        return this.orderNum;
    }
    public void setLeader(String leader){
        this.leader = leader;
    }
    public String getLeader(){
        return this.leader;
    }
    public void setPhone(String phone){
        this.phone = phone;
    }
    public String getPhone(){
        return this.phone;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public String getEmail(){
        return this.email;
    }
    public void setStatus(String status){
        this.status = status;
    }
    public String getStatus(){
        return this.status;
    }
    public void setDelFlag(String delFlag){
        this.delFlag = delFlag;
    }
    public String getDelFlag(){
        return this.delFlag;
    }
    public void setParentName(String parentName){
        this.parentName = parentName;
    }
    public String getParentName(){
        return this.parentName;
    }
    public void setChildren(List<Dept> children){
        this.children = children;
    }
    public List<Dept> getChildren(){
        return this.children;
    }
}
