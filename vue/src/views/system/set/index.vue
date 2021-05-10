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
      <el-form-item label="报警" prop="isAlarm">
        <el-select v-model="queryParams.isAlarm" placeholder="请选择报警" clearable size="small">
          <el-option
            v-for="dict in isAlarmOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="雷达感应" prop="isRadar">
        <el-select v-model="queryParams.isRadar" placeholder="请选择雷达感应" clearable size="small">
          <el-option
            v-for="dict in isRadarOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="托管" prop="isHost">
        <el-select v-model="queryParams.isHost" placeholder="请选择托管" clearable size="small">
          <el-option
            v-for="dict in isHostOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="射频遥控" prop="isRfControl">
        <el-select v-model="queryParams.isRfControl" placeholder="请选择射频遥控" clearable size="small">
          <el-option
            v-for="dict in isRfControlOptions"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="用户" prop="ownerId">
        <el-input
          v-model="queryParams.ownerId"
          placeholder="请输入用户"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="配网地址" prop="networkAddress">
        <el-input
          v-model="queryParams.networkAddress"
          placeholder="请输入配网地址"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:set:add']"
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
          v-hasPermi="['system:set:edit']"
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
          v-hasPermi="['system:set:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:set:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="setList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" prop="deviceSetId" />
      <el-table-column label="设备ID" align="center" prop="deviceId" />
      <el-table-column label="设备编号" align="center" prop="deviceNum" />
      <el-table-column label="报警" align="center" prop="isAlarm"  />
      <el-table-column label="雷达感应" align="center" prop="isRadar" />
      <el-table-column label="托管" align="center" prop="isHost" />
      <el-table-column label="重启" align="center" prop="isReset"  />
      <el-table-column label="打开AP" align="center" prop="isAp"  />
      <el-table-column label="射频遥控" align="center" prop="isRfControl"  />
      <el-table-column label="遥控配对" align="center" prop="isRfLearn" />
      <el-table-column label="遥控清码" align="center" prop="isRfClear"  />
      <el-table-column label="按键一" align="center" prop="rfOneFunc" :formatter="rfOneFuncFormat" />
      <el-table-column label="按键二" align="center" prop="rfTwoFunc" :formatter="rfTwoFuncFormat" />
      <el-table-column label="按键三" align="center" prop="rfThreeFunc" :formatter="rfThreeFuncFormat" />
      <el-table-column label="按键四" align="center" prop="rfFourFunc" :formatter="rfFourFuncFormat" />
      <el-table-column label="用户" align="center" prop="ownerId" />
      <el-table-column label="配网地址" align="center" prop="networkAddress" />
      <el-table-column label="配网IP" align="center" prop="networkIp" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:set:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:set:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改设备配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备" prop="deviceId">
          <el-input v-model="form.deviceId" placeholder="请输入设备" />
        </el-form-item>
        <el-form-item label="设备编号" prop="deviceNum">
          <el-input v-model="form.deviceNum" placeholder="请输入设备编号" />
        </el-form-item>
        <el-form-item label="报警" prop="isAlarm">
          <el-select v-model="form.isAlarm" placeholder="是否启动报警">
            <el-option
              v-for="dict in isAlarmOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="雷达感应" prop="isRadar">
          <el-select v-model="form.isRadar" placeholder="是否启动雷达感应">
            <el-option
              v-for="dict in isRadarOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="托管" prop="isHost">
          <el-select v-model="form.isHost" placeholder="是否托管">
            <el-option
              v-for="dict in isHostOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="重启" prop="isReset">
          <el-select v-model="form.isReset" placeholder="是否重启">
            <el-option
              v-for="dict in isResetOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="打开AP" prop="isAp">
          <el-select v-model="form.isAp" placeholder="是否打开AP">
            <el-option
              v-for="dict in isApOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="射频遥控" prop="isRfControl">
          <el-select v-model="form.isRfControl" placeholder="是否启动射频遥控">
            <el-option
              v-for="dict in isRfControlOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="遥控配对" prop="isRfLearn">
          <el-select v-model="form.isRfLearn" placeholder="是否遥控配对">
            <el-option
              v-for="dict in isRfLearnOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="遥控清码" prop="isRfClear">
          <el-select v-model="form.isRfClear" placeholder="是否遥控清码">
            <el-option
              v-for="dict in isRfClearOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键一" prop="rfOneFunc">
          <el-select v-model="form.rfOneFunc" placeholder="请选择按键一">
            <el-option
              v-for="dict in rfOneFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键二" prop="rfTwoFunc">
          <el-select v-model="form.rfTwoFunc" placeholder="请选择按键二">
            <el-option
              v-for="dict in rfTwoFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键三" prop="rfThreeFunc">
          <el-select v-model="form.rfThreeFunc" placeholder="请选择按键三">
            <el-option
              v-for="dict in rfThreeFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键四" prop="rfFourFunc">
          <el-select v-model="form.rfFourFunc" placeholder="请选择按键四">
            <el-option
              v-for="dict in rfFourFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="用户" prop="ownerId">
          <el-input v-model="form.ownerId" placeholder="请输入用户" />
        </el-form-item>
        <el-form-item label="配网地址" prop="networkAddress">
          <el-input v-model="form.networkAddress" placeholder="请输入配网地址" />
        </el-form-item>
        <el-form-item label="配网IP" prop="networkIp">
          <el-input v-model="form.networkIp" placeholder="请输入配网IP" />
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
import { listSet, getSet, delSet, addSet, updateSet, exportSet } from "@/api/system/set";

