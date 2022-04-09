<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="新闻标题" prop="newsName">
        <el-input
          v-model="queryParams.newsName"
          placeholder="请输入新闻标题"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <!-- <el-form-item label="新闻封面" prop="newsCover">
        <el-input
          v-model="queryParams.newsCover"
          placeholder="请输入新闻封面"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item> -->
      <el-form-item label="是否置顶" prop="newsIsTop">
        <el-select v-model="queryParams.newsIsTop" placeholder="请选择是否置顶(0-置顶 1-置顶)" clearable size="small">
          <el-option
            v-for="dict in dict.type.iot_yes_no"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否banner" prop="newsIsBanner">
        <el-select v-model="queryParams.newsIsBanner" placeholder="请选择是否banner(0-是banner 1-不是banner)" clearable size="small">
          <el-option
            v-for="dict in dict.type.iot_yes_no"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <!-- <el-form-item label="分类ID" prop="classifyId">
        <el-input
          v-model="queryParams.classifyId"
          placeholder="请输入分类ID"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item> -->
      <el-form-item label="分类名称" prop="classifyName">
        <el-select v-model="queryParams.classifyId" clearable size="small">
          <el-option
            v-for="classifyin in classifyinfo"
            :key="classifyin.id"
            :label="classifyin.label"
            :value="classifyin.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="新闻状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择新闻状态" clearable size="small">
          <el-option
            v-for="dict in dict.type.iot_is_enable"
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
          v-hasPermi="['iot:news:add']"
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
          v-hasPermi="['iot:news:edit']"
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
          v-hasPermi="['iot:news:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['iot:news:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="newsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="新闻ID" align="center" prop="newsId" />
      <el-table-column label="新闻标题" align="center" prop="newsName" />
      <!-- <el-table-column label="新闻内容" align="center" prop="newsContent" /> -->
      <el-table-column label="新闻封面" align="center" prop="newsCover" >
        <template slot-scope="scope">
          <img :src="scope.row.newsCover"/>
        </template>
      </el-table-column>
      <el-table-column label="是否置顶" align="center" prop="newsIsTop">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.newsIsTop"/>
        </template>
      </el-table-column>
      <el-table-column label="是否banner" align="center" prop="newsIsBanner">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.newsIsBanner"/>
        </template>
      </el-table-column>
      <!-- <el-table-column label="分类ID" align="center" prop="classifyId" />
      <el-table-column label="分类名称" align="center" prop="classifyName" /> -->
      <el-table-column label="新闻状态" align="center" prop="status">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.iot_is_enable" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['iot:news:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['iot:news:remove']"
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

    <!-- 添加或修改新闻对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="1000px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="新闻标题" prop="newsName">
          <el-input v-model="form.newsName" placeholder="请输入新闻标题" />
        </el-form-item>
        <el-form-item label="新闻内容">
          <editor v-model="form.newsContent" :min-height="192"/>
          <!-- <my-quill-editor v-model="form.newsContent"/> -->
        </el-form-item>
        <el-form-item label="新闻封面">
          <imageUpload ref="image-upload" :value="form.newsCover" :limit="1" :fileSize="1" @input="getImagePath($event)"></imageUpload>
          <!-- <el-upload v-model="form.newsCover" :min-height="192" /> -->
        </el-form-item>
        <el-form-item label="是否置顶" prop="newsIsTop">
          <el-select v-model="form.newsIsTop" placeholder="请选择是否置顶(0-置顶 1-置顶)">
            <el-option
              v-for="dict in dict.type.iot_yes_no"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="是否banner" prop="newsIsBanner">
          <el-select v-model="form.newsIsBanner" placeholder="请选择是否banner(0-是banner 1-不是banner)">
            <el-option
              v-for="dict in dict.type.iot_yes_no"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="新闻状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择新闻状态">
            <el-option
              v-for="dict in dict.type.iot_is_enable"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <!-- <el-form-item label="分类ID" prop="classifyId">
          <el-input v-model="form.classifyId" placeholder="请输入分类ID" />
        </el-form-item> -->
        <el-form-item label="分类">
          <el-checkbox v-model="menuNodeAll" @change="handleCheckedTreeNodeAll($event, 'classify')">全选/全不选</el-checkbox>
          <el-tree
            class="tree-border"
            :data="classifyOptions"
            show-checkbox
            ref="classify"
            node-key="id"
            :check-strictly="!form.menuCheckStrictly"
            empty-text="加载中，请稍候"
            :props="defaultProps"
          ></el-tree>
        </el-form-item>
        <!-- <el-form-item label="删除标志" prop="delFlag">
          <el-input v-model="form.delFlag" placeholder="请输入删除标志" />
        </el-form-item> -->
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
import { listNews, getNews, delNews, addNews, updateNews } from "@/api/news/news";
import imageUpload from "../../../components/ImageUpload/index"
import {treeselect,classifyNewsTreeselect } from "@/api/news/classify";
import MyQuillEditor from '../../../components/quill/course-rich-text'
export default {
  name: "News",
  dicts: ['iot_yes_no', 'iot_yes_no', 'iot_is_enable'],
  components: {
        imageUpload,
        MyQuillEditor
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
      // 新闻表格数据
      newsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 列表
      classifyOptions: [],
      classifyinfo: [],
      menuCheckStrictly: true,
      menuNodeAll: false,
      defaultProps: {
        children: "children",
        label: "label"
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        newsName: null,
        newsContent: null,
        newsCover: null,
        newsIsTop: null,
        newsIsBanner: null,
        classifyId: null,
        // classifyName: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        newsName: [
          { required: true, message: "新闻标题不能为空", trigger: "blur" }
        ],
        newsContent: [
          { required: true, message: "新闻内容不能为空", trigger: "blur" }
        ],
        newsCover: [
          { required: true, message: "新闻封面不能为空", trigger: "blur" }
        ],
        newsIsTop: [
          { required: true, message: "是否置顶(0-置顶 1-置顶)不能为空", trigger: "change" }
        ],
        newsIsBanner: [
          { required: true, message: "是否banner(0-是banner 1-不是banner)不能为空", trigger: "change" }
        ],
        // classifyId: [
        //   { required: true, message: "分类ID不能为空", trigger: "blur" }
        // ],
        // classifyName: [
        //   { required: true, message: "分类名称不能为空", trigger: "blur" }
        // ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询新闻列表 */
    getList() {
      this.getClassifyTreeselects();
      this.loading = true;
      listNews(this.queryParams).then(response => {
        this.newsList = response.rows;
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
      this.menuNodeAll = false;
      if (this.$refs.classify != undefined) {
        this.$refs.classify.setCheckedKeys([]);
      }
      this.form = {
        newsId: null,
        newsName: null,
        newsContent: null,
        newsCover: null,
        newsIsTop: null,
        newsIsBanner: null,
        classifyId: null,
        classifyName: null,
        status: null,
        delFlag: null,
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
      this.resetForm("queryForm");
      this.queryParams.classifyId = [];
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.newsId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.getClassifyTreeselect();
      this.form.newsContent = null;
      this.open = true;
      this.title = "添加新闻";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const newsId = row.newsId || this.ids
      const roleMenu = this.getClassifyNewTreeselect(newsId);
      getNews(newsId).then(response => {
        this.form = response.data;
        this.open = true;
        this.$nextTick(() => {
          roleMenu.then(res => {
            debugger;
            let checkedKeys = res.checkedKeys
            checkedKeys.forEach((v) => {
                this.$nextTick(()=>{
                    this.$refs.classify.setChecked(v, true ,false);
                })
            })
          });
        });
        this.title = "修改新闻";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          let classifyIds = [];
            this.classifyOptions.forEach(classify => {
              classifyIds.push(classify.id)
            });
            this.form.classifyId = classifyIds;
          if (this.form.newsId != null) {
            updateNews(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            let classifyIds = [];
            this.classifyOptions.forEach(classify => {
              classifyIds.push(classify.id)
            });
            this.form.classifyId = classifyIds;
            addNews(this.form).then(response => {
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
      const newsIds = row.newsId || this.ids;
      this.$modal.confirm('是否确认删除新闻编号为"' + newsIds + '"的数据项？').then(function() {
        return delNews(newsIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('iot/news/export', {
        ...this.queryParams
      }, `news_${new Date().getTime()}.xlsx`)
    },
    /**获取上传图片的路径 */
    getImagePath(data) {
      debugger;
      this.form.newsCover = data;
    },
    /** 查询分类树结构 */
    getClassifyTreeselect() {
      treeselect().then(response => {
        this.classifyOptions = response.data;
      });
    },

    /** 查询分类树结构 */
    getClassifyTreeselects() {
      treeselect().then(response => {
        this.classifyinfo = response.data;
        console.log(this.classifyinfo)
      });
    },
     // 树权限（全选/全不选）
    handleCheckedTreeNodeAll(value, type) {
      if (type == 'classify') {
        this.$refs.classify.setCheckedNodes(value ? this.classifyOptions: []);
      }
    },
    /** 根据角色ID查询菜单树结构 */
    getClassifyNewTreeselect(newsId) {
      return classifyNewsTreeselect(newsId).then(response => {
        this.classifyOptions = response.menus;
        return response;
      });
    },
  
  }
};
</script>
