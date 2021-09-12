// app.js

import { appLogin } from "/utils/login.js";

App({
  onLaunch(options) {

    // 登录
    appLogin(options);
  },
  globalData: {
    userInfo: null
  }
})
