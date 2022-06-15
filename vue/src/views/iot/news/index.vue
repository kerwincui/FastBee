<template>
<div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="60px" v-if="isAdmin">
        <el-form-item label="标题" prop="title">
            <el-input v-model="queryParams.title" placeholder="请输入标题" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="分类" prop="categoryName">
            <el-input v-model="queryParams.categoryName" placeholder="请输入分类名称" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="置顶" prop="isTop">
            <el-select v-model="queryParams.isTop" placeholder="是否置顶" clearable size="small" style="width:100px;">
                <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
        </el-form-item>
        <el-form-item label="轮播" prop="isBanner">
            <el-select v-model="queryParams.isBanner" placeholder="是否轮播" clearable size="small" style="width:100px;">
                <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
        </el-form-item>

        <el-form-item label="发布" prop="status">
            <el-select v-model="queryParams.status" placeholder="选择状态" clearable size="small" style="width:100px;">
                <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:news:add']">新增</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:news:edit']">修改</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:news:remove']">删除</el-button>
        </el-col>
        <el-col :span="1.5">
            <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['iot:news:export']">导出</el-button>
        </el-col>
        <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="newsList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="图片" align="center" prop="imgUrl" width="140px;">
            <template slot-scope="scope">
                <el-image style="border-radius:5px;height:80px;width:120px;margin-bottom:-5px;" lazy :preview-src-list="[baseUrl+scope.row.imgUrl]" :src="baseUrl+scope.row.imgUrl" fit="cover"></el-image>
            </template>
        </el-table-column>
        <el-table-column label="标题" align="center" prop="title" />        
        <el-table-column label="分类" align="center" prop="categoryName">
            <template slot-scope="scope">
                <el-tag type="info">{{scope.row.categoryName}}</el-tag>
            </template>
        </el-table-column>
        <el-table-column label="作者" align="center" prop="author" width="100" />
        <el-table-column label="置顶" align="center" prop="isTop" width="80">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isTop" />
            </template>
        </el-table-column>
        <el-table-column label="轮播" align="center" prop="isBanner" width="80">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isBanner" />
            </template>
        </el-table-column>
        <el-table-column label="发布" align="center" prop="status" width="80">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.status" />
            </template>
        </el-table-column>

        <el-table-column label="创建时间" align="center" prop="createTime" width="120">
            <template slot-scope="scope">
                <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
            </template>
        </el-table-column>
        <el-table-column label="备注" align="center" prop="remark" />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
                <el-button size="mini" type="text" icon="el-icon-view" @click="openDetailDialog(scope.row.newsId)">查看</el-button>
                <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:news:edit']">修改</el-button>
                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:news:remove']">删除</el-button>
            </template>
        </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改新闻资讯对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="60px">
            <el-row :gutter="20">
                <el-col :span="12">
                    <el-form-item label="标题" prop="title">
                        <el-input v-model="form.title" placeholder="请输入标题" />
                    </el-form-item>
                    <el-form-item label="作者" prop="author">
                        <el-input v-model="form.author" placeholder="请输入作者" />
                    </el-form-item>
                    <el-form-item label="摘要" prop="remark">
                        <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="3" />
                    </el-form-item>
                    <el-row>
                        <el-col :span="8">
                            <el-form-item label="置顶" prop="isTop">
                                <el-switch v-model="form.isTop" active-text="" inactive-text="" :active-value="1" :inactive-value="0"></el-switch>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="轮播" prop="isBanner">
                                <el-switch v-model="form.isBanner" active-text="" inactive-text="" :active-value="1" :inactive-value="0"></el-switch>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="发布" prop="status">
                                <el-switch v-model="form.status" active-text="" inactive-text="" :active-value="1" :inactive-value="0"></el-switch>
                            </el-form-item>
                        </el-col>
                    </el-row>

                </el-col>
                <el-col :span="12">
                    <el-form-item label="分类" prop="categoryId">
                        <el-select v-model="form.categoryId" placeholder="请选择分类" @change="selectCategory">
                            <el-option v-for="category in categoryList" :key="category.id" :label="category.name" :value="category.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="图片">
                        <imageUpload ref="image-upload" :value="form.imgUrl" :limit="1" :fileSize="1" @input="getImagePath($event)"></imageUpload>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-form-item label="内容">
                <editor v-model="form.content" :min-height="192" />
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm">确 定</el-button>
            <el-button @click="cancel">取 消</el-button>
        </div>
    </el-dialog>

    <!--通知公告详情 -->
    <el-dialog :title="form.title" :visible.sync="openDetail" width="800px" append-to-body>
        <div style="margin-top:-20px;margin-bottom:10px;">
            <el-tag size="mini" effect="dark" type="success">{{form.categoryName}}</el-tag>
            <span style="margin-left:20px;">{{form.createTime}}</span>
        </div>
        <div v-loading="loadingDetail" class="content">
            <div v-html="form.content"></div>
        </div>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="closeDetail"> 关 闭 </el-button>
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
                    message: "标题不能为空",
                    trigger: "blur"
                }],
                content: [{
                    required: true,
                    message: "内容不能为空",
                    trigger: "blur"
                }],
                categoryId: [{
                    required: true,
                    message: "分类不能为空",
                    trigger: "blur"
                }],
                author: [{
                    required: true,
                    message: "作者不能为空",
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
                content: "暂无内容",
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
            this.title = "添加新闻资讯";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const newsId = row.newsId || this.ids
            getNews(newsId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改新闻资讯";
            });
        },
        /** 提交按钮 */
        submitForm() {
            console.log(this.form);
            if (this.form.imgUrl == null || this.form.imgUrl == "") {
                this.$modal.msgError("请上传图片");
                return;
            }
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.newsId != null) {
                        updateNews(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
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
            this.$modal.confirm('是否确认删除新闻资讯编号为"' + newsIds + '"的数据项？').then(function () {
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
            this.titleDetail = "详情";
            this.openDetail = false;
            this.reset();
        },
    }
};
</script>

<style lang="scss" scoped>
.content {
    line-height: 24px;
    padding: 10px;
    border: 1px solid #eee;
    border-radius: 10px;
}
</style>
