package com.fastbee.http.service;

import com.dtflys.forest.callback.SuccessWhen;
import com.dtflys.forest.http.ForestRequest;
import com.dtflys.forest.http.ForestResponse;

public class SuccessCondition implements SuccessWhen {
    @Override
    public boolean successWhen(ForestRequest forestRequest, ForestResponse forestResponse) {
        return forestResponse.noException() &&   // 请求过程没有异常
                forestResponse.statusOk() &&     // 状态码在 100 ~ 399 范围内
                forestResponse.statusIsNot(203); // 但不能是 203
    }
}
