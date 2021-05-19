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

package com.kerwin.wumei.core.webview;

import android.app.Activity;
import android.os.Handler;
import android.util.Log;
import android.webkit.WebView;

import com.just.agentweb.core.web.AgentWebUIControllerImplBase;

import java.lang.ref.WeakReference;

/**
 * 如果你需要修改某一个AgentWeb 内部的某一个弹窗 ，请看下面的例子
 * 注意写法一定要参照 DefaultUIController 的写法 ，因为UI自由定制，但是回调的方式是固定的，并且一定要回调。
 *
 * @author xuexiang
 * @since 2019-10-30 23:18
 */
public class UIController extends AgentWebUIControllerImplBase {

    private WeakReference<Activity> mActivity;

    public UIController(Activity activity) {
        mActivity = new WeakReference<>(activity);
    }

    @Override
    public void onShowMessage(String message, String from) {
        super.onShowMessage(message, from);
        Log.i(TAG, "message:" + message);
    }

    @Override
    public void onSelectItemsPrompt(WebView view, String url, String[] items, Handler.Callback callback) {
        // 使用默认的UI
        super.onSelectItemsPrompt(view, url, items, callback);
    }

}
