package com.fastbee.base.core.hanler;

import com.fastbee.common.core.protocol.Message;
import com.fastbee.base.session.Session;
import com.fastbee.base.util.VirtualList;
import com.fastbee.common.exception.ServiceException;
import io.netty.util.concurrent.DefaultThreadFactory;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Method;
import java.util.List;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * 异步批量处理报文
 * @author bill
 */
@Slf4j
public class AsyncBatchHandler extends BaseHandler{


   /*消息处理队列*/
   private final ConcurrentLinkedQueue<Message> queue;

   /*线程池*/
   private final ThreadPoolExecutor executor;

   private final int poolSize;

   private final int maxEventSize;

   private final int maxWait;

   private final int warningLines;


    public AsyncBatchHandler(Object target, Method targetMethod, String desc, int poolSize, int maxEventSize, int maxWait) {

        super(target, targetMethod, desc);
        Class<?>[] parameterTypes = targetMethod.getParameterTypes();
        if (parameterTypes.length >1){
            throw new ServiceException("参数列表过长");
        }
        if (!parameterTypes[0].isAssignableFrom(List.class)){
            throw new ServiceException("参数不是List类型");
        }

        this.poolSize = poolSize;
        this.maxEventSize = maxEventSize;
        this.maxWait = maxWait;
        this.warningLines = maxEventSize * poolSize * 50;

        this.queue = new ConcurrentLinkedQueue<>();
        this.executor = new ThreadPoolExecutor(this.poolSize,this.poolSize,1000L, TimeUnit.MILLISECONDS
                ,new LinkedBlockingQueue<>(500),new DefaultThreadFactory(targetMethod.getName()));

        for (int i = 0; i < poolSize; i++) {
            boolean start = i == 0;
            executor.execute(()->{
                try {
                    startInternal(start);
                }catch (Exception e){
                    log.error("线程池处理数据出错",e);
                }
            });
        }

    }

    @Override
    public <T extends Message> T invoke(T request, Session session) throws Exception {
        queue.offer(request);
        return null;
    }

    public void startInternal(boolean master) {
        Message[] array = new Message[maxEventSize];
        long logtime = 0;
        long starttime = 0;

        for (; ; ) {
            Message temp;
            int i = 0;
            while ((temp = queue.poll()) != null) {
                array[i++] = temp;
                if (i >= maxEventSize) {
                    break;
                }
            }

            if (i > 0) {
                starttime = System.currentTimeMillis();
                try {
                    targetMethod.invoke(targetObject, new VirtualList<>(array, i));
                } catch (Exception e) {
                    log.warn(targetMethod.getName(), e);
                }
                long time = System.currentTimeMillis() - starttime;
                if (time > 1000L) {
                    log.warn("线程池处理数据耗时:{}ms,共{}条记录", time, i);
                }
            }

            if (i < maxEventSize) {
                try {
                    for (int j = 0; j < i; j++) {
                        array[j] = null;
                    }
                    Thread.sleep(maxWait);
                } catch (InterruptedException e) {
                    log.error("sleep error!");
                }
            } else if (master) {
                if (logtime < starttime) {
                    logtime = starttime + 5000L;

                    int size = queue.size();
                    if (size > warningLines) {
                        log.warn("线程池队列已满, size:{}", size);
                    }
                }
            }
        }
    }
}
