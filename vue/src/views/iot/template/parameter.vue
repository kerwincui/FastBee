<template>
  <div style="padding: 6px">
    <!-- 添加或修改通用物模型对话框 -->
    <el-dialog :title="$t('template.paramter.038405-0')" :visible.sync="openEdit" width="900px" append-to-body>
      <div style="margin: -30px 0 30px; background-color: #ddd; height: 1px"></div>
      <el-row>
        <el-col :span="12" style="border: 1px solid #ddd; border-radius: 5px; padding: 10px; background-color: #eee">
          <el-form :model="queryParams" :inline="true" label-width="48px" size="small">
            <el-form-item label="" prop="templateName">
              <el-input v-model="queryParams.templateName" :placeholder="$t('template.paramter.038405-1')" style="width: 160px" clearable size="mini" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item>
              <el-button type="info" icon="el-icon-search" size="mini" @click="handleQuery" style="padding: 5px">{{ $t('template.paramter.038405-2') }}</el-button>
            </el-form-item>
            <el-form-item>
              <el-link :underline="false" icon="el-icon-info" type="primary" style="margin-left: 20px">{{ $t('template.paramter.038405-3') }}</el-link>
            </el-form-item>
          </el-form>

          <el-table v-loading="loading" :data="templateList" size="mini" @row-click="rowClick" highlight-current-row :border="false" :show-header="false" :row-style="{ backgroundColor: '#eee' }">
            <el-table-column :label="$t('template.paramter.038405-4')" width="30" align="center">
              <template slot-scope="scope">
                <input type="radio" :checked="scope.row.isSelect" :disabled="scope.row.datatype == 'array' || scope.row.datatype == 'object'" name="template" />
              </template>
            </el-table-column>
            <el-table-column :label="$t('template.paramter.038405-5')" align="left" prop="templateName" />
            <el-table-column :label="$t('template.paramter.038405-6')" align="left" prop="identifier" />
            <el-table-column :label="$t('template.paramter.038405-7')" align="center" prop="datatype" width="60">
              <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_data_type" :value="scope.row.datatype" />
              </template>
            </el-table-column>
          </el-table>

          <pagination
            v-show="total > 0"
            small
            style="margin: 0 0 10px; background-color: #eee"
            layout="prev, pager, next"
            :total="total"
            :page.sync="queryParams.pageNum"
            :limit.sync="queryParams.pageSize"
            @pagination="getList"
          />
        </el-col>

        <el-col :span="11" :offset="1">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item :label="$t('template.paramter.038405-8')" prop="name">
              <el-input v-model="form.name" :placeholder="$t('template.paramter.038405-9')" style="width: 270px" size="small" />
            </el-form-item>
            <el-form-item :label="$t('template.paramter.038405-10')" prop="id">
              <el-input v-model="form.id" :placeholder="$t('template.paramter.038405-11')" style="width: 270px" size="small"></el-input>
            </el-form-item>
            <el-form-item :label="$t('template.paramter.038405-12')" prop="order">
              <el-input-number controls-position="right" v-model="form.order" :placeholder="$t('template.paramter.038405-13')" type="number" style="width: 270px" size="small" />
            </el-form-item>

            <el-form-item :label="$t('template.paramter.038405-14')" prop="property">
              <el-checkbox name="isChart" :label="$t('template.paramter.038405-15')" @change="isChartChange" v-model="form.isChart" :true-label="1" :false-label="0"></el-checkbox>
              <el-checkbox name="isMonitor" :label="$t('template.paramter.038405-16')" @change="isMonitorChange" v-model="form.isMonitor" :true-label="1" :false-label="0"></el-checkbox>
              <el-checkbox name="isReadonly" :label="$t('template.paramter.038405-17')" @change="isReadonlyChange" v-model="form.isReadonly" :true-label="1" :false-label="0"></el-checkbox>
              <el-checkbox name="isHistory" :label="$t('template.paramter.038405-18')" v-model="form.isHistory" :true-label="1" :false-label="0"></el-checkbox>
              <el-checkbox name="isSharePerm" :label="$t('template.paramter.038405-19')" v-model="form.isSharePerm" :true-label="1" :false-label="0"></el-checkbox>
            </el-form-item>

            <div style="margin-bottom: 20px; background-color: #ddd; height: 1px"></div>
            <el-form-item :label="$t('template.paramter.038405-20')" prop="datatype">
              <el-select v-model="form.datatype" :placeholder="$t('template.paramter.038405-21')" style="width: 125px" size="small">
                <el-option key="integer" :label="$t('template.paramter.038405-22')" value="integer"></el-option>
                <el-option key="decimal" :label="$t('template.paramter.038405-23')" value="decimal"></el-option>
                <el-option key="bool" :label="$t('template.paramter.038405-24')" value="bool" :disabled="form.isChart == 1"></el-option>
                <el-option key="enum" :label="$t('template.paramter.038405-25')" value="enum" :disabled="form.isChart == 1"></el-option>
                <el-option key="string" :label="$t('template.paramter.038405-26')" value="string" :disabled="form.isChart == 1"></el-option>
              </el-select>
            </el-form-item>
            <div v-if="form.datatype == 'integer' || form.datatype == 'decimal'">
              <el-form-item :label="$t('template.paramter.038405-27')">
                <el-row>
                  <el-col :span="10">
                    <el-input v-model="form.specs.min" :placeholder="$t('template.paramter.038405-28')" type="number" size="small" />
                  </el-col>
                  <el-col :span="4" align="center">{{ $t('template.paramter.038405-29') }}</el-col>
                  <el-col :span="10">
                    <el-input v-model="form.specs.max" :placeholder="$t('template.paramter.038405-30')" type="number" size="small" />
                  </el-col>
                </el-row>
              </el-form-item>
              <el-form-item :label="$t('template.paramter.038405-31')">
                <el-input v-model="form.specs.unit" :placeholder="$t('template.paramter.038405-32')" style="width: 308px" size="small" />
              </el-form-item>
              <el-form-item :label="$t('template.paramter.038405-33')">
                <el-input-number controls-position="right" v-model="form.specs.step" :placeholder="$t('template.paramter.038405-34')" type="number" style="width: 308px" size="small" />
              </el-form-item>
            </div>
            <div v-if="form.datatype == 'bool'">
              <el-form-item :label="$t('template.paramter.038405-35')" prop="">
                <el-row style="margin-bottom: 10px">
                  <el-col :span="10">
                    <el-input v-model="form.specs.falseText" :placeholder="$t('template.paramter.038405-36')" size="small" />
                  </el-col>
                  <el-col :span="10" :offset="1">{{ $t('template.paramter.038405-37') }}</el-col>
                </el-row>
                <el-row>
                  <el-col :span="10">
                    <el-input v-model="form.specs.trueText" :placeholder="$t('template.paramter.038405-38')" size="small" />
                  </el-col>
                  <el-col :span="10" :offset="1">{{ $t('template.paramter.038405-39') }}</el-col>
                </el-row>
              </el-form-item>
            </div>
            <div v-if="form.datatype == 'enum'">
              <el-form-item :label="$t('template.paramter.038405-40')">
                <el-select v-model="form.specs.showWay" :placeholder="$t('template.paramter.038405-41')" style="width: 175px">
                  <el-option key="select" :label="$t('template.paramter.038405-42')" value="select"></el-option>
                  <el-option key="button" :label="$t('template.paramter.038405-43')" value="button"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item :label="$t('template.paramter.038405-44')" prop="">
                <el-row v-for="(item, index) in form.specs.enumList" :key="'enum' + index" style="margin-bottom: 10px">
                  <el-col :span="8">
                    <el-input v-model="item.value" :placeholder="$t('template.paramter.038405-45')" size="small" />
                  </el-col>
                  <el-col :span="11" :offset="1">
                    <el-input v-model="item.text" :placeholder="$t('template.paramter.038405-46')" size="small" />
                  </el-col>
                  <el-col :span="3" :offset="1" v-if="index != 0"><a style="color: #f56c6c" @click="removeEnumItem(index)">{{ $t('template.paramter.038405-47') }}</a></el-col>
                </el-row>
                <div>
                  +
                  <a style="color: #409eff" @click="addEnumItem()">{{ $t('template.paramter.038405-48') }}</a>
                </div>
              </el-form-item>
            </div>
            <div v-if="form.datatype == 'string'">
              <el-form-item :label="$t('template.paramter.038405-49')" prop="">
                <el-row>
                  <el-col :span="10">
                    <el-input v-model="form.specs.maxLength" :placeholder="$t('template.paramter.038405-50')" type="number" size="small" />
                  </el-col>
                </el-row>
              </el-form-item>
            </div>
          </el-form>
        </el-col>
      </el-row>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">{{ $t('template.paramter.038405-51') }}</el-button>
        <el-button @click="cancel">{{ $t('template.paramter.038405-52') }}</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style>
