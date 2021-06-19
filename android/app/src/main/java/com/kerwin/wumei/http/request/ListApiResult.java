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

package com.kerwin.wumei.http.request;

import com.xuexiang.xhttp2.model.ApiResult;

public class ListApiResult<T> extends ApiResult<T> {

    private T rows;
    private int total;

    public T getRows() {
        return rows;
    }
    public ListApiResult<T> setRows(T rows) {
        this.rows = rows;
        return this;
    }

    public int getTotal(){return total;}
    public ListApiResult<T> setTotal(int total){
        this.total=total;
        return this;
    }

    @Override
    public boolean isSuccess() {
        return getCode() == 200;
    }

    @Override
    public T getData() {
        return rows;
    }

    @Override
    public String toString() {
        return "ApiResult{" +
                "code='" + CODE + '\'' +
                ", msg='" + MSG + '\'' +
                '}';
    }
}
