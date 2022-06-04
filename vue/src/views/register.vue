<template>
<div class="register">

    <div style="padding:20px;">
        <el-row :gutter="10">
            <el-col :xs="24" :sm="24" :md="14" :lg="14" :xl="14">
                <div class="login-top hidden-sm-and-down">
                    <h1>
                        <a href="https://wumei.live/" target="_blank" style="color:#FFF;">物美智能</a>
                        -
                        <a href="https://wumei.live/" target="_blank" style="color:#FFF;">物联美好生活</a>
                    </h1>
                    <h2><a href="https://wumei.live/" target="_blank" style="color:#FFF;">wumei smart</a> open source living iot platform</h2>

                    <div style="max-width:330px;text-align:left;margin:0 auto;">
                        <div v-if="!bindAccount" style="padding:25px 0;">
                            <span style="color:#fff;margin-right:10px;">登录方式</span>
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
                        <div>
                            <el-button type="warning" style="padding:0px;">
                                <el-link href="https://wumei.live/" :underline="false" target="_blank" style="color:#fff;padding:12px 18px;">返回官网</el-link>
                            </el-button>
                            <el-button type="danger" style="padding:0px;">
                                <el-link href="https://wumei.live/doc" :underline="false" target="_blank" style="color:#fff;padding:12px 18px;">查看文档</el-link>
                            </el-button>
                            <el-button style="padding:0px;">
                                <router-link :to='{path:"/login",query: this.$route.query }' style="color:#666;padding:11px 18px;display:flex;padding-bottom:12px;">账号登录
                                </router-link>
                            </el-button>
                        </div>
                    </div>
                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :md="8" :lg="8" :xl="8">
                <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="register-form" style="z-index:1000">
                    <h3 class="title" v-if="!bindAccount">注册账号</h3>
                    <h3 class="title" v-else>注册绑定物美智能账户</h3>
                    <el-form-item prop="username">
                        <el-input v-model="registerForm.username" type="text" auto-complete="off" placeholder="账号">
                            <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="phonenumber">
                        <el-input v-model="registerForm.phonenumber" type="text" auto-complete="off" placeholder="手机号码">
                            <svg-icon slot="prefix" icon-class="phone" class="el-input__icon input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input v-model="registerForm.password" type="password" auto-complete="off" placeholder="密码" @keyup.enter.native="handleRegister">
                            <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="confirmPassword">
                        <el-input v-model="registerForm.confirmPassword" type="password" auto-complete="off" placeholder="确认密码" @keyup.enter.native="handleRegister">
                            <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="code" v-if="captchaOnOff">
                        <el-input v-model="registerForm.code" auto-complete="off" placeholder="验证码" style="width: 63%" @keyup.enter.native="handleRegister">
                            <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
                        </el-input>
                        <div class="register-code">
                            <img :src="codeUrl" @click="getCode" />
                        </div>
                    </el-form-item>
                    <el-form-item style="width:100%;">
                        <el-button v-if="!bindAccount" :loading="loading" type="primary" style="width:100%;" @click.native.prevent="handleRegister">
                            <span v-if="!loading">注 册</span>
                            <span v-else>注 册 中...</span>
                        </el-button>
                        <el-button v-else :loading="loading" type="primary" style="width:100%;" @click.native.prevent="handleRegister">
                            <span v-if="!loading">绑 定</span>
                            <span v-else>绑 定 中...</span>
                        </el-button>
                    </el-form-item>
                </el-form>
            </el-col>

        </el-row>
    </div>
    <!--  底部  -->
    <div class="el-register-footer">
        <span>Copyright © 2018-2021 <a target="_blank" href="http://wumei.live">wumei smart</a> All Rights Reserved.</span>
    </div>
</div>
</template>

<script>
import 'element-ui/lib/theme-chalk/display.css';
import {
    getCodeImg,
    checkBindId,
    bindRegister
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
            }).catch(() => {});
        }
    }
};
</script>

<style lang="scss">
.register {
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

.login-top {
    color: #fff;
    text-align: center;
    padding-top: 30px;

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
        padding:0px;
        h1 {
            font-size: 62px;
        }

        h2 {
            font-size: 35px;
            margin-top: -30px;
        }
    }
}

.register-form {
    box-shadow: 0 20px 20px 0 rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    background: #ffffff;
    background-color: rgba(250, 250, 250, 0.8);
    border: 1px solid #fff;
    padding: 25px 25px 5px 25px;
    margin:0 auto;
    z-index: 1000;
    max-width: 370px;
    margin-bottom: 100px;

    .el-input {
        height: 38px;
        input {
            height: 38px;
            background-color: rgba(0, 0, 0, 0.1);
            color:#333;
        }
         // 谷歌
        input::-webkit-input-placeholder{
            color:#666;
        }
        // 火狐19+版本
        input::-moz-placeholder{   /* Mozilla Firefox 19+ */
            color:#666;
        }
        // 火狐4-18版本
        input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
            color:#666;
        }
        // IE10-11版本
        input:-ms-input-placeholder{  /* Internet Explorer 10-11 */ 
            color:#666;
        }
    }

    .input-icon {
        height: 39px;
        width: 14px;
        margin-left: 2px;
        color:#fff;
    }
}

.register-code {
    width: 33%;
    height: 38px;
    float: right;

    img {
        cursor: pointer;
        vertical-align: middle;
        border-radius:5px;
        height: 38px;
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
</style>