.specsColor {
  background-color: #fcfcfc;
}
</style>

<script>
import { listTemplate } from '@/api/iot/template';
export default {
  name: 'things_parameter',
  dicts: ['iot_things_type', 'iot_data_type', 'iot_yes_no'],
  props: {
    data: {
      type: Object,
      default: null,
    },
  },
  watch: {
    data: function (newVal, oldVal) {
      this.index = newVal.index;
      if (newVal && newVal.parameter.name && newVal.parameter.name != '') {
        this.form.name = newVal.parameter.name;
        this.form.id = newVal.parameter.id;
        this.form.order = newVal.parameter.order;
        this.form.isChart = newVal.parameter.isChart ? newVal.parameter.isChart : 0;
        this.form.isHistory = newVal.parameter.isHistory ? newVal.parameter.isHistory : 1;
        this.form.isSharePerm = newVal.parameter.isSharePerm ? newVal.parameter.isSharePerm : 0;
        this.form.isMonitor = newVal.parameter.isMonitor ? newVal.parameter.isMonitor : 0;
        this.form.isReadonly = newVal.parameter.isReadonly ? newVal.parameter.isReadonly : 0;
        this.form.specs = newVal.parameter.datatype;
        this.form.datatype = this.form.specs.type;
        if (!this.form.specs.enumList) {
          this.form.specs.enumList = [
            {
              value: '',
              text: '',
            },
          ];
        }
        if (!this.form.specs.arrayType) {
          this.form.specs.arrayType = 'int';
        }
      }
      this.openEdit = true;
      this.getList();
    },
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 总条数
      total: 0,
      // 通用物模型表格数据
      templateList: [],
      // 是否显示弹出层
      openEdit: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        type: null,
      },
      // 参数索引
      index: -1,
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        name: [
          {
            required: true,
            message: this.$t('template.paramter.038405-53'),
            trigger: 'blur',
          },
        ],
        id: [
          {
            required: true,
            message: this.$t('template.paramter.038405-54'),
            trigger: 'blur',
          },
        ],
        order: [
          {
            required: true,
            message: this.$t('template.paramter.038405-55'),
            trigger: 'blur',
          },
        ],
        datatype: [
          {
            required: true,
            message: this.$t('template.paramter.038405-56'),
            trigger: 'change',
          },
        ],
      },
    };
  },
  created() {
    this.getList();
    this.reset();
  },
  methods: {
    /** 查询通用物模型列表 */
    getList() {
      this.loading = true;
      listTemplate(this.queryParams).then((response) => {
        //模板列表初始化isSelect值，用于单选
        for (let i = 0; i < response.rows.length; i++) {
          response.rows[i].isSelect = false;
        }
        this.templateList = response.rows;
        this.total = response.total;
        this.setRadioSelected(this.productId);
        this.loading = false;
      });
    },
    /** 单选数据 */
    rowClick(item) {
      if (item != null && item.datatype != 'array' && item.datatype != 'object') {
        this.form.name = item.templateName;
        this.form.id = item.identifier;
        this.form.order = item.modelOrder;
        this.form.isChart = item.isChart ? item.isChart : 0;
        this.form.isHistory = item.isHistory ? item.isHistory : 1;
        this.form.isSharePerm = item.isSharePerm ? item.isSharePerm : 0;
        this.form.isReadonly = item.isReadonly ? item.isReadonly : 0;
        this.form.isMonitor = item.isMonitor ? item.isMonitor : 0;
        this.form.datatype = item.datatype;
        // Json转对象
        this.form.specs = JSON.parse(item.specs);
        if (!this.form.specs.enumList) {
          this.form.specs.enumList = [
            {
              value: '',
              text: '',
            },
          ];
        }
        if (!this.form.specs.arrayType) {
          this.form.specs.arrayType = 'int';
        }
        this.setRadioSelected(item.templateId);
      }
    },
    /** 设置单选按钮选中 */
    setRadioSelected(templateId) {
      for (let i = 0; i < this.templateList.length; i++) {
        if (this.templateList[i].templateId == templateId) {
          this.templateList[i].isSelect = true;
        } else {
          this.templateList[i].isSelect = false;
        }
      }
    },
    // 取消按钮
    cancel() {
      this.openEdit = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.index = -1;
      this.form = {
        name: null,
        id: null,
        order: 0,
        datatype: 'integer',
        isChart: 0,
        isHistory: 1,
        isSharePerm: 0,
        isMonitor: 0,
        isReadonly: 0,
        specs: {
          enumList: [
            {
              value: '',
              text: '',
            },
          ],
          showWay: 'select', // 显示方式select=下拉选择框，button=按钮
        },
      };
      this.resetForm('form');
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          // 格式化datatype
          this.form.datatype = this.formatThingsSpecs();
          // 清空不需要存储数据
          delete this.form.specs;
          this.openEdit = false;
          // 返回参数对象
          let data = {
            parameter: JSON.parse(JSON.stringify(this.form)),
            index: this.index,
          };
          console.log('data', data);
          this.$emit('dataEvent', data);
          this.reset();
        }
      });
    },
    // 是否图表展示改变
    isChartChange() {
      if (this.form.isChart == 1) {
        this.form.isReadonly = 1;
      } else {
        this.form.isMonitor = 0;
      }
    },
    // 是否实时监测改变
    isMonitorChange() {
      if (this.form.isMonitor == 1) {
        this.form.isReadonly = 1;
        this.form.isChart = 1;
      }
    },
    // 是否只读数据改变
    isReadonlyChange() {
      if (this.form.isReadonly == 0) {
        this.form.isMonitor = 0;
        this.form.isChart = 0;
      }
    },
    // 格式化物模型
    formatThingsSpecs() {
      var data = {};
      data.type = this.form.datatype;
      if (this.form.datatype == 'integer' || this.form.datatype == 'decimal') {
        data.min = Number(this.form.specs.min ? this.form.specs.min : 0);
        data.max = Number(this.form.specs.max ? this.form.specs.max : 100);
        data.unit = this.form.specs.unit ? this.form.specs.unit : '';
        data.step = Number(this.form.specs.step ? this.form.specs.step : 1);
      } else if (this.form.datatype == 'string') {
        data.maxLength = Number(this.form.specs.maxLength ? this.form.specs.maxLength : 1024);
      } else if (this.form.datatype == 'bool') {
        data.falseText = this.form.specs.falseText ? this.form.specs.falseText : this.$t('template.paramter.038405-57');
        data.trueText = this.form.specs.trueText ? this.form.specs.trueText : this.$t('template.paramter.038405-58');
      } else if (this.form.datatype == 'array') {
        data.arrayType = this.form.specs.arrayType;
      } else if (this.form.datatype == 'enum') {
        data.showWay = this.form.specs.showWay;
        if (this.form.specs.enumList && this.form.specs.enumList[0].text != '') {
          data.enumList = this.form.specs.enumList;
        } else {
          data.showWay = 'select';
          data.enumList = [
            {
              value: '0',
              text: this.$t('template.paramter.038405-59'),
            },
            {
              value: '1',
              text: this.$t('template.paramter.038405-60'),
            },
          ];
        }
      }
      return data;
    },
    /** 添加枚举项 */
    addEnumItem() {
      this.form.specs.enumList.push({
        value: '',
        text: '',
      });
    },
    /** 删除枚举项 */
    removeEnumItem(index) {
      this.form.specs.enumList.splice(index, 1);
    },
  },
};
</script>
