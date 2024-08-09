package com.fastbee.http.client;

import com.dtflys.forest.annotation.Get;
import com.dtflys.forest.http.ForestResponse;

public interface Cn12306 {

    @Get(url = "${idServiceUrl}")
    ForestResponse<String> index();

}
