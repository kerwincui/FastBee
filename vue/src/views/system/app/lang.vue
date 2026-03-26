<template>
  <div class="system-app-lang">
    <el-card v-show="showSearch" style="margin-bottom: 10px">
      <el-form
        @submit.native.prevent
        :model="queryParams"
        ref="queryForm"
        :inline="true"
        label-width="46px"
        style="margin-bottom: -20px"
      >
        <el-form-item prop="langName">
          <el-input
            v-model="queryParams.langName"
            :placeholder="$t('app.lang.755172-14')"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item prop="country">
          <el-input
            v-model="queryParams.country"
            :placeholder="$t('app.lang.755172-12')"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <div style="float: right">
          <el-button type="primary" icon="el-icon-search" @click="handleQuery">{{ $t('search') }}</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">{{ $t('reset') }}</el-button>
        </div>
      </el-form>
    </el-card>

    <el-card>
      <el-row :gutter="10" style="margin-bottom: 16px">
        <el-col :span="1.5">
          <el-button
            type="primary"
            plain
            icon="el-icon-plus"
            size="small"
            @click="handleAdd"
            v-hasPermi="['app:language:add']"
          >
            {{ $t('add') }}
          </el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            plain
            icon="el-icon-delete"
            size="small"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['app:language:remove']"
          >
            {{ $t('del') }}
          </el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            v-hasPermi="['app:language:export']"
            plain
            size="small"
            :loading="exportLoading"
            @click="handleExport"
          >
            {{ $t('app.start.891644-43') }}
          </el-button>
        </el-col>
        <el-col :span="1.5">
          <el-upload v-hasRole="['admin']" :show-file-list="false" ref="upload" action="" :http-request="handleImport">
            <el-button slot="trigger" :loading="importLoading" size="small" plain>
              {{ $t('app.start.891644-44') }}
            </el-button>
          </el-upload>
        </el-col>
        <el-col :span="1.5">
          <el-dropdown v-hasRole="['admin']" @command="handleExportBackendMenu($event, true)">
            <el-button plain size="small">
              {{ $t('app.start.891644-47') }}
              <i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item
                v-for="dict in dict.type.international_configuration_template"
                :key="dict.value"
                :command="dict.value"
              >
                {{ dict.label }}
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-col>
        <el-col :span="1.5">
          <el-dropdown v-hasRole="['admin']" @command="handleExportBackendMenu($event, false)">
            <el-button plain size="small">
              {{ $t('app.start.891644-45') }}
              <i class="el-icon-arrow-down el-icon--right"></i>
            </el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item
                v-for="dict in dict.type.international_configuration_template"
                :key="dict.value"
                :command="dict.value"
              >
                {{ dict.label }}
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-col>
        <el-col :span="1.5">
          <el-dropdown v-hasRole="['admin']" @command="handleImportTranslate">
            <el-upload
              v-hasRole="['admin']"
              :show-file-list="false"
              ref="upload"
              action=""
              :http-request="handleImportBackendMenu"
              :disabled="true"
            >
              <el-button slot="trigger" size="small" plain>
                {{ $t('app.start.891644-46') }}
                <i class="el-icon-arrow-down el-icon--right"></i>
              </el-button>
            </el-upload>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item
                v-for="dict in dict.type.international_configuration_template"
                :key="dict.value"
                :command="dict.value"
              >
                {{ dict.label }}
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </el-col>
        <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
      </el-row>

      <el-table v-loading="loading" :data="languageList" :border="false" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column :label="$t('app.lang.755172-4')" align="center" prop="id" min-width="80" />
        <el-table-column :label="$t('app.lang.755172-8')" align="left" prop="langName" min-width="180" />
        <el-table-column :label="$t('app.lang.755172-5')" align="center" prop="language" min-width="100" />
        <el-table-column :label="$t('app.lang.755172-6')" align="center" prop="country" min-width="120" />
        <el-table-column :label="$t('app.lang.755172-7')" align="center" prop="timeZone" min-width="100" />
        <el-table-column fixed="right" :label="$t('opation')" align="center" width="130">
          <template slot-scope="scope">
            <el-button
              size="small"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['app:language:edit']"
            >
              {{ $t('update') }}
            </el-button>
            <el-button
              size="small"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['app:language:remove']"
            >
              {{ $t('del') }}
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        style="margin-bottom: 20px"
        v-show="total > 0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>

    <!-- 添加或修改app语言对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="560px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="75px">
        <el-form-item :label="$t('app.lang.755172-8')" prop="langName">
          <el-input v-model="form.langName" :placeholder="$t('app.lang.755172-14')" style="width: 390px" />
        </el-form-item>
        <el-form-item :label="$t('app.lang.755172-5')" prop="language">
          <el-input v-model="form.language" :placeholder="$t('app.lang.755172-11')" style="width: 390px" />
        </el-form-item>
        <el-form-item :label="$t('app.lang.755172-6')" prop="country">
          <el-input v-model="form.country" :placeholder="$t('app.lang.755172-12')" style="width: 390px" />
        </el-form-item>
        <el-form-item :label="$t('app.lang.755172-7')" prop="timeZone">
          <el-input v-model="form.timeZone" :placeholder="$t('app.lang.755172-13')" style="width: 390px" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">
          {{ $t('confirm') }}
        </el-button>
        <el-button @click="cancel">
          {{ $t('cancel') }}
        </el-button>
      </div>
    </el-dialog>

    <el-dialog :title="$t('app.lang.755172-22')" :visible.sync="productModelVisible" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item :label="$t('app.lang.755172-23')" prop="productId">
          <el-select v-model="productId" :placeholder="$t('pleaseSelect')">
            <el-option v-for="item in prodcutModels" :key="item.id" :label="item.name" :value="item.id"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitProdcutModel">
          {{ $t('confirm') }}
        </el-button>
        <el-button @click="closeProductModelDialog">
          {{ $t('cancel') }}
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listLanguage,
  getLanguage,
  delLanguage,
  addLanguage,
  updateLanguage,
  exportTranslate,
  importTranslate,
} from '@/api/system/language';
import * as langTransformer from './script/langTransformer';
import * as xlsxHandler from './script/xlsx';
import * as jszip from './script/jszip';
import { downFileByBlob } from '@/utils/common.js';
import { listShortProduct } from '@/api/iot/product';