export default {
  name: "Set",
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
      // 设备配置表格数据
      setList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 报警字典
      isAlarmOptions: [{
        "label": "打开",
        "value": 1
      }, {
        "label": "关闭",
        "value": 0
      }],
      // 雷达感应字典
      isRadarOptions: [{
        "label": "打开",
        "value": 1
      }, {
        "label": "关闭",
        "value": 0
      }],
      // 托管字典
      isHostOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      }],
      // 重启字典
      isResetOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      }],
      // 打开AP字典
      isApOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      }],
      // 射频遥控字典
      isRfControlOptions: [{
        "label": "打开",
        "value": 1
      }, {
        "label": "关闭",
        "value": 0
      }],
      // 遥控配对字典
      isRfLearnOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      }],
      // 遥控清码字典
      isRfClearOptions: [{
        "label": "是",
        "value": 1
      }, {
        "label": "否",
        "value": 0
      }],
      // 按键一字典
      rfOneFuncOptions: [],
      // 按键二字典
      rfTwoFuncOptions: [],
      // 按键三字典
      rfThreeFuncOptions: [],
      // 按键四字典
      rfFourFuncOptions: [],
      // 创建时间时间范围
      daterangeCreateTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceId: null,
        deviceNum: null,
        isAlarm: null,
        isRadar: null,
        isHost: null,
        isRfControl: null,
        ownerId: null,
        networkAddress: null,
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
    this.getDicts("rf_function").then(response => {
      this.rfOneFuncOptions = response.data;
    });
    this.getDicts("rf_function").then(response => {
      this.rfTwoFuncOptions = response.data;
    });
    this.getDicts("rf_function").then(response => {
      this.rfThreeFuncOptions = response.data;
    });
    this.getDicts("rf_function").then(response => {
      this.rfFourFuncOptions = response.data;
    });
  },
  methods: {
    /** 查询设备配置列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeCreateTime && '' != this.daterangeCreateTime) {
        this.queryParams.params["beginCreateTime"] = this.daterangeCreateTime[0];
        this.queryParams.params["endCreateTime"] = this.daterangeCreateTime[1];
      }
      listSet(this.queryParams).then(response => {
        this.setList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 按键一字典翻译
    rfOneFuncFormat(row, column) {
      return this.selectDictLabel(this.rfOneFuncOptions, row.rfOneFunc);
    },
    // 按键二字典翻译
    rfTwoFuncFormat(row, column) {
      return this.selectDictLabel(this.rfTwoFuncOptions, row.rfTwoFunc);
    },
    // 按键三字典翻译
    rfThreeFuncFormat(row, column) {
      return this.selectDictLabel(this.rfThreeFuncOptions, row.rfThreeFunc);
    },
    // 按键四字典翻译
    rfFourFuncFormat(row, column) {
      return this.selectDictLabel(this.rfFourFuncOptions, row.rfFourFunc);
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        deviceSetId: null,
        deviceId: null,
        deviceNum: null,
        isAlarm: null,
        isRadar: null,
        isHost: null,
        isReset: null,
        isAp: null,
        isRfControl: null,
        isRfLearn: null,
        isRfClear: null,
        rfOneFunc: null,
        rfTwoFunc: null,
        rfThreeFunc: null,
        rfFourFunc: null,
        ownerId: null,
        networkAddress: null,
        networkIp: null,
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
      this.ids = selection.map(item => item.deviceSetId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加设备配置";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const deviceSetId = row.deviceSetId || this.ids
      getSet(deviceSetId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改设备配置";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.deviceSetId != null) {
            updateSet(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addSet(this.form).then(response => {
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
      const deviceSetIds = row.deviceSetId || this.ids;
      this.$confirm('是否确认删除设备配置编号为"' + deviceSetIds + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delSet(deviceSetIds);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        })
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有设备配置数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportSet(queryParams);
        }).then(response => {
          this.download(response.msg);
        })
    }
  }
};
</script>
