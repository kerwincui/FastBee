/*
 * Copyright (C) 2021 xuexiangjys(xuexiangjys@163.com)
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
 *
 */

package com.kerwin.wumei.core.http.callback;

import androidx.annotation.NonNull;

import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xhttp2.callback.ProgressLoadingCallBack;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xhttp2.model.XHttpRequest;
import com.xuexiang.xhttp2.subsciber.impl.IProgressLoader;
import com.xuexiang.xutil.common.StringUtils;
import com.xuexiang.xutil.common.logger.Logger;

/**
 * 带错误toast提示和加载进度条的网络请求回调
 *
 * @author xuexiang
 * @since 2019-11-18 23:16
 */
public abstract class TipProgressLoadingCallBack<T> extends ProgressLoadingCallBack<T> {
    /**
     * 记录一下请求的url,确定出错的请求是哪个请求
     */
    private String mUrl;

    public TipProgressLoadingCallBack(BaseFragment fragment) {
        super(fragment.getProgressLoader());
    }

    public TipProgressLoadingCallBack(IProgressLoader iProgressLoader) {
        super(iProgressLoader);
    }

    public TipProgressLoadingCallBack(@NonNull XHttpRequest req, IProgressLoader iProgressLoader) {
        this(req.getUrl(), iProgressLoader);
    }

    public TipProgressLoadingCallBack(String url, IProgressLoader iProgressLoader) {
        super(iProgressLoader);
        mUrl = url;
    }

    @Override
    public void onError(ApiException e) {
        super.onError(e);
        XToastUtils.error(e);
        if (!StringUtils.isEmpty(mUrl)) {
            Logger.e("网络请求的url:" + mUrl, e);
        } else {
            Logger.e(e);
        }
    }
}