export default {
  name: 'AppLang',
  dicts: ['international_configuration_template'],
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
      // app语言表格数据
      languageList: [],
      // 弹出层标题
      title: '',
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        langName: '',
        country: '',
        pageNum: 1,
        pageSize: 10,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        langName: [
          {
            required: true,
            message: this.$t('app.lang.755172-14'),
            trigger: 'blur',
          },
        ],
        language: [
          {
            required: true,
            message: this.$t('app.lang.755172-11'),
            trigger: 'blur',
          },
        ],
        country: [
          {
            required: true,
            message: this.$t('app.lang.755172-12'),
            trigger: 'blur',
          },
        ],
      },
      // 导出语言包loading
      exportLoading: false,
      // 导入excel生成语言包loading
      importLoading: false,
      currentLanguage: '',
      currentTranslateModule: '',
      productModelVisible: false,
      prodcutModels: [],
      productId: '',
    };
  },
  created() {
    this.getList();
    this.getProductModels();
  },
  methods: {
    /** 查询app语言列表 */
    getList() {
      this.loading = true;
      listLanguage(this.queryParams).then((response) => {
        this.languageList = response.rows;
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
        language: null,
        country: null,
        timeZone: null,
        createBy: null,
        createTime: null,
        langName: null,
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
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = this.$t('app.lang.755172-17');
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids;
      getLanguage(id).then((response) => {
        this.form = response.data;
        this.open = true;
        this.title = this.$t('app.lang.755172-18');
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          if (this.form.id != null) {
            updateLanguage(this.form).then((response) => {
              this.$modal.msgSuccess(this.$t('updateSuccess'));
              this.open = false;
              this.getList();
            });
          } else {
            addLanguage(this.form).then((response) => {
              this.$modal.msgSuccess(this.$t('addSuccess'));
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal
        .confirm(this.$t('app.lang.755172-21', [ids]))
        .then(function () {
          return delLanguage(ids);
        })
        .then(() => {
          this.getList();
          this.$modal.msgSuccess(this.$t('delSuccess'));
        })
        .catch(() => {});
    },
    // 导出语言包
    handleExport() {
      if (this.languageList.length === 0) {
        return;
      }
      try {
        this.exportLoading = true;
        // 中英文映射
        const langs = this.languageList.reduce((obj, item) => {
          obj[item.language] = item.country;
          return obj;
        }, {});
        // 获取json数据
        const jsonMap = langTransformer.getLangJson();
        // 转换为excel导出需要的数据格式
        const excelData = langTransformer.transoformToExcel(jsonMap, langs);
        // 导出为excel
        xlsxHandler.exportExcel(excelData, 'lang.xlsx');
      } finally {
        this.exportLoading = false;
      }
    },
    // 导入语言包excel直接导出转换后的压缩包
    async handleImport(fileInfo) {
      try {
        this.importLoading = true;
        // 中英文映射
        const langs = this.languageList.reduce((obj, item) => {
          obj[item.country] = item.language;
          return obj;
        }, {});
        // 读取excel文件，解析为json数据
        const data = await xlsxHandler.parseJson(fileInfo.file);
        // 将json文件转换为以模块维度的数据，用于进一步处理成压缩包文件数据
        const jsonData = jszip.parseJsonZipData(data, langs);
        // 生成zip的文件列表
        const files = jszip.generateJsonZipFiles(jsonData);
        // 下载为压缩包
        jszip.downloadFiles2Zip({
          zipName: 'lang',
          files: files,
        });
      } finally {
        this.importLoading = false;
      }
    },
    // 导出菜单名称翻译列表
    async handleExportBackendMenu(value, isSource = false) {
      this.currentTranslateModule = value;
      const exportFn = () => {
        const sourceData = this.dict.type.international_configuration_template;
        const isThingsModel = this.currentTranslateModule === 'things_model';
        exportTranslate(value, isSource, isThingsModel ? this.productId : null).then((response) => {
          let name = sourceData.find((item) => item.value === value).name;
          if (isThingsModel) {
            name += '_' + this.prodcutModels.find((item) => item.id === this.productId).name;
          }
          if (response.type === 'application/json') {
            this.$modal.msgError(`导出异常`);
            return;
          }
          const fileName = isSource ? `${name}原表数据.xlsx` : `${name}翻译数据.xlsx`;
          downFileByBlob(response, fileName);
          isThingsModel && this.closeProductModelDialog();
        });
      };
      if (value === 'things_model') {
        this.productModelVisible = true;
        this.callback = () => {
          exportFn();
        };
      } else {
        exportFn();
      }
    },
    async handleImportBackendMenu(fileInfo) {
      let formData = new FormData();
      formData.append('file', fileInfo.file);
      const isThingsModel = this.currentTranslateModule === 'things_model';
      const productId = isThingsModel && this.productId ? this.productId : '';
      importTranslate(formData, this.currentTranslateModule, productId).then((res) => {
        if (res.code === 200) {
          this.$modal.msgSuccess('导入成功');
        } else {
          this.$modal.msgError(res.msg);
        }
        isThingsModel && this.closeProductModelDialog();
      });
    },
    handleImportTranslate(value) {
      this.currentTranslateModule = value;
      if (value === 'things_model') {
        this.productModelVisible = true;
        this.callback = () => {
          this.$refs.upload.$el.querySelector('input').click();
        };
      } else {
        this.$refs.upload.$el.querySelector('input').click();
      }
    },
    async getProductModels() {
      const params = {
        pageSize: 999,
        showSenior: true,
      };
      const res = await listShortProduct(params);
      if (res.code === 200) {
        this.prodcutModels = res.data || [];
      }
    },
    closeProductModelDialog() {
      this.productModelVisible = false;
      this.productId = '';
    },
    submitProdcutModel() {
      if (!this.productId) {
        this.$message.warning('请选择产品后再确认');
        return;
      }
      this.callback && this.callback(this.productId);
    },
  },
};
</script>

<style lang="scss" scoped>
.system-app-lang {
  padding: 20px;

  .search-card {
    margin-bottom: 15px;
    padding: 3px 0;
  }

  .search-form {
    margin-bottom: -22.5px;
  }
}
</style>
