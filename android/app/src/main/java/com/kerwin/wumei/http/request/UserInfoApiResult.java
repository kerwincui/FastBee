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


public class UserInfoApiResult<T> extends ApiResult<T> {

    private T user;

    public T getUser() {
        return user;
    }

    public UserInfoApiResult<T> setUser(T user) {
        this.user = user;
        return this;
    }

    @Override
    public boolean isSuccess() {
        return getCode() == 200;
    }

    @Override
    public T getData() {
        return user;
    }

    @Override
    public String toString() {
        return "ApiResult{" +
                "code='" + CODE + '\'' +
                ", msg='" + MSG + '\'' +
                ", user=" + user +
                '}';
    }
}
