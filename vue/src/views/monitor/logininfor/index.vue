<template>
    <div class="app-container">
        <el-card shadow="never" class="search-card">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
                <el-form-item :label="$t('monitor.logininfor.670912-0')" prop="ipaddr">
                    <el-input v-model="queryParams.ipaddr" :placeholder="$t('monitor.logininfor.670912-1')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('monitor.logininfor.670912-2')" prop="userName">
                    <el-input v-model="queryParams.userName" :placeholder="$t('monitor.logininfor.670912-3')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('monitor.logininfor.670912-4')" prop="status">
                    <el-select v-model="queryParams.status" :placeholder="$t('monitor.logininfor.670912-5')" clearable style="width: 240px">
                        <el-option v-for="dict in dict.type.sys_common_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('monitor.logininfor.670912-6')">
                    <el-date-picker
                        v-model="dateRange"
                        style="width: 240px"
                        value-format="yyyy-MM-dd"
                        type="daterange"
                        range-separator="-"
                        :start-placeholder="$t('monitor.logininfor.670912-7')"
                        :end-placeholder="$t('monitor.logininfor.670912-8')"
                    ></el-date-picker>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>

            <el-row :gutter="10" class="mb8">
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['monitor:logininfor:remove']">{{ $t('del') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" @click="handleClean" v-hasPermi="['monitor:logininfor:remove']">{{ $t('clean') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-unlock" size="small" :disabled="single" @click="handleUnlock" v-hasPermi="['monitor:logininfor:unlock']">
                        {{ $t('monitor.logininfor.670912-9') }}
                    </el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['monitor:logininfor:export']">{{ $t('export') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table
                ref="tables"
                v-loading="loading"
                :data="list"
                :border="false"
                header-cell-class-name="table-header"
                @selection-change="handleSelectionChange"
                :default-sort="defaultSort"
                @sort-change="handleSortChange"
            >
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column :label="$t('monitor.logininfor.670912-10')" align="center" prop="infoId" />
                <el-table-column :label="$t('monitor.logininfor.670912-2')" align="center" prop="userName" :show-overflow-tooltip="true" sortable="custom" :sort-orders="['descending', 'ascending']" />
                <el-table-column :label="$t('monitor.logininfor.670912-0')" align="center" prop="ipaddr" width="130" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('monitor.logininfor.670912-11')" align="center" prop="loginLocation" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('monitor.logininfor.670912-12')" align="center" prop="browser" :show-overflow-tooltip="true" />
                <el-table-column :label="$t('monitor.logininfor.670912-13')" align="center" prop="os" />
                <el-table-column :label="$t('monitor.logininfor.670912-4')" align="center" prop="status">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_common_status" :value="scope.row.status" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('monitor.logininfor.670912-14')" align="center" prop="msg" />
                <el-table-column :label="$t('monitor.logininfor.670912-6')" align="center" prop="loginTime" sortable="custom" :sort-orders="['descending', 'ascending']" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.loginTime) }}</span>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
        </el-card>
    </div>
</template>

<script>
import { list, delLogininfor, cleanLogininfor, unlockLogininfor } from '@/api/monitor/logininfor';

export default {
    name: 'Logininfor',
    dicts: ['sys_common_status'],
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
            // 选择用户名
            selectName: '',
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 表格数据
            list: [],
            // 日期范围
            dateRange: [],
            // 默认排序
            defaultSort: { prop: 'loginTime', order: 'descending' },
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                ipaddr: undefined,
                userName: undefined,
                status: undefined,
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询登录日志列表 */
        getList() {
            this.loading = true;
            list(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.list = response.rows;
                this.total = response.total;
                this.loading = false;
            });
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
            this.queryParams.pageNum = 1;
            this.$refs.tables.sort(this.defaultSort.prop, this.defaultSort.order);
        },
        /** 多选框选中数据 */
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.infoId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
            this.selectName = selection.map((item) => item.userName);
        },
        /** 排序触发事件 */
        handleSortChange(column, prop, order) {
            this.queryParams.orderByColumn = column.prop;
            this.queryParams.isAsc = column.order;
            this.getList();
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const infoIds = row.infoId || this.ids;
            this.$modal
                .confirm(this.$t('monitor.logininfor.670912-15', [infoIds]))
                .then(function () {
                    return delLogininfor(infoIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('delSuccess'));
                })
                .catch(() => {});
        },
        /** 清空按钮操作 */
        handleClean() {
            this.$modal
                .confirm(this.$t('monitor.logininfor.670912-16'))
                .then(function () {
                    return cleanLogininfor();
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('cleanSuccess'));
                })
                .catch(() => {});
        },
        /** 解锁按钮操作 */
        handleUnlock() {
            const username = this.selectName;
            this.$modal
                .confirm(this.$t('monitor.logininfor.670912-17', [username]))
                .then(function () {
                    return unlockLogininfor(username);
                })
                .then(() => {
                    this.$modal.msgSuccess(this.$t('monitor.logininfor.670912-18', [username]));
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'monitor/logininfor/export',
                {
                    ...this.queryParams,
                },
                `logininfor_${new Date().getTime()}.xlsx`
            );
        },
    },
};
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
.search-card {
    margin-bottom: 15px;
    border-radius: 8px;

    ::v-deep .el-card__body {
        padding: 18px 18px 0 18px;
    }
}
</style>
