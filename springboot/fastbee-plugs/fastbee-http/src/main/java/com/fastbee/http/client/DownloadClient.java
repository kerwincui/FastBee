package com.fastbee.http.client;

import com.dtflys.forest.annotation.BaseRequest;
import com.dtflys.forest.annotation.GetRequest;
import com.dtflys.forest.annotation.Request;
import com.dtflys.forest.callback.OnProgress;
import com.dtflys.forest.extensions.DownloadFile;

import java.io.File;
import java.io.InputStream;

/**
 * @author gongjun[dt_flys@hotmail.com]
 * @since 2020-08-04 22:33
 */
@BaseRequest(baseURL = "localhost:8080")
public interface DownloadClient {

    @Request(url = "/images/test-img.jpg")
    @DownloadFile(dir = "${0}", filename = "test-download-annotation.jpg")
    void downloadImage(String targetDir);

    /**
     * 用@DownloadFile注解指定文件下载文件，dir属性指定下载目标目录，filename指定目标文件名
     * @param targetDir
     */
    @GetRequest(url = "/images/test-img.jpg")
    @DownloadFile(dir = "${0}", filename = "target.zip")
    File downloadFile(String targetDir, OnProgress onProgress);

    /**
     * 返回类型用byte[]，可将下载的文件转换成字节数组
     * @return
     */
    @GetRequest(url = "/images/test-img.jpg")
    @DownloadFile(dir = "D:\\TestDownload", filename = "temp.jpg")
    byte[] downloadImageToByteArrayWithAnnotation();


    @Request(url = "/images/test-img.jpg")
    byte[] downloadImageToByteArray();

    @Request(url = "/images/test-img.jpg")
    @DownloadFile(dir = "D:\\TestDownload", filename = "temp.jpg")
    InputStream downloadImageToInputStream();


}
