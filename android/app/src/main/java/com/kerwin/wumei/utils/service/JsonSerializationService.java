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

package com.kerwin.wumei.utils.service;

import android.content.Context;

import com.xuexiang.xrouter.annotation.Router;
import com.xuexiang.xrouter.facade.service.SerializationService;
import com.xuexiang.xutil.net.JsonUtil;

import java.lang.reflect.Type;

/**
 * @author XUE
 * @since 2019/3/27 16:39
 */
@Router(path = "/service/json")
public class JsonSerializationService implements SerializationService {
    /**
     * 对象序列化为json
     *
     * @param instance obj
     * @return json string
     */
    @Override
    public String object2Json(Object instance) {
        return JsonUtil.toJson(instance);
    }

    /**
     * json反序列化为对象
     *
     * @param input json string
     * @param clazz object type
     * @return instance of object
     */
    @Override
    public <T> T parseObject(String input, Type clazz) {
        return JsonUtil.fromJson(input, clazz);
    }

    /**
     * 进程初始化的方法
     *
     * @param context 上下文
     */
    @Override
    public void init(Context context) {

    }
}
