<template>
    <el-dialog :title="$t('sip.sipidGen.998538-1')" :visible.sync="open" width="400px" append-to-body
        :close-on-click-modal="false">
        <el-form ref="createForm" :model="createForm" label-width="100px">
            <el-form-item :label="$t('sip.sipidGen.998538-0')" prop="city">
                <el-cascader :options="cityOptions" v-model="createForm.city" @change="changeProvince" change-on-select
                    :props="{ checkStrictly: false }"></el-cascader>
            </el-form-item>
            <el-form-item :label="$t('sip.index.998533-9')" prop="deviceType">
                <el-select v-model="createForm.deviceType" :placeholder="$t('sip.index.998533-9')">
                    <el-option v-for="dict in dict.type.video_type" :key="dict.value" :label="dict.label"
                        :value="dict.value" :disabled="dict.value === '600'"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('sip.index.998533-15')" prop="channelType">
                <el-select v-model="createForm.channelType" :placeholder="$t('sip.index.998533-16')"
                    :disabled="createForm.deviceType == ''">
                    <el-option v-for="dict in dict.type.channel_type" :key="dict.value" :label="dict.label"
                        :value="dict.value" :disabled="dict.value === '600' || dict.value === '601'"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('sip.index.998533-20')" prop="createNum">
                <el-input-number controls-position="right" :min="1" :max="10" v-model="createForm.createNum"
                    :placeholder="$t('sip.index.998533-19')" type="number" style="width: 220px" />
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm">{{ $t('sip.index.998533-21') }}</el-button>
            <el-button @click="closeDialog">{{ $t('cancel') }}</el-button>
        </div>
    </el-dialog>
</template>

<script>
import { regionData, CodeToText } from 'element-china-area-data';

import { addChannel } from '@/api/iot/channel';

export default {
    name: 'SipidDialog',
    dicts: ['video_type', 'channel_type'],
    props: {
        product: {
            type: Object,
            default: null,
        },
    },
    data() {
        return {
            // 遮罩层
            loading: true,
            title: this.$t('sip.sipidGen.998538-1'),
            // 总条数
            total: 0,
            // 打开选择产品对话框
            open: false,
            devsipid: '',
            createForm: {
                city: '',
                deviceType: '',
                channelType: '',
                createNum: 1,
            },
            // 城市
            cityOptions: regionData,
            city: '',
            cityCode: '',
        };
    },
    created() { },
    methods: {
        /** 行政区划改变 **/
        changeProvince(data) {
            if (data && data[0] != null && data[1] != null && data[2] != null) {
                const str = CodeToText[data[0]] + '/' + CodeToText[data[1]] + '/' + CodeToText[data[2]];
                this.createForm.citycode = str;
            }
        },
        /** 提交按钮 */
        submitForm() {
            if (this.createForm.createNum < 1) {
                this.$modal.alertError(this.$t('sip.index.998533-42'));
                return;
            }
            if (!this.createForm.id) {
                this.createForm.deviceSipId = this.createForm.city[2] + '0000' + this.createForm.deviceType + '0';
                this.createForm.channelSipId = this.createForm.city[2] + '0000' + this.createForm.channelType + '0';

                if (
                    this.createForm.deviceType !== '' &&
                    this.createForm.channelType !== '' &&
                    this.createForm.city.length === 3
                ) {
                    addChannel(this.createForm.createNum, this.createForm).then((response) => {
                        this.$modal.msgSuccess(this.$t('addSuccess'));
                        this.open = false;
                        this.getList();
                    });
                } else {
                    this.$message({
                        type: 'error',
                        message: this.$t('sip.index.998533-44'),
                    });
                }
            } else {
                updateChannel(this.createForm).then((response) => {
                    this.$modal.msgSuccess(this.$t('updateSuccess'));
                    this.open = false;
                    this.getList();
                });
            }
        },
        confirmSelectProduct() {
            this.open = false;
            this.$emit('addGenEvent', this.devsipid);
        },
        /**关闭对话框 */
        closeDialog() {
            this.open = false;
        },
    },
};
</script>

<style scoped></style>
