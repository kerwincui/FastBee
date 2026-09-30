package com.fastbee.security;

import com.fastbee.common.constant.CacheConstants;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.entity.*;
import com.fastbee.common.core.domain.model.*;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.utils.*;
import com.fastbee.framework.security.filter.JwtAuthenticationTokenFilter;
import com.fastbee.framework.web.service.TokenService;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceUser;
import com.fastbee.iot.domain.Script;
import com.fastbee.iot.mapper.*;
import com.fastbee.iot.model.*;
import com.fastbee.iot.ruleEngine.RuleProcess;
import com.fastbee.iot.ruleEngine.security.ScriptSecurityValidator;
import com.fastbee.iot.service.*;
import com.fastbee.iot.service.impl.ScriptServiceImpl;
import com.fastbee.mqtt.acl.MqttAccessControl;
import com.fastbee.mqtt.auth.AuthService;
import com.fastbee.ruleEngine.context.MsgContext;
import com.fastbee.ruleEngine.security.SecureGroovyScriptExecutor;
import com.fastbee.system.service.ISysUserService;
import com.fastbee.web.controller.system.SysProfileController;
import com.yomahub.liteflow.script.ScriptExecutorFactory;
import org.junit.*;
import org.mockito.ArgumentCaptor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.support.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.lang.reflect.Field;
import java.util.*;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

/** Isolated component regressions: no deployment, database, Redis or real devices are contacted. */
public class SecurityRegressionTest {
    private static final String HASH = SecurityUtils.encryptPassword("SecurityTestPassword!");
    private static org.springframework.context.support.GenericApplicationContext flowContext;
    @BeforeClass public static void initializeLocalLiteflowContext() {
        flowContext=new org.springframework.context.support.GenericApplicationContext();
        com.yomahub.liteflow.property.LiteflowConfig config=new com.yomahub.liteflow.property.LiteflowConfig();
        config.setRuleSource("security/local-flow.xml");
        flowContext.getBeanFactory().registerSingleton("liteflowConfig",config);
        flowContext.refresh(); new com.yomahub.liteflow.spi.spring.SpringAware().setApplicationContext(flowContext);
    }
    @AfterClass public static void closeLocalLiteflowContext() {
        com.yomahub.liteflow.flow.FlowBus.cleanCache();
        flowContext.close(); new com.yomahub.liteflow.spi.spring.SpringAware().setApplicationContext(null);
    }
    public static class LocalFixtureNode extends com.yomahub.liteflow.core.NodeComponent {
        @Override public void process() { }
    }
    private LoginUser login;
    private SysUser user;
    private RedisCache redis;
    private ISysUserService users;
    private AuthService auth;
    private MqttClientPrincipal principal;
    private MqttAccessControl acl;
    private DeviceMapper devices;
    private DeviceUserMapper shares;
    private Device device;

