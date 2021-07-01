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
    <el-form
      :model="queryParams"
      ref="queryForm"
      :inline="true"
      v-show="showSearch"
      label-width="68px"
    >
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
        <el-select
          v-model="queryParams.categoryId"
          placeholder="请选择分类"
          clearable
          size="small"
        >
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
        <el-button
          type="primary"
          icon="el-icon-search"
          size="mini"
          @click="handleQuery"
          >搜索</el-button
        >
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery"
          >重置</el-button
        >
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
    </el-row> -->

    <el-table
      v-loading="loading"
      :data="deviceList"
      @selection-change="handleSelectionChange"
      border
      :row-class-name="tableRowClassName"
    >
      <!-- <el-table-column type="selection" width="45" align="center" /> -->
      <el-table-column label="序号" width="50" align="center" prop="deviceId" />
      <el-table-column label="编号" align="center" prop="deviceNum" />
      <el-table-column label="名称" align="center" prop="deviceName" />
      <el-table-column
        label="分类"
        align="center"
        prop="categoryId"
        :formatter="categoryFormat"
      />
      <el-table-column label="用户" align="center" prop="nickName" />
      <el-table-column label="固件版本" align="center" prop="firmwareVersion" />
      <el-table-column label="在线" align="center" prop="isOnline">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isOnline" :active-value=1 :inactive-value=0 active-color="#13ce66" disabled></el-switch>
        </template>
      </el-table-column>
      <!-- wifi信号强度(信号极好4格[-55—— 0]，信号好3格[-70—— -55），信号一般2格[-85—— -70），信号差1格[-100—— -85）) -->
      <el-table-column label="信号" align="center" prop="rssi">
        <template slot-scope="scope" style="font-size: 40px">
          <div style="font-size: 30px">
            <svg-icon v-if="scope.row.rssi >= '-55'" icon-class="wifi_4" />
            <svg-icon
              v-else-if="scope.row.rssi >= '-70' && scope.row.rssi < '-55'"
              icon-class="wifi_3"
            />
            <svg-icon
              v-else-if="scope.row.rssi >= '-85' && scope.row.rssi < '-70'"
              icon-class="wifi_2"
            />
            <svg-icon
              v-else-if="scope.row.rssi >= '-100' && scope.row.rssi < '-85'"
              icon-class="wifi_1"
            />
            <svg-icon v-else icon-class="wifi_0" />
          </div>
        </template>
      </el-table-column>
      <el-table-column label="继电器" align="center" prop="relayStatus">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.relayStatus" :active-value=1 :inactive-value=0 active-color="#13ce66" disabled></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="灯状态" align="center" prop="lightStatus">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.lightStatus" :active-value=1 :inactive-value=0 active-color="#13ce66" disabled></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="雷达感应" align="center" prop="isRadar">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isRadar" :active-value=1 :inactive-value=0 disabled></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="报警" align="center" prop="isAlarm">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isAlarm" :active-value=1 :inactive-value=0 disabled></el-switch>
        </template>
      </el-table-column>
      <el-table-column label="遥控" align="center" prop="isRfControl">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.isRfControl" :active-value=1 :inactive-value=0 disabled></el-switch>
        </template>
      </el-table-column>
      <el-table-column
        label="设备温度"
        align="center"
        prop="deviceTemperature"
      />
      <el-table-column label="配网地址" align="center" prop="networkAddress" />
      <!-- <el-table-column label="配网IP" align="center" prop="networkIp" /> -->
      <el-table-column
        label="创建时间"
        align="center"
        prop="createTime"
        width="100"
      >
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, "{y}-{m}-{d}") }}</span>
        </template>
      </el-table-column>

      <el-table-column
        label="操作"
        align="center"
        class-name="small-padding fixed-width"
        width="120"
      >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleStatus(scope.row)"
            v-hasPermi="['system:device:edit']"
            >状态</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-setting"
            @click="handleSet(scope.row)"
            v-hasPermi="['system:device:edit']"
            >配置</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:device:edit']"
            >修改</el-button
          >
          <el-button
            size="mini"
            type="text"
            icon="el-icon-cloudy"
            disabled
            v-hasPermi="['system:device:edit']"
            >升级</el-button
          >
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改设备对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="编号" prop="deviceNum">
          <el-input
            v-model="form.deviceNum"
            placeholder="请输入编号"
            :disabled="true"
          />
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select
            v-model="form.categoryId"
            placeholder="请选择分类"
            :disabled="true"
          >
            <el-option
              v-for="category in categoryList"
              :key="category.categoryId"
              :label="category.categoryName"
              :value="category.categoryId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="固件版本" prop="firmwareVersion">
          <el-input
            v-model="form.firmwareVersion"
            placeholder="请输入固件版本"
            :disabled="true"
          />
        </el-form-item>
        <el-form-item label="名称" prop="deviceName">
          <el-input v-model="form.deviceName" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input
            v-model="form.remark"
            type="textarea"
            placeholder="请输入内容"
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>        
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 添加或修改设备状态对话框 -->
    <el-dialog
      :title="statusTitle"
      :visible.sync="statusOpen"
      width="630px"
      append-to-body
    >
      <el-form
        ref="statusForm"
        :model="statusForm"
        :rules="rules"
        label-width="120px"
      >
        <el-row>
          <el-col :span="24">
            <el-form-item label="继电器" prop="relayStatus">
              <el-switch
                v-model="statusForm.relayStatus"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 active-color="#13ce66">
              </el-switch>
            </el-form-item>
          </el-col>
          <el-col :span="24" :offset="0">
            <el-form-item label="灯状态" prop="lightStatus">
              <el-switch
                v-model="statusForm.lightStatus"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 active-color="#13ce66">
              </el-switch>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="24">
            <el-form-item label="彩灯模式" prop="lightMode">
              <el-select
                v-model="statusForm.lightMode"
                placeholder="请选择彩灯模式"
              >
                <el-option
                  v-for="dict in lightModeOptions"
                  :key="dict.dictValue"
                  :label="dict.dictLabel"
                  :value="parseInt(dict.dictValue)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="24">
            <el-form-item label="渐变间隔/ms" prop="lightInterval">
              <el-slider
                v-model="statusForm.lightInterval"
                :min=0
                :max=1500
                show-input>
              </el-slider>
            </el-form-item>
          </el-col>
          <el-col :span="24" :offset="0">
            <el-form-item label="渐变时间/ms" prop="fadeTime">
              <el-slider
                v-model="statusForm.fadeTime"
                :min=0
                :max=1500
                show-input>
              </el-slider>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="24" >
            <el-form-item label="亮度" prop="brightness">
              <el-slider
                v-model="statusForm.brightness"
                show-input>
              </el-slider>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="红色" prop="red">
               <el-slider
                v-model="statusForm.red"
                :max=255
                show-input>
              </el-slider>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="绿色" prop="green">
               <el-slider
                v-model="statusForm.green"
                :max=255
                show-input>
              </el-slider>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="蓝色" prop="blue">
               <el-slider
                v-model="statusForm.blue"
                :max=255
                show-input>
              </el-slider>
            </el-form-item>
          </el-col>
        </el-row>

        <el-divider content-position="center"/>
        <el-row>
          <el-col :span="11">
            <el-form-item label="空气温度" prop="airTemperature">
              <el-tag placeholder="请输入空气温度" type="success">
                {{ statusForm.airTemperature }} ℃
              </el-tag>
            </el-form-item>
          </el-col>
          <el-col :span="11" :offset="1">
            <el-form-item label="空气湿度" prop="airHumidity">
              <el-tag placeholder="请输入空气湿度" type="success">
                {{ statusForm.airHumidity }} %RH
              </el-tag>
            </el-form-item>
          </el-col>
        </el-row>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="statusSubmitForm(false)">确 定</el-button>
        <el-button type="success" @click="statusSubmitForm(true)">应 用</el-button>
        <el-button @click="statusCancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 添加或修改设备配置对话框 -->
    <el-dialog
      :title="setTitle"
      :visible.sync="setOpen"
      width="630px"
      append-to-body
    >
      <el-form ref="setForm" :model="setForm" :rules="rules" label-width="120px">
        <el-form-item label="雷达感应" prop="isRadar">
            <el-switch
                v-model="setForm.isRadar"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 >
              </el-switch>
        </el-form-item>

        <el-form-item label="报警" prop="isAlarm">
            <el-switch
                v-model="setForm.isAlarm"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 >
              </el-switch>
        </el-form-item>

        <el-form-item label="雷达感应间隔/s" prop="radarInterval">
          <el-slider
                v-model="setForm.radarInterval"
                :min=1
                :max=60
                show-input>
              </el-slider>
        </el-form-item>

        <el-divider content-position="center"/>
        <el-form-item label="射频遥控" prop="isRfControl">
            <el-switch
                v-model="setForm.isRfControl"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 >
              </el-switch>
        </el-form-item>
        <el-form-item label="遥控配对" prop="isRfLearn">
          <el-switch
                v-model="setForm.isRfLearn"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 >
              </el-switch>
        </el-form-item>
        <el-form-item label="遥控清码" prop="isRfClear">
          <el-switch
                v-model="setForm.isRfClear"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 >
              </el-switch>
        </el-form-item>
        <el-row>
          <el-col :span="11">
            <el-form-item label="按键一" prop="rfOneFunc">
              <el-select v-model="setForm.rfOneFunc" placeholder="请选择按键一">
                <el-option
                  v-for="dict in rfFuncOptions"
                  :key="dict.dictValue"
                  :label="dict.dictLabel"
                  :value="parseInt(dict.dictValue)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="11" offset="1">
            <el-form-item label="按键二" prop="rfTwoFunc">
              <el-select v-model="setForm.rfTwoFunc" placeholder="请选择按键二">
                <el-option
                  v-for="dict in rfFuncOptions"
                  :key="dict.dictValue"
                  :label="dict.dictLabel"
                  :value="parseInt(dict.dictValue)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="11">
            <el-form-item label="按键三" prop="rfThreeFunc">
              <el-select v-model="setForm.rfThreeFunc" placeholder="请选择按键三">
                <el-option
                  v-for="dict in rfFuncOptions"
                  :key="dict.dictValue"
                  :label="dict.dictLabel"
                  :value="parseInt(dict.dictValue)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="11" offset="1">
            <el-form-item label="按键四" prop="rfFourFunc">
              <el-select v-model="setForm.rfFourFunc" placeholder="请选择按键四">
                <el-option
                  v-for="dict in rfFuncOptions"
                  :key="dict.dictValue"
                  :label="dict.dictLabel"
                  :value="parseInt(dict.dictValue)"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>     

        <el-divider content-position="center"/>
                <el-form-item label="重启" prop="isReset">
            <el-switch
                v-model="setForm.isReset"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 active-color="#f56c6c">
              </el-switch>
        </el-form-item>
        <el-form-item label="打开AP" prop="isAp">
           <el-switch
                v-model="setForm.isAp"
                active-text="打开"
                inactive-text="关闭"
                :active-value=1 :inactive-value=0 active-color="#f56c6c">
              </el-switch>
        </el-form-item>

        <!-- <el-form-item label="托管" prop="isHost">
          <el-select v-model="setForm.isHost" placeholder="是否托管">
            <el-option
              v-for="dict in isHostOptions"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item> -->

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="setSubmitForm(false)">确 定</el-button>
        <el-button type="success" @click="setSubmitForm(true)">应 用</el-button>
        <el-button @click="setCancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style>
