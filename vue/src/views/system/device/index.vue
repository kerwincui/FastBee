<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设备编号" prop="deviceNum">
        <el-input
          v-model="queryParams.deviceNum"
          placeholder="请输入编号"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="分类" prop="categoryId">
        <el-select v-model="queryParams.categoryId" placeholder="请选择分类" clearable size="small">
          <el-option
            v-for="category in categoryList"
            :key="category.categoryId"
            :label="category.categoryName"
            :value="category.categoryId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="设备名称" prop="deviceName">
        <el-input
          v-model="queryParams.deviceName"
          placeholder="请输入名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="固件版本" prop="firmwareVersion">
        <el-input
          v-model="queryParams.firmwareVersion"
          placeholder="请输入固件版本"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['system:device:add']"
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
          v-hasPermi="['system:device:edit']"
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
          v-hasPermi="['system:device:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:device:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="deviceList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" prop="deviceId" />
      <el-table-column label="编号" align="center" prop="deviceNum" />
      <el-table-column label="分类" align="center" prop="categoryId" :formatter="categoryFormat" />
      <el-table-column label="名称" align="center" prop="deviceName" />
      <el-table-column label="固件版本" align="center" prop="firmwareVersion" />
      <el-table-column label="用户" align="center" prop="ownerId" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleStatus(scope.row)"
            v-hasPermi="['system:device:edit']"
          >状态</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-setting"
            @click="handleSet(scope.row)"
            v-hasPermi="['system:device:edit']"
          >配置</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:device:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:device:remove']"
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

    <!-- 添加或修改设备对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="编号" prop="deviceNum">
          <el-input v-model="form.deviceNum" placeholder="请输入编号" />
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择分类" >
            <el-option
              v-for="category in categoryList"
              :key="category.categoryId"
              :label="category.categoryName"
              :value="category.categoryId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="名称" prop="deviceName">
          <el-input v-model="form.deviceName" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="固件版本" prop="firmwareVersion">
          <el-input v-model="form.firmwareVersion" placeholder="请输入固件版本" />
        </el-form-item>
        <el-form-item label="用户" prop="ownerId">
          <el-input v-model="form.ownerId" placeholder="请输入用户" />
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

    <!-- 添加或修改设备状态对话框 -->
    <el-dialog :title="statusTitle" :visible.sync="statusOpen" width="500px" append-to-body>
      <el-form ref="statusForm" :model="statusForm" :rules="rules" label-width="80px">
        <el-form-item label="设备" prop="deviceId">
          <el-input v-model="statusForm.deviceId" placeholder="请输入设备" />
        </el-form-item>
        <el-form-item label="设备编号" prop="deviceNum">
          <el-input v-model="statusForm.deviceNum" placeholder="请输入设备编号" />
        </el-form-item>
        <el-form-item label="继电器" prop="relayStatus">
          <el-select v-model="statusForm.relayStatus" placeholder="请选择继电器状态">
            <el-option
              v-for="dict in relayStatusOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="灯状态" prop="lightStatus">
          <el-select v-model="statusForm.lightStatus" placeholder="请选择灯状态">
            <el-option
              v-for="dict in lightStatusOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="在线" prop="isOnline">
          <el-select v-model="statusForm.isOnline" placeholder="请选择是否状态">
            <el-option
              v-for="dict in isOnlineOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="设备温度" prop="deviceTemperature">
          <el-input v-model="statusForm.deviceTemperature" placeholder="请输入设备温度" />
        </el-form-item>
        <el-form-item label="设备湿度" prop="deviceHumidity">
          <el-input v-model="statusForm.deviceHumidity" placeholder="请输入设备湿度" />
        </el-form-item>
        <el-form-item label="空气温度" prop="airTemperature">
          <el-input v-model="statusForm.airTemperature" placeholder="请输入空气温度" />
        </el-form-item>
        <el-form-item label="空气湿度" prop="airHumidity">
          <el-input v-model="statusForm.airHumidity" placeholder="请输入空气湿度" />
        </el-form-item>
        <el-form-item label="触发源" prop="triggerSource">
          <el-select v-model="statusForm.triggerSource" placeholder="请选择触发源">
            <el-option
              v-for="dict in triggerSourceOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="彩灯亮度" prop="brightness">
          <el-input v-model="statusForm.brightness" placeholder="请输入彩灯亮度" />
        </el-form-item>
        <el-form-item label="渐变间隔" prop="lightInterval">
          <el-input v-model="statusForm.lightInterval" placeholder="请输入渐变间隔" />
        </el-form-item>
        <el-form-item label="彩灯模式" prop="lightMode">
          <el-select v-model="statusForm.lightMode" placeholder="请选择彩灯模式">
            <el-option
              v-for="dict in lightModeOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="红灯" prop="red">
          <el-input v-model="statusForm.red" placeholder="请输入红灯" />
        </el-form-item>
        <el-form-item label="绿灯" prop="green">
          <el-input v-model="statusForm.green" placeholder="请输入绿灯" />
        </el-form-item>
        <el-form-item label="蓝灯" prop="blue">
          <el-input v-model="statusForm.blue" placeholder="请输入蓝灯" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="statusForm.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="statusSubmitForm">确 定</el-button>
        <el-button @click="statusCancel">取 消</el-button>
      </div>
    </el-dialog>

         <!-- 添加或修改设备配置对话框 -->
    <el-dialog :title="setTitle" :visible.sync="setOpen" width="500px" append-to-body>
      <el-form ref="setForm" :model="setForm" :rules="rules" label-width="80px">
        <el-form-item label="设备" prop="deviceId">
          <el-input v-model="setForm.deviceId" placeholder="请输入设备" />
        </el-form-item>
        <el-form-item label="设备编号" prop="deviceNum">
          <el-input v-model="setForm.deviceNum" placeholder="请输入设备编号" />
        </el-form-item>
        <el-form-item label="报警" prop="isAlarm">
          <el-select v-model="setForm.isAlarm" placeholder="是否启动报警">
            <el-option
              v-for="dict in isAlarmOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="雷达感应" prop="isRadar">
          <el-select v-model="setForm.isRadar" placeholder="是否启动雷达感应">
            <el-option
              v-for="dict in isRadarOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="托管" prop="isHost">
          <el-select v-model="setForm.isHost" placeholder="是否托管">
            <el-option
              v-for="dict in isHostOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="重启" prop="isReset">
          <el-select v-model="setForm.isReset" placeholder="是否重启">
            <el-option
              v-for="dict in isResetOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="打开AP" prop="isAp">
          <el-select v-model="setForm.isAp" placeholder="是否打开AP">
            <el-option
              v-for="dict in isApOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="射频遥控" prop="isRfControl">
          <el-select v-model="setForm.isRfControl" placeholder="是否启动射频遥控">
            <el-option
              v-for="dict in isRfControlOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="遥控配对" prop="isRfLearn">
          <el-select v-model="setForm.isRfLearn" placeholder="是否遥控配对">
            <el-option
              v-for="dict in isRfLearnOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="遥控清码" prop="isRfClear">
          <el-select v-model="setForm.isRfClear" placeholder="是否遥控清码">
            <el-option
              v-for="dict in isRfClearOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键一" prop="rfOneFunc">
          <el-select v-model="setForm.rfOneFunc" placeholder="请选择按键一">
            <el-option
              v-for="dict in rfOneFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键二" prop="rfTwoFunc">
          <el-select v-model="setForm.rfTwoFunc" placeholder="请选择按键二">
            <el-option
              v-for="dict in rfTwoFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键三" prop="rfThreeFunc">
          <el-select v-model="setForm.rfThreeFunc" placeholder="请选择按键三">
            <el-option
              v-for="dict in rfThreeFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="按键四" prop="rfFourFunc">
          <el-select v-model="setForm.rfFourFunc" placeholder="请选择按键四">
            <el-option
              v-for="dict in rfFourFuncOptions"
              :key="dict.dictValue"
              :label="dict.dictLabel"
              :value="parseInt(dict.dictValue)"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="用户" prop="ownerId">
          <el-input v-model="setForm.ownerId" placeholder="请输入用户" />
        </el-form-item>
        <el-form-item label="配网地址" prop="networkAddress">
          <el-input v-model="setForm.networkAddress" placeholder="请输入配网地址" />
        </el-form-item>
        <el-form-item label="配网IP" prop="networkIp">
          <el-input v-model="setForm.networkIp" placeholder="请输入配网IP" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="setForm.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="setSubmitForm">确 定</el-button>
        <el-button @click="setCancel">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listDevice, getDevice, delDevice, addDevice, updateDevice, exportDevice } from "@/api/system/device";
