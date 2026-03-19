<template>
    <el-form ref="form" :model="user" :rules="rules" label-width="80px">
        <el-form-item :label="$t('system.user.profile.nickName')" prop="nickName">
            <el-input v-model="user.nickName" maxlength="30" />
        </el-form-item>
        <el-form-item :label="$t('system.user.profile.phoneNumber')" prop="phonenumber">
            <el-input v-model="user.phonenumber" maxlength="11" />
        </el-form-item>
        <el-form-item :label="$t('system.user.profile.emailAddress')" prop="email">
            <el-input v-model="user.email" maxlength="50" />
        </el-form-item>
        <el-form-item :label="$t('system.user.profile.gender')">
            <el-radio-group v-model="user.sex">
                <el-radio label="0">{{ $t('male') }}</el-radio>
                <el-radio label="1">{{ $t('female') }}</el-radio>
            </el-radio-group>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" size="mini" @click="submit">{{ $t('save') }}</el-button>
            <el-button type="danger" size="mini" @click="close">{{ $t('close') }}</el-button>
        </el-form-item>
    </el-form>
</template>

<script>
import { updateUserProfile } from '@/api/system/user';

export default {
    props: {
        user: {
            type: Object,
        },
    },
    data() {
        return {
            // 表单校验
            rules: {
                nickName: [{ required: true, message: this.$t('system.user.profile.nickNameRequired'), trigger: 'blur' }],
                email: [
                    { required: true, message: this.$t('system.user.profile.emailRequired'), trigger: 'blur' },
                    {
                        type: 'email',
                        message: this.$t('system.user.profile.emailFormat'),
                        trigger: ['blur', 'change'],
                    },
                ],
                phonenumber: [
                    { required: true, message: this.$t('system.user.profile.phoneRequired'), trigger: 'blur' },
                    {
                        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
                        message: this.$t('system.user.profile.phoneFormat'),
                        trigger: 'blur',
                    },
                ],
            },
        };
    },
    methods: {
        submit() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    updateUserProfile(this.user).then((response) => {
                        this.$modal.msgSuccess(this.$t('updateSuccess'));
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
