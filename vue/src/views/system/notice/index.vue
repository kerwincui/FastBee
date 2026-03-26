<template>
    <div class="notice-wrap">
        <!-- 搜索栏 -->
        <el-card shadow="never" class="search-card">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
                <el-form-item :label="$t('system.notice.670989-0')" prop="noticeTitle">
                    <el-input v-model="queryParams.noticeTitle" :placeholder="$t('system.notice.670989-1')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.notice.670989-2')" prop="createBy">
                    <el-input v-model="queryParams.createBy" :placeholder="$t('system.notice.670989-3')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.notice.670989-4')" prop="noticeType">
                    <el-select v-model="queryParams.noticeType" :placeholder="$t('system.notice.670989-5')" clearable>
                        <el-option v-for="dict in dict.type.sys_notice_type" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <!-- 操作按钮和数据表格 -->
        <el-card shadow="never" class="table-card">
            <el-row :gutter="10" style="margin-bottom: 15px">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['system:notice:add']">{{ $t('add') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['system:notice:edit']">{{ $t('edit') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:notice:remove']">{{ $t('del') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table v-loading="loading" :data="noticeList" @selection-change="handleSelectionChange" header-cell-class-name="table-header" :border="false">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column :label="$t('system.notice.670989-15')" align="center" prop="noticeId" width="100" />
                <el-table-column :label="$t('system.notice.670989-0')" align="center" prop="noticeTitle" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('system.notice.670989-5')" align="center" prop="noticeType" width="100">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_notice_type" :value="scope.row.noticeType" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('status')" align="center" prop="status" width="100">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_notice_status" :value="scope.row.status" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('system.notice.670989-8')" align="center" prop="createBy" width="100" />
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="100">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:notice:edit']">{{ $t('edit') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:notice:remove']">{{ $t('del') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

            <!-- 添加或修改公告对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="780px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                    <el-row>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.notice.670989-0')" prop="noticeTitle">
                                <el-input v-model="form.noticeTitle" :placeholder="$t('system.notice.670989-1')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.notice.670989-5')" prop="noticeType">
                                <el-select v-model="form.noticeType" :placeholder="$t('system.notice.670989-6')">
                                    <el-option v-for="dict in dict.type.sys_notice_type" :key="dict.value" :label="dict.label" :value="dict.value"></el-option>
                                </el-select>
                            </el-form-item>
                        </el-col>
                        <el-col :span="24">
                            <el-form-item :label="$t('status')">
                                <el-radio-group v-model="form.status">
                                    <el-radio v-for="dict in dict.type.sys_notice_status" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="24">
                            <el-form-item :label="$t('system.notice.670989-7')">
                                <editor v-model="form.noticeContent" :min-height="192" />
                            </el-form-item>
                        </el-col>
                    </el-row>
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
import { listNotice, getNotice, delNotice, addNotice, updateNotice } from '@/api/system/notice';

export default {
    name: 'Notice',
    dicts: ['sys_notice_status', 'sys_notice_type'],
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
            // 公告表格数据
            noticeList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                noticeTitle: undefined,
                createBy: undefined,
                status: undefined,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                noticeTitle: [{ required: true, message: this.$t('system.notice.670989-9'), trigger: 'blur' }],
                noticeType: [{ required: true, message: this.$t('system.notice.670989-10'), trigger: 'change' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询公告列表 */
        getList() {
            this.loading = true;
            listNotice(this.queryParams).then((response) => {
                this.noticeList = response.rows;
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
                noticeId: undefined,
                noticeTitle: undefined,
                noticeType: undefined,
                noticeContent: undefined,
                status: '0',
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
            this.ids = selection.map((item) => item.noticeId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.notice.670989-11');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const noticeId = row.noticeId || this.ids;
            getNotice(noticeId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.notice.670989-12');
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.noticeId != undefined) {
                        updateNotice(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addNotice(this.form).then((response) => {
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
            const noticeIds = row.noticeId || this.ids;
            this.$modal
                .confirm(this.$t('system.notice.670989-13', [noticeIds]))
                .then(function () {
                    return delNotice(noticeIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('delSuccess'));
                })
                .catch(() => {});
        },
    },
};
</script>

<style lang="scss" scoped>
.notice-wrap {
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
