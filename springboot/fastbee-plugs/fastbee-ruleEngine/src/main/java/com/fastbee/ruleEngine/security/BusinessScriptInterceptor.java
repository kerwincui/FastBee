package com.fastbee.ruleEngine.security;

import com.fastbee.ruleEngine.context.MsgContext;
import groovy.lang.Closure;
import groovy.lang.GString;
import groovy.lang.Script;
import org.kohsuke.groovy.sandbox.GroovyInterceptor;
import java.lang.reflect.Method;
import java.util.*;

/** Default-deny capabilities: never grant a package, reflection or a Spring bean. */
final class BusinessScriptInterceptor extends GroovyInterceptor {
    private static Set<String> names(String text) { return new HashSet<>(Arrays.asList(text.split(" "))); }
    private static final Set<String> VALUES = names(
            "java.lang.String java.lang.StringBuilder java.lang.StringBuffer java.lang.Boolean java.lang.Character " +
            "java.lang.Byte java.lang.Short java.lang.Integer java.lang.Long java.lang.Float java.lang.Double " +
            "java.math.BigDecimal java.math.BigInteger java.math.RoundingMode java.util.Date java.util.UUID " +
            "java.util.ArrayList java.util.LinkedList java.util.HashMap java.util.LinkedHashMap java.util.TreeMap " +
            "java.util.HashSet java.util.LinkedHashSet java.util.TreeSet cn.hutool.json.JSONObject cn.hutool.json.JSONArray");
    private static final Set<String> DATA_METHODS = names(
            "toString equals hashCode compareTo isCase asBoolean size length isEmpty contains containsKey containsValue " +
            "get getAt getOrDefault put putAt putAll putIfAbsent add addAll set remove removeAll retainAll clear " +
            "keySet values entrySet getKey getValue setValue iterator listIterator hasNext next hasPrevious previous " +
            "each eachWithIndex forEach collect collectMany collectEntries find findAll findIndexOf findIndexValues findResult " +
            "any every count countBy groupBy inject sum min max sort reverse unique flatten join take drop takeWhile dropWhile " +
            "first last head tail init toList toSet toArray subList collate transpose intersect disjoint plus minus multiply " +
            "div intdiv mod power abs negate positive negative next previous round setScale scale precision signum " +
            "add subtract divide remainder pow movePointLeft movePointRight stripTrailingZeros toPlainString " +
            "intValue longValue doubleValue floatValue shortValue byteValue booleanValue toInteger toLong toDouble " +
            "toFloat toBigDecimal toBigInteger toBoolean isNumber isInteger isLong isDouble isBigDecimal " +
            "trim strip toLowerCase toUpperCase startsWith endsWith indexOf lastIndexOf substring subSequence charAt " +
            "replace replaceAll replaceFirst split tokenize matches findAll padLeft padRight capitalize " +
            "uncapitalize center getBytes getChars toCharArray concat equalsIgnoreCase compareToIgnoreCase " +
            "append insert delete deleteCharAt encodeBase64 decodeBase64 encodeHex decodeHex " +
            "getTime setTime before after format getYear getMonth getDate getHours getMinutes getSeconds " +
            "getStr getInt getLong getDouble getFloat getBool getBigDecimal getBigInteger getJSONObject getJSONArray " +
            "getObj getByPath setOnce toJSONString toStringPretty toJsonStr toJsonPrettyStr upto downto times step withIndex");
    private static final Set<String> CONTEXT_METHODS = names(
            "getTopic setTopic getPayload setPayload getSerialNumber setSerialNumber getProductId setProductId " +
            "getProtocolCode setProtocolCode getData setData hasData printlog placeholders getDataMap setDataMap");
    private static final Set<String> CONTEXT_PROPERTIES = names("topic payload serialNumber productId protocolCode dataMap");
    private static final Map<String, Set<String>> STATICS = new HashMap<>();
    static {
        STATICS.put("cn.hutool.json.JSONUtil", names("parse parseObj parseArray toJsonStr toJsonPrettyStr isTypeJSON isTypeJSONObject isTypeJSONArray quote escape wrap"));
        STATICS.put("cn.hutool.core.util.NumberUtil", names("add sub mul div round roundStr isNumber isInteger isLong isDouble isBigDecimal compare equals parseInt parseLong parseDouble parseFloat toBigDecimal toBigInteger max min count range"));
        STATICS.put("java.lang.Math", names("abs min max round ceil floor sqrt pow log log10 exp sin cos tan asin acos atan atan2 random signum toDegrees toRadians"));
        STATICS.put("java.lang.System", names("currentTimeMillis nanoTime"));
        STATICS.put("java.util.UUID", names("randomUUID fromString"));
        STATICS.put("java.util.Arrays", names("asList toString deepToString copyOf copyOfRange equals deepEquals sort binarySearch"));
        STATICS.put("java.util.Collections", names("emptyList emptyMap emptySet singleton singletonList singletonMap sort reverse min max frequency disjoint nCopies"));
        STATICS.put("cn.hutool.http.HttpUtil", names("get post createGet createPost createRequest"));
        STATICS.put("cn.hutool.http.HttpRequest", names("get post put delete patch head options"));
    }
    private final Class<? extends Script> scriptType;
    private final Map<String, Object> variables;
    private final Set<String> helpers = new HashSet<>();
    BusinessScriptInterceptor(Class<? extends Script> scriptType, Map<String, Object> variables) {
        this.scriptType = scriptType;
        this.variables = variables;
        for (Method m : scriptType.getDeclaredMethods()) {
            if (!m.isSynthetic() && !names("run main getMetaClass setMetaClass invokeMethod getProperty setProperty").contains(m.getName())) helpers.add(m.getName());
        }
    }
    private SecurityException denied(Object receiver, String operation) {
        String type = receiver == null ? "null" : receiver instanceof Class ? ((Class<?>) receiver).getName() : receiver.getClass().getName();
        return new SecurityException("规则脚本无此能力: " + type + "." + operation);
    }
    private boolean data(Object object) {
        if (object == null) return false;
        Class<?> c = object.getClass();
        return VALUES.contains(c.getName()) || object instanceof GString || c.isArray()
                || (c.getClassLoader() == null && c.getName().startsWith("java.util.")
                    && (object instanceof Collection || object instanceof Map || object instanceof Map.Entry || object instanceof Iterator))
                || c.getName().equals("groovy.lang.IntRange") || c.getName().equals("groovy.lang.EmptyRange");
    }
    private boolean staticAllowed(Class<?> type, String method) {
        Set<String> methods = STATICS.get(type.getName());
        if (type.getName().startsWith("cn.hutool.http.") && !ScriptSandbox.isNetworkAllowed()) return false;
        return methods != null && methods.contains(method)
                || VALUES.contains(type.getName()) && names("valueOf parseInt parseLong parseDouble parseFloat parseBoolean parseByte parseShort toString format join").contains(method);
    }
    @Override public Object onMethodCall(Invoker invoker, Object receiver, String method, Object... args) throws Throwable {
        checkArguments(args);
        if (receiver instanceof Class) {
            if (!staticAllowed((Class<?>) receiver, method)) throw denied(receiver, method);
        } else if (receiver != null && receiver.getClass() == scriptType) {
            if (!helpers.contains(method)) throw denied(receiver, method);
        } else if (receiver instanceof Closure && receiver.getClass().getClassLoader() == scriptType.getClassLoader()) {
            if (!names("call doCall curry rcurry ncurry memoize trampoline").contains(method)) throw denied(receiver, method);
        } else if (receiver != null && receiver.getClass() == MsgContext.class) {
            if ("getLogger".equals(method) && args.length == 0) return ScriptLog.INSTANCE;
            if (!CONTEXT_METHODS.contains(method)) throw denied(receiver, method);
        } else if (receiver == ScriptLog.INSTANCE) {
            if (!names("debug info warn error trace isDebugEnabled isInfoEnabled isWarnEnabled isErrorEnabled isTraceEnabled").contains(method)) throw denied(receiver, method);
        } else if (receiver == ScriptConsole.OUT || receiver == ScriptConsole.ERR) {
            if (!names("print println printf format").contains(method)) throw denied(receiver, method);
        } else if (receiver != null && receiver == variables.get("sceneContext")
                && receiver.getClass().getName().equals("com.fastbee.mq.ruleEngine.SceneContext")) {
            if (!"process".equals(method) || args.length != 1 || !(args[0] instanceof String)) throw denied(receiver, method);
        } else if (receiver != null && receiver.getClass().getName().equals("cn.hutool.http.HttpRequest")) {
            if (!ScriptSandbox.isNetworkAllowed() || !names("header body form timeout setConnectionTimeout setReadTimeout execute").contains(method)) throw denied(receiver, method);
        } else if (receiver != null && receiver.getClass().getName().equals("cn.hutool.http.HttpResponse")) {
            if (!names("body bodyBytes getStatus isOk header headers close").contains(method)) throw denied(receiver, method);
        } else {
            if (!data(receiver) || !DATA_METHODS.contains(method)) throw denied(receiver, method);
            if (("getAt".equals(method) || "putAt".equals(method)) && args.length > 0) checkIndex(receiver, args[0]);
        }
        return super.onMethodCall(invoker, receiver, method, args);
    }
    @Override public Object onStaticCall(Invoker invoker, Class receiver, String method, Object... args) throws Throwable {
        checkArguments(args);
        if (!staticAllowed(receiver, method)) throw denied(receiver, method);
        return super.onStaticCall(invoker, receiver, method, args);
    }
    @Override public Object onNewInstance(Invoker invoker, Class receiver, Object... args) throws Throwable {
        checkArguments(args);
        if (!VALUES.contains(receiver.getName())) throw denied(receiver, "new");
        return super.onNewInstance(invoker, receiver, args);
    }
    @Override public Object onSuperCall(Invoker invoker, Class sender, Object receiver, String method, Object... args) { throw denied(receiver, "super." + method); }
    @Override public void onSuperConstructor(Invoker invoker, Class receiver, Object... args) { throw denied(receiver, "super"); }
    @Override public Object onGetProperty(Invoker invoker, Object receiver, String property) throws Throwable {
        // Keep existing rule scripts working without handing them the shared JVM streams.
        if (receiver == System.class && "out".equals(property)) return ScriptConsole.OUT;
        if (receiver == System.class && "err".equals(property)) return ScriptConsole.ERR;
        if (receiver != null && receiver.getClass() == MsgContext.class && "logger".equals(property)) return ScriptLog.INSTANCE;
        if (receiver != null && receiver.getClass() == scriptType && variables.containsKey(property)) return variables.get(property);
        if (receiver instanceof Map) return ((Map<?, ?>) receiver).get(property);
        if (receiver != null && receiver.getClass() == MsgContext.class && CONTEXT_PROPERTIES.contains(property)) return super.onGetProperty(invoker, receiver, property);
        if (receiver instanceof Class && VALUES.contains(((Class<?>) receiver).getName())) {
            java.lang.reflect.Field field = ((Class<?>) receiver).getField(property);
            if (java.lang.reflect.Modifier.isStatic(field.getModifiers()) && java.lang.reflect.Modifier.isFinal(field.getModifiers())
                    && (field.getType().isPrimitive() || field.getType() == String.class || field.getType().isEnum())) return field.get(null);
        }
        if (data(receiver) && names("size length bytes empty time").contains(property)) return super.onGetProperty(invoker, receiver, property);
        throw denied(receiver, property);
    }
    @Override public Object onSetProperty(Invoker invoker, Object receiver, String property, Object value) throws Throwable {
        if (receiver instanceof Map) { ((Map) receiver).put(property, value); return value; }
        if (receiver != null && receiver.getClass() == MsgContext.class && CONTEXT_PROPERTIES.contains(property)) return super.onSetProperty(invoker, receiver, property, value);
        throw denied(receiver, property);
    }
    @Override public Object onGetAttribute(Invoker invoker, Object receiver, String attribute) { throw denied(receiver, attribute); }
    @Override public Object onSetAttribute(Invoker invoker, Object receiver, String attribute, Object value) { throw denied(receiver, attribute); }
    private void checkIndex(Object receiver, Object index) {
        if (receiver instanceof Map) return;
        if (!data(receiver) || !(index instanceof Number || index instanceof groovy.lang.Range || index instanceof Collection)) throw denied(receiver, "index");
        if (index instanceof Collection) for (Object i : (Collection<?>) index) if (!(i instanceof Number)) throw denied(receiver, "index");
    }
    private void checkArguments(Object[] args) {
        Set<Object> visited = Collections.newSetFromMap(new IdentityHashMap<Object, Boolean>());
        for (Object arg : args) checkArgument(arg, visited);
    }
    private void checkArgument(Object arg, Set<Object> visited) {
        if (arg == null || !visited.add(arg)) return;
        if (arg instanceof Class) {
            Class<?> type = (Class<?>) arg;
            if (!VALUES.contains(type.getName()) && !type.isPrimitive()) throw denied(type, "argument type");
        } else if (arg instanceof Map) {
            for (Object entry : ((Map<?, ?>) arg).entrySet()) {
                checkArgument(((Map.Entry<?, ?>) entry).getKey(), visited);
                checkArgument(((Map.Entry<?, ?>) entry).getValue(), visited);
            }
        } else if (arg instanceof Collection) {
            for (Object value : (Collection<?>) arg) checkArgument(value, visited);
        } else if (arg instanceof Object[]) {
            for (Object value : (Object[]) arg) checkArgument(value, visited);
        } else if (!data(arg) && arg.getClass() != MsgContext.class
                && !(arg instanceof Closure && arg.getClass().getClassLoader() == scriptType.getClassLoader())) {
            throw denied(arg, "argument");
        }
    }
    @Override public Object onGetArray(Invoker invoker, Object receiver, Object index) throws Throwable { checkIndex(receiver, index); return super.onGetArray(invoker, receiver, index); }
    @Override public Object onSetArray(Invoker invoker, Object receiver, Object index, Object value) throws Throwable { checkIndex(receiver, index); return super.onSetArray(invoker, receiver, index, value); }
}
