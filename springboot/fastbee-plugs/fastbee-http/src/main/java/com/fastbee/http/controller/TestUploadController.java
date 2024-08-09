package com.fastbee.http.controller;

import com.fastbee.http.client.UploadClient;
import com.fastbee.http.service.FileService;
import com.fastbee.http.utils.PathUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@RestController
public class TestUploadController {

    private final static Logger logger = LoggerFactory.getLogger(TestUploadController.class);

    @javax.annotation.Resource
    private FileService fileService;

    @Value("${fastbee.profile}")
    private String uploadPath;

    @javax.annotation.Resource
    private UploadClient uploadClient;


    @GetMapping("/hello")
    public String hello() {
        return "hello";
    }

    //处理文件上传的方法
    @PostMapping("/upload")
    public Map upload(MultipartFile file, HttpServletRequest request) throws IOException {
        String webPath = "upload";
        System.out.println("webPath=" + webPath);
        String webFilePath = PathUtil.appendWebPath(webPath, file.getOriginalFilename());
        System.out.println("webFilePath=" + webFilePath);
        String filePath = PathUtil.appendWebPath(uploadPath, webFilePath);
        System.out.println("filePath=" + filePath);
        Map<String, String> result = fileService.uploadReal(filePath, file);
        result.put("webUrl", webFilePath);
        return result;
    }

    //处理文件上传的方法
    @PostMapping("/upload2")
    public Map upload2(MultipartFile file, @RequestParam("username") String username, HttpServletRequest request) throws IOException {
        String webPath = "upload";
        System.out.println("username=" + username);
        System.out.println("webPath=" + webPath);
        String webFilePath = PathUtil.appendWebPath(webPath, file.getOriginalFilename());
        System.out.println("webFilePath=" + webFilePath);
        String filePath = PathUtil.appendWebPath(uploadPath, webFilePath);
        System.out.println("filePath=" + filePath);
        Map<String, String> result = fileService.uploadReal(filePath, file);
        result.put("webUrl", webFilePath);
        return result;
    }

    //处理文件上传的方法
    @PostMapping("/upload-array")
    public Map uploadList(MultipartFile[] files, HttpServletRequest request) throws IOException {
        String webPath = "upload";
        System.out.println("webPath=" + webPath);
        Map<String, Map> resultMap = new LinkedHashMap<>();
        for (MultipartFile file : files) {
            String webFilePath = PathUtil.appendWebPath(webPath, file.getOriginalFilename());
            System.out.println("webFilePath=" + webFilePath);
            String filePath = PathUtil.appendWebPath(uploadPath, webFilePath);
            System.out.println("filePath=" + filePath);
            Map<String, String> result = fileService.uploadReal(filePath, file);
            result.put("webUrl", webFilePath);
            resultMap.put(file.getName(), result);
        }
        return resultMap;
    }


    @PostMapping("/do-upload-file-path")
    public Map doUploadFilePath() throws IOException {
        Resource resource = new ClassPathResource("test-img.jpg");
        String filePath = resource.getFile().getPath();
        Map result = uploadClient.upload(filePath, progress -> {
            logger.info("-------------------------------------------------------");
            logger.info("total bytes: " + progress.getTotalBytes());
            logger.info("current bytes: " + progress.getCurrentBytes());
            logger.info("percentage: " + (progress.getRate() * 100) + "%");
        });
        return result;
    }



    @PostMapping("/do-upload-file")
    public Map doUploadFile() throws IOException {
        Resource resource = new ClassPathResource("test-img.jpg");
        File file = resource.getFile();
        Map result = uploadClient.upload(file, progress -> {
            logger.info("-------------------------------------------------------");
            logger.info("total bytes: " + progress.getTotalBytes());
            logger.info("current bytes: " + progress.getCurrentBytes());
            logger.info("percentage: " + (progress.getRate() * 100) + "%");
        });
        return result;
    }

    @PostMapping("/do-upload-bytes")
    public Map doUploadBytes() throws IOException {
        Resource resource = new ClassPathResource("test-img.jpg");
        File file = resource.getFile();
        byte[] buffer = null;
        try {
            FileInputStream fis = new FileInputStream(file);
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            byte[] b = new byte[1024];
            int n;
            while ((n = fis.read(b)) != -1) {
                bos.write(b, 0, n);
            }
            fis.close();
            bos.close();
            buffer = bos.toByteArray();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Map result = uploadClient.upload(buffer, "test-bytes.jpg");
        return result;
    }


    @PostMapping("/do-upload-input-stream")
    public Map doUploadInputStream() throws IOException {
        Resource resource = new ClassPathResource("test-img.jpg");
        File file = resource.getFile();
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Map result = uploadClient.upload(fis, "test-input-stream.jpg");
        return result;
    }

    @PostMapping("/do-upload-resource")
    public Map doUploadResource() {
        Resource resource = new ClassPathResource("test-img.jpg");
        Map result = uploadClient.upload(resource);
        return result;
    }

    @PostMapping("/do-upload-multipart-file")
    public Map doUploadMultipartFile(MultipartFile multipartFile)  {
        Map result = uploadClient.upload(multipartFile, multipartFile.getOriginalFilename(), progress -> {
            logger.info("-------------------------------------------------------");
            logger.info("total bytes: " + progress.getTotalBytes());
            logger.info("current bytes: " + progress.getCurrentBytes());
            logger.info("percentage: " + (progress.getRate() * 100) + "%");
            logger.info("is done: " + progress.isDone());
        });
        return result;
    }

    @PostMapping("/do-upload-multipart-file-list")
    public Map doUploadMultipartFileList(MultipartFile multipartFile1, MultipartFile multipartFile2)  {
//        Map result = uploadClient.uploadList(
//                Lists.newArrayList(multipartFile1, multipartFile2), progress -> {
//            logger.info("-------------------------------------------------------");
//            logger.info("total bytes: " + progress.getTotalBytes());
//            logger.info("current bytes: " + progress.getCurrentBytes());
//            logger.info("percentage: " + (progress.getRate() * 100) + "%");
//            logger.info("is done: " + progress.isDone());
//        });
        return null;
    }


    @PostMapping("/do-upload-path-list")
    public Map doUploadPathList() throws IOException {
        Resource[] resources = new Resource[]{
                new ClassPathResource("static/images/test-img.jpg"),
                new ClassPathResource("static/images/test-img2.jpg"),
                new ClassPathResource("static/images/test-img3.jpg")
        };
        List<String> pathList = new LinkedList<>();
        for (int i = 0; i < resources.length; i++) {
            pathList.add(resources[i].getFile().getPath());
        }
        Map result = uploadClient.uploadPathList(pathList);
        return result;
    }


}
