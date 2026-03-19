<template>
  <div style="padding:6px;">
    <el-form ref="form" :model="form" label-width="100px">
      <el-row :gutter="100">
        <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="8">
          <el-form-item :label="$t('sip.sipConfig.998537-0')" prop="isdefault">
            <el-switch v-model="form.isdefault" :active-value="1" :inactive-value="0"/>
          </el-form-item>
          <el-form-item :label="$t('sip.sipConfig.998537-1')" prop="ip">
            <el-input v-model="form.ip" disabled />
          </el-form-item>
          <el-form-item :label="$t('sip.sipConfig.998537-2')" prop="domain">
            <el-input v-model="form.domain" />
          </el-form-item>
          <el-form-item :label="$t('sip.sipConfig.998537-3')" prop="password">
            <el-input v-model="form.password" :placeholder="$t('sip.sipConfig.998537-4')" />
          </el-form-item>
        </el-col>
        <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="8">
          <el-form-item :label="$t('sip.sipConfig.998537-5')">
            <el-input v-model="accessWay" disabled>
            </el-input>
          </el-form-item>
          <el-form-item :label="$t('sip.sipConfig.998537-6')" prop="port">
            <el-input v-model="form.port" type="number" disabled />
          </el-form-item>
          <el-form-item :label="$t('sip.sipConfig.998537-7')" prop="serverSipid">
            <el-input v-model="form.serverSipid" />
          </el-form-item>
        </el-col>
        <el-col :xs="23" :sm="23" :md="23" :lg="23" :xl="15">
          <el-form-item style="text-align:center;margin-top:20px;">
            <el-button v-show="form.id && productInfo.status != 2" v-hasPermi="['iot:video:edit']" type="primary"
              @click="submitForm">{{ $t('edit') }}</el-button>
            <el-button v-show="!form.id && productInfo.status != 2" v-hasPermi="['iot:video:add']" type="primary"
              @click="submitForm">{{ $t('add') }}</el-button>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>
  </div>
</template>

<style>
.specsColor {
  background-color: #fcfcfc;
}
</style>

<script>
import {
  getSipconfig,
  addSipconfig,
  updateSipconfig,
} from '@/api/iot/sipConfig';

export default {
  name: 'ConfigSip',
  props: {
    product: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      // 接入方式
      accessWay: this.$t('sip.sipConfig.998537-11'),
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 总条数
      total: 0,
      // sip系统配置表格数据
      sipconfigList: [],
      // 弹出层标题
      title: '',
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        productId: null,
      },
      // 表单参数
      form: {},
      // 表单校验
        rules: {
        domain: [{
          required: true,
          message: this.$t('sip.sipConfig.998537-8'),
          trigger: 'blur',
        }],
        serverSipid: [{
          required: true,
          message: this.$t('sip.sipConfig.998537-9'),
          trigger: 'blur',
        }],
        password: [{
          required: true,
          message: this.$t('sip.sipConfig.998537-10'),
          trigger: 'blur',
        }],
      },
    };
  },
  watch: {
    // 获取到父组件传递的productId后，刷新列表
    product: function (newVal, oldVal) {
      this.productInfo = newVal;
      if (this.productInfo && this.productInfo.productId != 0) {
        // 表单没有数据则获取默认配置
        if (!this.form.id) {
          this.getSipconfig(true);
        }
      }
    },
  },
  created() {
    this.productInfo = this.product;
    if (this.productInfo && this.productInfo.productId != 0) {
      this.getSipconfig(false);
    }
  },
  methods: {
    /** 获取产品下第一条SIP配置 */
    getSipconfig(isDefault) {
      getSipconfig(this.productInfo.productId, isDefault).then(response => {
        this.form = response.data;
        if (isDefault) {
          this.submitForm();
        }
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          this.form.productId = this.product.productId;
          if (this.form.isdefault == null) {
            this.form.isdefault = 0;
          }
          if (this.form.id != null) {
            updateSipconfig(this.form).then(response => {
              this.$modal.msgSuccess(this.$t('updateSuccess'));
            });
          } else {
            addSipconfig(this.form).then(response => {
              this.$modal.msgSuccess(this.$t('addSuccess'));
              this.getSipconfig(false);
            });
          }
        }
      });
    },
  },
};
</script>
