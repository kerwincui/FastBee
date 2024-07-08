package com.fastbee.sip.util;

import com.fastbee.sip.util.result.BaseResult;
import com.fastbee.sip.util.result.CodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.context.request.async.WebAsyncTask;

import java.util.concurrent.Callable;

@Slf4j
public class WebAsyncUtil {
    public static final Long COMMON_TIMEOUT = 30000L;

    public static WebAsyncTask<Object> init(ThreadPoolTaskExecutor executor, Callable<Object> callable) {
        WebAsyncTask<Object> asyncTask = new WebAsyncTask<>(COMMON_TIMEOUT, executor, callable);

        asyncTask.onCompletion(() -> log.info("任务执行完成"));
        asyncTask.onError(() -> BaseResult.out(CodeEnum.FAIL, "error"));
        asyncTask.onTimeout(() -> BaseResult.out(CodeEnum.FAIL, "timeout"));

        return asyncTask;
    }
}
