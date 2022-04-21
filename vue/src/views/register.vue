<template>
  <div class="register">

    <div style="width:520px;padding:20px;">
      <el-row :gutter="10">
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
          <div class="login-top">
            <h1>物美智能 - 开源生活物联网平台</h1>
            <h2>wumei smart open source living iot platform</h2>
          </div>
        </el-col>
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
          <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="register-form"
                   style="z-index:1000">
            <h3 class="title" v-if="!bindAccount">注册账号</h3>
            <h3 class="title" v-else>注册绑定物美智能账户</h3>
            <el-form-item prop="username">
              <el-input v-model="registerForm.username" type="text" auto-complete="off" placeholder="账号">
                <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="phonenumber">
              <el-input v-model="registerForm.phonenumber" type="text" auto-complete="off" placeholder="手机号码">
                <svg-icon slot="prefix" icon-class="phone" class="el-input__icon input-icon"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="registerForm.password" type="password" auto-complete="off" placeholder="密码"
                        @keyup.enter.native="handleRegister">
                <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="confirmPassword">
              <el-input v-model="registerForm.confirmPassword" type="password" auto-complete="off" placeholder="确认密码"
                        @keyup.enter.native="handleRegister">
                <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon"/>
              </el-input>
            </el-form-item>
            <el-form-item prop="code" v-if="captchaOnOff">
              <el-input v-model="registerForm.code" auto-complete="off" placeholder="验证码" style="width: 63%"
                        @keyup.enter.native="handleRegister">
                <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon"/>
              </el-input>
              <div class="register-code">
                <img :src="codeUrl" @click="getCode" class="register-code-img"/>
              </div>
            </el-form-item>
            <el-form-item style="width:100%;">
              <el-button v-if="!bindAccount" :loading="loading" size="medium" type="primary" style="width:100%;"
                         @click.native.prevent="handleRegister">
                <span v-if="!loading">注 册</span>
                <span v-else>注 册 中...</span>
              </el-button>
              <el-button v-else :loading="loading" size="medium" type="primary" style="width:100%;"
                         @click.native.prevent="handleRegister">
                <span v-if="!loading">绑 定</span>
                <span v-else>绑 定 中...</span>
              </el-button>
              <div style="margin-top:20px;">

                <div v-if="!bindAccount" style=" margin-bottom: 10px;text-align: center ">
                  <!--                        <span style="color:#fff;margin-right:10px; float: left">快速登录</span>-->

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
                <router-link style="float:left;color:#fff;font-size:16px;"
                             :to='{path:"/login",query: this.$route.query }'>使用已有账户登录 >>
                </router-link>

                <div style="float: right">
                  <a style="margin-right:20px;" target="_blank" href="http://wumei.live">返回官网</a>
                </div>

              </div>
            </el-form-item>
          </el-form>
        </el-col>

      </el-row>
    </div>
    <!--  底部  -->
    <div class="el-register-footer">
      <span>Copyright © 2018-2021 <a target="_blank"
                                     href="http://wumei.live">wumei smart</a> All Rights Reserved.</span>
    </div>
  </div>
</template>

<script>
import {
  getCodeImg, checkBindId, bindRegister
} from "@/api/login";
import {
  register
} from '@/api/iot/tool';

export default {
  name: "Register",
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.registerForm.password !== value) {
        callback(new Error("两次输入的密码不一致"));
      } else {
        callback();
      }
    };
    return {
      codeUrl: "",
      registerForm: {
        username: "",
        phonenumber: "",
        password: "",
        confirmPassword: "",
        code: "",
        uuid: "",
        bindId: ""
      },
      registerRules: {
        username: [{
          required: true,
          trigger: "blur",
          message: "请输入您的账号"
        },
          {
            min: 2,
            max: 20,
            message: '用户账号长度必须介于 2 和 20 之间',
            trigger: 'blur'
          }
        ],
        phonenumber: [{
          required: true,
          trigger: "blur",
          message: "请输入您的手机号码"
        },
          {
            min: 11,
            max: 11,
            message: '手机号码长度为11',
            trigger: 'blur'
          }
        ],
        password: [{
          required: true,
          trigger: "blur",
          message: "请输入您的密码"
        },
          {
            min: 5,
            max: 20,
            message: '用户密码长度必须介于 5 和 20 之间',
            trigger: 'blur'
          }
        ],
        confirmPassword: [{
          required: true,
          trigger: "blur",
          message: "请再次输入您的密码"
        },
          {
            required: true,
            validator: equalToPassword,
            trigger: "blur"
          }
        ],
        code: [{
          required: true,
          trigger: "change",
          message: "请输入验证码"
        }]
      },
      loading: false,
      captchaOnOff: true,
      bindAccount: false
    };
  },
  created() {
    this.checkBind();
    this.getCode();
  },
  methods: {
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
            this.registerForm.bindId = bindId;
          } else {
            this.registerForm.bindId = "";
            this.$router.push({
              query: {}
            })
          }
        })
      }
    },

    getCode() {
      getCodeImg().then(res => {
        this.captchaOnOff = res.captchaOnOff === undefined ? true : res.captchaOnOff;
        if (this.captchaOnOff) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.registerForm.uuid = res.uuid;
        }
      });
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
    handleRegister() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.loading = true;
          if (this.bindAccount) {
            bindRegister(this.registerForm).then(res => {
              this.innerRegister(res)
            }).catch(() => {
              this.loading = false;
              if (this.captchaOnOff) {
                this.getCode();
              }
            });
          } else {
            register(this.registerForm).then(res => {
              this.innerRegister(res)
            }).catch(() => {
              this.loading = false;
              if (this.captchaOnOff) {
                this.getCode();
              }
            })
          }

        }
      });
    },

    innerRegister(res) {
      const username = this.registerForm.username;
      this.$alert("<font color='red'>恭喜你，您的账号 " + username + " 注册成功！</font>", '系统提示', {
        dangerouslyUseHTMLString: true,
        type: 'success'
      }).then(() => {
        this.$router.push("/login");
      }).catch(() => {
      });
    }
  }
};
</script>

<style lang="scss">
.register {
  display: flex;
  justify-content: center;
  height: 100%;
  background: linear-gradient(303deg, #48c6ef 10%, #6f86d6 80%);
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

.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #333;
  font-size: 24px;
}

.register-form {
  border-radius: 6px;
  background: #ffffff;
  background-color: rgba(250, 250, 250, 0.2);
  border: 1px solid #fff;
  padding: 25px 25px 5px 25px;
  margin: 20px;

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

.register-code {
  width: 33%;
  height: 38px;
  float: right;

  img {
    cursor: pointer;
    vertical-align: middle;
  }
}

.el-register-footer {
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

.register-code-img {
  height: 38px;
}
</style>
