/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设备ID" prop="deviceId">
        <el-input
          v-model="queryParams.deviceId"
          placeholder="请输入设备ID"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备编号" prop="deviceNum">
        <el-input
          v-model="queryParams.deviceNum"
          placeholder="请输入设备编号"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item label="继电器" prop="relayStatus">
        <el-select v-model="queryParams.relayStatus" placeholder="请选择继电器" clearable size="small">
          <el-option
            v-for="item in relayStatusOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="灯状态" prop="lightStatus">
        <el-select v-model="queryParams.lightStatus" placeholder="请选择灯状态" clearable size="small">
          <el-option
            v-for="dict in lightStatusOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="在线" prop="isOnline">
        <el-select v-model="queryParams.isOnline" placeholder="请选择在线" clearable size="small">
          <el-option
            v-for="dict in isOnlineOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="触发源" prop="triggerSource">
        <el-select v-model="queryParams.triggerSource" placeholder="请选择触发源" clearable size="small">
          <el-option
            v-for="dict in triggerSourceOptions"
            :key="dict.dictValue"
            :label="dict.dictLabel"
            :value="dict.dictValue"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
          v-model="daterangeCreateTime"
          size="small"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:status:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:status:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:status:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:status:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row> -->

    <el-table v-loading="loading" :data="statusList" @selection-change="handleSelectionChange">
      <!-- <el-table-column type="selection" width="55" align="center" /> -->
      <el-table-column label="序号" align="center" prop="deviceStatusId" />
      <el-table-column label="设备ID" align="center" prop="deviceId" />
      <el-table-column label="设备编号" align="center" prop="deviceNum" />
      <el-table-column label="继电器" align="center" prop="relayStatus"  />
      <el-table-column label="灯状态" align="center" prop="lightStatus"  />
      <el-table-column label="在线" align="center" prop="isOnline" />
      <el-table-column label="信号" align="center" prop="rssi" />
      <el-table-column label="设备温度" align="center" prop="deviceTemperature" />      
      <el-table-column label="空气温度" align="center" prop="airTemperature" />
      <el-table-column label="空气湿度" align="center" prop="airHumidity" />
      <el-table-column label="触发源" align="center" prop="triggerSource" :formatter="triggerSourceFormat" />
      <el-table-column label="彩灯亮度" align="center" prop="brightness" />
      <el-table-column label="渐变间隔" align="center" prop="lightInterval" />
      <el-table-column label="彩灯模式" align="center" prop="lightMode" :formatter="lightModeFormat" />
      <el-table-column label="渐变时间" align="center" prop="fadeTime" />
      <el-table-column label="红灯" align="center" prop="red" />
      <el-table-column label="绿灯" align="center" prop="green" />
      <el-table-column label="蓝灯" align="center" prop="blue" />
      <!-- <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:status:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:status:remove']"
          >删除</el-button>
        </template> -->
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改设备状态对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备" prop="deviceId">
          <el-input v-model="form.deviceId" placeholder="请输入设备" />
        </el-form-item>
        <el-form-item label="设备编号" prop="deviceNum">
          <el-input v-model="form.deviceNum" placeholder="请输入设备编号" />
        </el-form-item>
        <el-form-item label="继电器" prop="relayStatus">
          <el-select v-model="form.relayStatus" placeholder="请选择继电器状态">
            <el-option
              v-for="dict in relayStatusOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="灯状态" prop="lightStatus">
          <el-select v-model="form.lightStatus" placeholder="请选择灯状态">
            <el-option
              v-for="dict in lightStatusOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="在线" prop="isOnline">
          <el-select v-model="form.isOnline" placeholder="请选择是否状态">
            <el-option
              v-for="dict in isOnlineOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="信号" prop="rssi">
          <el-input v-model="form.rssi" placeholder="请输入信号" />
        </el-form-item>
        <el-form-item label="设备温度" prop="deviceTemperature">
          <el-input v-model="form.deviceTemperature" placeholder="请输入设备温度" />
        </el-form-item>
        <el-form-item label="空气温度" prop="airTemperature">
          <el-input v-model="form.airTemperature" placeholder="请输入空气温度" />
        </el-form-item>
        <el-form-item label="空气湿度" prop="airHumidity">
          <el-input v-model="form.airHumidity" placeholder="请输入空气湿度" />
        </el-form-item>
        <el-form-item label="触发源" prop="triggerSource">
          <el-select v-model="form.triggerSource" placeholder="请选择触发源">
            <el-option
              v-for="dict in triggerSourceOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="彩灯亮度" prop="brightness">
          <el-input v-model="form.brightness" placeholder="请输入彩灯亮度" />
        </el-form-item>
        <el-form-item label="渐变间隔" prop="lightInterval">
          <el-input v-model="form.lightInterval" placeholder="请输入渐变间隔" />
        </el-form-item>
        <el-form-item label="渐变时间" prop="fadeTime">
          <el-input v-model="form.fadeTime" placeholder="请输入渐变时间" />
        </el-form-item>
        <el-form-item label="彩灯模式" prop="lightMode">
          <el-select v-model="form.lightMode" placeholder="请选择彩灯模式">
            <el-option
              v-for="dict in lightModeOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="红灯" prop="red">
          <el-input v-model="form.red" placeholder="请输入红灯" />
        </el-form-item>
        <el-form-item label="绿灯" prop="green">
          <el-input v-model="form.green" placeholder="请输入绿灯" />
        </el-form-item>
        <el-form-item label="蓝灯" prop="blue">
          <el-input v-model="form.blue" placeholder="请输入蓝灯" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listStatus, getStatus, delStatus, addStatus, updateStatus, exportStatus } from "@/api/system/status";

