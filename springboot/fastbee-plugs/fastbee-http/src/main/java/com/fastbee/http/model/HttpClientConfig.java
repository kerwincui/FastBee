package com.fastbee.http.model;

import com.dtflys.forest.http.ForestRequestType;
import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class HttpClientConfig {
    private String backend;
    private String url;
    private ForestRequestType method;
    private Map<String, Object> headers;
    private Map<String, Object> querys;
    private String body;
}