import { getNewStatus, updateStatus } from "@/api/system/status";
import { getNewSet, updateSet } from "@/api/system/set";
import { listCategory } from "@/api/system/category";

export default {
  name: "Device",
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
      // 设备表格数据
      deviceList: [],
      // 弹出层标题
      title: "",
      statusTitle:"",
      setTitle:"",
      // 是否显示弹出层
      open: false,
      statusOpen:false,
      setOpen:false,
      // 创建时间时间范围
      daterangeCreateTime: [],
      // 分类
      categoryList: [],
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
        deviceNum: null,
        categoryId: null,
        deviceName: null,
        firmwareVersion: null,
        ownerId: null,
        createTime: null,
      },
      // 查询分类参数
      queryCategoryParams: {
        pageNum: 1,
        pageSize: 100,
        categoryName: null,
      },
      // 表单参数
      form: {},
      statusForm:{},
      setForm:{},
      // 表单校验
      rules: {
        deviceNum: [
          { required: true, message: "编号不能为空", trigger: "blur" }
        ],
        deviceName: [
          { required: true, message: "名称不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getCategoryList();
    this.getList();
    this.getDicts("iot_trigger_source").then(response => {
      this.triggerSourceOptions = response.data;
    });
    this.getDicts("light_mode").then(response => {
      this.lightModeOptions = response.data;
    });
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
    /** 查询设备列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeCreateTime && '' != this.daterangeCreateTime) {
        this.queryParams.params["beginCreateTime"] = this.daterangeCreateTime[0];
        this.queryParams.params["endCreateTime"] = this.daterangeCreateTime[1];
      }
      listDevice(this.queryParams).then(response => {
        this.deviceList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 查询设备分类
    getCategoryList() {
      listCategory(this.queryCategoryParams).then(response => {
        this.categoryList = response.rows;
      });
    },
    // 分类翻译
    categoryFormat(row, column) {
      var name="";
      for(var i=0;i<this.categoryList.length;i++){
        if(this.categoryList[i].categoryId==row.categoryId){
          name=this.categoryList[i].categoryName;
          break;
        }
      }
      return name;
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
    statusCancel() {
      this.statusOpen = false;
      this.statusReset();
    },
    setCancel() {
      this.setOpen = false;
      this.setReset();
    },
    // 表单重置
    reset() {
      this.form = {
        deviceId: null,
        deviceNum: null,
        categoryId: null,
        deviceName: null,
        firmwareVersion: null,
        ownerId: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      };
      this.resetForm("form");
    },
    statusReset() {
      this.statusForm = {
        deviceStatusId: null,
        deviceId: null,
        deviceNum: null,
        relayStatus: null,
        lightStatus: null,
        isOnline: null,
        deviceTemperature: null,
        deviceHumidity: null,
        airTemperature: null,
        airHumidity: null,
        triggerSource: null,
        brightness: null,
        lightInterval: null,
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
      this.resetForm("statusForm");
    },
    setReset() {
      this.setForm = {
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
      this.resetForm("setForm");
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
      this.ids = selection.map(item => item.deviceId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加设备";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const deviceId = row.deviceId || this.ids
      getDevice(deviceId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改设备";
      });
    },
    /** 状态按钮操作 */
    handleStatus(row) {
      this.reset();
      const deviceId = row.deviceId || this.ids
      getNewStatus(deviceId).then(response => {
        this.statusForm = response.data;
        this.statusOpen = true;
        this.statusTitle = "设备状态";
      });
    },
    /** 配置按钮操作 */
    handleSet(row) {
      this.reset();
      const deviceId = row.deviceId || this.ids
      getNewSet(deviceId).then(response => {
        this.setForm = response.data;
        this.setOpen = true;
        this.setTitle = "设备配置";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.deviceId != null) {
            updateDevice(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDevice(this.form).then(response => {
              this.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 提交按钮 */
    statusSubmitForm() {
      this.$refs["statusForm"].validate(valid => {
        if (valid) {
          if (this.statusForm.deviceStatusId != null) {
            updateStatus(this.statusForm).then(response => {
              this.msgSuccess("更新成功");
              this.statusOpen = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 提交按钮 */
    setSubmitForm() {
      this.$refs["setForm"].validate(valid => {
        if (valid) {
          if (this.setForm.deviceSetId != null) {
            updateSet(this.setForm).then(response => {
              this.msgSuccess("修改成功");
              this.setOpen = false;
              this.getList();
            });
          } 
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const deviceIds = row.deviceId || this.ids;
      this.$confirm('是否确认删除设备编号为"' + deviceIds + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delDevice(deviceIds);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        })
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有设备数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportDevice(queryParams);
        }).then(response => {
          this.download(response.msg);
        })
    }
  }
};
</script>
