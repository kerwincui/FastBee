<template>
  <div id="mediaServerEdit" v-loading="isLoging">
    <el-dialog title="流媒体服务器节点" :width="dialogWidth" top="2rem" :close-on-click-modal="false" :visible.sync="showDialog" :destroy-on-close="true" @close="close()">
      <div id="formStep" style="margin-top: 1rem; margin-right: 20px">
        <el-form v-if="currentStep == 1" ref="mediaServerForm" :rules="rules" :model="mediaServerForm" label-width="280px" style="width: 70%">
<!--          <el-form-item label="所属租户" prop="productName">-->
<!--            <el-input readonly v-model="mediaServerForm.tenantName" placeholder="请选择所属租户">-->
<!--              <el-button slot="append" @click="selectUser()">选择</el-button>-->
<!--            </el-input>-->
<!--          </el-form-item>-->
          <el-form-item label="服务器IP" prop="ip">
            <el-input v-model="mediaServerForm.ip" placeholder="媒体服务IP" clearable></el-input>
          </el-form-item>
          <el-form-item label="Http端口" prop="portHttp">
            <el-input v-model="mediaServerForm.portHttp" placeholder="媒体服务HTTP端口" clearable></el-input>
          </el-form-item>
          <el-form-item label="服务密钥" prop="secret">
            <el-input v-model="mediaServerForm.secret" placeholder="媒体服务SECRET" clearable></el-input>
          </el-form-item>
          <el-form-item>
            <div style="float: right; font-size: 28px">
              <el-button @click="close">取消</el-button>
              <el-button type="success" @click="checkServer" :loading="btnLoading">测试</el-button>
              <el-button type="primary" v-if="currentStep === 1 && serverCheck === 1" @click="next">下一步</el-button>
            </div>
          </el-form-item>
        </el-form>
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form v-if="currentStep === 2 || currentStep === 3" ref="mediaServerForm1" :rules="rules" :model="mediaServerForm" label-width="140px" :disabled="!editFlag">
              <el-form-item label="配置名称" prop="serverId">
                <el-input v-model="mediaServerForm.serverId" placeholder="配置名称" clearable></el-input>
              </el-form-item>
              <el-form-item label="服务器IP" prop="ip">
                <el-input v-if="currentStep === 2" v-model="mediaServerForm.ip" disabled></el-input>
                <el-input v-if="currentStep === 3" v-model="mediaServerForm.ip"></el-input>
              </el-form-item>
              <el-form-item label="播放协议" prop="protocol">
                <el-select v-model="mediaServerForm.protocol" style="width: 100%">
                  <el-option key="http" label="http" value="http"></el-option>
                  <el-option key="https" label="https" value="https"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="HookUrl" prop="hookurl">
                <el-input v-model="mediaServerForm.hookurl" placeholder="HookUrl" clearable></el-input>
              </el-form-item>
              <el-form-item label="Http端口" prop="portHttp">
                <el-input v-if="currentStep === 2" v-model="mediaServerForm.portHttp" disabled></el-input>
                <el-input v-if="currentStep === 3" v-model="mediaServerForm.portHttp"></el-input>
              </el-form-item>
              <el-form-item label="Https端口" prop="portHttps">
                <el-input v-model="mediaServerForm.portHttps" placeholder="Https端口" clearable></el-input>
              </el-form-item>
              <el-form-item label="Rtsp端口" prop="portRtsp">
                <el-input v-model="mediaServerForm.portRtsp" placeholder="Rtsp端口" clearable></el-input>
              </el-form-item>
            </el-form>
          </el-col>
          <el-col :span="12">
            <el-form v-if="currentStep === 2 || currentStep === 3" ref="mediaServerForm2" :rules="rules" :model="mediaServerForm" label-width="180px" :disabled="!editFlag">
              <el-form-item label="流媒体密钥" prop="secret">
                <el-input v-if="currentStep === 2" v-model="mediaServerForm.secret" disabled></el-input>
                <el-input v-if="currentStep === 3" v-model="mediaServerForm.secret"></el-input>
              </el-form-item>
              <el-form-item label="服务器域名" prop="domain">
                <el-input v-model="mediaServerForm.domain" placeholder="服务器域名" clearable></el-input>
              </el-form-item>
              <el-form-item label="自动配置">
                <el-switch v-model="mediaServerForm.autoConfig"></el-switch>
              </el-form-item>
              <el-form-item label="收流模式">
                <el-switch active-text="多端口" inactive-text="单端口" @change="portRangeChange" v-model="mediaServerForm.rtpEnable"></el-switch>
              </el-form-item>
              <el-form-item v-if="!mediaServerForm.rtpEnable" label="收流端口" prop="rtpProxyPort">
                <el-input v-model.number="mediaServerForm.rtpProxyPort" clearable></el-input>
              </el-form-item>
              <el-form-item v-if="mediaServerForm.rtpEnable" label="收流端口">
                <el-input v-model="rtpPortRange1" placeholder="起始" @change="portRangeChange" clearable style="width: 100px" prop="rtpPortRange1"></el-input>
                <el-input v-model="rtpPortRange2" placeholder="终止" @change="portRangeChange" clearable style="width: 100px" prop="rtpPortRange2" ></el-input>
              </el-form-item>
              <el-form-item label="Rtmp端口" prop="portRtmp">
                <el-input v-model="mediaServerForm.portRtmp" placeholder="Rtmp端口" clearable></el-input>
              </el-form-item>
              <el-form-item label="录像管理端口" prop="recordPort">
                <el-input v-model.number="mediaServerForm.recordPort" :disabled="!editFlag">
                  <el-button v-if="mediaServerForm.recordPort > 0" class="el-icon-check" slot="append" type="primary" @click="checkRecordServer"></el-button>
                </el-input>
                <i v-if="recordServerCheck === 1" class="el-icon-success" style="color: #3caf36; position: absolute; top: 14px"></i>
                <i v-if="recordServerCheck === 2" class="el-icon-loading" style="color: #3caf36; position: absolute; top: 14px"></i>
                <i v-if="recordServerCheck === -1" class="el-icon-error" style="color: #c80000; position: absolute; top: 14px"></i>
              </el-form-item>
              <el-form-item>
                <div style="float: right">
                  <el-button type="primary" @click="onSubmit"  v-if="editFlag">提交</el-button>
                  <el-button @click="close"  v-if="editFlag">关闭</el-button>
                </div>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
      </div>
    </el-dialog>
    <!-- 选择用户 -->
    <user-list ref="userList" @userEvent="getUserData($event)" />
  </div>
