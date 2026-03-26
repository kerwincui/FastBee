<template>
    <div class="newsCategory_wrap">
        <el-card shadow="never" class="search-card" v-show="showSearch">
            <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
                <el-form-item :label="$t('system.newsCategory.874509-0')" prop="categoryName">
                    <el-input v-model="queryParams.categoryName" :placeholder="$t('system.news.893410-3')" clearable size="small" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('device.index.105953-8') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('device.index.105953-9') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card shadow="never">
            <el-row :gutter="10" class="mb8">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['iot:newsCategory:add']">{{ $t('system.sysclient.652154-4') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:newsCategory:edit']">{{ $t('system.sysclient.652154-5') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:newsCategory:remove']">{{ $t('system.sysclient.652154-6') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['iot:newsCategory:export']">{{ $t('system.sysclient.652154-7') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table v-loading="loading" :data="categoryList" @selection-change="handleSelectionChange" :border="false">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column :label="$t('system.newsCategory.874509-1')" align="center" prop="categoryId" />
                <el-table-column :label="$t('system.newsCategory.874509-0')" align="center" prop="categoryName" />
                <el-table-column :label="$t('system.newsCategory.874509-2')" align="center" prop="orderNum" />
                <el-table-column :label="$t('device.index.105953-33')" align="center" prop="createTime" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('iot.group.index.637432-9')" align="center" prop="remark" min-width="200" header-align="center" />
                <el-table-column :label="$t('device.index.105953-34')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button size="small" type="text" icon="el-icon-view" @click="handleUpdate(scope.row)" v-hasPermi="['iot:newsCategory:add']">{{ $t('device.index.105953-60') }}</el-button>
                        <el-button size="small" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:newsCategory:remove']">{{ $t('system.sysclient.652154-6') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pagination-container">
                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
            </div>

            <!-- 添加或修改新闻分类对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                    <el-form-item :label="$t('system.newsCategory.874509-0')" prop="categoryName">
                        <el-input v-model="form.categoryName" :placeholder="$t('system.news.893410-3')" />
                    </el-form-item>
                    <el-form-item :label="$t('system.newsCategory.874509-2')" prop="orderNum">
                        <el-input-number v-model="form.orderNum" :placeholder="$t('system.newsCategory.874509-3')" type="number" controls-position="right" style="width: 100%" />
                    </el-form-item>
                    <el-form-item :label="$t('iot.group.index.637432-9')" prop="remark">
                        <el-input v-model="form.remark" type="textarea" :placeholder="$t('iot.group.index.637432-16')" />
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:newsCategory:edit']" v-show="form.categoryId">{{ $t('iot.group.index.637432-17') }}</el-button>
                    <el-button type="primary" @click="submitForm" v-hasPermi="['iot:newsCategory:add']" v-show="!form.categoryId">{{ $t('iot.group.index.637432-18') }}</el-button>
                    <el-button @click="cancel">{{ $t('iot.group.index.637432-19') }}</el-button>
                </div>
            </el-dialog>
        </el-card>
    </div>
</template>

<script>
import { listNewsCategory, getNewsCategory, delNewsCategory, addNewsCategory, updateNewsCategory } from '@/api/iot/newsCategory';

export default {
    name: 'Category',
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
            // 新闻分类表格数据
            categoryList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                categoryName: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                categoryName: [
                    {
                        required: true,
                        message: this.$t('system.newsCategory.874509-4'),
                        trigger: 'blur',
                    },
                ],
                orderNum: [
                    {
                        required: true,
                        message: this.$t('system.newsCategory.874509-5'),
                        trigger: 'blur',
                    },
                ],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询新闻分类列表 */
        getList() {
            this.loading = true;
            listNewsCategory(this.queryParams).then((response) => {
                this.categoryList = response.rows;
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
                categoryId: null,
                categoryName: null,
                orderNum: null,
                delFlag: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null,
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
            this.ids = selection.map((item) => item.categoryId);
            this.single = selection.length !== 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.newsCategory.874509-6');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const categoryId = row.categoryId || this.ids;
            getNewsCategory(categoryId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.newsCategory.874509-7');
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.categoryId != null) {
                        updateNewsCategory(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-24'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addNewsCategory(this.form).then((response) => {
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
            const categoryIds = row.categoryId || this.ids;
            let msg = '';
            this.$modal
                .confirm(this.$t('system.newsCategory.874509-8', [categoryIds]))
                .then(function () {
                    return delNewsCategory(categoryIds).then((response) => {
                        msg = response.msg;
                    });
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(msg);
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'iot/newsCategory/export',
                {
                    ...this.queryParams,
                },
                `category_${new Date().getTime()}.xlsx`
            );
        },
    },
};
</script>

<style lang="scss" scoped>
.newsCategory_wrap {
    background-color: #f5f7fa !important;
    padding: 15px;
    min-height: 100vh;
    .search-card {
        margin-bottom: 10px;
        padding: 3px 0;

        ::v-deep .el-card__body {
            padding: 18px 18px 0 18px;
        }
    }
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
