<template>
    <div class="login-wrap">
        <div class="logo-wrap">
            <img class="icon" src="@/assets/images/logo_blue.png" />
            <span class="text">{{ $t('login.989807-37') }}</span>
        </div>
        <pre class="introduce-text">{{ $t('login.989807-38') }}</pre>
        <div class="img-wrap">
            <img style="width: 100%; height: 100%" src="@/assets/images/cover.png" />
        </div>
        <div class="box-wrap">
            <div class="form-box">
                <div class="title-wrap">
                    <div v-if="!bindId" class="name">{{ $t('login.989807-1') }}</div>
                    <div v-else class="name">{{ $t('login.989807-36') }}</div>
                    <langSelect class="lang"></langSelect>
                </div>
                <pre class="demo-account">{{ $t('login.989807-33') }}</pre>
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
                    </div>
                    <el-form-item style="width: 100%">
                        <div style="margin-bottom: 10px">
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
                            <div class="other-link">
                                <el-link href="https://fastbee.cn/" :underline="false" target="_blank">{{ $t('login.989807-41') }}</el-link>
                                <el-divider direction="vertical"></el-divider>
                                <el-link href="https://fastbee.cn/doc" :underline="false" target="_blank">{{ $t('login.989807-40') }}</el-link>
                                <el-divider direction="vertical"></el-divider>
                                <router-link v-if="!bindAccount" :to="{ path: '/register', query: this.$route.query }">{{ $t('login.989807-18') }}</router-link>
                            </div>
                            <div class="other-login">
                                <span class="text">{{ $t('login.989807-42') }}</span>
                                <svg-icon class="icon" icon-class="wechat" style="color: #07c160" @click="handleGotoWeChatLogin" />
                            </div>
                        </div>
                    </el-form-item>
                </el-form>
            </div>

            <!--  底部  -->
            <div class="el-login-footer">
                <span>
                    Copyright © 2021-2026
                    <a target="_blank" href="http://fastbee.cn">FastBee</a>
                    All Rights Reserved.
                </span>
            </div>
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

<style lang="scss" scoped>
.login-wrap {
    user-select: none;
    height: 100vh;
    max-width: 100%;
    width: 100vw;
    display: flex;

    .logo-wrap {
        position: absolute;
        top: 80px;
        left: 80px;
        display: flex;
        flex-direction: row;
        align-items: center;

        .icon {
            width: 42px;
            height: 46px;
        }

        .text {
            font-size: 36px;
            font-weight: 500;
            margin-left: 12px;
            color: #486ff2;
        }
    }

    .introduce-text {
        position: absolute;
        font-weight: 400;
        font-size: 14px;
        color: #909399;
        line-height: 20px;
        text-align: left;
        font-style: normal;
        top: 146px;
        left: 80px;
        width: 500px;
        white-space: pre-wrap;
        word-wrap: break-word;
    }

    .img-wrap {
        flex: 1;
        background: #0f73ee;
    }

    .box-wrap {
        position: relative;
        width: 608px;
        align-items: center;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        justify-content: center;

        .form-box {
            margin-top: -8%; // 上移35下面留宽一点
            width: 300px;

            .title-wrap {
                display: flex;
                justify-content: space-between;
                align-items: center;

                .name {
                    font-weight: 600;
                    font-size: 24px;
                    color: #303133;
                }

                .lang {
                    cursor: pointer;

                    ::v-deep .el-dropdown {
                        font-weight: 400;
                        font-size: 14px;
                        color: #909399;
                    }
                }
            }

            .demo-account {
                font-weight: 400;
                font-size: 14px;
                color: #909399;
                margin: 40px 0 0;
            }

            .form-wrap {
                ::v-deep .el-form-item {
                    margin-bottom: 21px;

                    .el-form-item__content {
                        line-height: 14px;
                    }
                }

                .text {
                    color: #909399;
                    font-size: 14px;
                    text-align: left;
                    white-space: nowrap;
                    cursor: pointer;
                }
            }

            .btn {
                margin-top: 26px;
                width: 100%;
                height: 40px;
            }
        }
    }
}
.other-link {
    margin-top: 17px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
}
.login-image {
    // width: 100%;
    // height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.cover-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.login-right {
    display: flex;
    flex-direction: column;
    background-color: #fff;
}

.login-header {
    flex-shrink: 0;
}

.login-form {
    flex: 1;
    padding: 0px;
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
    position: absolute;
    bottom: 24px;
    font-weight: 400;
    font-size: 12px;
    color: #909399;
    line-height: 20px;
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

// 响应式设计：当屏幕小于768px时，只显示右侧登录表单
@media (max-width: 767.98px) {
    .login-right {
        width: 100% !important;
    }
}
@media screen and (min-width: 1920px) {
    .login-wrap .box-wrap {
        width: 811px;
    }
}

@media screen and (max-width: 1180px) {
    .login-wrap .box-wrap {
        width: 498px;

        .form-box {
            width: 246px;
        }
    }

    .login-wrap .logo-wrap {
        top: 66px;
        left: 66px;

        .icon {
            width: 34px;
            height: 38px;
        }

        .text {
            font-size: 29px;
            margin-left: 10px;
            color: #486ff2;
        }
    }

    .login-wrap .introduce-text {
        font-size: 11px;
        top: 120px;
        left: 66px;
    }
}

@media screen and (max-width: 968px) {
    .login-wrap .img-wrap {
        display: none;
    }

    .login-wrap .logo-wrap {
        display: none;
    }

    .login-wrap .introduce-text {
        display: none;
    }

    .login-wrap .box-wrap {
        width: 100%;
    }
}
</style>
