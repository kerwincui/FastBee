package com.fastbee.http.service;

import com.dtflys.forest.Forest;
import com.dtflys.forest.http.ForestRequest;
import com.fastbee.http.model.HttpClientConfig;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HttpClientFactory {
    public static ForestRequest instance(HttpClientConfig config) {
        ForestRequest request = Forest.request();
        return request.url(config.getUrl())
                .type(config.getMethod())
                .backend(config.getBackend())
                .addQuery(config.getQuerys())
                .addHeader(config.getHeaders())
                .addBody(config.getBody());
    }
}
