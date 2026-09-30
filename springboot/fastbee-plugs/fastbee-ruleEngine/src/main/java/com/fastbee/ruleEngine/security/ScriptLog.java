package com.fastbee.ruleEngine.security;

/** Preserve msgContext.logger without exposing Logback configuration or its application context. */
public final class ScriptLog {
    static final ScriptLog INSTANCE = new ScriptLog();
    private static final org.slf4j.Logger LOG = org.slf4j.LoggerFactory.getLogger("script");
    private ScriptLog() {}
    public void debug(String message, Object... args) { LOG.debug(message, args); }
    public void info(String message, Object... args) { LOG.info(message, args); }
    public void warn(String message, Object... args) { LOG.warn(message, args); }
    public void error(String message, Object... args) { LOG.error(message, args); }
    public void trace(String message, Object... args) { LOG.trace(message, args); }
    public boolean isDebugEnabled() { return LOG.isDebugEnabled(); }
    public boolean isInfoEnabled() { return LOG.isInfoEnabled(); }
    public boolean isWarnEnabled() { return LOG.isWarnEnabled(); }
    public boolean isErrorEnabled() { return LOG.isErrorEnabled(); }
    public boolean isTraceEnabled() { return LOG.isTraceEnabled(); }
}
