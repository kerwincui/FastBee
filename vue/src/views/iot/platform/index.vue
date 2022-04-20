<template>
  <div class="app-container">
    <el-form v-show="showSearch" ref="queryForm" :inline="true" :model="queryParams" label-width="85px">
      <el-form-item label="第三方平台" prop="platform">
        <el-select v-model="queryParams.platform" clearable placeholder="请选择第三方平台" size="small">
          <el-option
            v-for="dict in dict.type.iot_social_platform"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" clearable placeholder="请选择 0:启用 ,1:禁用" size="small">
          <el-option
            v-for="dict in dict.type.iot_social_platform_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
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
          v-hasPermi="['iot:platform:add']"
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
          v-hasPermi="['iot:platform:edit']"
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
          v-hasPermi="['iot:platform:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['iot:platform:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="platformList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column align="center" label="登录平台主键" prop="socialPlatformId"/>
      <el-table-column align="center" label="第三方平台" prop="platform">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.iot_social_platform" :value="scope.row.platform"/>
        </template>
      </el-table-column>
      <el-table-column align="center" label="状态" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.iot_social_platform_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="第三方平台申请Id" align="center" prop="clientId"/>
      <el-table-column label="第三方平台密钥" align="center" prop="secretKey"/>
      <el-table-column label="用户认证后跳转地址" align="center" prop="redirectUri"/>
      <el-table-column align="center" label="创建者" prop="createBy"/>
      <el-table-column align="center" label="创建时间" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="更新时间" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="更新者" prop="updateBy"/>
      <el-table-column align="center" label="备注" prop="remark"/>
      <el-table-column align="center" label="绑定注册登录uri,http://localhost/login?bindId=" prop="bindUri"/>
      <el-table-column align="center" label="跳转登录uri,http://localhost/login?loginId=" prop="redirectLoginUri"/>
      <el-table-column align="center" label="错误提示uri,http://localhost/login?errorId=" prop="errorMsgUri"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['iot:platform:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['iot:platform:remove']"
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

    <!-- 添加或修改第三方登录平台控制对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="第三方平台" prop="platform">
          <el-select v-model="form.platform" placeholder="请选择第三方平台">
            <el-option
              v-for="dict in dict.type.iot_social_platform"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label=" 0:启用 ,1:禁用" prop="status">
          <el-select v-model="form.status" placeholder="请选择 0:启用 ,1:禁用">
            <el-option
              v-for="dict in dict.type.iot_social_platform_status"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="第三方平台申请Id" prop="clientId">
          <el-input v-model="form.clientId" placeholder="请输入第三方平台申请Id"/>
        </el-form-item>
        <el-form-item label="第三方平台密钥" prop="secretKey">
          <el-input v-model="form.secretKey" placeholder="请输入第三方平台密钥"/>
        </el-form-item>
        <el-form-item label="用户认证后跳转地址" prop="redirectUri">
          <el-input v-model="form.redirectUri" placeholder="请输入用户认证后跳转地址"/>
        </el-form-item>
        <el-form-item label="删除标记位(0代表存在，2代表删除)" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标记位(0代表存在，2代表删除)"/>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入内容" type="textarea"/>
        </el-form-item>
        <el-form-item label="绑定注册登录uri,http://localhost/login?bindId=" prop="bindUri">
          <el-input v-model="form.bindUri" placeholder="请输入绑定注册登录uri,http://localhost/login?bindId="/>
        </el-form-item>
        <el-form-item label="跳转登录uri,http://localhost/login?loginId=" prop="redirectLoginUri">
          <el-input v-model="form.redirectLoginUri" placeholder="请输入跳转登录uri,http://localhost/login?loginId="/>
        </el-form-item>
        <el-form-item label="错误提示uri,http://localhost/login?errorId=" prop="errorMsgUri">
          <el-input v-model="form.errorMsgUri" placeholder="请输入错误提示uri,http://localhost/login?errorId="/>
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
import {addPlatform, delPlatform, getPlatform, listPlatform, updatePlatform} from "@/api/iot/platform";

export default {
  name: "Platform",
  dicts: ['iot_social_platform', 'iot_social_platform_status'],
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
      // 第三方登录平台控制表格数据
      platformList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        platform: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        platform: [
          {required: true, message: "第三方平台不能为空", trigger: "change"}
        ],
        status: [
          {required: true, message: " 0:启用 ,1:禁用不能为空", trigger: "change"}
        ],
        clientId: [
          {required: true, message: "第三方平台申请Id不能为空", trigger: "blur"}
        ],
        secretKey: [
          {required: true, message: "第三方平台密钥不能为空", trigger: "blur"}
        ],
        redirectUri: [
          {required: true, message: "用户认证后跳转地址不能为空", trigger: "blur"}
        ],
        bindUri: [
          {required: true, message: "绑定注册登录uri,http://localhost/login?bindId=不能为空", trigger: "blur"}
        ],
        redirectLoginUri: [
          {required: true, message: "跳转登录uri,http://localhost/login?loginId=不能为空", trigger: "blur"}
        ],
        errorMsgUri: [
          {required: true, message: "错误提示uri,http://localhost/login?errorId=不能为空", trigger: "blur"}
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询第三方登录平台控制列表 */
    getList() {
      this.loading = true;
      listPlatform(this.queryParams).then(response => {
        this.platformList = response.rows;
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
        socialPlatformId: null,
        platform: null,
        status: null,
        clientId: null,
        secretKey: null,
        redirectUri: null,
        delFlag: null,
        createBy: null,
        createTime: null,
        updateTime: null,
        updateBy: null,
        remark: null,
        bindUri: null,
        redirectLoginUri: null,
        errorMsgUri: null
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
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.socialPlatformId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加第三方登录平台控制";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const socialPlatformId = row.socialPlatformId || this.ids
      getPlatform(socialPlatformId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改第三方登录平台控制";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.socialPlatformId != null) {
            updatePlatform(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addPlatform(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const socialPlatformIds = row.socialPlatformId || this.ids;
      this.$modal.confirm('是否确认删除第三方登录平台控制编号为"' + socialPlatformIds + '"的数据项？').then(function() {
        return delPlatform(socialPlatformIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('iot/platform/export', {
        ...this.queryParams
      }, `platform_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