</template>

<script>
import { addmediaServer, checkmediaServer, updatemediaServer } from '@/api/iot/mediaServer';
import userList from '@/views/iot/sip/user-list.vue';

export default {
  name: 'MediaServerEdit',
  components: { userList },
  props: {
    editFlag: {
      type: Boolean,
      default: false,

},
  },
  data() {
    const isValidIp = (rule, value, callback) => {
      // 校验IP是否符合规则
      var reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
      if (!reg.test(value)) {
        return callback(new Error('请输入有效的IP地址'));
      } else {
        callback();
      }
      return true;
    };
    const isValidPort = (rule, value, callback) => {
      // 校验IP是否符合规则
      var reg = /^(([0-9]|[1-9]\d{1,3}|[1-5]\d{4}|6[0-5]{2}[0-3][0-5]))$/;
      if (!reg.test(value)) {
        return callback(new Error('请输入有效的端口号'));
      } else {
        callback();
      }
      return true;
    };
    return {
      tempTenantId: '',
      tempTenantName: '',
      btnLoading: false,
      dialogWidth: '',
      defaultWidth: 1000,
      listChangeCallback: null,
      showDialog: false,
      isLoging: false,
      dialogLoading: false,
      currentStep: 1,
      platformList: [],
      serverCheck: 0,
      recordServerCheck: 0,
      mediaServerForm: {
        serverId: '',
        ip: '',
        domain: '',
        productId: '',
        productName: '',
        tenantId: '',
        tenantName: '',
        autoConfig: true,
        hookurl: '',
        secret: '',
        portHttp: '',
        portHttps: '',
        recordPort: '',
        portRtmp: '',
        portRtsp: '',
        rtpEnable: true,
        rtpPortRange: '',
        rtpProxyPort: '',
      },
      rtpPortRange1: 30000,
      rtpPortRange2: 30100,
      rules: {
        ip: [{ required: true, validator: isValidIp, message: '请输入有效的IP地址', trigger: 'blur' }],
        portHttp: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        portHttps: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        recordPort: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        portRtmp: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        portRtsp: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        rtpPortRange1: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        rtpPortRange2: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        rtpProxyPort: [{ required: true, validator: isValidPort, message: '请输入有效的端口号', trigger: 'blur' }],
        secret: [{ required: true, message: '请输入secret', trigger: 'blur' }],
      },
    };
  },
  computed: {},
  created() {
    this.setDialogWidth();
  },
  methods: {
    setDialogWidth() {
      let val = document.body.clientWidth;
      if (val < this.defaultWidth) {
        this.dialogWidth = '100%';
      } else {
        this.dialogWidth = this.defaultWidth + 'px';
      }
    },
    openDialog: function (param, callback) {
      this.showDialog = true;
      this.listChangeCallback = callback;
      if (param != null) {
        if (param.autoConfig === 1) {
          param.autoConfig = param.autoConfig === 1;
        } else if (param.autoConfig === 0) {
          param.autoConfig = param.autoConfig === 1;
        }

        if (param.rtpEnable === 1) {
          param.rtpEnable = param.rtpEnable === 1;
        } else if (param.rtpEnable === 0) {
          param.rtpEnable = param.rtpEnable === 1;
        }

        this.mediaServerForm = param;
        this.currentStep = 3;
        if (param.rtpPortRange) {
          let rtpPortRange = this.mediaServerForm.rtpPortRange.split(',');
          if (rtpPortRange.length > 0) {
            this.rtpPortRange1 = rtpPortRange[0];
            this.rtpPortRange2 = rtpPortRange[1];
          }
        }
      }
    },
    checkServer: function () {
      this.$refs.mediaServerForm.validate((valid) => {
        if (valid) {
          this.btnLoading = true;
          this.serverCheck = 0;
          let query = {
            ip: this.mediaServerForm.ip,
            port: this.mediaServerForm.portHttp,
            secret: this.mediaServerForm.secret,
          };
          checkmediaServer(query)
            .then((response) => {
              this.btnLoading = false;
              if (response.data != null) {
                this.mediaServerForm = response.data;
                this.mediaServerForm.autoConfig = true;
                this.mediaServerForm.rtpEnable = true;
                this.mediaServerForm.protocol = 'http';
                this.mediaServerForm.domain = 'fastbee.com';
                this.mediaServerForm.enabled = 1;
                this.mediaServerForm.tenantId = this.tempTenantId;
                this.mediaServerForm.tenantName = this.tempTenantName;
                this.mediaServerForm.serverId = 'fastbee';
                this.mediaServerForm.hookurl = 'java:8080';
                this.mediaServerForm.portHttps = 8443;
                this.mediaServerForm.recordPort = 18081;
                this.mediaServerForm.portRtmp = 1935;
                this.mediaServerForm.portRtsp = 554;
                this.mediaServerForm.rtpProxyPort = '';
                this.rtpPortRange1 = 30000;
                this.rtpPortRange2 = 30100;
                this.serverCheck = 1;
                this.$modal.alertSuccess('配置地址连接成功');
              } else {
                this.serverCheck = -1;
                this.$modal.alertError('配置地址无法连接');
              }
            })
            .catch((error) => {
              this.serverCheck = -1;
              this.$message({
                showClose: true,
                message: error,
                type: 'error',
              });
            });
        }
      });
    },
    next: function () {
      this.currentStep = 2;
      this.defaultWidth = 900;
      this.setDialogWidth();
    },
    checkRecordServer: function () {
      let that = this;
      that.recordServerCheck = 2;
      if (that.mediaServerForm.recordPort <= 0 || that.mediaServerForm.recordPort > 65535) {
        that.recordServerCheck = -1;
        that.$message({
          showClose: true,
          message: '端口号应该在-65535之间',
          type: 'error',
        });
        return;
      }
    },
    onSubmit: function () {
      this.dialogLoading = true;
      this.mediaServerForm.rtpEnable = this.mediaServerForm.rtpEnable ? 1 : 0;
      this.mediaServerForm.autoConfig = this.mediaServerForm.autoConfig ? 1 : 0;
      if (this.mediaServerForm.id != null) {
        updatemediaServer(this.mediaServerForm).then((response) => {
          this.$modal.msgSuccess('修改成功');
          this.showDialog = false;
        });
      } else {
        this.portRangeChange();
        addmediaServer(this.mediaServerForm).then((response) => {
          this.$modal.msgSuccess('新增成功');
          this.showDialog = false;
        });
      }
      this.$parent.getServerList();
      this.$parent.delay();
    },
    close: function () {
      this.showDialog = false;
      this.dialogLoading = false;
      this.mediaServerForm = {
        serverId: '',
        ip: '',
        domain: '',
        autoConfig: true,
        hookurl: '',
        secret: '',
        portHttp: '',
        portHttps: '',
        recordPort: '',
        portRtmp: '',
        portRtsp: '',
        rtpEnable: true,
        rtpPortRange: '',
        rtpProxyPort: '',
      };
      this.rtpPortRange1 = 30000;
      this.rtpPortRange2 = 30100;
      this.listChangeCallback = null;
      this.currentStep = 1;
    },
    portRangeChange: function () {
      if (this.mediaServerForm.rtpEnable) {
        this.mediaServerForm.rtpPortRange = this.rtpPortRange1 + ',' + this.rtpPortRange2;
        console.log(this.mediaServerForm.rtpPortRange);
      }
    },
    selectUser() {
      this.$refs.userList.open = true;
      this.$refs.userList.getList();
    },
    getUserData(user) {
      this.tempTenantId = user.userId;
      this.tempTenantName = user.userName;
      this.mediaServerForm.tenantId = user.userId;
      this.mediaServerForm.tenantName = user.userName;
    },
  },
};
</script>
