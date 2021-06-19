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

import android.os.Bundle;
import androidx.annotation.NonNull;

import com.xuexiang.xrouter.facade.service.SerializationService;
import com.xuexiang.xrouter.launcher.XRouter;

/**
 * @author xuexiang
 * @since 2018/8/3 下午2:54
 */
public final class RouterUtils {

    private RouterUtils() {
        throw new UnsupportedOperationException("u can't instantiate me...");
    }

    public static Bundle getBundle(String key, Object value) {
        Bundle bundle = new Bundle();
        bundle.putString(key, XRouter.getInstance().navigation(SerializationService.class).object2Json(value));
        return bundle;
    }

    /**
     * 注入依赖
     *
     * @param target
     */
    public static void inject(@NonNull Object target) {
        XRouter.getInstance().inject(target);
    }

}
