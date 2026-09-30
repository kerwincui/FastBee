package com.fastbee.ruleEngine.security;

/** Legacy console syntax backed by the script logger, never a JVM PrintStream. */
public final class ScriptConsole {
    static final ScriptConsole OUT = new ScriptConsole(false);
    static final ScriptConsole ERR = new ScriptConsole(true);
    private final boolean error;

    private ScriptConsole(boolean error) { this.error = error; }

    private void write(String message) {
        if (error) ScriptLog.INSTANCE.error(message);
        else ScriptLog.INSTANCE.info(message);
    }

    public void print(Object value) { write(String.valueOf(value)); }
    public void println(Object value) { print(value); }
    public void println() { write(""); }
    public ScriptConsole printf(String format, Object... args) {
        write(String.format(format, args));
        return this;
    }
    public ScriptConsole format(String format, Object... args) { return printf(format, args); }
}
