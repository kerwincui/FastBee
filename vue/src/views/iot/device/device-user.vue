<template>
  <div style="padding-left: 20px">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-share" size="mini" @click="shareDevice" v-hasPermi="['iot:device:share']">分享设备</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-refresh" size="mini" @click="getList">刷新</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="deviceUserList" @selection-change="handleSelectionChange" size="mini">
      <el-table-column label="用户编号" align="center" prop="userId" width="100" />
      <el-table-column label="用户名称" align="center" prop="userName" />
      <el-table-column label="手机号码" align="center" prop="phonenumber" width="150" />
      <el-table-column label="用户类型" align="center" prop="isOwner" width="150">
        <template slot-scope="scope">
          <el-tag type="primary" v-if="scope.row.isOwner">主人</el-tag>
          <el-tag type="success" v-else>分享</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="分享时间" align="center" prop="createTime" width="150">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="left" prop="remark" header-align="center" min-width="150" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:device:share']" v-if="scope.row.isOwner == 0">编辑</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:device:share']" v-if="scope.row.isOwner == 0">取消分享</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!--设备分享对话框-->
    <el-dialog title="设备分享" :visible.sync="open" width="800px">
      <div style="margin-top: -50px">
        <el-divider></el-divider>
      </div>
      <!--用户查询-->
      <el-form :model="permParams" ref="queryForm" :rules="rules" :inline="true" label-width="80px" v-if="type == 1">
        <el-form-item label="手机号码" prop="phonenumber">
          <el-input type="text" placeholder="请输入用户手机号码" v-model="permParams.phonenumber" minlength="10" clearable size="small" show-word-limit style="width: 240px" @keyup.enter.native="handleQuery"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="userQuery">查询用户</el-button>
        </el-form-item>
      </el-form>

      <!--用户信息和权限设置-->
      <div v-loading="permsLoading" style="background-color: #f8f8f9; line-height: 28px">
        <div v-if="message" style="padding: 20px">{{ message }}</div>
        <div v-if="form.userId" style="padding: 15px">
          <div style="font-weight: bold; line-height: 28px">用户信息</div>
          <span style="width: 80px; display: inline-block">用户ID：</span>
          <span>{{ form.userId }}</span>
          <br />
          <span style="width: 80px; display: inline-block">手机号码：</span>
          <span>{{ form.phonenumber }}</span>
          <br />
          <span style="width: 80px; display: inline-block">用户名称：</span>
          <span>{{ form.userName }}</span>
          <br />
          <!--选择权限-->
          <div style="font-weight: bold; margin: 15px 0 10px">设置用户权限</div>
          <el-table :data="sharePermissionList" highlight-current-row size="mini" ref="multipleTable" @select="handleSelectionChange" @select-all="handleSelectionAll">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="权限名称" align="center" key="modelName" prop="modelName" />
            <el-table-column label="权限标识" align="center" key="identifier" prop="identifier" />
            <el-table-column label="备注信息" align="left" min-width="100" header-align="center" key="remark" prop="remark" />
          </el-table>
          <!--选择权限-->
          <div style="font-weight: bold; margin: 15px 0 10px">备注信息</div>
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="2" />
        </div>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm" :disabled="!form.userId || !deviceInfo.deviceId">确定</el-button>
        <el-button @click="closeSelectUser">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { addDeviceUser, listDeviceUser, getDeviceUser, delDeviceUser, updateDeviceUser, shareUser } from '@/api/iot/deviceuser';
import { permListModel } from '@/api/iot/model';

