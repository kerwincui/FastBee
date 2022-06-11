<template>
<div class="app-container">
    <el-row :gutter="20">
        <el-col :span="6" :xs="24">
            <el-card class="box-card">
                <div slot="header" class="clearfix">
                    <span>个人信息</span>
                </div>
                <div>
                    <div class="text-center">
                        <userAvatar :user="user" />
                    </div>
                    <ul class="list-group list-group-striped">
                        <li class="list-group-item">
                            <svg-icon icon-class="user" />
                            用户名称
                            <div class="pull-right">{{ user.userName }}</div>
                        </li>
                        <li class="list-group-item">
                            <svg-icon icon-class="number" />
                            用户编号
                            <div class="pull-right">{{ user.userId }}</div>
                        </li>
                        <li class="list-group-item">
                            <svg-icon icon-class="phone" />
                            手机号码
                            <div class="pull-right">{{ user.phonenumber }}</div>
                        </li>
                        <li class="list-group-item">
                            <svg-icon icon-class="email" />
                            用户邮箱
                            <div class="pull-right">{{ user.email }}</div>
                        </li>
                        <li class="list-group-item" style="padding-top:40px;">
                            <svg-icon icon-class="tree" />
                            所属部门
                            <div class="pull-right" v-if="user.dept">{{ user.dept.deptName }} / {{ postGroup }}</div>
                        </li>
                        <li class="list-group-item">
                            <svg-icon icon-class="peoples" />
                            所属角色
                            <div class="pull-right">{{ roleGroup }}</div>
                        </li>
                        <li class="list-group-item">
                            <svg-icon icon-class="date" />
                            创建日期
                            <div class="pull-right">{{ user.createTime }}</div>
                        </li>
                        <li class="list-group-item">
                            <svg-icon icon-class="qq" />
                            QQ
                            <div class="pull-right" v-if="!this.qqBind">
                                <el-button size="mini" style="margin-top: -7px" @click="bind(socialAccount.QQ.name)" disabled>未绑定</el-button>
                            </div>
                            <div style="float:right;display: flex;" v-else>
                                <span>{{ this.socialAccount.QQ.value.nickname }}</span>
                                <el-image style="width: 25px; height: 25px; margin-top: -7px;margin-left: 5px;margin-right: 5px" :src="this.socialAccount.QQ.value.avatar" />
                                <el-button style="margin-top: -5px" size="mini" @click="unbind(socialAccount.QQ.name)" disabled>解除绑定
                                </el-button>
                            </div>
                        </li>

                        <li class="list-group-item">
                            <svg-icon icon-class="wechat" />
                            微信
                            <div class="pull-right">
                                <el-button style="margin-top: -7px" size="mini" disabled>未绑定</el-button>
                            </div>

                        </li>
                    </ul>
                </div>
            </el-card>
        </el-col>
        <el-col :span="18" :xs="24">
            <el-card>
                <div slot="header" class="clearfix">
                    <span>基本资料</span>
                </div>
                <el-tabs v-model="activeTab">
                    <el-tab-pane label="基本资料" name="userinfo">
                        <userInfo :user="user" />
                    </el-tab-pane>
                    <el-tab-pane label="修改密码" name="resetPwd">
                        <resetPwd :user="user" />
                    </el-tab-pane>
                </el-tabs>
            </el-card>
        </el-col>
    </el-row>
</div>
</template>

<script>
import userAvatar from "./userAvatar";
import userInfo from "./userInfo";
import resetPwd from "./resetPwd";
import {
    getUserProfile
} from "@/api/system/user";
import {
    unbind,
    bind
} from "@/api/iot/platform";

export default {
    name: "Profile",
    components: {
        userAvatar,
        userInfo,
        resetPwd
    },
    data() {
        return {
            user: {},
            roleGroup: {},
            postGroup: {},
            activeTab: "userinfo",
            socialGroup: [],
            qqBind: false,
            wechatBind: false,
            socialAccount: {
                QQ: {
                    name: "QQ",
                    value: null
                },
                Wechat: {
                    name: "Wechat",
                    value: null
                },
                Status: {
                    bind: "0",
                    unbind: "1"
                }
            },
        };
    },
    created() {
        this.getUser();
    },
    methods: {
        getUser() {
            getUserProfile().then(response => {
                this.user = response.data;
                this.roleGroup = response.roleGroup;
                this.postGroup = response.postGroup;
                this.socialGroup = response.socialGroup;
                if (!(this.socialGroup === undefined || this.socialGroup === null)) {
                    this.socialGroup.forEach(social => {
                        if (social.status === this.socialAccount.Status.bind) {
                            switch (social.source) {
                                case this.socialAccount.QQ.name: {
                                    this.qqBind = true;
                                    this.socialAccount.QQ.value = social;
                                    break
                                }
                                case this.socialAccount.Wechat.name: {
                                    this.wechatBind = true;
                                    this.socialAccount.Wechat.value = social;
                                    break
                                }
                            }
                        }
                    })
                }
            });
        },
        bind(type) {
            switch (type) {
                case this.socialAccount.QQ.name: {
                    if (!this.qqBind) {
                        bind(type).then((res) => {
                            window.location.href = "http://localhost:8080/auth/render/qq";
                        });
                    }
                    break;
                }
            }

        },
        unbind(type) {
            switch (type) {
                case this.socialAccount.QQ.name: {
                    if (this.qqBind) {
                        unbind(this.socialAccount.QQ.value.socialUserId).then((res) => {
                            this.$modal.msgSuccess(res.msg);
                            this.qqBind = false;
                            this.socialAccount.QQ.value = null;
                        })
                    }
                    break;
                }
            }
        }
    }
};
</script>
