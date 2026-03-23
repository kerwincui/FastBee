<template>
    <div class="app-container">
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="60px" v-if="isAdmin">
            <el-form-item :label="$t('system.news.893410-0')" prop="title">
                <el-input v-model="queryParams.title" :placeholder="$t('system.news.893410-1')" clearable size="small"
                    @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('system.news.893410-2')" prop="categoryName">
                <el-input v-model="queryParams.categoryName" :placeholder="$t('system.news.893410-3')" clearable size="small"
                    @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('system.news.893410-4')" prop="isTop">
                <el-select v-model="queryParams.isTop" :placeholder="$t('system.news.893410-5')" clearable size="small" style="width:100px;">
                    <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label"
                        :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('system.news.893410-6')" prop="isBanner">
                <el-select v-model="queryParams.isBanner" :placeholder="$t('system.news.893410-7')" clearable size="small" style="width:100px;">
                    <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label"
                        :value="dict.value" />
                </el-select>
            </el-form-item>

            <el-form-item :label="$t('system.news.893410-8')" prop="status">
                <el-select v-model="queryParams.status" :placeholder="$t('system.news.893410-9')" clearable size="small" style="width:100px;">
                    <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label"
                        :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('device.index.105953-8') }}</el-button>
                <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('device.index.105953-9') }}</el-button>
            </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd"
                    v-hasPermi="['iot:news:add']">{{ $t('system.sysclient.652154-4') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate"
                    v-hasPermi="['iot:news:edit']">{{ $t('system.sysclient.652154-5') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete"
                    v-hasPermi="['iot:news:remove']">{{ $t('system.sysclient.652154-6') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport"
                    v-hasPermi="['iot:news:export']">{{ $t('system.sysclient.652154-7') }}</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="newsList" header-cell-class-name="table-header" :border="false" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column :label="$t('system.news.893410-10')" align="center" prop="imgUrl" width="140px;">
                <template slot-scope="scope">
                    <el-image style="border-radius:5px;height:80px;width:120px;margin-bottom:-5px;" lazy
                        :preview-src-list="[baseUrl + scope.row.imgUrl]" :src="baseUrl + scope.row.imgUrl"
                        fit="cover"></el-image>
                </template>
            </el-table-column>
            <el-table-column :label="$t('system.news.893410-0')" align="center" prop="title" />
            <el-table-column :label="$t('system.news.893410-2')" align="center" prop="categoryName">
                <template slot-scope="scope">
                    <el-tag type="info">{{ scope.row.categoryName }}</el-tag>
                </template>
            </el-table-column>
            <el-table-column :label="$t('system.news.893410-11')" align="center" prop="author" width="100" />
            <el-table-column :label="$t('system.news.893410-4')" align="center" prop="isTop" width="80">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isTop" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('system.news.893410-6')" align="center" prop="isBanner" width="80">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isBanner" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('system.news.893410-8')" align="center" prop="status" width="80">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.status" />
                </template>
            </el-table-column>

            <el-table-column :label="$t('device.index.105953-33')" align="center" prop="createTime" width="120">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.group.index.637432-9')" align="center" prop="remark" />
            <el-table-column :label="$t('device.index.105953-34')" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="small" type="text" icon="el-icon-view"
                        @click="openDetailDialog(scope.row.newsId)">{{ $t('system.news.893410-25') }}</el-button>
                    <el-button size="small" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)"
                        v-hasPermi="['iot:news:edit']">{{ $t('system.sysclient.652154-5') }}</el-button>
                    <el-button size="small" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)"
                        v-hasPermi="['iot:news:remove']">{{ $t('system.sysclient.652154-6') }}</el-button>
                </template>
            </el-table-column>
        </el-table>

        <div class="pagination-container">
        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
            @pagination="getList" />
        </div>

        <!-- 添加或修改新闻资讯对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="60px">
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item :label="$t('system.news.893410-0')" prop="title">
                            <el-input v-model="form.title" :placeholder="$t('system.news.893410-1')" />
                        </el-form-item>
                        <el-form-item :label="$t('system.news.893410-11')" prop="author">
                            <el-input v-model="form.author" :placeholder="$t('system.news.893410-12')" />
                        </el-form-item>
                        <el-form-item :label="$t('system.news.893410-13')" prop="remark">
                            <el-input v-model="form.remark" type="textarea" :placeholder="$t('iot.group.index.637432-16')" rows="3" />
                        </el-form-item>
                        <el-row>
                            <el-col :span="8">
                                <el-form-item :label="$t('system.news.893410-4')" prop="isTop">
                                    <el-switch v-model="form.isTop" active-text="" inactive-text="" :active-value="1"
                                        :inactive-value="0"></el-switch>
                                </el-form-item>
                            </el-col>
                            <el-col :span="8">
                                <el-form-item :label="$t('system.news.893410-6')" prop="isBanner">
                                    <el-switch v-model="form.isBanner" active-text="" inactive-text="" :active-value="1"
                                        :inactive-value="0"></el-switch>
                                </el-form-item>
                            </el-col>
                            <el-col :span="8">
                                <el-form-item :label="$t('system.news.893410-8')" prop="status">
                                    <el-switch v-model="form.status" active-text="" inactive-text="" :active-value="1"
                                        :inactive-value="0"></el-switch>
                                </el-form-item>
                            </el-col>
                        </el-row>

                    </el-col>
                    <el-col :span="12">
                        <el-form-item :label="$t('system.news.893410-2')" prop="categoryId">
                            <el-select v-model="form.categoryId" :placeholder="$t('system.news.893410-14')" @change="selectCategory">
                                <el-option v-for="category in categoryList" :key="category.id" :label="category.name"
                                    :value="category.id"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item :label="$t('system.news.893410-10')">
                            <imageUpload ref="image-upload" :value="form.imgUrl" :limit="1" :fileSize="1"
                                @input="getImagePath($event)"></imageUpload>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item :label="$t('system.news.893410-15')">
                    <editor v-model="form.content" :min-height="192" />
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">{{ $t('device.index.105953-56') }}</el-button>
                <el-button @click="cancel">{{ $t('iot.group.index.637432-19') }}</el-button>
            </div>
        </el-dialog>

        <!--通知公告详情 -->
        <el-dialog :title="form.title" :visible.sync="openDetail" width="800px" append-to-body>
            <div style="margin-top:-20px;margin-bottom:10px;">
                <el-tag size="small" effect="dark" type="success">{{ form.categoryName }}</el-tag>
                <span style="margin-left:20px;">{{ form.createTime }}</span>
            </div>
            <div v-loading="loadingDetail" class="content">
                <div v-html="form.content"></div>
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="closeDetail"> {{ $t('device.device-edit.148398-57') }} </el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import {
    listNews,
    getNews,
    delNews,
    addNews,
    updateNews
} from "@/api/iot/news";
import {
    listShortNewsCategory
} from '@/api/iot/newsCategory'
import imageUpload from "../../../components/ImageUpload/index"

export default {
    name: "News",
    dicts: ['iot_yes_no'],
    components: {
        imageUpload
    },
    data() {
        return {
            // 是否为管理员
            isAdmin: false,
            // 详情加载
            loadingDetail: false,
            // 打开详情
            openDetail: false,
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
            // 新闻资讯表格数据
            newsList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 分类列表
            categoryList: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                title: null,
                isTop: null,
                isBanner: null,
                categoryName: null,
                status: '1', // 默认为发布
            },
            // 表单参数
            form: {},
            baseUrl: process.env.VUE_APP_BASE_API,
            // 表单校验
            rules: {
                title: [{
                    required: true,
                    message: this.$t('system.news.893410-16'),
                    trigger: "blur"
                }],
                content: [{
                    required: true,
                    message: this.$t('system.news.893410-17'),
                    trigger: "blur"
                }],
                categoryId: [{
                    required: true,
                    message: this.$t('system.news.893410-18'),
                    trigger: "blur"
                }],
                author: [{
                    required: true,
                    message: this.$t('system.news.893410-19'),
                    trigger: "blur"
                }],
            }
        };
    },
    created() {
        this.getList();
        this.init();

    },
    methods: {
        init() {
            if (this.$store.state.user.roles.indexOf("tenant") === -1 && this.$store.state.user.roles.indexOf("general") === -1) {
                this.isAdmin = true
                // 获取分类列表
                listShortNewsCategory().then(response => {
                    this.categoryList = response.data;
                })
            }
        },
        /** 查询新闻资讯列表 */
        getList() {
            this.loading = true;
            listNews(this.queryParams).then(response => {
                this.newsList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /**获取上传图片的路径 */
        getImagePath(data) {
            this.form.imgUrl = data;
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 表单重置
        reset() {
            this.form = {
                newsId: null,
                title: null,
                content: this.$t('system.news.893410-20'),
                imgUrl: "",
                isTop: null,
                isBanner: null,
                categoryId: null,
                categoryName: null,
                status: null,
                author: null,
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
            this.handleQuery();
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map(item => item.newsId)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.news.893410-21');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const newsId = row.newsId || this.ids
            getNews(newsId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.news.893410-22');
            });
        },
        /** 提交按钮 */
        submitForm() {
            console.log(this.form);
            if (this.form.imgUrl == null || this.form.imgUrl == "") {
                this.$modal.msgError(this.$t('system.news.893410-23'));
                return;
            }
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.newsId != null) {
                        updateNews(this.form).then(response => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-24'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addNews(this.form).then(response => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-25'));
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
            this.$modal.confirm(this.$t('system.news.893410-24', [newsIds])).then(function () {
                return delNews(newsIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess(this.$t('iot.group.index.637432-27'));
            }).catch(() => { });
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/news/export', {
                ...this.queryParams
            }, `news_${new Date().getTime()}.xlsx`)
        },
        /** 选择分类 */
        selectCategory(val) {
            for (var i = 0; i < this.categoryList.length; i++) {
                if (this.categoryList[i].id == val) {
                    this.form.categoryName = this.categoryList[i].name;
                    return;
                }
            }
        },
        // 打开信息详情
        openDetailDialog(newsId) {
            this.openDetail = true;
            this.loadingDetail = true;
            getNews(newsId).then(response => {
                this.form = response.data;
                this.openDetail = true;
                this.loadingDetail = false;
            });
        },
        // 取消按钮
        closeDetail() {
            this.titleDetail = this.$t('system.news.893410-25');
            this.openDetail = false;
            this.reset();
        },
    }
};
</script>

<style lang="scss" scoped>.content {
    line-height: 24px;
    padding: 10px;
    border: 1px solid #eee;
    border-radius: 10px;
}</style>

</script>

<style lang="scss" scoped>
.table-header {
  background-color: #f5f7fa !important;
  color: #606266;
  font-weight: 600;
  text-align: center;
}

::v-deep .el-table {
  th {
    background-color: #f5f7fa;
    color: #606266;
    font-weight: 600;
    text-align: center;
  }
  
  td {
    padding: 12px 0;
  }
  
  .el-table__body tr:hover > td {
    background-color: #f5f7fa !important;
  }
}

.pagination-container {
    line-height: 40px;
    margin-bottom: 30px;
    margin-top: 0;
    padding: 0;
}

::v-deep .el-pagination {
  padding: 0;
  text-align: right;
}
</style>
