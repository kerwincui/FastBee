<template>
    <el-form ref="form" :model="user" :rules="rules" label-width="80px">
        <el-form-item :label="$t('oldPassword')" prop="oldPassword">
            <el-input v-model="user.oldPassword" :placeholder="$t('system.user.profile.oldPasswordPlaceholder')" type="password" show-password />
        </el-form-item>
        <el-form-item :label="$t('newPassword')" prop="newPassword">
            <el-input v-model="user.newPassword" :placeholder="$t('system.user.profile.newPasswordPlaceholder')" type="password" show-password />
        </el-form-item>
        <el-form-item :label="$t('confirmPassword')" prop="confirmPassword">
            <el-input v-model="user.confirmPassword" :placeholder="$t('system.user.profile.confirmPasswordPlaceholder')" type="password" show-password />
        </el-form-item>
        <el-form-item>
            <el-button type="primary" size="mini" @click="submit">{{ $t('save') }}</el-button>
            <el-button type="danger" size="mini" @click="close">{{ $t('close') }}</el-button>
        </el-form-item>
    </el-form>
</template>

<script>
import { updateUserPwd } from '@/api/system/user';

export default {
    data() {
        const equalToPassword = (rule, value, callback) => {
            if (this.user.newPassword !== value) {
                callback(new Error(this.$t('system.user.profile.pwdNotMatch')));
            } else {
                callback();
            }
        };
        return {
            user: {
                oldPassword: undefined,
                newPassword: undefined,
                confirmPassword: undefined,
            },
            // 表单校验
            rules: {
                oldPassword: [{ required: true, message: this.$t('system.user.profile.oldPasswordRequired'), trigger: 'blur' }],
                newPassword: [
                    { required: true, message: this.$t('system.user.profile.newPasswordRequired'), trigger: 'blur' },
                    { min: 6, max: 20, message: this.$t('system.user.profile.passwordLength'), trigger: 'blur' },
                    {
                        trigger: 'blur',
                        validator: (rule, value, callback) => {
                            var passwordreg = /(?![A-Z]*$)(?![a-z]*$)(?![0-9]*$)(?![^a-zA-Z0-9]*$)/;
                            if (!passwordreg.test(value)) {
                                callback(new Error(this.$t('system.user.profile.passwordStrength')));
                            } else {
                                callback();
                            }
                        },
                    },
                ],
                confirmPassword: [
                    { required: true, message: this.$t('system.user.profile.confirmPasswordRequired'), trigger: 'blur' },
                    { required: true, validator: equalToPassword, trigger: 'blur' },
                ],
            },
        };
    },
    methods: {
        submit() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    const params = {
                        oldPassword: this.user.oldPassword,
                        newPassword: this.user.newPassword,
                    };
                    updateUserPwd(params).then((response) => {
                        this.$modal.msgSuccess(this.$t('updateSuccessReLogin'));
                        if (response.code == 200) {
                            //清除登录缓存
                            localStorage.removeItem('token');
                            this.$store.dispatch('LogOut').then(() => {
                                location.href = '/index';
                            });
                        }
                    });
                }
            });
        },
        close() {
            this.$tab.closePage();
        },
    },
};
</script>
