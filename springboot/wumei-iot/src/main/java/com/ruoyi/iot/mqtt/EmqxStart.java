package com.ruoyi.iot.mqtt;

import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 *项目启动执行
 */
@Component
@Order(value = 1)   //执行顺序控制
public class EmqxStart implements ApplicationRunner {

    @Autowired
    private EmqxClient emqxClient;

    @Override
    public void run(ApplicationArguments applicationArguments) throws Exception{
        emqxClient.connect();

        /*模拟客户端发布主题，测试多线程处理订阅主题业务*/
      /**  JSONObject message = new JSONObject();
        message.put("id",2);
        message.put("value","hello");
        message.put("remark","12");
        Thread.sleep(10000);
        new Thread(() ->{
            for (int i = 0; i < 3000; i++) {
                emqxClient.publish(0,false,"/2/D6329VL54419L1Y0/info/post",message.toJSONString());
                //测试多线程性能
                try {
                    Thread.sleep(300);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }).start();
       */
    }
}
