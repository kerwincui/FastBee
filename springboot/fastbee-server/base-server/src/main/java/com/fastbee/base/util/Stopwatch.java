package com.fastbee.base.util;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author bill
 */
public class Stopwatch {
    private final AtomicInteger count = new AtomicInteger();
    private final Thread thread;

    public Stopwatch start() {
        this.thread.start();
        return this;
    }

    public int increment() {
        return count.incrementAndGet();
    }

    public Stopwatch() {
        thread = new Thread(() -> {
            long start;
            while (true) {
                if (count.get() > 0) {
                    start = System.currentTimeMillis();
                    break;
                }
                try {
                    Thread.sleep(1L);
                } catch (Exception e) {
                }
            }
            while (true) {
                try {
                    Thread.sleep(2000L);
                } catch (Exception e) {
                }
                int num = count.get();
                long time = (System.currentTimeMillis() - start) / 1000;
                System.out.println(time + "\t" + num + "\t" + num / time);
            }
        });
        thread.setName(Thread.currentThread().getName() + "-c");
        thread.setPriority(Thread.MIN_PRIORITY);
        thread.setDaemon(true);
    }
}
