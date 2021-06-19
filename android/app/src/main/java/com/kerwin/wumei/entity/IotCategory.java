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

public class IotCategory {
    /** 序号 */
    private Long categoryId;

    /** 分类名称 */
    private String categoryName;

    public void setCategoryId(Long categoryId)
    {
        this.categoryId = categoryId;
    }
    public Long getCategoryId()
    {
        return categoryId;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }
    public String getCategoryName()
    {
        return categoryName;
    }

}
