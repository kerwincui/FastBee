package com.fastbee;

import com.dtflys.forest.springboot.annotation.ForestScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 启动程序
 *
 * @author ruoyi
 */
@SpringBootApplication
@ForestScan(basePackages = "com.fastbee")
public class FastBeeApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(FastBeeApplication.class, args);
    }
}
