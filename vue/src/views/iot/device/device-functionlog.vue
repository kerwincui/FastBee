<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item :label="$t('device.device-functionlog.399522-0')" label-width="120px" v-if="isSubDev">
        <el-select v-model="queryParams.slaveId" :placeholder="$t('device.device-functionlog.399522-1')" @change="selectSlave">
          <el-option v-for="slave in slaveList" :key="slave.slaveId" :label="`${slave.deviceName}   (${ $t('device.device-functionlog.399522-2').replace('$', slave.slaveId) })`" :value="slave.slaveId"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item :label="$t('device.device-functionlog.399522-3')" prop="funType">
        <el-select v-model="queryParams.funType" :placeholder="$t('device.device-functionlog.399522-4')" clearable size="small">
          <el-option v-for="dict in dict.type.iot_function_type" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item :label="$t('device.device-functionlog.399522-5')" prop="identify">
        <el-input v-model="queryParams.identify" :placeholder="$t('device.device-functionlog.399522-6')" clearable size="small" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item :label="$t('device.device-functionlog.399522-7')">
        <el-date-picker v-model="daterangeTime" size="small" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" :start-placeholder="$t('device.device-functionlog.399522-8')" :end-placeholder="$t('device.device-functionlog.399522-9')"></el-date-picker>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('device.device-functionlog.399522-10') }}</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('device.device-functionlog.399522-11') }}</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="logList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column :label="showName" align="center" prop="identify" />
      <el-table-column :label="$t('device.device-functionlog.399522-12')" align="center" prop="funType" width="120px">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.iot_function_type" :value="scope.row.funType" />
        </template>
      </el-table-column>
      <el-table-column :label="$t('device.device-functionlog.399522-13')" align="center" prop="funValue" />
      <el-table-column :label="$t('device.device-edit.148398-7')" align="center" prop="serialNumber" />
      <el-table-column :label="$t('device.device-functionlog.399522-15')" align="center" prop="createTime" />
      <el-table-column :label="$t('device.device-functionlog.399522-16')" align="center" prop="resultMsg" />
      <el-table-column :label="$t('device.index.105953-34')" align="center" width="80">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:device:remove']">{{ $t('device.device-functionlog.399522-18') }}</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listLog, delLog } from '@/api/iot/functionLog';

export default {
  name: 'device-func',
  dicts: ['iot_function_type', 'iot_yes_no'],
  props: {
    device: {
      type: Object,
      default: null,
    },
  },
  watch: {
    // 获取到父组件传递的device后
    device: function (newVal) {
      this.deviceInfo = newVal;
      if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
        this.isSubDev = this.deviceInfo.subDeviceList && this.deviceInfo.subDeviceList.length > 0;
        this.showName = this.isSubDev ? this.$t('device.device-functionlog.399522-19') : this.$t('device.device-functionlog.399522-5');
        this.queryParams.deviceId = this.deviceInfo.deviceId;
        this.queryParams.slaveId = this.deviceInfo.slaveId;
        this.queryParams.serialNumber = this.deviceInfo.serialNumber;
        this.slaveList = newVal.subDeviceList;
        this.getList();
      }
    },
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 设备服务下发日志表格数据
      logList: [],
      // 弹出层标题
      title: '',
      // 是否显示弹出层
      open: false,
      //设备数据
      deviceInfo: {},
      // 时间范围
      daterangeTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        identify: null,
        funType: null,
        funValue: null,
        messageId: null,
        deviceName: null,
        serialNumber: null,
        mode: null,
        userId: null,
        resultMsg: null,
        resultCode: null,
        slaveId: null,
      },
      // 表单参数
      form: {},
      //是否是modbus设备组
      isSubDev: false,
      showName: null,
      slaveList: [],
      // 表单校验
      rules: {
        identify: [{ required: true, message: this.$t('device.device-functionlog.399522-20'), trigger: 'blur' }],
        funType: [{ required: true, message: this.$t('device.device-functionlog.399522-21'), trigger: 'change' }],
        funValue: [{ required: true, message: this.$t('device.device-functionlog.399522-22'), trigger: 'blur' }],
        serialNumber: [{ required: true, message: this.$t('device.device-functionlog.399522-23'), trigger: 'blur' }],
      },
    };
  },
  created() {
    this.queryParams.serialNumber = this.device.serialNumber;
    this.getList();
  },
  methods: {
    /** 查询设备服务下发日志列表 */
    getList() {
      this.loading = true;
      if (null != this.daterangeTime && '' != this.daterangeTime) {
        this.queryParams.beginTime = this.daterangeTime[0];
        this.queryParams.endTime = this.daterangeTime[1];
      }
      if (this.queryParams.slaveId) {
        this.queryParams.serialNumber = this.queryParams.serialNumber + '_' + this.queryParams.slaveId;
      }
      listLog(this.queryParams).then((response) => {
        this.logList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        identify: null,
        funType: null,
        funValue: null,
        messageId: null,
        deviceName: null,
        serialNumber: null,
        mode: null,
        userId: null,
        resultMsg: null,
        resultCode: null,
        createBy: null,
        createTime: null,
        remark: null,
      };
      this.resetForm('form');
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm('queryForm');
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal
        .confirm(this.$t('device.device-functionlog.399522-24', [ids]))
        .then(function () {
          return delLog(ids);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess(this.$t('device.device-functionlog.399522-26'));
        })
        .catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download(
        'iot/log/export',
        {
          ...this.queryParams,
        },
        `log_${new Date().getTime()}.xlsx`
      );
    },
    //选择从机
    selectSlave() {},
  },
};
</script>
