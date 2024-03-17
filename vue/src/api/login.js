import request from '@/utils/request';

// 登录方法
export function login(username, password, code, uuid) {
  const data = {
    username,
    password,
    code,
    uuid,
  };
  return request({
    url: '/login',
    headers: {
      isToken: false,
    },
    method: 'post',
    data: data,
  });
}

// 注册方法
export function register(data) {
  return request({
    url: '/register',
    headers: {
      isToken: false,
    },
    method: 'post',
    data: data,
  });
}

// 获取用户详细信息
export function getInfo() {
  return request({
    url: '/getInfo',
    method: 'get',
  });
}

// 检查BindID
export function checkBindId(bindId) {
  return request({
    url: '/auth/checkBindId/' + bindId,
    method: 'get',
  });
}

// 微信绑定获取结果信息
export function getWxBindMsg(wxBindMsgId) {
  return request({
    url: '/wechat/getWxBindMsg?wxBindMsgId=' + wxBindMsgId,
    method: 'get',
  })
}

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post',
  });
}

// 获取验证码
export function getCodeImg() {
  return request({
    url: '/captchaImage',
    headers: {
      isToken: false,
    },
    method: 'get',
    timeout: 20000,
  });
}
// 微信登录直接跳转登录
export function socialLogin(loginId) {
  return request({
    url: '/auth/login/' + loginId,
    method: 'get',
  });
}

// 微信登录绑定登录
export function bindLogin(data) {
  return request({
    url: '/auth/bind/login',
    headers: {
      isToken: false,
    },
    method: 'post',
    data: data,
  });
}

// 三方登录注册绑定
export function bindRegister(data) {
  return request({
    url: '/auth/bind/register',
    headers: {
      isToken: false,
    },
    method: 'post',
    timeout: 20000,
    data: data,
  });
}