    private static void field(Object target, String name, Object value) throws Exception {
        for (Class<?> c=target.getClass(); c!=null; c=c.getSuperclass()) {
            try { Field f=c.getDeclaredField(name); f.setAccessible(true); f.set(target,value); return; }
            catch (NoSuchFieldException ignored) {}
        }
        throw new NoSuchFieldException(name);
    }
    @Before public void setup() throws Exception {
        user = new SysUser(); user.setUserId(42L); user.setUserName("owner"); user.setStatus("0"); user.setDelFlag("0"); user.setPassword(HASH); user.setRoles(new ArrayList<>());
        login = new LoginUser(42L,1L,user,new HashSet<>()); login.setToken("security-test-session"); login.setNeedChangePwd(false);
        SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken(login,null,Collections.emptyList()));
        redis=mock(RedisCache.class); users=mock(ISysUserService.class); auth=new AuthService();
        field(auth,"redisCache",redis); field(auth,"userService",users);
        when(redis.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY+login.getToken())).thenReturn(login);
        when(users.selectUserById(42L)).thenReturn(user);
        principal=MqttClientPrincipal.ofWeb("web-security-test",42L,false); principal.setSessionId(login.getToken());
        devices=mock(DeviceMapper.class); shares=mock(DeviceUserMapper.class); acl=new MqttAccessControl();
        field(acl,"authService",auth); field(acl,"deviceMapper",devices); field(acl,"deviceUserMapper",shares);
        device=new Device(); device.setDeviceId(9L); device.setProductId(41L); device.setUserId(42L); device.setTenantId(99L);
        when(devices.selectDeviceBySerialNumber("device")).thenReturn(device);
    }
    @After public void cleanup() {
        SecurityContextHolder.clearContext();
        if(TransactionSynchronizationManager.isSynchronizationActive()) TransactionSynchronizationManager.clearSynchronization();
        ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").cleanCache();
    }
    @Test public void oldDefaultPasswordSessionsAreDetected() {
        login.setNeedChangePwd(null); user.setPassword(SecurityUtils.encryptPassword("admin123"));
        assertTrue(PasswordPolicy.requiresChange(login));
        login.setNeedChangePwd(null); user.setPassword(HASH);
        assertFalse(PasswordPolicy.requiresChange(login));
    }
    @Test public void onlyTheExactNonAdminDemoAccountIsExempt() {
        user.setPassword(SecurityUtils.encryptPassword("123456"));
        user.setUserName("fastbee"); login.setNeedChangePwd(true);
        assertFalse(PasswordPolicy.requiresChange(login)); assertEquals(Boolean.FALSE,login.getNeedChangePwd());
        for(String name:Arrays.asList("admin","fastbee-t1","FastBee","fastbee-other")) {
            user.setUserName(name); login.setNeedChangePwd(null); assertTrue(name,PasswordPolicy.requiresChange(login));
        }
        user.setUserName("fastbee"); user.setUserId(1L); login.setNeedChangePwd(null);
        assertTrue("The built-in administrator is never a demo exemption",PasswordPolicy.requiresChange(login));
    }
    @Test public void demoLoginResponseUsesAuthenticatedSessionPolicy() throws Exception {
        com.fastbee.web.controller.system.SysLoginController controller=new com.fastbee.web.controller.system.SysLoginController();
        com.fastbee.framework.web.service.SysLoginService loginService=mock(com.fastbee.framework.web.service.SysLoginService.class);
        TokenService tokens=mock(TokenService.class); field(controller,"loginService",loginService); field(controller,"tokenService",tokens);
        LoginBody body=new LoginBody(); body.setUsername("FastBee"); body.setPassword("123456"); body.setCode("code"); body.setUuid("uuid");
        HttpServletRequest request=mock(HttpServletRequest.class);
        when(loginService.login(eq("FastBee"),eq("123456"),eq("code"),eq("uuid"),isNull())).thenReturn("demo-token");
        when(tokens.getLoginUserByToken("demo-token")).thenReturn(login);
        user.setUserName("fastbee"); login.setNeedChangePwd(true);
        assertEquals(Boolean.FALSE,controller.login(request,body).get("needChangePwd"));
        user.setUserName("admin"); login.setNeedChangePwd(true);
        assertEquals(Boolean.TRUE,controller.login(request,body).get("needChangePwd"));
    }
    @Test public void cachedDemoRestrictionIsClearedWithoutBlockingHomepage() throws Exception {
        user.setUserName("fastbee"); login.setNeedChangePwd(true); Filter filter=new Filter();
        TokenService tokens=mock(TokenService.class); field(filter,"tokenService",tokens);
        HttpServletRequest request=mock(HttpServletRequest.class); HttpServletResponse response=mock(HttpServletResponse.class); FilterChain chain=mock(FilterChain.class);
        when(tokens.getLoginUser(request)).thenReturn(login); when(request.getMethod()).thenReturn("GET"); when(request.getServletPath()).thenReturn("/iot/device/statistic");
        filter.invoke(request,response,chain);
        assertEquals(Boolean.FALSE,login.getNeedChangePwd()); verify(tokens).setLoginUser(login); verify(chain).doFilter(request,response);
        verify(response,never()).setStatus(403);
    }
    @Test public void demoMqttExemptionStillEnforcesDeviceAccessAndRevocation() {
        user.setUserName("fastbee"); user.setPassword(SecurityUtils.encryptPassword("123456")); login.setNeedChangePwd(true);
        assertTrue(acl.canPublish(principal,"/41/device/monitor/get","{}"));
        device.setUserId(77L); assertFalse(acl.canSubscribe(principal,"/41/device/#"));
        device.setUserId(42L); when(redis.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY+login.getToken())).thenReturn(null);
        assertFalse(acl.canPublish(principal,"/41/device/monitor/get","{}"));
    }
    private static class Filter extends JwtAuthenticationTokenFilter {
        void invoke(HttpServletRequest request,HttpServletResponse response,FilterChain chain) throws Exception { super.doFilterInternal(request,response,chain); }
    }
    @Test public void mandatoryChangeBlocksBackendEvenWithClientFlagRemoved() throws Exception {
        login.setNeedChangePwd(true); Filter filter=new Filter(); TokenService tokens=mock(TokenService.class); field(filter,"tokenService",tokens);
        HttpServletRequest request=mock(HttpServletRequest.class); HttpServletResponse response=mock(HttpServletResponse.class); FilterChain chain=mock(FilterChain.class);
        when(tokens.getLoginUser(request)).thenReturn(login); when(request.getMethod()).thenReturn("POST"); when(request.getServletPath()).thenReturn("/iot/script/validate");
        StringWriter body=new StringWriter(); when(response.getWriter()).thenReturn(new PrintWriter(body));
        filter.invoke(request,response,chain); verify(response).setStatus(403); verifyNoInteractions(chain); assertTrue(body.toString().contains("needChangePwd"));
        when(request.getMethod()).thenReturn("PUT"); when(request.getServletPath()).thenReturn("/system/user/profile/updatePwd");
        filter.invoke(request,response,chain); verify(chain).doFilter(request,response);
        assertFalse(PasswordPolicy.allowedWhileChanging("GET","/system/user/profile/updatePwd"));
    }
    @Test public void passwordChangeRejectsAnotherDefaultAndRefreshesState() throws Exception {
        login.setNeedChangePwd(true); SysProfileController controller=new SysProfileController(); TokenService tokens=mock(TokenService.class);
        field(controller,"userService",users); field(controller,"tokenService",tokens);
        Map<String,String> input=new HashMap<>(); input.put("oldPassword","SecurityTestPassword!"); input.put("newPassword","123456");
        assertNotEquals(200,controller.updatePwd(input).get("code")); verify(users,never()).resetUserPwd(anyString(),anyString());
        input.put("newPassword","ChangedPassword!"); when(users.resetUserPwd(eq("owner"),anyString())).thenReturn(1);
        assertEquals(200,controller.updatePwd(input).get("code")); assertFalse(login.getNeedChangePwd()); verify(tokens).setLoginUser(login);
    }
    @Test public void mqttOwnerAdminDeviceAndServerKeepWorking() {
        assertTrue(acl.canPublish(principal,"/41/device/monitor/get","{}"));
        assertTrue(acl.canPublish(principal,"/41/device/ota/get","{}"));
        assertTrue(acl.canSubscribe(principal,"/41/device/#"));
        assertTrue(acl.canPublish(MqttClientPrincipal.of("device",MqttClientPrincipal.ClientType.DEVICE),"/41/device/property/post"));
        assertTrue(acl.canSubscribe(MqttClientPrincipal.of("server",MqttClientPrincipal.ClientType.SERVER),"/+/+/property/post"));
        user.setUserId(1L); principal.setUserId(1L); when(users.selectUserById(1L)).thenReturn(user);
        assertTrue(acl.canSubscribe(principal,"/+/+/property/post"));
    }
    @Test public void oldRestrictedSessionCannotResetAnAlreadyChangedPassword() throws Exception {
        login.setNeedChangePwd(true); user.setPassword(SecurityUtils.encryptPassword("admin123"));
        SysUser current=new SysUser(); current.setUserId(42L); current.setStatus("0"); current.setDelFlag("0"); current.setPassword(HASH);
        when(users.selectUserById(42L)).thenReturn(current);
        SysProfileController controller=new SysProfileController(); field(controller,"userService",users); field(controller,"tokenService",mock(TokenService.class));
        Map<String,String> input=new HashMap<>(); input.put("oldPassword","admin123"); input.put("newPassword","AttackerReplacement!");
        org.springframework.context.support.StaticMessageSource messages=new org.springframework.context.support.StaticMessageSource();
        messages.addMessage("user.update.failed.password.wrong",org.springframework.context.i18n.LocaleContextHolder.getLocale(),"Old password does not match");
        org.springframework.beans.factory.support.DefaultListableBeanFactory factory=new org.springframework.beans.factory.support.DefaultListableBeanFactory();
        factory.registerSingleton("messageSource",messages); new com.fastbee.common.utils.spring.SpringUtils().postProcessBeanFactory(factory);
        assertNotEquals(200,controller.updatePwd(input).get("code"));
        verify(users,never()).resetUserPwd(anyString(),anyString());
    }
    @Test public void mqttRevocationStatusAndDefaultPasswordsApplyToExistingConnections() {
        assertTrue(acl.canPublish(principal,"/41/device/monitor/get"));
        when(redis.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY+login.getToken())).thenReturn(null);
        assertFalse(acl.canPublish(principal,"/41/device/monitor/get")); assertFalse(acl.canSubscribe(principal,"/41/device/#"));
        when(redis.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY+login.getToken())).thenReturn(login); user.setStatus("1");
        assertFalse(acl.canPublish(principal,"/41/device/monitor/get"));
        user.setStatus("0"); login.setNeedChangePwd(true); assertFalse(acl.canSubscribe(principal,"/41/device/#"));
        assertFalse(acl.canPublish(null,"/41/device/property/post"));
    }
    @Test public void crossDeviceAndSpoofedProductTopicsAreRejected() {
        device.setUserId(77L); assertFalse(acl.canPublish(principal,"/41/device/monitor/get"));
        assertFalse(acl.canSubscribe(principal,"/41/device/#")); device.setUserId(42L);
        assertFalse(acl.canPublish(principal,"/999/device/monitor/get"));
        assertFalse(acl.canSubscribe(principal,"/41/+/#"));
        assertFalse(acl.canPublish(principal,"garbage"));
    }
    @Test public void tenantAndSharedModelPermissionsArePreserved() {
        device.setUserId(77L); device.setTenantId(42L); SysRole role=new SysRole(); role.setRoleKey("tenant"); user.setRoles(Collections.singletonList(role));
        assertTrue(acl.canPublish(principal,"/41/device/ota/get"));
        user.setRoles(Collections.emptyList()); DeviceUser share=new DeviceUser(); share.setIsOwner(0); share.setPerms("monitor,temp, light");
        when(shares.selectDeviceUserByDeviceIdAndUserId(9L,42L)).thenReturn(share);
        assertTrue(acl.canSubscribe(principal,"/41/device/property/post"));
        assertTrue(acl.canPublish(principal,"/41/device/monitor/get","{}"));
        assertTrue(acl.canPublish(principal,"/41/device/function/get","[{\"id\":\"light\",\"value\":1}]"));
        assertFalse(acl.canPublish(principal,"/41/device/function/get","[{\"id\":\"other\"}]"));
        assertFalse(acl.canPublish(principal,"/41/device/property/post","{}"));
        assertFalse(acl.canPublish(principal,"/41/device/ota/get","{}"));
    }
    @Test public void legacyDeviceCacheUpgradesAndDisabledScriptsAreNotSelected() throws Exception {
        RuleProcess process=new RuleProcess(); IProductService products=mock(IProductService.class); IScriptService scripts=mock(IScriptService.class);
        field(process,"redisCache",redis); field(process,"productService",products); field(process,"scriptService",scripts);
        ProductCode product=new ProductCode(); product.setProductId(41L); product.setProtocolCode("JSON"); product.setUserId(42L);
        when(redis.containsKey(anyString())).thenReturn(true); when(redis.getCacheObject(anyString())).thenReturn("{\"productId\":41,\"protocolCode\":\"JSON\"}");
        when(products.getProtocolBySerialNumber("device")).thenReturn(product);
        assertEquals(Long.valueOf(42),process.getDeviceDetail("device").getUserId());
        when(scripts.selectRuleScriptIdArray(any())).thenReturn(new String[0]);
        process.processRuleScript("device",1,"topic","{}");
        ArgumentCaptor<ScriptCondition> condition=ArgumentCaptor.forClass(ScriptCondition.class); verify(scripts).selectRuleScriptIdArray(condition.capture());
        assertEquals(Integer.valueOf(1),condition.getValue().getEnable());
    }
    private Script script(String id,String source) {
        Script s=new Script(); s.setScriptId(id); s.setScriptLanguage("groovy"); s.setScriptData(source); s.setUserId(42L); s.setEnable(1); return s;
    }
    private ScriptServiceImpl service(ScriptMapper mapper) throws Exception {
        ScriptServiceImpl service=new ScriptServiceImpl(); field(service,"ruleScriptMapper",mapper); field(service,"scriptSecurityValidator",new ScriptSecurityValidator()); return service;
    }
    @Test public void mqttRuleConversionFeedsTheJsonDecoder() throws Exception {
        String id = "Dconsole_compatibility_report";
        String source = "System.out.println('before conversion'); def input=JSONUtil.parseObj(msgContext.payload); "
                + "def values=[]; input.keySet().forEach(key -> { values.add([id:key,value:input.getStr(key)]) }); "
                + "msgContext.payload=JSONUtil.toJsonStr(values); System.out.println(msgContext.payload)";
        com.yomahub.liteflow.core.FlowExecutor flow = new com.yomahub.liteflow.core.FlowExecutor(flowContext.getBean(com.yomahub.liteflow.property.LiteflowConfig.class));
        com.fastbee.ruleEngine.core.FlowLogExecutor logExecutor = new com.fastbee.ruleEngine.core.FlowLogExecutor(); field(logExecutor,"flowExecutor",flow);
        com.yomahub.liteflow.builder.LiteFlowNodeBuilder.createScriptNode().setId(id).setLanguage("groovy").setScript(source).build();
        RuleProcess process = new RuleProcess(); IProductService products=mock(IProductService.class); IScriptService lookup=mock(IScriptService.class);
        field(process,"redisCache",redis); field(process,"productService",products); field(process,"scriptService",lookup);
        field(process,"flowLogExecutor",logExecutor); field(process,"scriptSandbox",new com.fastbee.ruleEngine.security.ScriptSandbox());
        ProductCode product=new ProductCode(); product.setProductId(41L); product.setProtocolCode("JSON"); product.setUserId(42L);
        when(products.getProtocolBySerialNumber("D1ELV3A5TOJS")).thenReturn(product);
        when(lookup.selectRuleScriptIdArray(any())).thenReturn(new String[]{id});
        try {
            MsgContext converted = process.processRuleScript("D1ELV3A5TOJS",1,"/41/D1ELV3A5TOJS/property/post","{\"co2\":666,\"temperature\":23.5}");
            assertEquals("/41/D1ELV3A5TOJS/property/post",converted.getTopic());
            com.fastbee.common.core.mq.DeviceReport report = new com.fastbee.json.JsonProtocolService().decode(
                    com.fastbee.common.core.mq.message.DeviceData.builder().data(converted.getPayload().getBytes(java.nio.charset.StandardCharsets.UTF_8)).build(),"D1ELV3A5TOJS");
            assertEquals("D1ELV3A5TOJS",report.getSerialNumber());
            List<com.fastbee.common.core.thingsModel.ThingsModelSimpleItem> values = report.getValuesInput().getThingsModelValueRemarkItem();
            assertEquals(2,values.size());
            Map<String,String> actual = new HashMap<>();
            for(com.fastbee.common.core.thingsModel.ThingsModelSimpleItem value:values) actual.put(value.getId(),value.getValue());
            assertEquals("666",actual.get("co2")); assertEquals("23.5",actual.get("temperature"));
        } finally {
            com.yomahub.liteflow.flow.FlowBus.removeChain("dataChain_"+id);
            com.yomahub.liteflow.flow.FlowBus.removeNode(id);
        }
    }
    @Test public void invalidProtocolPayloadReportsTheOriginalParsingErrorInAllLocales() throws Exception {
        org.springframework.context.support.ResourceBundleMessageSource messages = new org.springframework.context.support.ResourceBundleMessageSource();
        messages.setBasename("i18n/messages"); messages.setDefaultEncoding("UTF-8"); messages.setFallbackToSystemLocale(false);
        org.springframework.beans.factory.support.DefaultListableBeanFactory factory = new org.springframework.beans.factory.support.DefaultListableBeanFactory();
        factory.registerSingleton("messageSource",messages);
        Field beanFactory = com.fastbee.common.utils.spring.SpringUtils.class.getDeclaredField("beanFactory"); beanFactory.setAccessible(true);
        Object previousFactory = beanFactory.get(null);
        org.springframework.context.i18n.LocaleContext previousLocale = org.springframework.context.i18n.LocaleContextHolder.getLocaleContext();
        new com.fastbee.common.utils.spring.SpringUtils().postProcessBeanFactory(factory);
        try {
            for(Locale locale:Arrays.asList(Locale.ROOT,Locale.SIMPLIFIED_CHINESE,Locale.US)) {
                org.springframework.context.i18n.LocaleContextHolder.setLocale(locale);
                try {
                    new com.fastbee.json.JsonProtocolService().decode(com.fastbee.common.core.mq.message.DeviceData.builder()
                            .data("{\"co2\":666}".getBytes(java.nio.charset.StandardCharsets.UTF_8)).build(),"D1ELV3A5TOJS");
                    fail("An unconverted object must not pass the array decoder");
                } catch (com.fastbee.common.exception.ServiceException expected) {
                    // This Fastjson version rejects the object while converting array items.
                    assertTrue(expected.getMessage(),expected.getMessage().contains("ClassCastException"));
                    assertTrue(expected.getMessage(),expected.getMessage().contains("ThingsModelSimpleItem"));
                    assertFalse(expected.getMessage().contains("{0}"));
                }
            }
        } finally {
            beanFactory.set(null,previousFactory);
            org.springframework.context.i18n.LocaleContextHolder.setLocaleContext(previousLocale);
        }
    }
    @Test public void newlyCreatedScriptRunsImmediatelyAndKeepsItsLifecycle() throws Exception {
        com.yomahub.liteflow.core.FlowExecutor flow=new com.yomahub.liteflow.core.FlowExecutor(flowContext.getBean(com.yomahub.liteflow.property.LiteflowConfig.class));
        com.fastbee.ruleEngine.core.FlowLogExecutor logExecutor=new com.fastbee.ruleEngine.core.FlowLogExecutor(); field(logExecutor,"flowExecutor",flow);
        ScriptMapper mapper=mock(ScriptMapper.class); ScriptServiceImpl service=service(mapper);
        when(mapper.insertRuleScript(any())).thenReturn(1); when(mapper.updateRuleScript(any())).thenReturn(1); when(mapper.deleteRuleScriptByIds(any())).thenReturn(1);
        Script created=script(null,"msgContext.payload = 'created'"); created.setScriptType("script"); created.setScriptPurpose(1);
        TransactionSynchronizationManager.initSynchronization();
        assertEquals(1,service.insertRuleScript(created)); String id=created.getScriptId();
        assertFalse(com.yomahub.liteflow.flow.FlowBus.containNode(id));
        for(TransactionSynchronization synchronization:TransactionSynchronizationManager.getSynchronizations()) synchronization.afterCommit();
        TransactionSynchronizationManager.clearSynchronization();
        assertTrue("A committed new script must be available to LiteFlow immediately",com.yomahub.liteflow.flow.FlowBus.containNode(id));
        when(mapper.selectRuleScriptById(id)).thenReturn(created);
        RuleProcess process=new RuleProcess(); IProductService products=mock(IProductService.class); IScriptService lookup=mock(IScriptService.class);
        field(process,"redisCache",redis); field(process,"productService",products); field(process,"scriptService",lookup);
        field(process,"flowLogExecutor",logExecutor); field(process,"scriptSandbox",new com.fastbee.ruleEngine.security.ScriptSandbox());
        ProductCode product=new ProductCode(); product.setProductId(41L); product.setProtocolCode("JSON"); product.setUserId(42L);
        when(products.getProtocolBySerialNumber("device")).thenReturn(product); when(lookup.selectRuleScriptIdArray(any())).thenReturn(new String[]{id});
        try {
            assertEquals("created",process.processRuleScript("device",1,"/41/device/property/post","{}").getPayload());
            Script edited=script(id,"msgContext.payload = 'updated'"); service.updateRuleScript(edited);
            assertEquals("updated",process.processRuleScript("device",2,"/41/device/function/get","{}").getPayload());
            assertEquals(edited.getScriptData(),com.yomahub.liteflow.flow.FlowBus.getNode(id).getScript());
            // The mapper preserves stored ownership when an update DTO omits that column.
            created.setScriptData(edited.getScriptData());
            Script disabled=new Script(); disabled.setScriptId(id); disabled.setEnable(0); service.updateRuleScript(disabled);
            assertFalse(ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").getNodeIds().contains(id));
            MsgContext blocked=new MsgContext(); assertFalse(flow.execute2Resp("dataChain_"+id,null,blocked).isSuccess()); assertNull(blocked.getPayload());
            created.setEnable(0);
            Script enabled=new Script(); enabled.setScriptId(id); enabled.setEnable(1); service.updateRuleScript(enabled);
            assertEquals("updated",process.processRuleScript("device",1,"/41/device/property/post","{}").getPayload());
            service.deleteRuleScriptById(id); assertFalse(ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").getNodeIds().contains(id));
        } finally {
            com.yomahub.liteflow.flow.FlowBus.removeChain("dataChain_"+id);
            com.yomahub.liteflow.flow.FlowBus.removeNode(id);
        }
    }
    @Test public void rolledBackScriptNeverBecomesExecutable() throws Exception {
        ScriptMapper mapper=mock(ScriptMapper.class); ScriptServiceImpl service=service(mapper); when(mapper.insertRuleScript(any())).thenReturn(1);
        TransactionSynchronizationManager.initSynchronization(); Script created=script(null,"return 1"); service.insertRuleScript(created);
        for(TransactionSynchronization synchronization:TransactionSynchronizationManager.getSynchronizations()) synchronization.afterCompletion(TransactionSynchronization.STATUS_ROLLED_BACK);
        assertFalse(com.yomahub.liteflow.flow.FlowBus.containNode(created.getScriptId()));
        assertFalse(ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").getNodeIds().contains(created.getScriptId()));
    }
    @Test public void editingNormalizesLanguagePreservesImportsAndCommitsBeforePublishing() throws Exception {
        ScriptMapper mapper=mock(ScriptMapper.class); ScriptServiceImpl service=service(mapper); Script old=script("Dtest","return 1");
        when(mapper.selectRuleScriptById("Dtest")).thenReturn(old); when(mapper.updateRuleScript(any())).thenReturn(1);
        Script update=script("Dtest","import cn.hutool.json.JSONUtil; return 2"); update.setScriptLanguage(" GROOVY ");
        TransactionSynchronizationManager.initSynchronization();
        assertEquals(1,service.updateRuleScript(update)); assertEquals("groovy",update.getScriptLanguage()); assertTrue(update.getScriptData().startsWith("import cn.hutool.json.JSONUtil; return 2"));
        assertTrue(ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").getNodeIds().isEmpty());
        for(TransactionSynchronization synchronization:TransactionSynchronizationManager.getSynchronizations()) synchronization.afterCommit();
        assertTrue(ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").getNodeIds().contains("Dtest"));
    }
    @Test public void annotationInjectionAndForeignEditsNeverReachDatabase() throws Exception {
        ScriptMapper mapper=mock(ScriptMapper.class); ScriptServiceImpl service=service(mapper); Script old=script("Dtest","return 1"); when(mapper.selectRuleScriptById("Dtest")).thenReturn(old);
        Script update=script("Dtest","@groovy.transform.ASTTest(value={ System.setProperty('fastbee.security.service','bad') }) def x=1");
        System.clearProperty("fastbee.security.service");
        try{service.updateRuleScript(update);fail();}catch(com.fastbee.common.exception.ServiceException expected){}
        assertNull(System.getProperty("fastbee.security.service")); verify(mapper,never()).updateRuleScript(any());
        old.setUserId(77L); try{service.updateRuleScript(script("Dtest","return 1"));fail();}catch(com.fastbee.common.exception.ServiceException expected){}
        try{service.deleteRuleScriptByIds(new String[]{"Dtest"});fail();}catch(com.fastbee.common.exception.ServiceException expected){}
        verify(mapper,never()).deleteRuleScriptByIds(any());
    }
    @Test public void disableAndDeleteEvictCompiledScript() throws Exception {
        ScriptMapper mapper=mock(ScriptMapper.class); ScriptServiceImpl service=service(mapper); Script old=script("Dtest","return 1"); when(mapper.selectRuleScriptById("Dtest")).thenReturn(old);
        when(mapper.updateRuleScript(any())).thenReturn(1); when(mapper.deleteRuleScriptByIds(any())).thenReturn(1);
        com.yomahub.liteflow.script.ScriptExecutor executor=ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy"); executor.load("Dtest","return 1");
        Script update=new Script(); update.setScriptId("Dtest"); update.setEnable(0); service.updateRuleScript(update); assertFalse(executor.getNodeIds().contains("Dtest"));
        executor.load("Dtest","return 1"); service.deleteRuleScriptById("Dtest"); assertFalse(executor.getNodeIds().contains("Dtest"));
    }
    @Test public void defaultAndExplicitGroovyShareTheSameReloadCache() {
        assertSame(ScriptExecutorFactory.loadInstance().getScriptExecutor(null), ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy"));
    }
    @Test public void generatedOfflineSceneStillCallsBusinessContext() throws Exception {
        org.springframework.beans.factory.support.DefaultListableBeanFactory factory=new org.springframework.beans.factory.support.DefaultListableBeanFactory();
        factory.registerSingleton("functionInvoke",mock(com.fastbee.mq.service.IFunctionInvoke.class));
        factory.registerSingleton("deviceService",mock(IDeviceService.class)); factory.registerSingleton("deviceUserService",mock(IDeviceUserService.class)); factory.registerSingleton("redis",redis);
        new com.fastbee.common.utils.spring.SpringUtils().postProcessBeanFactory(factory);
        com.fastbee.mq.ruleEngine.SceneContext context=new com.fastbee.mq.ruleEngine.SceneContext("device",41L,6,Collections.emptyList());
        String json="{\"purpose\":2,\"source\":1,\"silent\":0,\"type\":6,\"deviceNums\":\"device\",\"sceneId\":9,\"productId\":41,\"scriptId\":\"Ttest\"}";
        String source="String json="+com.alibaba.fastjson2.JSON.toJSONString(json)+"; sceneContext.process(json);";
        assertEquals(Boolean.TRUE,SecureGroovyScriptExecutor.evaluate(SecureGroovyScriptExecutor.compileSource(source),Collections.singletonMap("sceneContext",context)));
        assertEquals(1,context.getSceneThingsModelItems().size());
    }
    @Test public void mqttAuthenticationBindsAndRevokesServerSession() throws Exception {
        String secret="local-security-regression-signing-key-only"; field(auth,"secret",secret);
        String jwt=io.jsonwebtoken.Jwts.builder().claim(com.fastbee.common.constant.Constants.LOGIN_USER_KEY,login.getToken())
                .signWith(io.jsonwebtoken.SignatureAlgorithm.HS512,secret).compact();
        MqttClientPrincipal authenticated=auth.authenticate("web-test","owner",jwt);
        assertNotNull(authenticated); assertEquals(login.getToken(),authenticated.getSessionId());
        login.setNeedChangePwd(true); assertNull(auth.authenticate("web-test","owner",jwt));
        login.setNeedChangePwd(false); when(redis.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY+login.getToken())).thenReturn(null);
        assertNull(auth.authenticate("web-test","owner",jwt));
    }
    @Test public void simulatedMqttPublishCannotBypassAcl() throws Exception {
        com.fastbee.mqtt.handler.MqttPublish handler=spy(new com.fastbee.mqtt.handler.MqttPublish()); MqttAccessControl policy=mock(MqttAccessControl.class); field(handler,"mqttAccessControl",policy);
        io.netty.channel.embedded.EmbeddedChannel channel=new io.netty.channel.embedded.EmbeddedChannel();
        io.netty.channel.ChannelHandlerContext context=mock(io.netty.channel.ChannelHandlerContext.class); when(context.channel()).thenReturn(channel);
        com.fastbee.base.session.Session session=new com.fastbee.base.session.Session(); session.setPrincipal(principal); session.setClientId("web-test");
        com.fastbee.base.util.AttributeUtils.setSession(channel,session); com.fastbee.base.util.AttributeUtils.setClientId(channel,"web-test");
        io.netty.handler.codec.mqtt.MqttPublishMessage message=io.netty.handler.codec.mqtt.MqttMessageBuilders.publish().topicName("/41/device/property/simulate")
                .qos(io.netty.handler.codec.mqtt.MqttQoS.AT_LEAST_ONCE).messageId(1).payload(io.netty.buffer.Unpooled.wrappedBuffer(new byte[]{123,125})).build();
        try { handler.handler(context,message); verify(context).close(); verify(handler,never()).sendTestToMQ(any()); verify(policy).canPublish(eq(principal),eq("/41/device/property/simulate"),eq("{}")); }
        finally { message.release(); channel.finishAndReleaseAll(); }
    }
    @Test public void subscriptionRejectsOnlyUnauthorizedTopicsWithSubackCodes() throws Exception {
        com.fastbee.mqtt.handler.MqttSubscribe handler=new com.fastbee.mqtt.handler.MqttSubscribe(); field(handler,"mqttAccessControl",acl); field(handler,"redisCache",redis);
        io.netty.channel.embedded.EmbeddedChannel channel=new io.netty.channel.embedded.EmbeddedChannel(); io.netty.channel.ChannelHandlerContext context=mock(io.netty.channel.ChannelHandlerContext.class);
        when(context.channel()).thenReturn(channel); when(context.writeAndFlush(any())).thenReturn(channel.newSucceededFuture());
        com.fastbee.base.session.Session session=new com.fastbee.base.session.Session(); session.setPrincipal(principal); session.setClientId("web-test"); session.setHandlerContext(context);
        com.fastbee.base.util.AttributeUtils.setSession(channel,session);
        io.netty.handler.codec.mqtt.MqttSubscribeMessage message=io.netty.handler.codec.mqtt.MqttMessageBuilders.subscribe().messageId(7)
                .addSubscription(io.netty.handler.codec.mqtt.MqttQoS.AT_LEAST_ONCE,"/41/device/property/post")
                .addSubscription(io.netty.handler.codec.mqtt.MqttQoS.AT_LEAST_ONCE,"/41/foreign/property/post").build();
        try {
            handler.subscribe(context,message); ArgumentCaptor<Object> ack=ArgumentCaptor.forClass(Object.class); verify(context).writeAndFlush(ack.capture());
            assertEquals(Arrays.asList(1,128),((io.netty.handler.codec.mqtt.MqttSubAckMessage)ack.getValue()).payload().grantedQoSLevels());
        } finally { com.fastbee.mqtt.manager.ClientManager.remove("web-test"); channel.finishAndReleaseAll(); }
    }
    @Test public void liveDeliveryStopsAfterSessionRevocation() throws Exception {
        org.springframework.beans.factory.support.DefaultListableBeanFactory factory=new org.springframework.beans.factory.support.DefaultListableBeanFactory(); factory.registerSingleton("acl",acl);
        new com.fastbee.common.utils.spring.SpringUtils().postProcessBeanFactory(factory);
        io.netty.channel.ChannelHandlerContext context=mock(io.netty.channel.ChannelHandlerContext.class); com.fastbee.base.session.Session session=new com.fastbee.base.session.Session(); session.setPrincipal(principal); session.setHandlerContext(context);
        when(redis.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY+login.getToken())).thenReturn(null);
        io.netty.handler.codec.mqtt.MqttPublishMessage message=io.netty.handler.codec.mqtt.MqttMessageBuilders.publish().topicName("/41/device/property/post").qos(io.netty.handler.codec.mqtt.MqttQoS.AT_MOST_ONCE).payload(io.netty.buffer.Unpooled.wrappedBuffer(new byte[]{123,125})).build();
        try { com.fastbee.mqtt.manager.ResponseManager.publishClients(message,session); verify(context).close(); verify(context,never()).writeAndFlush(any()); } finally { message.release(); }
    }
}
