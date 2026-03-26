<template>
    <div class="config-wrap">
        <!-- 搜索栏 -->
        <el-card shadow="never" class="search-card">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
                <el-form-item :label="$t('system.config.898564-0')" prop="configName">
                    <el-input v-model="queryParams.configName" :placeholder="$t('system.config.898564-1')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.config.898564-2')" prop="configKey">
                    <el-input v-model="queryParams.configKey" :placeholder="$t('system.config.898564-3')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.config.898564-4')" prop="configType">
                    <el-select v-model="queryParams.configType" :placeholder="$t('system.config.898564-4')" clearable>
                        <el-option v-for="dict in dict.type.sys_yes_no" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('creatTime')">
                    <el-date-picker
                        v-model="dateRange"
                        style="width: 240px"
                        value-format="yyyy-MM-dd"
                        type="daterange"
                        range-separator="-"
                        :start-placeholder="$t('system.dict.index.880996-3')"
                        :end-placeholder="$t('system.dict.index.880996-4')"
                    ></el-date-picker>
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
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['system:config:add']">{{ $t('add') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['system:config:edit']">{{ $t('update') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:config:remove']">{{ $t('del') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['system:config:export']">{{ $t('export') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-refresh" size="small" @click="handleRefreshCache" v-hasPermi="['system:config:remove']">{{ $t('del') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table v-loading="loading" :data="configList" @selection-change="handleSelectionChange" header-cell-class-name="table-header" :border="false">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column :label="$t('system.config.898564-5')" align="center" prop="configId" />
                <el-table-column :label="$t('system.config.898564-0')" align="center" prop="configName" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('system.config.898564-2')" align="center" prop="configKey" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('system.config.898564-6')" align="center" prop="configValue" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('system.config.898564-4')" align="center" prop="configType">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_yes_no" :value="scope.row.configType" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('remark')" align="center" prop="remark" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime) }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:config:edit']">{{ $t('update') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:config:remove']">{{ $t('del') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pagination-container">
                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
            </div>
        </el-card>

        <!-- 添加或修改参数配置对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item :label="$t('system.config.898564-0')" prop="configName">
                    <el-input v-model="form.configName" :placeholder="$t('system.config.898564-1')" />
                </el-form-item>
                <el-form-item :label="$t('system.config.898564-2')" prop="configKey">
                    <el-input v-model="form.configKey" :placeholder="$t('system.config.898564-3')" />
                </el-form-item>
                <el-form-item :label="$t('system.config.898564-6')" prop="configValue">
                    <el-input v-model="form.configValue" type="textarea" :placeholder="$t('system.config.898564-7')" />
                </el-form-item>
                <el-form-item :label="$t('system.config.898564-4')" prop="configType">
                    <el-radio-group v-model="form.configType">
                        <el-radio v-for="dict in dict.type.sys_yes_no" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
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
    </div>
</template>

<script>
import { listConfig, getConfig, delConfig, addConfig, updateConfig, refreshCache } from '@/api/system/config';

export default {
    name: 'Config',
    dicts: ['sys_yes_no'],
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
            // 参数表格数据
            configList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 日期范围
            dateRange: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                configName: undefined,
                configKey: undefined,
                configType: undefined,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                configName: [{ required: true, message: this.$t('system.config.898564-8'), trigger: 'blur' }],
                configKey: [{ required: true, message: this.$t('system.config.898564-9'), trigger: 'blur' }],
                configValue: [{ required: true, message: this.$t('system.config.898564-10'), trigger: 'blur' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询参数列表 */
        getList() {
            this.loading = true;
            listConfig(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.configList = response.rows;
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
                configId: undefined,
                configName: undefined,
                configKey: undefined,
                configValue: undefined,
                configType: 'Y',
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
            this.dateRange = [];
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.config.898564-11');
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.configId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const configId = row.configId || this.ids;
            getConfig(configId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.config.898564-12');
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.configId != undefined) {
                        updateConfig(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addConfig(this.form).then((response) => {
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
            const configIds = row.configId || this.ids;
            this.$modal
                .confirm(this.$t('system.config.898564-13', [configIds]))
                .then(function () {
                    return delConfig(configIds);
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
                'system/config/export',
                {
                    ...this.queryParams,
                },
                `config_${new Date().getTime()}.xlsx`
            );
        },
        /** 刷新缓存按钮操作 */
        handleRefreshCache() {
            refreshCache().then(() => {
                this.$modal.msgSuccess(this.$t('refreshSuccess'));
            });
        },
    },
};
</script>

<style lang="scss" scoped>
.config-wrap {
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
