<template>
<div class="login">

    <div style="padding:20px;">
        <el-row :gutter="10">
            <el-col :xs="24" :sm="24" :md="14" :lg="14" :xl="14">
                <div class="login-top hidden-sm-and-down">
                    <h1>
                        <a href="https://wumei.live/" target="_blank">物美智能 </a>
                        -
                        <a href="https://wumei.live/" target="_blank" style="">物联美好生活</a>
                    </h1>
                    <h2><a href="https://wumei.live/" target="_blank">wumei smart</a> open source living iot platform</h2>

                    <div style="max-width:330px;text-align:left;margin:0 auto;">                        
                        <div v-if="!bindAccount" style="padding:25px 0;">
                            <span style="margin-right:10px;">登录方式</span>
                            <el-button type="success" title="微信登录" size="mini" @click="authLogin" style="border:1px solid #fff;" disabled>
                                <svg-icon icon-class="wechat" /> 微信
                            </el-button>
                            <el-button type="danger" title="QQ登录" size="mini" @click="qqLogin" style="border:1px solid #fff;" disabled>
                                <svg-icon icon-class="qq" /> QQ
                            </el-button>
                            <el-button type="primary" title="支付宝登录" size="mini" @click="authLogin" style="border:1px solid #fff;" disabled>
                                <svg-icon icon-class="zhifubao" /> 支付宝
                            </el-button>
                        </div>
                        <div v-if="register">
                            <el-button type="warning" style="padding:0px;">
                                <el-link href="https://wumei.live/" :underline="false" target="_blank" style="color:#fff;padding:12px 18px;">返回官网</el-link>
                            </el-button>
                            <el-button type="success" style="padding:0px;">
                                <el-link href="https://wumei.live/doc" :underline="false" target="_blank" style="color:#fff;padding:12px 18px;">查看文档</el-link>
                            </el-button>
                            <el-button style="padding:0px;">
                                <router-link :to='{path:"/register",query: this.$route.query }' style="color:#666;padding:11px 18px;display:flex;padding-bottom:12px;">注册账号
                                </router-link>
                            </el-button>
                        </div>
                        <div style="line-height:20px;border:1px solid #fff;color:#eee;margin-top:30px;width:316px;">
                            <table>
                                <tr>
                                    <td rowspan="3" style="width:60px;font-weight:bold;color:#fff;line-height:28px;background-color:#F56C6C;text-align:center;font-size:18px;">演 示<br />账 号</td>
                                    <td style="padding:10px 15px 0 10px;">受限管理</td>
                                    <td style="padding:10px 30px 0 0;">wumei</td>
                                    <td style="padding-top:10px;">123456</td>
                                </tr>
                                 <tr>
                                    <td style="padding:0 15px 0 10px;">租户账号</td>
                                    <td>wumei-t1</td>
                                    <td>123456</td>
                                </tr>
                                 <tr>
                                    <td style="padding:0 15px 10px 10px;">普通用户</td>
                                    <td style="padding-bottom:10px;">wumei-u1</td>
                                    <td style="padding-bottom:10px;">123456</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :md="8" :lg="8" :xl="8">
                <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
                    <h3 class="title" v-if="!bindAccount">账号登录</h3>
                    <h3 class="bindAccountTitle" v-else>绑定物美智能账户</h3>
                    <el-form-item prop="username">
                        <el-input v-model="loginForm.username" type="text" auto-complete="off" placeholder="账号">
                            <svg-icon slot="prefix" icon-class="user" class="input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input v-model="loginForm.password" type="password" auto-complete="off" placeholder="密码" @keyup.enter.native="handleLogin">
                            <svg-icon slot="prefix" icon-class="password" class="input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="code" v-if="captchaOnOff">
                        <el-input v-model="loginForm.code" auto-complete="off" placeholder="验证码" style="width: 63%" @keyup.enter.native="handleLogin">
                            <svg-icon slot="prefix" icon-class="validCode" class="input-icon" />
                        </el-input>
                        <div class="login-code">
                            <img :src="codeUrl" @click="getCode" />
                        </div>
                    </el-form-item>
                    <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;color:#000;">记住密码</el-checkbox>
                    <el-form-item style="width:100%;">
                        <el-button v-if="!bindAccount" :loading="loading" type="primary" style="width:100%;" @click.native.prevent="handleLogin">
                            <span v-if="!loading">登 录</span>
                            <span v-else>登 录 中...</span>
                        </el-button>
                        <el-button v-else :loading="loading" type="primary" style="width:100%;" @click.native.prevent="handleLogin">
                            <span v-if="!loading">绑定</span>
                            <span v-else>绑 定 中...</span>
                        </el-button>

                    </el-form-item>
                </el-form>
            </el-col>
        </el-row>
    </div>
    <!--  底部  -->
    <div class="el-login-footer">
        <span>Copyright © 2018-2021 <a target="_blank" href="http://wumei.live">wumei smart</a> All Rights Reserved.</span>
    </div>
</div>
</template>

<script>
import 'element-ui/lib/theme-chalk/display.css';
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
                }).catch(() => {});
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
                getErrorMsg(errorId).then(res => {}).catch(err => {
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
                        }).catch(() => {});
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
    background: linear-gradient(303deg, #48c6ef 10%, #6f86d6 80%);
    height: 100%;
    overflow: auto;
    padding-top: 150px;

}

.title {
    margin: 0px auto 20px auto;
    text-align: center;
    color: #333;
    font-size: 28px;
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

    @media screen and (min-width:992px) {
        h1 {
            font-size: 36px;
        }

        h2 {
            font-size: 20px;
            margin-top: -20px;
        }
    }

    @media screen and (min-width:1200px) {
        h1 {
            font-size: 46px;
        }

        h2 {
            font-size: 26px;
            margin-top: -25px;
        }
    }

    @media screen and (min-width:1920px) {
        padding: 0px;

        h1 {
            font-size: 62px;
        }

        h2 {
            font-size: 35px;
            margin-top: -30px;
        }
    }
}

.login-form {
    box-shadow: 0 20px 30px 0 rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    background-color: rgba(250, 250, 250, 0.8);
    border: 1px solid #fff;
    padding: 25px 25px 5px 25px;
    margin: 0 auto;
    z-index: 1000;
    max-width: 370px;
    margin-bottom: 100px;

    .el-input {
        height: 38px;

        input {
            height: 38px;
            background-color: rgba(0, 0, 0, 0.1);
            color: #333;
        }

        // 谷歌
        input::-webkit-input-placeholder {
            color: #666;
        }

        // 火狐19+版本
        input::-moz-placeholder {
            /* Mozilla Firefox 19+ */
            color: #666;
        }

        // 火狐4-18版本
        input:-moz-placeholder {
            /* Mozilla Firefox 4 to 18 */
            color: #666;
        }

        // IE10-11版本
        input:-ms-input-placeholder {
            /* Internet Explorer 10-11 */
            color: #666;
        }
    }

    .input-icon {
        height: 39px;
        width: 14px;
        margin-left: 2px;
        color: #fff;
    }
}

.login-code {
    width: 33%;
    height: 38px;
    float: right;

    img {
        cursor: pointer;
        vertical-align: middle;
        border-radius: 5px;
        height: 38px;
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
</style>
