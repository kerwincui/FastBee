/*
 * Copyright (C) 2018 xuexiangjys(xuexiangjys@163.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.kerwin.wumei.http.subscriber;


import androidx.annotation.NonNull;

import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xhttp2.model.XHttpRequest;
import com.xuexiang.xhttp2.subsciber.BaseSubscriber;
import com.xuexiang.xutil.common.StringUtils;
import com.xuexiang.xutil.common.logger.Logger;
import com.xuexiang.xutil.tip.ToastUtils;

/**
 * 网络请求的订阅，toast提示
 *
 * @author xuexiang
 * @since 2018/8/2 下午3:42
 */
public abstract class TipRequestSubscriber<T> extends BaseSubscriber<T> {
    /**
     * 记录一下请求的url,确定出错的请求是哪个请求
     */
    private String mUrl;

    public TipRequestSubscriber() {

    }

    public TipRequestSubscriber(@NonNull XHttpRequest req) {
        this(req.getUrl());
    }

    public TipRequestSubscriber(String url) {
        mUrl = url;
    }


    @Override
    public void onError(ApiException e) {
        ToastUtils.toast(e.getDisplayMessage());
        if (!StringUtils.isEmpty(mUrl)) {
            Logger.e("网络请求的url:" + mUrl, e);
        } else {
            Logger.e(e);
        }
    }
}
