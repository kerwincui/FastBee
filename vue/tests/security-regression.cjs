const fs = require('fs');
const path = require('path');
const vm = require('vm');
const assert = require('assert');
const compiler = require('vue-template-compiler');
const root = path.resolve(__dirname, '..');
let checks = 0;
function check(label, fn) { fn(); checks++; console.log('PASS ' + label); }
const source = p => fs.readFileSync(path.join(root, p), 'utf8');

async function main() {
  for (const file of ['src/components/ForceChangePwd/index.vue', 'src/layout/index.vue']) {
    const sfc = compiler.parseComponent(source(file));
    check('compile ' + file, () => assert.deepStrictEqual(compiler.compile(sfc.template.content).errors, []));
  }
  for (const locale of ['zh-CN', 'en-US']) {
    const messages = JSON.parse(source('src/lang/' + locale + '/common.json'));
    check(locale + ' password prompt translations', () => assert(messages.forceChangePwdTitle && messages.forceChangePwdTip && messages.forceChangePwdConfirm));
  }
  const storage = new Map();
  let info = {user: {userId: 42, userName: 'owner'}, roles: ['general'], permissions: [], needChangePwd: true};
  const sandbox = {
    module: {exports: {}}, process: {env: {}}, defAva: 'avatar',
    localStorage: {getItem: k => storage.get(k), setItem: (k,v) => storage.set(k,v), removeItem: k => storage.delete(k)},
    getToken: () => 'local-test-token', setToken: () => {}, removeToken: () => {},
    getInfo: () => Promise.resolve(info), login: () => Promise.resolve({token:'test-token',needChangePwd:true}), logout: () => Promise.resolve(),
    isHttp: () => false, isEmpty: value => !value,
  };
  const js = source('src/store/modules/user.js').replace(/^import .*$/gm, '').replace('export default user', 'module.exports = user');
  vm.runInNewContext(js, sandbox, {filename: 'user.js'});
  const store = sandbox.module.exports;
  const commit = (name, value) => store.mutations[name](store.state, value);
  const context = {commit, state: store.state};
  check('missing client flag initially false', () => assert.strictEqual(store.state.needChangePwd, false));
  await store.actions.GetInfo(context);
  check('server restores mandatory change after localStorage removal', () => assert.strictEqual(store.state.needChangePwd, true));
  info = {...info, needChangePwd: false};
  await store.actions.GetInfo(context);
  check('normal password does not display forced prompt', () => assert.strictEqual(store.state.needChangePwd, false));
  await store.actions.Login(context, {username:'owner',password:'test'});
  check('login response enables mandatory change', () => assert.strictEqual(store.state.needChangePwd, true));
  await store.actions.LogOut(context);
  check('logout clears token and prompt state', () => assert.strictEqual(store.state.token + ':' + store.state.needChangePwd, ':false'));

  let submitted = null, loggedOut = false;
  const componentSandbox = {module:{exports:{}}, location:{href:''}, updateUserPwd: input => {submitted=input; return Promise.resolve();}};
  const componentScript = compiler.parseComponent(source('src/components/ForceChangePwd/index.vue')).script.content
    .replace(/^import .*$/gm, '').replace('export default', 'module.exports =');
  vm.runInNewContext(componentScript, componentSandbox, {filename:'ForceChangePwd.vue'});
  const component = componentSandbox.module.exports;
  const instance = {$t:k=>k, $refs:{form:{validate:cb=>cb(true)}}, $modal:{msgSuccess:()=>{}},
    $store:{state:{user:{needChangePwd:true}}, commit:()=>{}, dispatch:()=>{loggedOut=true;return Promise.resolve();}}};
  Object.assign(instance,component.data.call(instance));
  instance.form.oldPassword='old'; instance.form.newPassword='NewPassword!'; instance.form.confirmPassword='NewPassword!';
  component.methods.submit.call(instance);
  await new Promise(resolve => setImmediate(resolve));
  check('password form posts old and new password', () => assert(submitted.oldPassword==='old' && submitted.newPassword==='NewPassword!'));
  check('successful change logs out and returns to login', () => assert(loggedOut && !instance.loading && componentSandbox.location.href==='/login'));
  checks += await require('./password-change-flow.cjs')();
  console.log('SECURITY_FRONTEND_PASS checks=' + checks);
}
main().catch(error => {console.error(error);process.exitCode=1;});
