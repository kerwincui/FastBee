package com.fastbee.http.controller;

import com.dtflys.forest.Forest;
import com.dtflys.forest.logging.LogConfiguration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicInteger;

@RestController
@RequestMapping("/async")
public class TestAsyncController {

    @GetMapping("/data")
    public Map<String, Object> getData() {
        Map<String, Object> map = new HashMap<>();
        map.put("value", "foo");
        return map;
    }

    @GetMapping("/test")
    public Map<String, Object> testAsync() throws InterruptedException {
        int batch = 20000;
        int total = 100;
        final LogConfiguration logConfiguration = new LogConfiguration();
        logConfiguration.setLogEnabled(false);
        for (int i = 0; i < batch; i++) {
            System.out.println("执行批次: " + i);
            final CountDownLatch latch = new CountDownLatch(total);
            final AtomicInteger count = new AtomicInteger(0);
            final AtomicInteger errorCount = new AtomicInteger(0);
            for (int j = 0; j < total; j++) {
                try {
                    Forest.get("/async/data")
                            .backend("httpclient")
                            .host("localhost")
                            .port(8080)
                            .setLogConfiguration(logConfiguration)
                            .async()
                            .onSuccess((data, req, res) -> {
                                latch.countDown();
                                int c = count.incrementAndGet();
//                                System.out.println("已成功 " + c);
                            })
                            .onError((ex, req, res) -> {
                                latch.countDown();
                                int c = count.incrementAndGet();
                                errorCount.incrementAndGet();
                                System.out.println("已失败 第一阶段: " + ex);
                            })
                            .execute();
                } catch (Throwable th) {
                }
            }
            try {
                latch.await();
            } catch (InterruptedException e) {
            }

            final CountDownLatch latch2 = new CountDownLatch(total);
            final AtomicInteger count2 = new AtomicInteger(0);
            final AtomicInteger errorCount2 = new AtomicInteger(0);
            for (int j = 0; j < total; j++) {
                Forest.get("/async/data")
                        .backend("httpclient")
                        .host("localhost")
                        .port(8080)
                        .async()
                        .setLogConfiguration(logConfiguration)
                        .onSuccess((data, req, res) -> {
                            latch2.countDown();
                            int c = count2.incrementAndGet();
                        })
                        .onError((ex, req, res) -> {
                            latch2.countDown();
                            int c = count2.incrementAndGet();
                            if (ex != null) {
                                errorCount2.incrementAndGet();
                            }
                            if (c == total) {
                            } else {
                                System.out.println("已失败 第二阶段: " + c);
                            }
                        })
                        .execute();
            }
            try {
                latch2.await();
            } catch (InterruptedException e) {
            }

        }
        Map<String, Object> map = new HashMap<>();
        map.put("status", "ok");
        return map;
    }
}
