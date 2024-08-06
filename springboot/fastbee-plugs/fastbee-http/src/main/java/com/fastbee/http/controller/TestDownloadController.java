package com.fastbee.http.controller;

import com.fastbee.http.client.DownloadClient;
import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * @author gongjun[dt_flys@hotmail.com]
 * @since 2020-08-04 22:36
 */
@RestController
public class TestDownloadController {

    @Resource
    private DownloadClient downloadClient;


    @GetMapping("/download-image")
    public Map downloadImage() {
        Map<String, Object> result = new HashMap<>();
        File file = downloadClient.downloadFile("D:\\TestDownload", progress -> {
            System.out.println("-------------------------------------------------------");
            System.out.println("total bytes: " + progress.getTotalBytes());
            System.out.println("current bytes: " + progress.getCurrentBytes());
            System.out.println("percentage: " + (int) Math.floor(progress.getRate() * 100) + "%");
        });
        result.put("status", "ok");
        return result;
    }

    @GetMapping("/download-file")
    public Map downloadFile() {
        Map<String, Object> result = new HashMap<>();
        File file = downloadClient.downloadFile("D:\\TestDownload", progress -> {
            System.out.println("-------------------------------------------------------");
            System.out.println("total bytes: " + progress.getTotalBytes());
            System.out.println("current bytes: " + progress.getCurrentBytes());
            System.out.println("percentage: " + (int) Math.floor(progress.getRate() * 100) + "%");
        });
        result.put("status", "ok");
        return result;
    }

    @GetMapping("/download-image-to-byte-array")
    public Map downloadImageToByteArray() throws IOException {
        Map<String, Object> result = new HashMap<>();
        byte[] buffer = downloadClient.downloadImageToByteArray();
        File file = new File("D:\\TestDownload\\test-byte-array.jpg");
        FileUtils.writeByteArrayToFile(file, buffer);
        result.put("status", "ok");
        return result;
    }

    @GetMapping("/download-image-to-byte-array-with-annotation")
    public Map downloadImageToByteArrayWithAnnotation() throws IOException {
        Map<String, Object> result = new HashMap<>();
        byte[] buffer = downloadClient.downloadImageToByteArrayWithAnnotation();
        File file = new File("D:\\TestDownload\\test-byte-array.jpg");
        FileUtils.writeByteArrayToFile(file, buffer);
        result.put("status", "ok");
        return result;
    }


    @GetMapping("/download-image-to-stream")
    public Map downloadImageToStream() throws IOException {
        Map<String, Object> result = new HashMap<>();
        InputStream in = downloadClient.downloadImageToInputStream();
        File file = new File("D:\\TestDownload\\test-input-stream.jpg");
        FileUtils.copyInputStreamToFile(in, file);
        result.put("status", "ok");
        return result;
    }


}