export default {
  name: 'device-user',
  dicts: ['iot_yes_no'],
  props: {
    device: {
      type: Object,
      default: null,
    },
  },
  watch: {
    // 获取到父组件传递的device后，刷新列表
    device: function (newVal, oldVal) {
      this.deviceInfo = newVal;
      if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
        this.queryParams.deviceId = this.deviceInfo.deviceId;
        this.getList();
      }
    },
  },
  data() {
    return {
      // 类型,1=新增，2=更新
      type: 1,
      // 消息提示
      message: '',
      // 权限遮罩层
      permsLoading: false,
      // 权限列表
      sharePermissionList: [],
      // 设备信息
      deviceInfo: {},
      // 是否显示选择用户弹出层
      open: false,
      // 查询参数
      permParams: {
        userName: undefined,
        phonenumber: undefined,
        deviceId: null,
      },
      // 查询表单验证
      rules: {
        phonenumber: [
          {
            required: true,
            message: '手机号码不能为空',
            trigger: 'blur',
          },
          {
            min: 11,
            max: 11,
            message: '手机号码长度为11位',
            trigger: 'blur',
          },
        ],
      },
      // 遮罩层
      loading: true,
      // 总条数
      total: 0,
      // 设备用户表格数据
      deviceUserList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceName: null,
        userName: null,
        userId: null,
        tenantName: null,
        isOwner: null,
      },
      // 表单参数
      form: {},
    };
  },
  created() {
    this.queryParams.deviceId = this.device.deviceId;
    this.getList();
  },
  methods: {
    /** 查询设备用户列表 */
    getList() {
      this.loading = true;
      listDeviceUser(this.queryParams).then((response) => {
        this.deviceUserList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 表单重置
    reset() {
      this.form = {
        deviceId: null,
        userId: null,
        deviceName: null,
        userName: null,
        perms: null,
        phonenumber: null,
        remark: null,
      };
      this.sharePermissionList = [];
      this.message = '';
      this.resetForm('form');
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      this.type = 2; //更新
      getDeviceUser(row.deviceId, row.userId).then((response) => {
        this.form = response.data;
        // 查询物模型权限列表
        this.getPermissionList();
        this.open = true;
      });
    },
    // 设备分享
    shareDevice() {
      this.type = 1; // 新增
      this.open = true;
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const deviceUser = row;
      this.$modal
        .confirm('确认取消分享设备？')
        .then(function () {
          return delDeviceUser(deviceUser);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess('取消分享成功');
        })
        .catch(() => {});
    },
    /** 用户按钮操作 */
    userQuery() {
      this.$refs['queryForm'].validate((valid) => {
        if (valid) {
          this.reset();
          this.getShareUser();
        }
      });
    },
    /** 查询用户 */
    getShareUser() {
      this.permsLoading = true;
      if (!this.deviceInfo.deviceId) {
        this.$modal.alert('查询不到设备信息，请刷新后重试');
        return;
      }
      this.permParams.deviceId = this.deviceInfo.deviceId;
      shareUser(this.permParams).then((response) => {
        if (response.data) {
          this.form = response.data;
          // 查询物模型权限列表
          this.getPermissionList();
        } else {
          this.permsLoading = false;
          this.message = '查询不到用户信息，或者该用户已经是设备用户';
        }
      });
    },
    /** 查询产品物模型设备权限列表 */
    async getPermissionList() {
      let perms = [];
      if (this.form.perms) {
        perms = this.form.perms.split(',');
      }
      console.log('deviceInfo', this.deviceInfo);
      permListModel(this.deviceInfo.productId).then((response) => {
        // 固定增加设备系统相关权限
        this.sharePermissionList = [
          {
            identifier: 'timer',
            modelName: '设备定时',
            remark: '定时执行任务',
          },
          {
            identifier: 'log',
            modelName: '设备日志',
            remark: '包含事件日志和指令日志',
          },
          {
            identifier: 'monitor',
            modelName: '实时监测',
            remark: '下发实时监测指令后，图表实时显示设备上报数据',
          },
          {
            identifier: 'statistic',
            modelName: '监测统计',
            remark: '图表显示存储的历史监测数据',
          },
        ];
        this.sharePermissionList = this.sharePermissionList.concat(response.data);

        // 设置选中
        if (perms.length > 0) {
          for (let i = 0; i < this.sharePermissionList.length; i++) {
            for (let j = 0; j < perms.length; j++) {
              if (this.sharePermissionList[i].identifier == perms[j]) {
                this.$nextTick(() => {
                  this.$refs.multipleTable.toggleRowSelection(this.sharePermissionList[i], true);
                });
                break;
              }
            }
          }
        }
        this.permsLoading = false;
      });
    },
    // 重置查询
    resetUserQuery() {
      this.resetForm('queryForm');
      this.reset();
    },
    // 关闭选择用户
    closeSelectUser() {
      this.open = false;
      this.resetUserQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.form.perms = selection.map((x) => x.identifier).join(',');
    },
    // 全选事件处理
    handleSelectionAll(selection) {
      this.form.perms = selection.map((x) => x.identifier).join(',');
    },
    /** 提交按钮 */
    submitForm() {
      if (this.type == 2) {
        // 更新设备用户
        updateDeviceUser(this.form).then((response) => {
          this.$modal.msgSuccess('更新成功');
          this.resetUserQuery();
          this.open = false;
          this.getList();
        });
      } else if (this.type == 1) {
        // 添加设备用户
        this.form.deviceId = this.deviceInfo.deviceId;
        this.form.deviceName = this.deviceInfo.deviceName;
        addDeviceUser(this.form).then((response) => {
          this.$modal.msgSuccess('新增成功');
          this.resetUserQuery();
          this.open = false;
          this.getList();
        });
      }
    },
  },
};
</script>
