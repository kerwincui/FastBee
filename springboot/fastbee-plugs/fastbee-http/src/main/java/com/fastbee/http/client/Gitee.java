package com.fastbee.http.client;

import com.dtflys.forest.annotation.BaseRequest;
import com.dtflys.forest.annotation.Get;
import com.dtflys.forest.annotation.Query;
import com.dtflys.forest.annotation.Request;
import com.dtflys.forest.callback.OnError;
import com.dtflys.forest.callback.OnSuccess;
import com.fastbee.http.model.GiteeBranch;
import com.fastbee.http.model.GiteeReadme;

import java.util.List;
import java.util.concurrent.Future;

/**
 * Gitee客户端接口
 */
@BaseRequest(baseURL = "${giteeUrl}", sslProtocol = "TLSv1.3")
public interface Gitee {

    /**
     * Gitee主页
     * @return
     */
    @Get(url = "/", sslProtocol = "TLSv2")
    String index();

    /**
     * 异步访问Gitee主页
     * @return
     */
    @Request(url = "/", async = true)
    Future<String> asyncIndex();

    /**
     * 异步访问Gitee主页
     * @return
     */
    @Request(url = "/", async = true)
    void asyncIndex2(OnSuccess<String> onSuccess, OnError onError);



    /**
     * 获取所有分支
     * @param accessToken 用户授权码
     * @param owner 仓库所属空间地址(企业、组织或个人的地址path)
     * @param repo 仓库路径(path)
     * @return
     */
    @Request(
            url = "/api/v5/repos/${1}/${2}/branches",
            contentType = "application/json",
            sslProtocol = "TLSv3",
            dataType = "json")
    List<GiteeBranch> branches(@Query("accessToken") String accessToken, String owner, String repo);


    /**
     * 获取仓库README
     * @param accessToken 用户授权码
     * @param owner 仓库所属空间地址(企业、组织或个人的地址path)
     * @param repo 仓库路径(path)
     * @param ref 分支、tag或commit
     * @return
     */
    @Request(
            url = "/api/v5/repos/${1}/${2}/readme",
            contentType = "application/json",
            dataType = "json",
            data = {"accessToken=${0}", "ref=${3}"})
    GiteeReadme readme(String accessToken, String owner, String repo, String ref);

}
