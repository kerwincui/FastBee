<template>
    <div class="login">
        <el-row>
            <el-col :xs="24">
                <div style="color: #fff; background-color: #0f73ee; width: 100%; height: 200px; text-align: center; padding: 15px; font-family: '微软雅黑'">
                    <div style="font-size: 42px; padding-top: 40px; width: 300px; margin: 0 auto">
                        <img :src="logo" alt="logo" style="width: 100px; height: 100px; float: left" />
                        <div style="float: left; margin-top: 13px; width: 200px; text-align: left">
                            <div>FastBee</div>
                            <div style="letter-spacing: 1.5px; font-size: 20px; font-weight: 600; margin-top: -8px; margin-left: 3px">{{ $t('login.989807-0') }}</div>
                        </div>
                    </div>
                </div>

                <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
                    <el-form-item>
                        <div class="alert-box-wrap" v-if="loginForm.bindId != null">
                            <div v-if="loginForm.bindId != null" class="alert-message-wrap">
                                <i class="el-icon-warning" />
                                {{ $t('login.989807-10') }}
                            </div>
                            <el-row>
                                <el-col :span="10.5">
                                    <div v-if="loginForm.bindId != null" class="alert-message-wrap">{{ $t('login.989807-11') }}</div>
                                </el-col>
                                <router-link
                                    v-if="loginForm.bindId != null"
                                    :to="{ path: '/register', query: this.$route.query }"
                                    style="margin-left: 10px; font-size: 14px; font-family: '微软雅黑'; color: rgba(41, 96, 197, 0.856)"
                                >
                                    {{ $t('login.989807-12') }}
                                </router-link>
                            </el-row>
                        </div>
                    </el-form-item>
                    <el-form-item prop="username">
                        <el-input v-model="loginForm.username" type="text" auto-complete="off" :placeholder="$t('login.989807-20')">
                            <svg-icon slot="prefix" icon-class="user" class="input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input v-model="loginForm.password" type="password" auto-complete="off" :placeholder="$t('login.989807-21')" @keyup.enter.native="handleLogin">
                            <svg-icon slot="prefix" icon-class="password" class="input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item v-if="captchaOnOff" prop="code">
                        <el-input v-model="loginForm.code" auto-complete="off" :placeholder="$t('login.989807-22')" style="width: 63%" @keyup.enter.native="handleLogin">
                            <svg-icon slot="prefix" icon-class="validCode" class="input-icon" />
                        </el-input>

                        <div class="login-code">
                            <img :src="codeUrl" @click="getCode" />
                        </div>
                    </el-form-item>
                    <div style="display: flex; justify-content: space-between">
                        <el-checkbox v-model="loginForm.rememberMe" style="margin: 0px 0px 25px 0px; color: #000">{{ $t('login.989807-7') }}</el-checkbox>
                        <langSelect class="lang"></langSelect>
                    </div>
                    <el-form-item style="width: 100%">
                        <div style="margin-bottom: 10px">
                            <!-- <el-button v-if="!bindAccount" :loading="loading" type="primary" style="width: 100%"
                @click.native.prevent="handleLogin">
                <span v-if="!loading">登 录</span>
                <span v-else>登 录 中...</span>
              </el-button> -->
                            <div v-if="!bindId">
                                <el-button class="btn" :loading="loading" type="primary" @click.native.prevent="handleLogin">
                                    <span v-if="!loading">{{ $t('login.989807-3') }}</span>
                                    <span v-else>{{ $t('login.989807-13') }}</span>
                                </el-button>
                            </div>
                            <div v-else>
                                <el-button class="btn" :loading="loading" type="primary" @click.native.prevent="handleBindLogin">
                                    <span v-if="!loading">{{ $t('login.989807-15') }}</span>
                                    <span v-else>{{ $t('login.989807-16') }}</span>
                                </el-button>
                                <el-button style="margin: 16px 0 0 0" class="btn" @click.native.prevent="handleBackLogin">
                                    <span>{{ $t('login.989807-44') }}</span>
                                </el-button>
                            </div>
                            <el-row>
                                <div>
                                    <el-link href="https://fastbee.cn/" :underline="false" target="_blank" style="float: left">{{ $t('login.989807-41') }}</el-link>
                                    <el-link href="https://fastbee.cn/doc" :underline="false" target="_blank" style="float: left; margin-left: 20px">{{ $t('login.989807-40') }}</el-link>
                                    <router-link v-if="!bindAccount" :to="{ path: '/register', query: this.$route.query }" style="float: left; margin-left: 20px">{{ $t('login.989807-18') }}</router-link>
                                </div>
                            </el-row>
                            <div class="other-login">
                                <span class="text">{{ $t('login.989807-42') }}</span>
                                <svg-icon class="icon" icon-class="wechat" style="color: #07c160" @click="handleGotoWeChatLogin" />
                            </div>
                        </div>
                    </el-form-item>
                </el-form>
            </el-col>
        </el-row>
        <!--  底部  -->
        <div class="el-login-footer">
            <span>
                Copyright © 2021-2025
                <a target="_blank" href="http://fastbee.cn">FastBee</a>
                All Rights Reserved.
            </span>
        </div>
    </div>
