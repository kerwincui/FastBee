package com.fastbee.http.service;

import com.dtflys.forest.annotation.BindingVar;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
public class FileService {


    public Map<String, String> uploadReal(String fileName, MultipartFile file) {
        //处理后缀
        HashMap<String, String> result = new HashMap<>();
        //获取物理路径
        File destFile = new File(fileName);
        System.out.println("uploadReal,destFile=" + destFile.getAbsolutePath());
        System.out.println("uploadReal,destFile.getParentFile=" + destFile.getParentFile().getAbsolutePath());
        //目录不存在
        if (!destFile.getParentFile().exists()) {
            destFile.getParentFile().mkdirs();
        }
        //目录存在是文件
        if (destFile.getParentFile().isFile()) {
            result.put("flag", "fail");
            result.put("message", "父级路径是文件而不是目录");
            return result;
        }
        try {
            file.transferTo(destFile);
            result.put("flag", "success");
            result.put("message", "文件上传成功");
        } catch (IOException e) {
            e.printStackTrace();
            result.put("flag", "fail");
            result.put("message", "文件写入本地发生异常");
        }
        return result;
    }


    @BindingVar("testVar")
    public String testVar() {
        return "xx";
    }

}
