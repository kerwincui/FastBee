package com.fastbee.ruleEngine.security;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/** Compatibility executor; each script invocation installs its own mandatory interceptor. */
public class SandboxThreadPoolExecutor extends ThreadPoolExecutor {

    public SandboxThreadPoolExecutor(int corePoolSize, int maximumPoolSize, long keepAliveTime,
                                     TimeUnit unit, BlockingQueue<Runnable> workQueue,
                                     ThreadFactory threadFactory) {
        super(corePoolSize, maximumPoolSize, keepAliveTime, unit, workQueue, threadFactory);
    }

    @Override
    public void execute(Runnable command) {
        super.execute(ScriptSandbox.propagate(command));
    }
}
