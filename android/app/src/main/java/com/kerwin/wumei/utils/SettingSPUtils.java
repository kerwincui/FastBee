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

package com.kerwin.wumei.utils;

import android.content.Context;

import com.kerwin.wumei.R;
import com.xuexiang.xutil.XUtil;
import com.xuexiang.xutil.data.BaseSPUtil;

/**
 * @author xuexiang
 * @since 2018/7/16 下午3:38
 */
public class SettingSPUtils extends BaseSPUtil {

    private static SettingSPUtils sInstance;

    private SettingSPUtils(Context context) {
        super(context);
    }

    public static SettingSPUtils getInstance() {
        if (sInstance == null) {
            synchronized (SettingSPUtils.class) {
                if (sInstance == null) {
                    sInstance = new SettingSPUtils(XUtil.getContext());
                }
            }
        }
        return sInstance;
    }

    /**
     * 获取服务器地址
     *
     * @return
     */
    public String getApiURL() {
        return getString(getString(R.string.service_api_key), getString(R.string.default_service_api));
    }

    /**
     * 获取服务器地址
     *
     * @return
     */
    public boolean setApiURL(String apiUrl) {
        return putString(getString(R.string.service_api_key), apiUrl);
    }
}
