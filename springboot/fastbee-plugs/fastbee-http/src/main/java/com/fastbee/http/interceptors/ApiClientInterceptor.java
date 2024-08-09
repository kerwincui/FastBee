package com.fastbee.http.interceptors;


import com.dtflys.forest.Forest;
import com.dtflys.forest.http.ForestHeaderMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.dtflys.forest.exceptions.ForestRuntimeException;
import com.dtflys.forest.http.ForestRequest;
import com.dtflys.forest.http.ForestResponse;
import com.dtflys.forest.interceptor.Interceptor;


public class ApiClientInterceptor implements Interceptor {

    private final Log log = LogFactory.getLog(ApiClientInterceptor.class);

    @Override
    public boolean beforeExecute(ForestRequest request) {
        String accessToken = "111111111";
        request.addHeader("accessToken", accessToken);
        log.info("Forest Version: " + Forest.VERSION);
        log.info("accessToken = " + accessToken);
        return true;
    }

    @Override
    public void onSuccess(Object data, ForestRequest request, ForestResponse response) {
        log.info("invoke Simple onSuccess");
    }

    @Override
    public void onError(ForestRuntimeException ex, ForestRequest request, ForestResponse response) {
        log.info("invoke Simple onError");
    }

    @Override
    public void afterExecute(ForestRequest request, ForestResponse response) {
        ForestHeaderMap headers = request.getHeaders();
        System.out.println(headers.getValues());
        log.info("invoke Simple afterExecute");
    }
}
