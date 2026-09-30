package com.fastbee.ruleEngine.security;

import com.yomahub.liteflow.enums.ScriptTypeEnum;
import com.yomahub.liteflow.script.ScriptExecuteWrap;
import com.yomahub.liteflow.script.ScriptExecutor;
import groovy.lang.Binding;
import groovy.lang.GroovyClassLoader;
import groovy.lang.Script;
import org.codehaus.groovy.ast.*;
import org.codehaus.groovy.classgen.GeneratorContext;
import org.codehaus.groovy.control.*;
import org.codehaus.groovy.control.customizers.CompilationCustomizer;
import org.codehaus.groovy.control.customizers.ImportCustomizer;
import org.codehaus.groovy.runtime.InvokerHelper;
import org.kohsuke.groovy.sandbox.SandboxTransformer;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/** The only LiteFlow script SPI: validation, SQL startup loading and hot reload share this compiler. */
public final class SecureGroovyScriptExecutor extends ScriptExecutor {
    private static final SecureGroovyScriptExecutor SHARED = new SecureGroovyScriptExecutor();
    private final Map<String, Class<? extends Script>> scripts = new ConcurrentHashMap<>();
    // LiteFlow keeps separate language/default-language SPI keys; they must share reload/unload state.
    @Override public ScriptExecutor init() { return SHARED; }

    @Override public ScriptTypeEnum scriptType() { return ScriptTypeEnum.GROOVY; }
    @Override public void load(String nodeId, String source) { scripts.put(nodeId, compileSource(source)); }
    public void install(String nodeId, Class<? extends Script> type) { scripts.put(nodeId, type); }
    @Override public void unLoad(String nodeId) { scripts.remove(nodeId); }
    @Override public List<String> getNodeIds() { return new ArrayList<>(scripts.keySet()); }
    @Override public void cleanCache() { scripts.clear(); }
    @Override public Object compile(String source) { return compileSource(source); }

    @Override public Object executeScript(ScriptExecuteWrap wrap) {
        Class<? extends Script> type = scripts.get(wrap.getNodeId());
        if (type == null) throw new IllegalStateException("Script is disabled or not loaded: " + wrap.getNodeId());
        Map<String, Object> variables = new HashMap<>();
        bindParam(wrap, variables::put, variables::putIfAbsent);
        return evaluate(type, variables);
    }

    public static Object evaluate(Class<? extends Script> type, Map<String, Object> variables) {
        BusinessScriptInterceptor policy = new BusinessScriptInterceptor(type, variables);
        policy.register();
        try {
            // Register BEFORE construction: field initializers are untrusted code too.
            return InvokerHelper.createScript(type, new Binding(new HashMap<>(variables))).run();
        } finally {
            policy.unregister();
        }
    }

    @SuppressWarnings("unchecked")
    public static Class<? extends Script> compileSource(String source) {
        if (source == null || source.trim().isEmpty()) throw new IllegalArgumentException("脚本内容不能为空");
        if (source.length() > 262144) throw new IllegalArgumentException("脚本不能超过 256 KiB");
        CompilerConfiguration config = new CompilerConfiguration();
        // No dependency downloads or classpath-provided global compilation callbacks.
        Set<String> disabled = new HashSet<>();
        disabled.add("groovy.grape.GrabAnnotationTransformation");
        try {
            Enumeration<URL> resources = SecureGroovyScriptExecutor.class.getClassLoader().getResources(
                    "META-INF/services/org.codehaus.groovy.transform.ASTTransformation");
            while (resources.hasMoreElements()) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                        resources.nextElement().openStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        line = line.split("#", 2)[0].trim();
                        if (!line.isEmpty()) disabled.add(line);
                    }
                }
            }
        } catch (java.io.IOException e) { throw new IllegalStateException("Cannot establish compiler policy", e); }
        config.setDisabledGlobalASTTransformations(disabled);
        ImportCustomizer imports = new ImportCustomizer();
        imports.addImports("cn.hutool.json.JSONArray", "cn.hutool.json.JSONObject",
                "cn.hutool.json.JSONUtil", "cn.hutool.core.util.NumberUtil");
        config.addCompilationCustomizers(new SourceBoundary(), imports, new SandboxTransformer() {
            @Override public void processConstructors(ClassCodeExpressionTransformer visitor, ClassNode node) {
                // Groovy 3 synthesizes Script(Binding) before this phase. Transforming that
                // trusted constructor with the Groovy 2 adapter generates invalid bytecode.
                // Only compiler-generated constructors of the fixed Script base can skip it.
                if (!node.isScript() || !"groovy.lang.Script".equals(node.getSuperClass().getName()))
                    throw new SecurityException("Unsupported script base class");
                for (ConstructorNode constructor : node.getDeclaredConstructors())
                    if (constructor.getLineNumber() >= 0) throw new SecurityException("Custom constructors are forbidden");
            }
        });
        try (GroovyClassLoader loader = new GroovyClassLoader(
                SecureGroovyScriptExecutor.class.getClassLoader(), config)) {
            return (Class<? extends Script>) loader.parseClass(source);
        } catch (java.io.IOException e) { throw new IllegalStateException(e); }
    }

    /** Runs before semantic analysis, hence before local AST transforms such as ASTTest. */
    private static final class SourceBoundary extends CompilationCustomizer {
        SourceBoundary() { super(CompilePhase.CONVERSION); }
        @Override public void call(SourceUnit source, GeneratorContext context, ClassNode node) {
            if (!node.isScript() || source.getAST().getPackage() != null) {
                throw new SecurityException("规则脚本不允许声明类或包");
            }
            ClassCodeVisitorSupport visitor = new ClassCodeVisitorSupport() {
                @Override protected SourceUnit getSourceUnit() { return source; }
                @Override public void visitAnnotations(AnnotatedNode annotated) {
                    if (!annotated.getAnnotations().isEmpty()) {
                        throw new SecurityException("规则脚本不允许注解或编译期转换");
                    }
                }
            };
            for (MethodNode method : node.getMethods()) {
                if (method.getLineNumber() > 0 && Arrays.asList("getMetaClass", "setMetaClass", "getProperty",
                        "setProperty", "invokeMethod", "getBinding", "setBinding", "finalize").contains(method.getName())) {
                    throw new SecurityException("不能覆盖脚本运行时基础方法");
                }
            }
            visitor.visitClass(node);
            for (ImportNode n : source.getAST().getImports()) visitor.visitAnnotations(n);
            for (ImportNode n : source.getAST().getStarImports()) visitor.visitAnnotations(n);
            for (ImportNode n : source.getAST().getStaticImports().values()) visitor.visitAnnotations(n);
            for (ImportNode n : source.getAST().getStaticStarImports().values()) visitor.visitAnnotations(n);
        }
    }
}
