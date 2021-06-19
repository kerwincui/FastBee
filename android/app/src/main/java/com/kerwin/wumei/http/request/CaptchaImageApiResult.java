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

import com.kerwin.wumei.entity.bo.CaptureImage;
import com.xuexiang.xhttp2.model.ApiResult;


public class CaptchaImageApiResult<T> extends ApiResult<T> {
    private String uuid;
    private String img;

    public String getUuid() {
        return uuid;
    }
    public CaptchaImageApiResult<T> setUuid(String uuid) {
        this.uuid = uuid;
        return this;
    }

    public String getImg() {
        return img;
    }
    public CaptchaImageApiResult<T> setImg(String img) {
        this.img = img;
        return this;
    }


    @Override
    public boolean isSuccess() {
        return getCode()==200;
    }

    @Override
    public T getData() {
        CaptureImage image=new CaptureImage();
        image.setImg(getImg());
        image.setUuid(getUuid());
        return (T) image;
    }

    @Override
    public String toString() {
        return "ApiResult{" +
                "code='" + CODE + '\'' +
                ", msg='" + MSG + '\'' +
                ", uuid='" + uuid + '\'' +
                ", img=" + img +
                '}';
    }
}
