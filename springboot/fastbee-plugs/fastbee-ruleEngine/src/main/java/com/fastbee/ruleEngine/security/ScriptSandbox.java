package com.fastbee.ruleEngine.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import javax.annotation.PostConstruct;
import java.util.function.Supplier;

/** Compatibility facade. The mandatory compiler and per-invocation interceptor enforce security. */
@Component
public final class ScriptSandbox {
    private static volatile boolean networkAllowed = true;
    @Value("${script.sandbox.enabled:true}") private boolean enabled = true;
    @Value("${script.sandbox.allow-network:true}") private boolean allowNetwork = true;
    @PostConstruct public void init() {
        if (!enabled) throw new IllegalStateException("不允许关闭规则脚本安全校验");
        networkAllowed = allowNetwork;
    }
    static boolean isNetworkAllowed() { return networkAllowed; }
    public static boolean isEnforced() { return true; }
    public static Runnable propagate(Runnable command) { return command; }
    public <T> T call(Supplier<T> action) { return action.get(); }
    public void run(Runnable action) { action.run(); }
}
