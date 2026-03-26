<template>
    <div class="post-wrap">
        <!-- 搜索栏 -->
        <el-card shadow="never" class="search-card" v-show="showSearch">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
                <el-form-item :label="$t('system.post.236590-0')" prop="postCode">
                    <el-input v-model="queryParams.postCode" :placeholder="$t('system.post.236590-1')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.post.236590-2')" prop="postName">
                    <el-input v-model="queryParams.postName" :placeholder="$t('system.post.236590-3')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.post.236590-4')" prop="status">
                    <el-select v-model="queryParams.status" :placeholder="$t('system.post.236590-4')" clearable>
                        <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <!-- 操作按钮和数据表格 -->
        <el-card shadow="never" class="table-card">
            <el-row :gutter="10" style="margin-bottom: 15px">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['system:post:add']">{{ $t('add') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['system:post:edit']">{{ $t('update') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:post:remove']">{{ $t('del') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['system:post:export']">{{ $t('export') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table v-loading="loading" :data="postList" @selection-change="handleSelectionChange" header-cell-class-name="table-header" :border="false">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column :label="$t('system.post.236590-5')" align="center" prop="postId" />
                <el-table-column :label="$t('system.post.236590-0')" align="center" prop="postCode" />
                <el-table-column :label="$t('system.post.236590-2')" align="center" prop="postName" />
                <el-table-column :label="$t('system.post.236590-6')" align="center" prop="postSort" />
                <el-table-column :label="$t('system.post.236590-4')" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime) }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:post:edit']">{{ $t('update') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:post:remove']">{{ $t('del') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pagination-container">
                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
            </div>

            <!-- 添加或修改岗位对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                    <el-form-item :label="$t('system.post.236590-2')" prop="postName">
                        <el-input v-model="form.postName" :placeholder="$t('system.post.236590-3')" />
                    </el-form-item>
                    <el-form-item :label="$t('system.post.236590-0')" prop="postCode">
                        <el-input v-model="form.postCode" :placeholder="$t('system.post.236590-1')" />
                    </el-form-item>
                    <el-form-item :label="$t('system.post.236590-6')" prop="postSort">
                        <el-input-number v-model="form.postSort" controls-position="right" :min="0" />
                    </el-form-item>
                    <el-form-item :label="$t('system.post.236590-4')" prop="status">
                        <el-radio-group v-model="form.status">
                            <el-radio v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item :label="$t('remark')" prop="remark">
                        <el-input v-model="form.remark" type="textarea" :placeholder="$t('plzInput')" />
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm">{{ $t('confirm') }}</el-button>
                    <el-button @click="cancel">{{ $t('cancel') }}</el-button>
                </div>
            </el-dialog>
        </el-card>
    </div>
</template>

<script>
import { listPost, getPost, delPost, addPost, updatePost } from '@/api/system/post';

export default {
    name: 'Post',
    dicts: ['sys_normal_disable'],
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
            // 岗位表格数据
            postList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                postCode: undefined,
                postName: undefined,
                status: undefined,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                postName: [{ required: true, message: this.$t('system.post.236590-7'), trigger: 'blur' }],
                postCode: [{ required: true, message: this.$t('system.post.236590-8'), trigger: 'blur' }],
                postSort: [{ required: true, message: this.$t('system.post.236590-9'), trigger: 'blur' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询岗位列表 */
        getList() {
            this.loading = true;
            listPost(this.queryParams).then((response) => {
                this.postList = response.rows;
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
                postId: undefined,
                postCode: undefined,
                postName: undefined,
                postSort: 0,
                status: '0',
                remark: undefined,
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
            this.ids = selection.map((item) => item.postId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.post.236590-10');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const postId = row.postId || this.ids;
            getPost(postId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.post.236590-11');
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.postId != undefined) {
                        updatePost(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addPost(this.form).then((response) => {
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
            const postIds = row.postId || this.ids;
            this.$modal
                .confirm(this.$t('system.post.236590-12', [postIds]))
                .then(function () {
                    return delPost(postIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('delSuccess'));
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'system/post/export',
                {
                    ...this.queryParams,
                },
                `post_${new Date().getTime()}.xlsx`
            );
        },
    },
};
</script>

<style lang="scss" scoped>
.post-wrap {
    padding: 15px;
    min-height: 100vh;
    background-color: #f5f7fa;
}

.search-card {
    margin-bottom: 15px;
    border-radius: 8px;

    ::v-deep .el-card__body {
        padding: 18px 18px 0 18px;
    }
}

.table-card {
    border-radius: 8px;

    ::v-deep .el-card__body {
        padding: 18px;
    }
}

.table-header {
    background-color: #f5f7fa !important;
    color: #606266;
    font-weight: 600;
}

::v-deep .el-table {
    th {
        background-color: #f5f7fa;
        color: #606266;
        font-weight: 600;
    }

    td {
        padding: 12px 0;
    }
}

.pagination-container {
    line-height: 40px;
    margin-bottom: 30px;
    margin-top: 0;
    padding: 0;
}

::v-deep .el-pagination {
    padding: 20px 0 0 0;
    text-align: right;
}

::v-deep .el-button--mini {
    padding: 7px 12px;
    font-size: 13px;
}

::v-deep .el-input__inner,
::v-deep .el-select__input {
    height: 32px;
    line-height: 32px;
    border-radius: 4px;
}

::v-deep .el-form-item {
    margin-bottom: 18px;
}
</style>
