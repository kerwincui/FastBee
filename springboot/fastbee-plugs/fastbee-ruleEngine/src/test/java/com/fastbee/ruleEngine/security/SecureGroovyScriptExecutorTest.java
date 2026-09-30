package com.fastbee.ruleEngine.security;

import com.fastbee.ruleEngine.context.MsgContext;
import com.yomahub.liteflow.script.ScriptExecutor;
import org.junit.Test;
import java.util.*;
import static org.junit.Assert.*;

public class SecureGroovyScriptExecutorTest {
    private Object run(String source) { return run(source, Collections.emptyMap()); }
    private Object run(String source, Map<String, Object> values) {
        return SecureGroovyScriptExecutor.evaluate(SecureGroovyScriptExecutor.compileSource(source), values);
    }
    private void rejected(String source) {
        try { run(source); fail("Unsafe script accepted: " + source); }
        catch (Exception expected) { /* Compile rejection or capability denial, never script side effects. */ }
    }
    @Test public void helperMethodsClosuresLoopsAndKeywordsInText() {
        assertEquals(12, run("def twice(x) { x * 2 }; def total = 0; [1,2,3].each { total += twice(it) }; assert 'ProcessBuilder' == 'ProcessBuilder'; return total"));
    }
    @Test public void jsonAndMutableMessageContext() {
        MsgContext message = MsgContext.builder().topic("/1/device/property/post").payload("{\"value\":2}").build();
        Object result = run("def obj = JSONUtil.parseObj(msgContext.getPayload()); obj.set('value', NumberUtil.mul(obj.getInt('value'), 3)); msgContext.setData('v', obj.getInt('value')); msgContext.setTopic('/1/device/property/post'); msgContext.setPayload(obj.toString()); return msgContext.getData('v')", Collections.singletonMap("msgContext", message));
        assertEquals(6, ((Number) result).intValue());
        assertTrue(message.getPayload().contains("6"));
    }
    @Test public void databaseSeedMessageForwardingConvertsObjectPayload() throws Exception {
        String source;
        try (java.io.InputStream input = getClass().getResourceAsStream("/database-message-forwarding.groovy")) {
            assertNotNull(input);
            source = new String(readBytes(input), java.nio.charset.StandardCharsets.UTF_8);
        }
        MsgContext message = MsgContext.builder().topic("/41/D1ELV3A5TOJS/property/post")
                .productId(41L).serialNumber("D1ELV3A5TOJS").protocolCode("JSON").payload("{\"co2\":666}").build();
        run(source, Collections.singletonMap("msgContext", message));
        assertEquals("/41/D1ELV3A5TOJS/property/post", message.getTopic());
        cn.hutool.json.JSONArray values = cn.hutool.json.JSONUtil.parseArray(message.getPayload());
        assertEquals(1, values.size());
        assertEquals("co2", values.getJSONObject(0).getStr("id"));
        assertEquals("666", values.getJSONObject(0).getStr("value"));
    }
    @Test public void safeConsoleLoggingDoesNotExposeJvmStreams() {
        java.io.PrintStream originalOut = System.out, originalErr = System.err;
        assertEquals(7, run("System.out.println('legacy log'); System.err.println('legacy warning'); "
                + "System.out.print('value='); System.out.printf('%s=%d', 'co2', 666); return 7"));
        rejected("System.out.close()");
        rejected("System.err.close()");
        rejected("System.out.getClass()");
        rejected("System.out.class");
        rejected("System.setOut(System.out)");
        rejected("System.setErr(System.err)");
        rejected("System.in.read()");
        assertSame(originalOut, System.out); assertSame(originalErr, System.err);
    }
    @Test public void javaCollectionForEachCallbacksRemainSandboxed() {
        assertEquals(Arrays.asList(2, 4), run("def result=[]; [1,2].forEach(value -> { result.add(value * 2) }); return result"));
        System.clearProperty("fastbee.security.callback");
        rejected("[1].forEach(value -> { System.setProperty('fastbee.security.callback','bad') })");
        assertNull(System.getProperty("fastbee.security.callback"));
    }
    @Test public void annotationsCannotRunDuringCompilation() {
        System.clearProperty("fastbee.security.ast");
        rejected("@groovy.transform.ASTTest(value={ System.setProperty('fastbee.security.ast','executed') }) def x = 1");
        assertNull(System.getProperty("fastbee.security.ast"));
        rejected("@groovy.lang.Grab('invalid:artifact:0') def x = 1");
        rejected("@groovy.transform.CompileStatic def x() { return 1 }; x()");
    }
    @Test public void commandApisAndSandboxSwitchAreDenied() {
        rejected("['cmd.exe','/d','/c','echo FASTBEE_SECURITY_TEST'].execute()");
        rejected("Runtime.getRuntime().exec('echo FASTBEE_SECURITY_TEST')");
        rejected("new ProcessBuilder('echo','FASTBEE_SECURITY_TEST').start()");
        rejected("com.fastbee.ruleEngine.security.ScriptSandbox.exit()");
        rejected("org.kohsuke.groovy.sandbox.GroovyInterceptor.getApplicableInterceptors().clear()");
    }
    @Test public void reflectionFilesThreadsAndNestedEnginesAreDenied() {
        rejected("Class.forName('java.lang.Runtime')");
        rejected("''.getClass().forName('java.lang.Runtime')");
        rejected("''.metaClass");
        rejected("this.binding");
        rejected("''.getAt('class')");
        rejected("new File('fastbee-security-no-such-file').text");
        rejected("new Thread({}).start()");
        rejected("new GroovyShell().evaluate('1')");
        rejected("def f = Class.&forName; f('java.lang.Runtime')");
    }
    @Test public void nestedPropertyAndArrayDataStillWork() {
        assertEquals("OK", run("def x=[a:[1,2,3]]; assert x.a[1] == 2; x.a[1]=4; assert x.a.sum()==8; return 'ok'.toUpperCase()"));
    }
    @Test public void spiHasNoUnrestrictedFallback() {
        List<ScriptExecutor> executors = new ArrayList<>();
        ServiceLoader.load(ScriptExecutor.class).forEach(executors::add);
        assertEquals(1, executors.size());
        assertEquals(SecureGroovyScriptExecutor.class, executors.get(0).getClass());
    }
    @Test public void compilationDoesNotPublishAndDisabledNodesUnload() {
        SecureGroovyScriptExecutor executor = new SecureGroovyScriptExecutor();
        executor.compile("return 1");
        assertTrue(executor.getNodeIds().isEmpty());
        executor.load("Dtest", "return 2");
        assertEquals(Collections.singletonList("Dtest"), executor.getNodeIds());
        executor.unLoad("Dtest");
        assertTrue(executor.getNodeIds().isEmpty());
    }
    @Test public void unregisteredExecutionFailsClosed() {
        try {
            SecureGroovyScriptExecutor.compileSource("return [1,2].sum()").newInstance().run();
            fail("Missing interceptor accepted");
        } catch (Exception expected) { }
    }
    @Test public void httpIntegrationRetainsExecuteMethod() throws Exception {
        com.sun.net.httpserver.HttpServer server = com.sun.net.httpserver.HttpServer.create(new java.net.InetSocketAddress("127.0.0.1", 0), 0);
        server.createContext("/test", exchange -> { byte[] body = "ok".getBytes(java.nio.charset.StandardCharsets.UTF_8); exchange.sendResponseHeaders(200, body.length); exchange.getResponseBody().write(body); exchange.close(); });
        server.start();
        try {
            assertEquals("ok", run("return cn.hutool.http.HttpRequest.get('http://127.0.0.1:" + server.getAddress().getPort() + "/test').timeout(2000).execute().body()"));
        } finally { server.stop(0); }
    }
    @Test public void originalFrontendTemplateAndLoggerAreCompatible() throws Exception {
        String source;
        try (java.io.InputStream input = getClass().getResourceAsStream("/default-data-flow.groovy")) {
            assertNotNull(input);
            source = new String(readBytes(input), java.nio.charset.StandardCharsets.UTF_8);
        }
        MsgContext message = MsgContext.builder().topic("/41/device/property/post").payload("{\"temperature\":23}").build();
        run(source, Collections.singletonMap("msgContext", message));
        assertEquals("/41/device/property/post", message.getTopic());
        assertEquals("{\"temperature\":23}", message.getPayload());
        try { run("msgContext.logger.getLoggerContext()", Collections.singletonMap("msgContext", message)); fail(); }
        catch (SecurityException expected) { }
    }
    private byte[] readBytes(java.io.InputStream input) throws Exception {
        java.io.ByteArrayOutputStream output = new java.io.ByteArrayOutputStream();
        byte[] buffer = new byte[4096]; int size;
        while ((size = input.read(buffer)) != -1) output.write(buffer, 0, size);
        return output.toByteArray();
    }
    @Test public void unsafeConversionAndMetaprogrammingAreDenied() {
        rejected("def j=JSONUtil.parseObj('{}'); j.get('x', ProcessBuilder)");
        rejected("def getMetaClass() { return null }; 1");
        rejected("System.setSecurityManager(null)");
        rejected("def x = 'java.lang.Runtime' as Class; x.getRuntime()");
        rejected("def a = ['cmd.exe']; a.('exe'+'cute')()");
        rejected("class Unsafe { static x=System.setProperty('fastbee.security.ast','bad') }; 1");
    }
    @Test public void actualLiteflowSequentialParallelAndAsyncPathsAreProtected() throws Exception {
        com.yomahub.liteflow.property.LiteflowConfig config=new com.yomahub.liteflow.property.LiteflowConfig();
        com.yomahub.liteflow.core.FlowExecutor executor=new com.yomahub.liteflow.core.FlowExecutor(config);
        com.yomahub.liteflow.builder.LiteFlowNodeBuilder.createScriptNode().setId("DsafeA").setLanguage("groovy").setScript("msgContext.setData('a',1)").build();
        com.yomahub.liteflow.builder.LiteFlowNodeBuilder.createScriptNode().setId("DsafeB").setLanguage("groovy").setScript("msgContext.setData('b',2)").build();
        com.yomahub.liteflow.builder.el.LiteFlowChainELBuilder.createChain().setChainName("securityParallel").setEL("WHEN(DsafeA,DsafeB)").build();
        MsgContext context=new MsgContext();
        com.yomahub.liteflow.flow.LiteflowResponse response=executor.execute2Future("securityParallel",null,context).get(10,java.util.concurrent.TimeUnit.SECONDS);
        assertTrue(response.getMessage(),response.isSuccess()); assertEquals(Integer.valueOf(1),context.getData("a")); assertEquals(Integer.valueOf(2),context.getData("b"));
        com.yomahub.liteflow.builder.LiteFlowNodeBuilder.createScriptNode().setId("Dunsafe").setLanguage("groovy").setScript("System.setProperty('fastbee.security.liteflow','bad')").build();
        com.yomahub.liteflow.builder.el.LiteFlowChainELBuilder.createChain().setChainName("securityUnsafe").setEL("THEN(Dunsafe)").build();
        System.clearProperty("fastbee.security.liteflow");
        assertFalse(executor.execute2Resp("securityUnsafe",null,new MsgContext()).isSuccess());
        assertNull(System.getProperty("fastbee.security.liteflow"));
        com.yomahub.liteflow.builder.el.LiteFlowChainELBuilder.createChain().setChainName("securityUnsafeParallel").setEL("WHEN(DsafeA,Dunsafe)").build();
        assertFalse(executor.execute2Future("securityUnsafeParallel",null,new MsgContext()).get(10,java.util.concurrent.TimeUnit.SECONDS).isSuccess());
        assertNull(System.getProperty("fastbee.security.liteflow"));
    }
}
