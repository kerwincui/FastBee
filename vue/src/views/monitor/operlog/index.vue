<template>
    <div class="app-container">
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
            <el-form-item :label="$t('operlog.874509-10')" prop="operIp">
                <el-input v-model="queryParams.operIp" :placeholder="$t('operlog.874509-10')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('operlog.874509-0')" prop="title">
                <el-input v-model="queryParams.title" :placeholder="$t('operlog.874509-1')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('operlog.874509-2')" prop="operName">
                <el-input v-model="queryParams.operName" :placeholder="$t('operlog.874509-3')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('system.notice.670989-4')" prop="businessType">
                <el-select v-model="queryParams.businessType" :placeholder="$t('operlog.874509-4')" clearable style="width: 240px">
                    <el-option v-for="dict in dict.type.sys_oper_type" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('status')" prop="status">
                <el-select v-model="queryParams.status" :placeholder="$t('operlog.874509-5')" clearable style="width: 240px">
                    <el-option v-for="dict in dict.type.sys_common_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('operlog.874509-6')">
                <el-date-picker
                    v-model="dateRange"
                    style="width: 240px"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    type="daterange"
                    range-separator="-"
                    :start-placeholder="$t('system.dict.index.880996-3')"
                    :end-placeholder="$t('system.dict.index.880996-4')"
                    :default-time="['00:00:00', '23:59:59']"
                ></el-date-picker>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
            </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['monitor:operlog:remove']">{{ $t('del') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" @click="handleClean" v-hasPermi="['monitor:operlog:remove']">{{ $t('operlog.874509-7') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['monitor:operlog:export']">{{ $t('export') }}</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table ref="tables" v-loading="loading" :data="list" @selection-change="handleSelectionChange" :default-sort="defaultSort" @sort-change="handleSortChange">
            <el-table-column type="selection" width="50" align="center" />
            <el-table-column :label="$t('operlog.874509-8')" align="center" prop="operId" />
            <el-table-column :label="$t('operlog.874509-0')" align="center" prop="title" :show-overflow-tooltip="true" />
            <el-table-column :label="$t('operlog.874509-4')" align="center" prop="businessType">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.sys_oper_type" :value="scope.row.businessType" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('operlog.874509-2')" align="center" prop="operName" width="110" :show-overflow-tooltip="true" sortable="custom" :sort-orders="['descending', 'ascending']" />
            <el-table-column :label="$t('operlog.874509-10')" align="center" prop="operIp" width="130" :show-overflow-tooltip="true" />
            <el-table-column :label="$t('operlog.874509-11')" align="center" prop="operLocation" :show-overflow-tooltip="true" />
            <el-table-column :label="$t('operlog.874509-30')" align="center" prop="status">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.sys_common_status" :value="scope.row.status" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('operlog.874509-12')" align="center" prop="operTime" width="160" sortable="custom" :sort-orders="['descending', 'ascending']">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.operTime) }}</span>
                </template>
            </el-table-column>
            <el-table-column :label="$t('operlog.874509-31')" align="center" prop="costTime" width="110" :show-overflow-tooltip="true" sortable="custom" :sort-orders="['descending', 'ascending']">
                <template slot-scope="scope">
                    <span>{{ scope.row.costTime }}ms</span>
                </template>
            </el-table-column>
            <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" icon="el-icon-view" @click="handleView(scope.row, scope.index)" v-hasPermi="['monitor:operlog:query']">{{ $t('operlog.874509-13') }}</el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 操作日志详细 -->
        <el-dialog :title="$t('operlog.874509-14')" :visible.sync="open" width="800px" append-to-body>
            <el-form ref="form" :model="form" label-width="100px" size="mini">
                <el-row>
                    <el-col :span="12">
                        <el-form-item :label="$t('operlog.874509-15')">{{ form.title }} / {{ typeFormat(form) }}</el-form-item>
                        <el-form-item :label="$t('operlog.874509-16')">{{ form.operName }} / {{ form.operIp }} / {{ form.operLocation }}</el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item :label="$t('operlog.874509-17')">{{ form.operUrl }}</el-form-item>
                        <el-form-item :label="$t('operlog.874509-18')">{{ form.requestMethod }}</el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item :label="$t('operlog.874509-19')">{{ form.method }}</el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item :label="$t('operlog.874509-20')">{{ form.operParam }}</el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item :label="$t('operlog.874509-21')">{{ form.jsonResult }}</el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item :label="$t('operlog.874509-22')">
                            <div v-if="form.status === 0">{{ $t('operlog.874509-23') }}</div>
                            <div v-else-if="form.status === 1">{{ $t('operlog.874509-24') }}</div>
                        </el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item :label="$t('operlog.874509-31')">{{ form.costTime }}ms</el-form-item>
                    </el-col>
                    <el-col :span="8">
                        <el-form-item :label="$t('operlog.874509-25')">{{ parseTime(form.operTime) }}</el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item :label="$t('operlog.874509-26')" v-if="form.status === 1">{{ form.errorMsg }}</el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="open = false">{{ $t('close') }}</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import { list, delOperlog, cleanOperlog } from '@/api/monitor/operlog';

export default {
    name: 'Operlog',
    dicts: ['sys_oper_type', 'sys_common_status'],
    data() {
        return {
            // 遮罩层
            loading: true,
            // 选中数组
            ids: [],
            // 非多个禁用
            multiple: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 表格数据
            list: [],
            // 是否显示弹出层
            open: false,
            // 日期范围
            dateRange: [],
            // 默认排序
            defaultSort: { prop: 'operTime', order: 'descending' },
            // 表单参数
            form: {},
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                operIp: undefined,
                title: undefined,
                operName: undefined,
                businessType: undefined,
                status: undefined,
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询登录日志 */
        getList() {
            this.loading = true;
            list(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.list = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        // 操作日志类型字典翻译
        typeFormat(row, column) {
            return this.selectDictLabel(this.dict.type.sys_oper_type, row.businessType);
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
            this.ids = selection.map((item) => item.operId);
            this.multiple = !selection.length;
        },
        /** 排序触发事件 */
        handleSortChange(column, prop, order) {
            this.queryParams.orderByColumn = column.prop;
            this.queryParams.isAsc = column.order;
            this.getList();
        },
        /** 详细按钮操作 */
        handleView(row) {
            this.open = true;
            this.form = row;
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const operIds = row.operId || this.ids;
            this.$modal
                .confirm(this.$t('operlog.874509-27', [operIds]))
                .then(function () {
                    return delOperlog(operIds);
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
                .confirm(this.$t('operlog.874509-28'))
                .then(function () {
                    return cleanOperlog();
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('operlog.874509-29'));
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'monitor/operlog/export',
                {
                    ...this.queryParams,
                },
                `operlog_${new Date().getTime()}.xlsx`
            );
        },
    },
};
</script>
