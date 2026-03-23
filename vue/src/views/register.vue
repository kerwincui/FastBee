<template>
    <div class="register-wrap">
        <div class="logo-wrap">
            <img class="icon" src="@/assets/images/logo_blue.png" />
            <span class="text">{{ $t('login.989807-37') }}</span>
        </div>
        <pre class="introduce-text">{{ $t('login.989807-38') }}</pre>
        <div class="img-wrap">
            <img style="width: 100%; height: 100%" src="@/assets/images/cover.png" />
        </div>
        <div class="box-wrap">
            <!-- 注册表单 -->
            <div class="form-box" v-show="!isHaveBind && !errorText && formIndex === 1">
                <div class="title-wrap">
                    <div class="name">{{ $t('register.974236-0') }}</div>
                    <langSelect class="lang"></langSelect>
                </div>
                <el-form class="form-wrap" id="registerForm" ref="registerForm" :model="registerForm" :rules="registerRules">
                    <el-form-item prop="username">
                        <div class="item-wrap">
                            <div class="input-wrap">
                                <input class="inner" v-model="registerForm.username" auto-complete="off" type="text" :placeholder="$t('login.989807-20')" />
                            </div>
                        </div>
                    </el-form-item>
                    <el-form-item prop="phonenumber">
                        <div class="item-wrap">
                            <div class="input-wrap">
                                <input class="inner" v-model="registerForm.phonenumber" auto-complete="off" type="text" :placeholder="$t('register.974236-14')" />
                            </div>
                        </div>
                    </el-form-item>
                    <el-form-item prop="password">
                        <div class="item-wrap">
                            <div class="input-wrap">
                                <input class="inner" v-model="registerForm.password" auto-complete="off" :type="pwdtype" :placeholder="$t('login.989807-21')" />
                                <span class="el-icon-view icon" @click="handlePasswordTypeChange()"></span>
                            </div>
                        </div>
                    </el-form-item>
                    <el-form-item prop="confirmPassword">
                        <div class="item-wrap">
                            <div class="input-wrap">
                                <input class="inner" v-model="registerForm.confirmPassword" auto-complete="off" :type="pwdtype" :placeholder="$t('login.989807-48')" />
                                <span class="el-icon-view icon" @click="handlePasswordTypeChange()"></span>
                            </div>
                        </div>
                    </el-form-item>
                    <el-form-item v-if="captchaOnOff" prop="code">
                        <div class="item-wrap">
                            <div class="input-wrap">
                                <input class="inner" v-model="registerForm.code" auto-complete="off" type="text" :placeholder="$t('login.989807-22')" />
                            </div>
                            <img class="input-append" :src="codeUrl" @click="getCode" />
                        </div>
                    </el-form-item>
                    <el-form-item>
                        <div class="item-wrap">
                            <el-checkbox v-model="registerForm.agree">
                                {{ $t('login.989807-53') }}
                                <span style="color: #486ff2; cursor: pointer" @click="handleGotoPrivacyPolicy">
                                    {{ $t('login.989807-54') }}
                                </span>
                            </el-checkbox>
                        </div>
                    </el-form-item>

                    <el-button class="btn" :loading="loading" type="primary" @click.native.prevent="handleRegister">
                        <span v-if="!loading">{{ $t('register.974236-4') }}</span>
                        <span v-else>{{ $t('register.974236-5') }}</span>
                    </el-button>

                    <div class="other-link">
                        <span class="text" @click="handleGotoLogin">{{ $t('register.974236-9') }}</span>
                        <el-divider direction="vertical" v-if="systemForm.document"></el-divider>
                        <span class="text" @click="handleGotoDoc" v-if="systemForm.document">{{ $t('login.989807-40') }}</span>
                        <el-divider direction="vertical" v-if="systemForm.website"></el-divider>
                        <span class="text" @click="handleGotoOS" v-if="systemForm.website">{{ $t('login.989807-41') }}</span>
                    </div>
                </el-form>
            </div>

            <!-- 绑定账号提示 -->
            <div class="form-box" v-if="isHaveBind">
                <div class="mess-text">
                    <i style="font-size: 16px" class="el-icon-warning" />
                    <span>&nbsp;{{ $t('login.989807-10') }}</span>
                    <span style="color: #486ff2; cursor: pointer" @click="handleRegister">&nbsp;{{ $t('login.989807-12') }}</span>
                </div>
                <el-button style="margin-top: 40px" class="btn" @click="handleGotoLogin">
                    <span>{{ $t('login.989807-44') }}</span>
                </el-button>
            </div>

            <!-- 错误信息提示 -->
            <div class="form-box" v-if="errorText">
                <div class="mess-text">
                    <i style="font-size: 16px" class="el-icon-warning" />
                    <span>{{ errorText }}</span>
                </div>
                <el-button style="margin-top: 40px" class="btn" @click="handleGotoLogin">
                    <span>{{ $t('login.989807-44') }}</span>
                </el-button>
            </div>

            <div class="copyright-wrap" v-if="systemForm.copyRight">
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
import { getCodeImg, checkBindId, getErrorMsg, socialLogin } from '@/api/login';
import { register } from '@/api/iot/tool';
import { setToken } from '@/utils/auth';
import langSelect from '@/layout/components/langSelect';