</template>

<script>
import 'element-ui/lib/theme-chalk/display.css';
import logo from '@/assets/logo/logo.gif';
import { getCodeImg, checkBindId, getErrorMsg, socialLogin, bindLogin } from '@/api/login';
import Cookies from 'js-cookie';
import { encrypt, decrypt } from '@/utils/jsencrypt';
import { setToken } from '@/utils/auth';
import langSelect from '@/layout/components/langSelect';

export default {
    name: 'Login',
    components: { langSelect },
    data() {
        return {
            logo,
            codeUrl: '',
            loginForm: {
                username: '',
                password: '',
                rememberMe: false,
                code: '',
                uuid: '',
                bindId: '',
                // loginId: '',
            },
            loginRules: {
                username: [
                    {
                        required: true,
                        trigger: 'blur',
                        message: this.$t('login.989807-20'),
                    },
                ],
                password: [
                    {
                        required: true,
                        trigger: 'blur',
                        message: this.$t('login.989807-21'),
                    },
                ],
                code: [
                    {
                        required: true,
                        trigger: 'change',
                        message: this.$t('login.989807-22'),
                    },
                ],
            },
            loading: false,
            // 验证码开关
            captchaOnOff: true,
            bindAccount: false,
            // 注册开关
            register: true,
            redirect: undefined,
            bindId: '',
        };
    },
    watch: {
        $route: {
            handler: function (route) {
                this.redirect = route.query && route.query.redirect;
            },
            immediate: true,
        },
    },
    created() {
        const { loginId } = this.$route.query;
        if (!loginId) {
            this.getCode();
            this.getCookie();
            this.checkBind();
            this.checkError();
        } else {
            this.redirectSocialLogin(loginId);
        }
    },
    methods: {
        redirectLogin(loginId) {
            this.loading = true;
            this.$store
                .dispatch('RedirectLogin', loginId)
                .then(() => {
                    this.$router
                        .push({
                            path: this.redirect || '/',
                        })
                        .catch(() => {});
                })
                .catch(() => {
                    this.loading = false;
                    if (this.captchaOnOff) {
                        this.getCode();
                    }
                    this.$router.push({
                        query: {},
                    });
                });
        },
        // 微信登录
        handleGotoWeChatLogin() {
            const baseUrl = process.env.VUE_APP_BASE_API;
            window.location.href = baseUrl + '/auth/render/wechat_open_web';
        },
        // 返回登录页（绑定登录或者登录）
        handleGotoLogin() {
            if (this.captchaOnOff) {
                this.getCode();
            }
            this.clearValidate('loginForm');
            this.formIndex = 1;
            this.isHaveBind = false;
            this.errorText = '';
        },
        // 返回登录（登录）
        handleBackLogin() {
            this.bindId = '';
            this.$router.push('/login');
        },
        // 检测绑定信息
        checkBind() {
            const { bindId } = this.$route.query;
            if (bindId) {
                checkBindId(bindId).then((res) => {
                    if (res.code === 200) {
                        this.isHaveBind = true;
                    } else {
                        this.isHaveBind = false;
                    }
                    if (this.isHaveBind) {
                        this.bindId = bindId;
                    } else {
                        this.bindId = '';
                        this.$router.push({
                            query: {},
                        });
                    }
                });
            }
        },
        // 绑定账号并登录
        handleBindLogin() {
            this.$refs.loginForm.validate((valid) => {
                if (valid) {
                    this.loading = true;
                    if (this.loginForm.rememberMe) {
                        Cookies.set('username', this.loginForm.username, {
                            expires: 30,
                        });
                        Cookies.set('password', encrypt(this.loginForm.password), {
                            expires: 30,
                        });
                        Cookies.set('rememberMe', this.loginForm.rememberMe, {
                            expires: 30,
                        });
                    } else {
                        Cookies.remove('username');
                        Cookies.remove('password');
                        Cookies.remove('rememberMe');
                    }
                    const params = { ...this.loginForm, uuid: this.uuid, bindId: this.bindId };
                    bindLogin(params)
                        .then((res) => {
                            setToken(res.token); // 保存token
                            this.$router
                                .push({
                                    path: '/',
                                })
                                .catch(() => {});
                        })
                        .catch(() => {
                            this.loading = false;
                            if (this.captchaOnOff) {
                                this.getCode();
                            }
                        });
                }
            });
        },
        // 检查错误信息
        checkError() {
            const { errorId } = this.$route.query;
            if (errorId) {
                getErrorMsg(errorId).then((res) => {
                    if (res.code === 200) {
                        this.errorText = res.msg;
                    } else {
                        this.errorText = '';
                    }
                });
            }
        },
        // 重定向到登录
        redirectLogin() {
            const { loginId } = this.$route.query;
            socialLogin(loginId).then((res) => {
                setToken(res.token); // 保存token
                this.$router.push({
                    path: this.redirect || '/',
                });
            });
        },

        redirectSocialLogin() {
            const query = this.$route.query;
            const loginId = query.loginId;
            socialLogin(loginId).then((res) => {
                // 保存token
                this.loading = true;
                setToken(res.token);
                this.$router
                    .push({
                        path: this.redirect || '/',
                    })
                    .catch(() => {});
                if (this.captchaOnOff) {
                    this.getCode();
                    this.loading = false;
                }
            });
        },
        checkBind() {
            const query = this.$route.query;
            const bindId = query.bindId;
            if (bindId === undefined || bindId === null) {
                this.bindAccount = false;
            } else {
                this.bindAccount = true;
                checkBindId(bindId).then((res) => {
                    this.bindAccount = res.bindAccount === undefined ? true : res.bindAccount;
                    if (this.bindAccount) {
                        this.loginForm.bindId = bindId;
                    } else {
                        this.loginForm.bindId = '';
                        this.$router.push({
                            query: {},
                        });
                    }
                });
            }
        },

        getCode() {
            getCodeImg().then((res) => {
                //this.captchaOnOff = res.captchaOnOff === undefined ? true : res.captchaOnOff;
                this.captchaOnOff = res.captchaEnabled;
                if (this.captchaOnOff) {
                    this.codeUrl = 'data:image/gif;base64,' + res.img;
                    this.loginForm.uuid = res.uuid;
                }
            });
        },

        getCookie() {
            const username = Cookies.get('username');
            const password = Cookies.get('password');
            const rememberMe = Cookies.get('rememberMe');
            const loginId = Cookies.get('loginId');
            this.loginForm = {
                username: username === undefined ? this.loginForm.username : username,
                password: password === undefined ? this.loginForm.password : decrypt(password),
                rememberMe: rememberMe === undefined ? false : Boolean(rememberMe),
                loginId: loginId === undefined ? this.loginForm.loginId : loginId,
            };
        },
        qqLogin() {
            window.location.href = 'http://localhost:8080/auth/render/qq';
        },
        weChatLogin() {
            const baseURL = process.env.VUE_APP_BASE_API;
            window.location.href = baseURL + '/auth/render/wechat_open_web';
        },
        authLogin() {
            this.$alert(this.$t('login.989807-63'), this.$t('login.989807-32'), {
                confirmButtonText: this.$t('confirm'),
                callback: (action) => {
                    this.$message({
                        type: 'info',
                        message: `action: ${action}`,
                    });
                },
            });
        },
        handleBind() {
            this.$refs.loginForm.validate((valid) => {
                if (valid) {
                    this.loading = true;
                    if (this.loginForm.rememberMe) {
                        Cookies.set('username', this.loginForm.username, {
                            expires: 30,
                        });
                        Cookies.set('password', encrypt(this.loginForm.password), {
                            expires: 30,
                        });
                        Cookies.set('rememberMe', this.loginForm.rememberMe, {
                            expires: 30,
                        });
                    } else {
                        Cookies.remove('username');
                        Cookies.remove('password');
                        Cookies.remove('rememberMe');
                    }
                    this.loginForm.bindId = this.$route.query.bindId;
                    bindLogin(this.loginForm)
                        .then((res) => {
                            // 保存token
                            setToken(res.token);
                            this.$router
                                .push({
                                    path: '/',
                                })
                                .catch(() => {});
                        })
                        .catch(() => {
                            this.loading = false;
                            if (this.captchaOnOff) {
                                this.loading = false;
                                this.getCode();
                            }
                        });
                }
            });
        },
        handleLogin() {
            this.$refs.loginForm.validate((valid) => {
                if (valid) {
                    this.loading = true;
                    if (this.loginForm.rememberMe) {
                        Cookies.set('username', this.loginForm.username, {
                            expires: 30,
                        });
                        Cookies.set('password', encrypt(this.loginForm.password), {
                            expires: 30,
                        });
                        Cookies.set('rememberMe', this.loginForm.rememberMe, {
                            expires: 30,
                        });
                    } else {
                        Cookies.remove('username');
                        Cookies.remove('password');
                        Cookies.remove('rememberMe');
                    }
                    this.$store
                        .dispatch('Login', this.loginForm)
                        .then(() => {
                            this.$router
                                .push({
                                    path: this.redirect || '/',
                                })
                                .catch(() => {});
                        })
                        .catch(() => {
                            this.loading = false;
                            if (this.captchaOnOff) {
                                this.getCode();
                            }
                        });
                }
            });
        },
    },
};
</script>

