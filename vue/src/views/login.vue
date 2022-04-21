<template>
  <div class="login">

    <div style="width:520px;padding:20px;">
      <el-row :gutter="10">
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
          <div class="login-top">
            <h1>物美智能 - 开源生活物联网平台</h1>
            <h2>wumei smart open source living iot platform</h2>
          </div>
        </el-col>
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
          <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form" style="z-index:1000">
            <h3 class="title" v-if="!bindAccount">账号登录
              <span style="font-size:16px;color:#eee">（ 演示账号：wumei<span style="margin:0 10px;">123456 ）</span></span>
            </h3>
            <h3 class="bindAccountTitle" v-else>绑定物美智能账户
            </h3>
            <el-form-item prop="username">
              <el-input v-model="loginForm.username" type="text" auto-complete="off" placeholder="账号">
                <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="loginForm.password" type="password" auto-complete="off" placeholder="密码"
                        @keyup.enter.native="handleLogin">
                <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="code" v-if="captchaOnOff">
              <el-input v-model="loginForm.code" auto-complete="off" placeholder="验证码" style="width: 63%"
                        @keyup.enter.native="handleLogin">
                <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon"/>
              </el-input>
              <div class="login-code">
                <img :src="codeUrl" @click="getCode" class="login-code-img"/>
              </div>
            </el-form-item>
            <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;color:#000;">记住密码</el-checkbox>
            <el-form-item style="width:100%;">
              <el-button v-if="!bindAccount" :loading="loading" size="medium" type="primary" style="width:100%;"
                         @click.native.prevent="handleLogin">
                <span v-if="!loading">登 录</span>
                <span v-else>登 录 中...</span>
              </el-button>
              <el-button v-else :loading="loading" size="medium" type="primary" style="width:100%;"
                         @click.native.prevent="handleLogin">
                <span v-if="!loading">绑定</span>
                <span v-else>绑 定 中...</span>
              </el-button>
              <div style="margin-top:20px;" v-if="!bindAccount">
                <div v-if="!bindAccount" style=";text-align: center ">

                  <el-button type="success" circle title="微信登录" size="small" @click="authLogin">
                    <svg-icon icon-class="wechat"/>
                  </el-button>

                  <el-button type="danger" circle title="QQ登录" size="small" @click="qqLogin">
                    <svg-icon icon-class="qq"/>
                  </el-button>
                  <el-button type="primary" circle title="支付宝登录" size="small" @click="authLogin">
                    <svg-icon icon-class="zhifubao"/>
                  </el-button>

                </div>
              </div>
              <a style="margin-right:20px;color:#222" target="_blank" href="http://wumei.live">返回官网</a>

              <div style="float: right;margin-top:10px;" v-if="register">

                <router-link style="color:#fff;font-size:16px;" :to='{path:"/register",query: this.$route.query }'>立即注册
                  >>
                </router-link>
              </div>
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>
    </div>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>Copyright © 2018-2021 <a target="_blank"
                                     href="http://wumei.live">wumei smart</a> All Rights Reserved.</span>
    </div>
  </div>
</template>

<script>
import {
  getCodeImg,
  checkBindId,
  getErrorMsg
} from "@/api/login";
import Cookies from "js-cookie";
import {
  encrypt,
  decrypt
} from '@/utils/jsencrypt'