export default {
    name: 'Register',
    components: { langSelect },
    data() {
        const equalToPassword = (rule, value, callback) => {
            if (this.registerForm.password !== value) {
                callback(new Error(this.$t('pwdNotMatch')));
            } else {
                callback();
            }
        };
        return {
            formIndex: 1, // 1 注册表单
            pwdtype: 'password', // 控制密码可见
            codeUrl: '',
            registerForm: {
                username: '',
                phonenumber: '',
                password: '',
                confirmPassword: '',
                code: '',
                uuid: '',
                bindId: '',
                agree: false, // 同意隐私协议
            },
            registerRules: {
                username: [
                    {
                        required: true,
                        trigger: 'blur',
                        message: this.$t('login.989807-20'),
                    },
                    {
                        min: 2,
                        max: 20,
                        message: this.$t('register.974236-13'),
                        trigger: 'blur',
                    },
                ],
                phonenumber: [
                    {
                        required: true,
                        trigger: 'blur',
                        message: this.$t('register.974236-14'),
                    },
                    {
                        min: 11,
                        max: 11,
                        message: this.$t('register.974236-15'),
                        trigger: 'blur',
                    },
                ],
                password: [
                    {
                        required: true,
                        trigger: 'blur',
                        message: this.$t('login.989807-21'),
                    },
                    {
                        min: 5,
                        max: 20,
                        message: this.$t('register.974236-16'),
                        trigger: 'blur',
                    },
                    {
                        trigger: 'blur',
                        validator: (rule, value, callback) => {
                            var passwordreg = /(?![A-Z]*$)(?![a-z]*$)(?![0-9]*$)(?![^a-zA-Z0-9]*$)/;
                            if (!passwordreg.test(value)) {
                                callback(new Error(this.$t('login.989807-62')));
                            } else {
                                callback();
                            }
                        },
                    },
                ],
                confirmPassword: [
                    {
                        required: true,
                        trigger: 'blur',
                        message: this.$t('register.974236-17'),
                    },
                    {
                        required: true,
                        validator: equalToPassword,
                        trigger: 'blur',
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
            redirect: undefined,
            bindId: '',
            systemForm: {
                copyRight: true,
                logo: undefined,
                imgUrl: undefined,
                accountTip: true,
                document: true,
                website: true,
                isShowPhone: true,
                isDoc: true,
            },
            isHaveBind: false, // 是否有绑定账号
            errorText: '', // 错误信息
        };
    },
    created() {
        const { loginId } = this.$route.query;
        if (!loginId) {
            this.getCode();
            this.checkBind();
            this.checkError();
            //获取配置信息
            this.getConfigKey('sys.logo.config').then((response) => {
                if (response.code === 200 && response.msg !== '' && response.msg !== '{}') {
                    this.systemForm = JSON.parse(response.msg);
                }
            });
        } else {
            this.redirectLogin(loginId);
        }
    },
    methods: {
        // 显示|隐藏密码
        handlePasswordTypeChange() {
            this.pwdtype == 'password' ? (this.pwdtype = 'text') : (this.pwdtype = 'password');
        },
        // 获取验证码
        getCode() {
            getCodeImg().then((res) => {
                this.captchaOnOff = res.captchaEnabled;
                if (this.captchaOnOff) {
                    this.codeUrl = 'data:image/gif;base64,' + res.img;
                    this.registerForm.uuid = res.uuid;
                }
            });
        },
        // 检测绑定信息
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
                        this.registerForm.bindId = bindId;
                    } else {
                        this.registerForm.bindId = '';
                        this.$router.push({
                            query: {},
                        });
                    }
                });
            }
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
        // 返回登录页
        handleGotoLogin() {
            if (this.captchaOnOff) {
                this.getCode();
            }
            this.formIndex = 1;
            this.isHaveBind = false;
            this.errorText = '';
            this.$router.push('/login');
        },
        // 查看文档
        handleGotoDoc() {
            window.open('https://fastbee.cn/doc', '_blank');
        },
        // 返回官网
        handleGotoOS() {
            window.open('https://fastbee.cn', '_blank');
        },
        // 跳转到隐私政策
        handleGotoPrivacyPolicy() {
            window.open('https://fastbee.cn/privacy-policy.html', '_blank');
        },
        qqLogin() {
            window.location.href = 'http://localhost:8080/auth/render/qq';
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
        handleRegister() {
            // 验證是否同意隱私協議
            if (!this.registerForm.agree) {
                this.$message({
                    type: 'warning',
                    message: this.$t('login.989807-58'),
                });
                return;
            }

            this.$refs.registerForm.validate((valid) => {
                if (valid) {
                    this.loading = true;
                    if (this.bindAccount) {
                        bindRegister(this.registerForm)
                            .then((res) => {
                                this.innerRegister(res);
                            })
                            .catch(() => {
                                this.loading = false;
                                if (this.captchaOnOff) {
                                    this.getCode();
                                }
                            });
                    } else {
                        register(this.registerForm)
                            .then((res) => {
                                this.innerRegister(res);
                            })
                            .catch(() => {
                                this.loading = false;
                                if (this.captchaOnOff) {
                                    this.getCode();
                                }
                            });
                    }
                }
            });
        },
        innerRegister(res) {
            const username = this.registerForm.username;
            this.$alert("<font color='red'>" + this.$t('register.974236-18') + username + this.$t('register.974236-19') + '</font>', this.$t('register.974236-20'), {
                dangerouslyUseHTMLString: true,
                type: 'success',
            })
                .then(() => {
                    this.$router.push('/login');
                })
                .catch(() => {});
        },
    },
};
</script>

