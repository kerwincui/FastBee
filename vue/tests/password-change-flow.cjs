const fs = require('fs');
const path = require('path');
const vm = require('vm');
const assert = require('assert');
const axios = require('axios');
const root = path.resolve(__dirname, '..');
const source = file => fs.readFileSync(path.join(root, file), 'utf8');
const withoutImports = js => js.replace(/^import .*$/gm, '');

module.exports = async function passwordChangeFlowTests() {
  let checks = 0;
  const check = (label, fn) => { fn(); checks++; console.log('PASS ' + label); };
  const helper = {module:{exports:{}}};
  vm.runInNewContext(source('src/utils/passwordChange.js').replace(/^export /gm, '')
    + '\nmodule.exports={PASSWORD_CHANGE_ROUTE,isPasswordChangeResponse,allowedWhileChangingPassword};',helper);
  const helpers = helper.module.exports;
  check('only explicit mandatory-password responses activate the gate', () => {
    assert(helpers.isPasswordChangeResponse({needChangePwd:true},403));
    assert(helpers.isPasswordChangeResponse({needChangePwd:true,code:403},200));
    assert(!helpers.isPasswordChangeResponse({needChangePwd:true,code:200},200));
    assert(!helpers.isPasswordChangeResponse({code:403},403));
  });
  check('password gate preserves essential endpoints with exact HTTP methods', () => {
    assert(helpers.allowedWhileChangingPassword({url:'/getInfo?refresh=1',method:'get'}));
    assert(helpers.allowedWhileChangingPassword({url:'/system/user/profile/updatePwd',method:'put'}));
    assert(helpers.allowedWhileChangingPassword({url:'/logout',method:'post'}));
    assert(!helpers.allowedWhileChangingPassword({url:'/system/user/profile/updatePwd',method:'get'}));
    assert(!helpers.allowedWhileChangingPassword({url:'/iot/device/statistic',method:'get'}));
  });

  let required=false, token='local-test-token', navigationCount=0, releaseNavigation;
  const messages=[], notifications=[];
  const state={user:{needChangePwd:false},settings:{language:'zh-CN'}};
  const router={currentRoute:{path:'/index'},replace:() => {
    navigationCount++;
    return new Promise(resolve => { releaseNavigation=resolve; });
  }};
  const store={state,commit:(name,value)=>{assert.strictEqual(name,'SET_NEED_CHANGE_PWD');state.user.needChangePwd=value;required=value;},dispatch:()=>Promise.resolve()};
  const Message=options=>messages.push(options);
  Message.error=msg=>messages.push(msg);
  let closed=0;
  const requestSandbox={module:{exports:{}},axios,router,store,getToken:()=>token,...helpers,
    Notification:{error:options=>notifications.push(options)},Message,MessageBox:{confirm:()=>Promise.reject(new Error('unused'))},
    Loading:{service:()=>({close:()=>{closed++;}})},errorCode:{default:'error'},
    tansParams:()=>'',blobValidate:()=>true,cache:{session:{getJSON:()=>null,setJSON:()=>{}}},saveAs:()=>{},
    process:{env:{VUE_APP_BASE_API:'/prod-api'}},console:{log:()=>{},warn:()=>{},error:()=>{}},location:{href:''}};
  const requestJs=withoutImports(source('src/utils/request.js')).replace('export default service;', 'module.exports={service,download};').replace(/^export /gm,'');
  vm.runInNewContext(requestJs,requestSandbox,{filename:'request.js'});
  const {service,download}=requestSandbox.module.exports;
  let adapterCalls=0;
  service.defaults.adapter=async config=>{adapterCalls++;return {status:200,data:{code:200,value:'ok'},config,request:{responseType:''}};};
  let result=await service.get('/iot/device/statistic');
  check('normal homepage requests still reach the server',()=>assert(result.value==='ok' && adapterCalls===1));
  state.user.needChangePwd=true;
  await assert.rejects(service.get('/iot/device/statistic'),err=>axios.isCancel(err)&&err.needChangePwd===true);
  check('restricted homepage requests never reach the network or show errors',()=>assert(adapterCalls===1 && messages.length===0 && notifications.length===0));
  await service.get('/getInfo');
  await service.put('/system/user/profile/updatePwd',{oldPassword:'old',newPassword:'new'});
  await service.post('/logout');
  check('getInfo password update and logout remain available',()=>assert.strictEqual(adapterCalls,4));
  await service.get('/captchaImage',{headers:{isToken:false}});
  check('anonymous login prerequisites are not blocked by a stale flag',()=>assert.strictEqual(adapterCalls,5));
  await download('/iot/device/export',{},'test.xlsx');
  check('blocked downloads close loading without a second error toast',()=>assert(closed===1 && messages.length===0 && adapterCalls===5));
  releaseNavigation(); await new Promise(resolve=>setImmediate(resolve)); navigationCount=0;
  state.user.needChangePwd=false;
  service.defaults.adapter=async config=>{throw Object.assign(new Error('Request failed with status code 403'),{config,response:{status:403,data:{code:403,needChangePwd:true,msg:'change password'}}});};
  const responses=await Promise.allSettled(Array.from({length:6},()=>service.get('/iot/device/statistic')));
  check('concurrent mandatory-password 403s produce one redirect and no toasts',()=> {
    assert(responses.every(r=>r.status==='rejected'&&axios.isCancel(r.reason)));
    assert(required && navigationCount===1 && messages.length===0 && notifications.length===0);
  });
  releaseNavigation(); await new Promise(resolve=>setImmediate(resolve)); navigationCount=0;
  state.user.needChangePwd=false;required=false;
  service.defaults.adapter=async config=>{throw Object.assign(new Error('Request failed with status code 403'),{config,response:{status:403,data:{code:403,msg:'forbidden'}}});};
  await assert.rejects(service.get('/iot/device/statistic'));
  check('ordinary authorization errors still show their original error',()=>assert(messages.length===1 && navigationCount===0 && !required));
  service.defaults.adapter=async config=>({status:200,data:{code:403,msg:'forbidden'},config,request:{responseType:''}});
  await assert.rejects(service.get('/iot/device/statistic'));
  check('ordinary application-level 403 notifications remain visible',()=>assert.strictEqual(notifications.length,1));
  service.defaults.adapter=async config=>({status:200,data:{code:403,needChangePwd:true},config,request:{responseType:''}});
  await assert.rejects(service.get('/iot/device/statistic'),err=>axios.isCancel(err));
  check('application-level mandatory-password responses use the same quiet gate',()=>assert(required && messages.length===1 && notifications.length===1 && navigationCount===1));
  releaseNavigation(); await new Promise(resolve=>setImmediate(resolve));

  let guard,afterEach,serverRequires=true,generated=0,languageLoads=0;
  let roles=[];state.user.needChangePwd=false; token='local-test-token';
  const guardStore={state,getters:{get roles(){return roles;}},dispatch:async name=>{
    if(name==='GetInfo'){state.user.needChangePwd=serverRequires;roles=['general'];}
    if(name==='GenerateRoutes'){generated++;return [];}
    if(name==='LogOut'){token='';roles=[];state.user.needChangePwd=false;}
  }};
  const guardSandbox={router:{beforeEach:fn=>{guard=fn;},afterEach:fn=>{afterEach=fn;},addRoutes:()=>{}},store:guardStore,
    Message:{error:()=>{}},NProgress:{configure:()=>{},start:()=>{},done:()=>{}},getToken:()=>token,isRelogin:{show:false},
    PASSWORD_CHANGE_ROUTE:helpers.PASSWORD_CHANGE_ROUTE,loadLanguageNames:()=>{languageLoads++;}};
  vm.runInNewContext(withoutImports(source('src/permission.js')),guardSandbox,{filename:'permission.js'});
  const navigate=path=>new Promise(resolve=>guard({path,fullPath:path,meta:{}},{path:'/'},resolve));
  result=await navigate('/index');
  check('refresh with a deleted browser flag redirects before generating business routes',()=>assert(result.path==='/change-password' && generated===0));
  result=await navigate('/change-password');
  check('the isolated password page is reachable without a redirect loop',()=>assert.strictEqual(result,undefined));
  result=await navigate('/bigScreen');
  check('direct business routes cannot mount while a password change is required',()=>assert.strictEqual(result.path,'/change-password'));
  afterEach();check('restricted navigation does not request optional language metadata',()=>assert.strictEqual(languageLoads,0));
  state.user.needChangePwd=false;serverRequires=false;roles=[];
  result=await navigate('/index');
  check('normal and demo sessions retain route generation and homepage navigation',()=>assert(result.path==='/index' && generated===1));
  afterEach();check('normal navigation still loads configured language names',()=>assert.strictEqual(languageLoads,1));
  result=await navigate('/change-password');
  check('unrestricted users do not get trapped on the password page',()=>assert.strictEqual(result.path,'/index'));
  token='';result=await navigate('/change-password');
  check('anonymous access to the password page follows the normal login flow',()=>assert.strictEqual(result,'/login?redirect=/change-password'));

  const context=function(){return {};};context.keys=()=>[];
  const fakeRequire={context:()=>context};
  let languageCalls=0;
  const languageSandbox={module:{exports:{}},Vue:{use:()=>{}},Element:{},VueI18n:function(options){this.locale=options.locale;this.t=k=>k;},
    locale:{use:()=>{}},enLocale:{},zhLocale:{},defaultSettings:{language:'zh-CN'},require:fakeRequire,
    listLanguage:async()=>{languageCalls++;return {rows:[{language:'en-US',langName:'Custom English'}]};}};
  vm.runInNewContext(withoutImports(source('src/lang/index.js')).replace('export { i18n, langs, loadLanguageNames };','module.exports={langs,loadLanguageNames};'),languageSandbox);
  check('importing translations no longer starts an eager HTTP request',()=>assert.strictEqual(languageCalls,0));
  const languageModule=languageSandbox.module.exports;
  await Promise.all([languageModule.loadLanguageNames(),languageModule.loadLanguageNames()]);
  await languageModule.loadLanguageNames();
  check('language metadata is loaded once and preserves custom names',()=>assert(languageCalls===1 && languageModule.langs['en-US'].language==='Custom English'));
  return checks;
};