<style lang="scss">
.login {
    height: 100%;
    overflow: auto;
}

.bindAccountTitle {
    margin: 0px auto 30px auto;
    text-align: center;
    color: #333;
    font-size: 24px;
}

.login-form {
    margin: 30px auto 0 auto;
    padding: 15px;
    z-index: 1000;
    max-width: 350px;

    input {
        height: 38px;
        background-color: #f1f1f1;
        color: #666;
    }

    .input-icon {
        height: 39px;
        width: 14px;
        margin-left: 2px;
    }
}

.login-code {
    width: 33%;
    float: right;

    img {
        cursor: pointer;
        vertical-align: middle;
        border-radius: 3px;
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
    color: #333;
    font-family: Arial;
    font-size: 12px;
    letter-spacing: 1px;
}

.alert-box-wrap {
    border: 1px solid #f78e21;

    .alert-message-wrap {
        font-size: 14px;
        font-family: '微软雅黑';
        color: rgba(197, 41, 41, 0.856);
        margin-left: 10px;
    }
}

.btn {
    margin-top: 26px;
    width: 100%;
    height: 40px;
}
.other-login {
    margin-top: 40px;
    display: flex;
    flex-direction: row;
    align-items: center;

    .icon {
        width: 16px;
        height: 16px;
        margin: 0 12px 0 8px;
        cursor: pointer;
    }
}
</style>