<style lang="scss" scoped>
.register-wrap {
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
                margin-bottom: 20px;

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

            .form-wrap {
                ::v-deep .el-form-item {
                    margin-bottom: 21px;

                    .el-form-item__content {
                        line-height: 14px;
                    }
                }

                .item-wrap {
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                    align-items: center;

                    .input-wrap {
                        display: flex;
                        flex-direction: row;
                        justify-content: space-between;
                        border-radius: 4px;
                        border: 1px solid #dcdfe6;
                        padding: 3px 16px;
                        width: 100%;

                        .inner {
                            background: none;
                            border: none;
                            box-sizing: border-box;
                            flex-grow: 1;
                            font-size: inherit;
                            outline: none;
                            padding: 0;
                            width: 100%;
                            color: #303133;
                            line-height: 30px;
                        }

                        .icon {
                            color: #303133;
                            cursor: pointer;
                            padding-top: 8px;
                        }
                    }

                    .input-append {
                        width: 112px;
                        height: 40px;
                        margin-left: 8px;
                        border-radius: 4px;
                        cursor: pointer;
                    }
                }

                .other-link {
                    margin-top: 17px;
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                    align-items: center;
                }

                .text {
                    color: #909399;
                    font-size: 14px;
                    text-align: left;
                    white-space: nowrap;
                    cursor: pointer;
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
            }

            .btn {
                margin-top: 26px;
                width: 100%;
                height: 40px;
            }

            .mess-text {
                font-weight: 400;
                font-size: 14px;
                line-height: 24px;
                color: #ed2525;
            }
        }

        .copyright-wrap {
            position: absolute;
            bottom: 24px;
            font-weight: 400;
            font-size: 12px;
            color: #909399;
            line-height: 20px;
        }
    }
}
// 响应式设计：当屏幕小于768px时，只显示右侧登录表单
@media (max-width: 767.98px) {
    .login-right {
        width: 100% !important;
    }
}
@media screen and (min-width: 1920px) {
    .register-wrap .box-wrap {
        width: 811px;
    }
}

@media screen and (max-width: 1180px) {
    .register-wrap .box-wrap {
        width: 498px;

        .form-box {
            width: 246px;
        }
    }

    .register-wrap .logo-wrap {
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

    .register-wrap .introduce-text {
        font-size: 11px;
        top: 120px;
        left: 66px;
    }
}

@media screen and (max-width: 968px) {
    .register-wrap .img-wrap {
        display: none;
    }

    .register-wrap .logo-wrap {
        display: none;
    }

    .register-wrap .introduce-text {
        display: none;
    }

    .register-wrap .box-wrap {
        width: 100%;
    }
}
</style>