export default {
  name: "Status",
  components: {
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
      // 设备状态表格数据
      statusList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 继电器字典
      relayStatusOptions: [{
        "label": "打开",
        "value": 1
      }, {
        "label": "关闭",
        "value": 0
      }],
      // 灯状态字典
      lightStatusOptions: [{
        "label": "打开",
        "value": 1
      }, {
        "label": "关闭",
        "value": 0
      }],
      // 在线字典
      isOnlineOptions: [{
        "label": "在线",
        "value": 1
      }, {
        "label": "离线",
        "value": 0
      }],
      // 触发源字典
      triggerSourceOptions: [],
      // 彩灯模式字典
      lightModeOptions: [],
      // 创建时间时间范围
      daterangeCreateTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceId: null,
        deviceNum: null,
        relayStatus: null,
        lightStatus: null,
        isOnline: null,
        triggerSource: null,
        createTime: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        deviceNum: [
          { required: true, message: "设备编号不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
    this.getDicts("iot_trigger_source").then(response => {
      this.triggerSourceOptions = response.data;
    });
    this.getDicts("light_mode").then(response => {
      this.lightModeOptions = response.data;
    });
  },
  methods: {
    /** 查询设备状态列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeCreateTime && '' != this.daterangeCreateTime) {
        this.queryParams.params["beginCreateTime"] = this.daterangeCreateTime[0];
        this.queryParams.params["endCreateTime"] = this.daterangeCreateTime[1];
      }
      listStatus(this.queryParams).then(response => {
        this.statusList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    
    // 触发源字典翻译
    triggerSourceFormat(row, column) {
      return this.selectDictLabel(this.triggerSourceOptions, row.triggerSource);
    },
    // 彩灯模式字典翻译
    lightModeFormat(row, column) {
      return this.selectDictLabel(this.lightModeOptions, row.lightMode);
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        deviceStatusId: null,
        deviceId: null,
        deviceNum: null,
        relayStatus: null,
        lightStatus: null,
        isOnline: null,
        deviceTemperature: null,
        rssi: null,
        airTemperature: null,
        airHumidity: null,
        triggerSource: null,
        brightness: null,
        lightInterval: null,
        fadeTime: null,
        lightMode: null,
        red: null,
        green: null,
        blue: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.daterangeCreateTime = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.deviceStatusId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加设备状态";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const deviceStatusId = row.deviceStatusId || this.ids
      getStatus(deviceStatusId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改设备状态";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.deviceStatusId != null) {
            updateStatus(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addStatus(this.form).then(response => {
              this.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const deviceStatusIds = row.deviceStatusId || this.ids;
      this.$confirm('是否确认删除设备状态编号为"' + deviceStatusIds + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delStatus(deviceStatusIds);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        })
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有设备状态数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportStatus(queryParams);
        }).then(response => {
          this.download(response.msg);
        })
    }
  }
};
</script>