export default {
  name: "Login",
  data() {
    return {
      codeUrl: "",
      loginForm: {
        username: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: "",
        bindId: ""
      },
      loginRules: {
        username: [{
          required: true,
          trigger: "blur",
          message: "请输入您的账号"
        }],
        password: [{
          required: true,
          trigger: "blur",
          message: "请输入您的密码"
        }],
        code: [{
          required: true,
          trigger: "change",
          message: "请输入验证码"
        }]
      },
      loading: false,
      // 验证码开关
      captchaOnOff: true,
      bindAccount: false,
      // 注册开关
      register: true,
      redirect: undefined
    };
  },
  watch: {
    $route: {
      handler: function (route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    let loginId = this.$route.query.loginId;
    if (loginId === undefined || loginId === null) {
      this.checkBind();
      this.checkErrorMsg();
      this.getCode();
      this.getCookie();
    } else {
      this.redirectLogin(loginId);
    }


  },
  methods: {
    redirectLogin(loginId) {
      this.loading = true;
      this.$store.dispatch("RedirectLogin", loginId).then(() => {
        this.$router.push({
          path: this.redirect || "/"
        }).catch(() => {
        });
      }).catch(() => {
        this.loading = false;
        if (this.captchaOnOff) {
          this.getCode();
        }
        this.$router.push({
          query: {}
        })
      });
    },
    checkBind() {
      let query = this.$route.query;
      let bindId = query.bindId;
      if (bindId === undefined || bindId === null) {
        this.bindAccount = false;
      } else {
        this.bindAccount = true;
        checkBindId(bindId).then(res => {
          this.bindAccount = res.bindAccount === undefined ? true : res.bindAccount
          if (this.bindAccount) {
            this.loginForm.bindId = bindId;
          } else {
            this.loginForm.bindId = "";
            this.$router.push({
              query: {}
            })
          }
        })
      }
    },
    checkErrorMsg() {
      let errorId = this.$route.query.errorId;
      if (errorId !== undefined && errorId !== null) {
        getErrorMsg(errorId).then(res => {
        }).catch(err => {
          this.$router.push({
            query: {}
          })
        })
      }
    },
    getCode() {
      getCodeImg().then(res => {
        this.captchaOnOff = res.captchaOnOff === undefined ? true : res.captchaOnOff;
        if (this.captchaOnOff) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.loginForm.uuid = res.uuid;
        }
      });
    },
    getCookie() {
      const username = Cookies.get("username");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = {
        username: username === undefined ? this.loginForm.username : username,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      };
    },
    qqLogin() {
      window.location.href = "http://localhost:8080/auth/render/qq";
    },
    authLogin() {
      this.$alert('第三方登录正在集成中...', '提示消息', {
        confirmButtonText: '确定',
        callback: action => {
          this.$message({
            type: 'info',
            message: `action: ${action}`
          });
        }
      });
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("username", this.loginForm.username, {
              expires: 30
            });
            Cookies.set("password", encrypt(this.loginForm.password), {
              expires: 30
            });
            Cookies.set('rememberMe', this.loginForm.rememberMe, {
              expires: 30
            });
          } else {
            Cookies.remove("username");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          console.log(this.loginForm)
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({
              path: this.redirect || "/"
            }).catch(() => {
            });
          }).catch(() => {
            this.loading = false;
            if (this.captchaOnOff) {
              this.getCode();
            }
          });
        }
      });
    },
  }
};
</script>

<style lang="scss">
.login {
  display: flex;
  justify-content: center;
  background: linear-gradient(303deg, #48c6ef 10%, #6f86d6 80%);
  height: 100%;
  overflow: auto;
}

.title {
  margin: 0px auto 30px auto;
  text-align: left;
  color: #333;
  font-size: 24px;
}

.bindAccountTitle {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #333;
  font-size: 24px;
}

.login-top {
  color: #fff;
  text-align: center;
  font-weight: bold;
  margin-top: 100px;

  h1 {
    font-size: 30px;
  }

  h2 {
    font-size: 21px;
    margin-top: -12px;
  }
}

.login-form {
  border-radius: 6px;
  background-color: rgba(250, 250, 250, 0.2);
  border: 1px solid #fff;
  padding: 25px 25px 5px 25px;
  margin: 20px;
  margin-bottom: 100px;

  .el-input {
    height: 38px;

    input {
      height: 38px;
    }
  }

  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
}

.login-code {
  width: 33%;
  height: 38px;
  float: right;

  img {
    cursor: pointer;
    vertical-align: middle;
  }
}

.el-login-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}

.login-code-img {
  height: 38px;
}
</style>
