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

package com.kerwin.wumei.core.http.loader;

import android.content.Context;

import com.xuexiang.xhttp2.subsciber.impl.IProgressLoader;

/**
 * 迷你加载框创建工厂
 *
 * @author xuexiang
 * @since 2019-11-18 23:23
 */
public class MiniProgressLoaderFactory implements IProgressLoaderFactory {

    @Override
    public IProgressLoader create(Context context) {
        return new MiniLoadingDialogLoader(context);
    }

    @Override
    public IProgressLoader create(Context context, String message) {
        return new MiniLoadingDialogLoader(context, message);
    }
}
