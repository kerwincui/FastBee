<template>
  <el-form ref="genInfoForm" :model="info" :rules="rules" label-width="150px">
    <el-row>
      <el-col :span="12">
        <el-form-item prop="tplCategory">
          <span slot="label">{{ $t('tool.genInfo.670902-0') }}</span>
          <el-select v-model="info.tplCategory" @change="tplSelectChange">
            <el-option :label="$t('tool.genInfo.670902-1')" value="crud" />
            <el-option :label="$t('tool.genInfo.670902-2')" value="tree" />
            <el-option :label="$t('tool.genInfo.670902-3')" value="sub" />
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item prop="tplWebType">
          <span slot="label">{{ $t('tool.genInfo.670902-4') }}</span>
          <el-select v-model="info.tplWebType">
            <el-option :label="$t('tool.genInfo.670902-5')" value="element-ui" />
            <el-option :label="$t('tool.genInfo.670902-6')" value="element-plus" />
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item prop="packageName">
          <span slot="label">
            {{ $t('tool.genInfo.670902-7') }}
            <el-tooltip :content="$t('tool.genInfo.670902-8')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.packageName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="moduleName">
          <span slot="label">
            {{ $t('tool.genInfo.670902-9') }}
            <el-tooltip :content="$t('tool.genInfo.670902-10')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.moduleName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="businessName">
          <span slot="label">
            {{ $t('tool.genInfo.670902-11') }}
            <el-tooltip :content="$t('tool.genInfo.670902-12')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.businessName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="functionName">
          <span slot="label">
            {{ $t('tool.genInfo.670902-13') }}
            <el-tooltip :content="$t('tool.genInfo.670902-14')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.functionName" />
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item prop="genType">
          <span slot="label">
            {{ $t('tool.genInfo.670902-15') }}
            <el-tooltip :content="$t('tool.genInfo.670902-16')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-radio v-model="info.genType" label="0">{{ $t('tool.genInfo.670902-17') }}</el-radio>
          <el-radio v-model="info.genType" label="1">{{ $t('tool.genInfo.670902-18') }}</el-radio>
        </el-form-item>
      </el-col>

      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            {{ $t('tool.genInfo.670902-19') }}
            <el-tooltip :content="$t('tool.genInfo.670902-20')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <treeselect
            :append-to-body="true"
            v-model="info.parentMenuId"
            :options="menus"
            :normalizer="normalizer"
            :show-count="true"
            :placeholder="$t('tool.genInfo.670902-21')"
          />
        </el-form-item>
      </el-col>

      <el-col :span="24" v-if="info.genType == '1'">
        <el-form-item prop="genPath">
          <span slot="label">
            {{ $t('tool.genInfo.670902-18') }}
            <el-tooltip :content="$t('tool.genInfo.670902-22')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-input v-model="info.genPath">
            <el-dropdown slot="append">
              <el-button type="primary">
                {{ $t('tool.genInfo.670902-23') }}
                <i class="el-icon-arrow-down el-icon--right"></i>
              </el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item @click.native="info.genPath = '/'">{{ $t('tool.genInfo.670902-24') }}</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </el-input>
        </el-form-item>
      </el-col>
    </el-row>

    <el-row v-show="info.tplCategory == 'tree'">
      <h4 class="form-header">{{ $t('tool.genInfo.670902-25') }}</h4>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            {{ $t('tool.genInfo.670902-26') }}
            <el-tooltip :content="$t('tool.genInfo.670902-27')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.treeCode" :placeholder="$t('tool.genInfo.670902-28')">
            <el-option
              v-for="(column, index) in info.columns"
              :key="index"
              :label="column.columnName + '：' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            {{ $t('tool.genInfo.670902-29') }}
            <el-tooltip :content="$t('tool.genInfo.670902-30')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.treeParentCode" :placeholder="$t('tool.genInfo.670902-28')">
            <el-option
              v-for="(column, index) in info.columns"
              :key="index"
              :label="column.columnName + '：' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            {{ $t('tool.genInfo.670902-31') }}
            <el-tooltip :content="$t('tool.genInfo.670902-32')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.treeName" :placeholder="$t('tool.genInfo.670902-28')">
            <el-option
              v-for="(column, index) in info.columns"
              :key="index"
              :label="column.columnName + '：' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
    </el-row>
    <el-row v-show="info.tplCategory == 'sub'">
      <h4 class="form-header">{{ $t('tool.genInfo.670902-33') }}</h4>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            {{ $t('tool.genInfo.670902-34') }}
            <el-tooltip :content="$t('tool.genInfo.670902-35')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.subTableName" :placeholder="$t('tool.genInfo.670902-28')" @change="subSelectChange">
            <el-option
              v-for="(table, index) in tables"
              :key="index"
              :label="table.tableName + '：' + table.tableComment"
              :value="table.tableName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item>
          <span slot="label">
            {{ $t('tool.genInfo.670902-36') }}
            <el-tooltip :content="$t('tool.genInfo.670902-37')" placement="top">
              <i class="el-icon-question"></i>
            </el-tooltip>
          </span>
          <el-select v-model="info.subTableFkName" :placeholder="$t('tool.genInfo.670902-28')">
            <el-option
              v-for="(column, index) in subColumns"
              :key="index"
              :label="column.columnName + '：' + column.columnComment"
              :value="column.columnName"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";

export default {
  components: { Treeselect },
  props: {
    info: {
      type: Object,
      default: null
    },
    tables: {
      type: Array,
      default: null
    },
    menus: {
      type: Array,
      default: []
    },
  },
  data() {
    return {
      subColumns: [],
      rules: {
        tplCategory: [
          { required: true, message: this.$i18n.t('tool.genInfo.670902-38'), trigger: "blur" }
        ],
        packageName: [
          { required: true, message: this.$i18n.t('tool.genInfo.670902-39'), trigger: "blur" }
        ],
        moduleName: [
          { required: true, message: this.$i18n.t('tool.genInfo.670902-40'), trigger: "blur" }
        ],
        businessName: [
          { required: true, message: this.$i18n.t('tool.genInfo.670902-41'), trigger: "blur" }
        ],
        functionName: [
          { required: true, message: this.$i18n.t('tool.genInfo.670902-42'), trigger: "blur" }
        ],
      }
    };
  },
  watch: {
    'info.subTableName': function(val) {
      this.setSubTableColumns(val);
    },
    'info.tplWebType': function(val) {
      if (val === '') {
        this.info.tplWebType = "element-ui";
      }
    }
  },
  methods: {
    /** 转换菜单数据结构 */
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children;
      }
      return {
        id: node.menuId,
        label: node.menuName,
        children: node.children
      };
    },
    /** 选择子表名触发 */
    subSelectChange(value) {
      this.info.subTableFkName = '';
    },
    /** 选择生成模板触发 */
    tplSelectChange(value) {
      if(value !== 'sub') {
        this.info.subTableName = '';
        this.info.subTableFkName = '';
      }
    },
    /** 设置关联外键 */
    setSubTableColumns(value) {
      for (var item in this.tables) {
        const name = this.tables[item].tableName;
        if (value === name) {
          this.subColumns = this.tables[item].columns;
          break;
        }
      }
    }
  }
};
</script>
