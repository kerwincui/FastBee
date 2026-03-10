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

//短信登录获取验证码
export function getSmsLoginCaptcha(phoneNumber) {
    return request({
        url: '/notify/smsLoginCaptcha?phoneNumber=' + phoneNumber,
        method: 'get',
    });
}

// 短信登录
export function smsLogin(data) {
    return request({
        url: '/auth/sms/login',
        method: 'post',
        data: data,
    });
}

export function getErrorMsg(errorId) {
    return request({
        url: '/auth/getErrorMsg/' + errorId,
        method: 'get',
    });
}

// 忘记密码发送短信
export function getSmsForgetPassword(phoneNumber) {
    return request({
        url: '/notify/smsForgetPassword?phoneNumber=' + phoneNumber,
        method: 'get',
    });
}

// 忘记密码重置用户密码
export function forgetPwdReset(data) {
    return request({
        url: '/system/user/forgetPwdReset',
        method: 'put',
        data: data,
    });
}

// ========== OAUTH 2.0 相关 ==========

export function getAuthorize(clientId) {
    return request({
        url: '/oauth2/authorize?clientId=' + clientId,
        method: 'get',
    });
}

export function authorize(responseType, clientId, redirectUri, state, autoApprove, checkedScopes, uncheckedScopes) {
    // 构建 scopes
    const scopes = {};
    for (const scope of checkedScopes) {
        scopes[scope] = true;
    }
    for (const scope of uncheckedScopes) {
        scopes[scope] = false;
    }
    // 发起请求
    return request({
        url: '/oauth2/authorize',
        headers: {
            'Content-type': 'application/x-www-form-urlencoded',
        },
        params: {
            response_type: responseType,
            client_id: clientId,
            redirect_uri: redirectUri,
            state: state,
            auto_approve: autoApprove,
            scope: JSON.stringify(scopes),
        },
        method: 'post',
    });
}

//登录
export function oauthLogin(data) {
    return request({
        url: '/auth/ssoLogin',
        method: 'post',
        data: data,
    });
}

//修改语言
export function changeLanguage(lang) {
    return request({
        url: '/changeLanguage',
        method: 'get',
        headers: {
            isToken: false,
        },
        params: {
            lang: lang,
        },
    });
}
