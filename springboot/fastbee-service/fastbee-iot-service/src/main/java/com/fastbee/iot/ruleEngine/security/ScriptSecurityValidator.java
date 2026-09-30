package com.fastbee.iot.ruleEngine.security;

import com.fastbee.ruleEngine.security.SecureGroovyScriptExecutor;
import org.springframework.stereotype.Component;

/** The same safe compiler serves validation, database loading and execution. */
@Component
public class ScriptSecurityValidator {
    public String validateLanguage(String language) {
        return language != null && "groovy".equalsIgnoreCase(language.trim()) ? null : "当前仅支持 groovy 脚本";
    }
    public String validateScriptData(String source) {
        try {
            SecureGroovyScriptExecutor.compileSource(source);
            return null;
        } catch (RuntimeException e) {
            String message = String.valueOf(e.getMessage()).replace((char) 10, ' ');
            return "脚本校验失败: " + message.substring(0, Math.min(300, message.length()));
        }
    }
}
