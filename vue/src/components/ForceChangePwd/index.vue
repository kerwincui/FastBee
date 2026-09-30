<template>
    <el-dialog
        :title="$t('forceChangePwdTitle')"
        :visible="visible"
        width="460px"
        append-to-body
        :show-close="false"
        :close-on-click-modal="false"
        :close-on-press-escape="false"
    >
        <el-alert :title="$t('forceChangePwdTip')" type="warning" :closable="false" show-icon style="margin-bottom: 16px" />
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item :label="$t('oldPassword')" prop="oldPassword">
                <el-input v-model="form.oldPassword" :placeholder="$t('system.user.profile.oldPasswordPlaceholder')" type="password" show-password />
            </el-form-item>
            <el-form-item :label="$t('newPassword')" prop="newPassword">
                <el-input v-model="form.newPassword" :placeholder="$t('system.user.profile.newPasswordPlaceholder')" type="password" show-password />
            </el-form-item>
            <el-form-item :label="$t('confirmPassword')" prop="confirmPassword">
                <el-input v-model="form.confirmPassword" :placeholder="$t('system.user.profile.confirmPasswordPlaceholder')" type="password" show-password />
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" :loading="loading" @click="submit">{{ $t('forceChangePwdConfirm') }}</el-button>
        </div>
    </el-dialog>
</template>

<script>
import { updateUserPwd } from '@/api/system/user';

export default {
    name: 'ForceChangePwd',
    data() {
        const equalToPassword = (rule, value, callback) => {
            if (this.form.newPassword !== value) {
                callback(new Error(this.$t('system.user.profile.pwdNotMatch')));
            } else {
                callback();
            }
        };
        return {
            loading: false,
            form: {
                oldPassword: undefined,
                newPassword: undefined,
                confirmPassword: undefined,
            },
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
    computed: {
        visible() {
            return this.$store.state.user.needChangePwd;
        },
    },
    methods: {
        submit() {
            this.$refs.form.validate((valid) => {
                if (!valid) {
                    return;
                }
                this.loading = true;
                updateUserPwd({ oldPassword: this.form.oldPassword, newPassword: this.form.newPassword })
                    .then(() => {
                        this.$modal.msgSuccess(this.$t('updateSuccessReLogin'));
                        // Stay on this isolated page until logout has completed.
                        return this.$store.dispatch('LogOut').then(() => {
                            location.href = '/login';
                        });
                    })
                    .catch(() => {})
                    .finally(() => {
                        this.loading = false;
                    });
            });
        },
    },
};
</script>