.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}
</style>

<script>
import {
  listDevice,
  getDevice,
  delDevice,
  addDevice,
  updateDevice,
  exportDevice
} from "@/api/system/device";
import { getNewStatus, updateStatus } from "@/api/system/status";
import { getNewSet, updateSet } from "@/api/system/set";
import { listCategory } from "@/api/system/category";

export default {
  name: "Device",
  components: {},
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
      statusTitle: "",
      setTitle: "",
      // 是否显示弹出层
      open: false,
      statusOpen: false,
      setOpen: false,
      // 创建时间时间范围
      daterangeCreateTime: [],
      // 分类
      categoryList: [],
      // 继电器字典
      openCloseOptions: [
        {
          label: "打开",
          value: 1
        },
        {
          label: "关闭",
          value: 0
        }
      ],
      // 灯状态字典
      yesNoOptions: [
        {
          label: "是",
          value: 1
        },
        {
          label: "否",
          value: 0
        }
      ],
      // 在线字典
      isOnlineOptions: [
        {
          label: "在线",
          value: 1
        },
        {
          label: "离线",
          value: 0
        }
      ],
      // 触发源字典
      triggerSourceOptions: [],
      // 彩灯模式字典
      lightModeOptions: [],
      
      // 按键字典
      rfFuncOptions: [],
      // 创建时间时间范围
      daterangeCreateTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        groupId:0,
        deviceNum: null,
        categoryId: null,
        deviceName: null,
        firmwareVersion: null,
        ownerId: null,
        createTime: null
      },
      // 表单参数
      form: {},
      statusForm: {},
      setForm: {},
      // 表单校验
      rules: {
        deviceNum: [
          { required: true, message: "编号不能为空", trigger: "blur" }
        ],
        deviceName: [
          { required: true, message: "名称不能为空", trigger: "blur" }
        ]
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
      this.rfFuncOptions = response.data;
    });
  },
  methods: {
    /**行颜色 */
    tableRowClassName({ row, rowIndex }) {
      if (rowIndex === 1) {
        return "success-row";
      } else if (rowIndex === 3) {
        return "warning-row";
      }
      return "";
    },
    /** 查询设备列表 */
    getList() {
      this.loading = true;
      this.queryParams.params = {};
      if (null != this.daterangeCreateTime && "" != this.daterangeCreateTime) {
        this.queryParams.params[
          "beginCreateTime"
        ] = this.daterangeCreateTime[0];
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
      var name = "";
      for (var i = 0; i < this.categoryList.length; i++) {
        if (this.categoryList[i].categoryId == row.categoryId) {
          name = this.categoryList[i].categoryName;
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
      this.resetForm("statusForm");
    },
    setReset() {
      this.setForm = {
        deviceSetId: null,
        deviceId: null,
        deviceNum: null,
        isAlarm: null,
        isRadar: null,
        radarInterval:null,
        isHost: null,
        isReset: null,
        isAp: null,
        isWifiOffline: null,
        isOpenCertifi: null,
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
      this.ids = selection.map(item => item.deviceId);
      this.single = selection.length !== 1;
      this.multiple = !selection.length;
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
      const deviceId = row.deviceId || this.ids;
      getDevice(deviceId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改设备";
      });
    },
    /** 状态按钮操作 */
    handleStatus(row) {
      this.reset();
      const deviceId = row.deviceId || this.ids;
      getNewStatus(deviceId).then(response => {
        this.statusForm = response.data;
        this.statusOpen = true;
        this.statusTitle = "设备状态";
      });
    },
    /** 配置按钮操作 */
    handleSet(row) {
      this.reset();
      const deviceId = row.deviceId || this.ids;
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
    /** 状态提交按钮 */
    statusSubmitForm(isApply) {
      this.$refs["statusForm"].validate(valid => {
        if (valid) {
          if (this.statusForm.deviceStatusId != null) {
            updateStatus(this.statusForm).then(response => {
              this.msgSuccess("更新成功");
              if(!isApply){
                this.statusOpen = false;
                this.getList();
              }              
            });
          }
        }
      });
    },
    /** 设置提交按钮 */
    setSubmitForm(isApply) {
      this.$refs["setForm"].validate(valid => {
        if (valid) {
          if (this.setForm.deviceSetId != null) {
            updateSet(this.setForm).then(response => {
              this.msgSuccess("更新成功");
              if(!isApply){
                this.setOpen = false;
                this.getList();
              }              
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const deviceIds = row.deviceId || this.ids;
      this.$confirm(
        '是否确认删除设备编号为"' + deviceIds + '"的数据项?',
        "警告",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      )
        .then(function() {
          return delDevice(deviceIds);
        })
        .then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        });
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm("是否确认导出所有设备数据项?", "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(function() {
          return exportDevice(queryParams);
        })
        .then(response => {
          this.download(response.msg);
        });
    }
  }
};
</script>
