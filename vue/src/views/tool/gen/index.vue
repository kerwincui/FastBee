<template>
    <div class="app-container">
        <!-- 搜索栏 - 上栏 -->
        <el-card shadow="never" class="search-card" v-show="showSearch">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
                <el-form-item :label="$t('gen.import.832346-1')" prop="tableName">
                    <el-input v-model="queryParams.tableName" :placeholder="$t('gen.import.832346-2')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('gen.import.832346-3')" prop="tableComment">
                    <el-input v-model="queryParams.tableComment" :placeholder="$t('gen.import.832346-4')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('creatTime')">
                    <el-date-picker
                        v-model="dateRange"
                        style="width: 240px"
                        value-format="yyyy-MM-dd"
                        type="daterange"
                        range-separator="-"
                        :start-placeholder="$t('system.job.log.085689-5')"
                        :end-placeholder="$t('system.job.log.085689-6')"
                    ></el-date-picker>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <!-- 操作按钮和数据表格 - 下栏 -->
        <el-card shadow="never" class="table-card">
            <el-row :gutter="10" style="margin-bottom: 15px">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-download" size="small" :disabled="multiple" @click="handleGenTable" v-hasPermi="['tool:gen:code']">{{ $t('build.index.2090840-3') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="openCreateTable" v-hasRole="['admin']">{{ $t('add') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="info" plain icon="el-icon-upload" size="small" @click="openImportTable" v-hasPermi="['tool:gen:import']">{{ $t('import') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleEditTable" v-hasPermi="['tool:gen:edit']">{{ $t('update') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['tool:gen:remove']">{{ $t('del') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table v-loading="loading" :data="tableList" @selection-change="handleSelectionChange" :border="false" header-cell-class-name="table-header">
                <el-table-column type="selection" align="center" width="55"></el-table-column>
                <el-table-column :label="$t('system.cache.list.093478-1')" type="index" width="50" align="center">
                    <template slot-scope="scope">
                        <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('gen.import.832346-1')" align="center" prop="tableName" :show-overflow-tooltip="true" width="120" />
                <el-table-column :label="$t('gen.import.832346-3')" align="center" prop="tableComment" :show-overflow-tooltip="true" width="120" />
                <el-table-column :label="$t('gen.index.467583-1')" align="center" prop="className" :show-overflow-tooltip="true" width="120" />
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="160" />
                <el-table-column :label="$t('updateTime')" align="center" prop="updateTime" width="160" />
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button type="text" size="small" icon="el-icon-view" @click="handlePreview(scope.row)" v-hasPermi="['tool:gen:preview']">{{ $t('preview') }}</el-button>
                        <el-button type="text" size="small" icon="el-icon-edit" @click="handleEditTable(scope.row)" v-hasPermi="['tool:gen:edit']">{{ $t('edit') }}</el-button>
                        <el-button type="text" size="small" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['tool:gen:remove']">{{ $t('del') }}</el-button>
                        <el-button type="text" size="small" icon="el-icon-refresh" @click="handleSynchDb(scope.row)" v-hasPermi="['tool:gen:edit']">{{ $t('gen.index.467583-3') }}</el-button>
                        <el-button type="text" size="small" icon="el-icon-download" @click="handleGenTable(scope.row)" v-hasPermi="['tool:gen:code']">{{ $t('gen.index.467583-4') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div class="pagination-container">
                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
            </div>
            <!-- Preview -->
            <el-dialog :title="preview.title" :visible.sync="preview.open" width="80%" top="5vh" append-to-body class="scrollbar">
                <el-tabs v-model="preview.activeName">
                    <el-tab-pane v-for="(value, key) in preview.data" :label="key.substring(key.lastIndexOf('/') + 1, key.indexOf('.vm'))" :name="key.substring(key.lastIndexOf('/') + 1, key.indexOf('.vm'))" :key="key">
                        <el-link :underline="false" icon="el-icon-document-copy" v-clipboard:copy="value" v-clipboard:success="clipboardSuccess" style="float: right">{{ $t('device.device-edit.148398-55') }}</el-link>
                        <pre><code class="hljs" v-html="highlightedCode(value, key)"></code></pre>
                    </el-tab-pane>
                </el-tabs>
            </el-dialog>
        </el-card>
        <import-table ref="import" @ok="handleQuery" />
        <create-table ref="create" @ok="handleQuery" />
    </div>
</template>

<script>
import { listTable, previewTable, delTable, genCode, synchDb } from '@/api/tool/gen';
import importTable from './importTable';
import createTable from './createTable';
import hljs from 'highlight.js/lib/highlight';
import 'highlight.js/styles/github-gist.css';
hljs.registerLanguage('java', require('highlight.js/lib/languages/java'));
hljs.registerLanguage('xml', require('highlight.js/lib/languages/xml'));
hljs.registerLanguage('html', require('highlight.js/lib/languages/xml'));
hljs.registerLanguage('vue', require('highlight.js/lib/languages/xml'));
hljs.registerLanguage('javascript', require('highlight.js/lib/languages/javascript'));
hljs.registerLanguage('sql', require('highlight.js/lib/languages/sql'));

export default {
    name: 'Gen',
    components: { importTable, createTable },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 唯一标识符
            uniqueId: '',
            // 选中数组
            ids: [],
            // 选中表数组
            tableNames: [],
            // 非单个禁用
            single: true,
            // 非多个禁用
            multiple: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 表数据
            tableList: [],
            // 日期范围
            dateRange: '',
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                tableName: undefined,
                tableComment: undefined,
            },
            // 预览参数
            preview: {
                open: false,
                title: this.$t('gen.index.467583-5'),
                data: {},
                activeName: 'domain.java',
            },
        };
    },
    created() {
        this.getList();
    },
    activated() {
        const time = this.$route.query.t;
        if (time != null && time != this.uniqueId) {
            this.uniqueId = time;
            this.queryParams.pageNum = Number(this.$route.query.pageNum);
            this.getList();
        }
    },
    methods: {
        /** 查询表集合 */
        getList() {
            this.loading = true;
            listTable(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.tableList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 生成代码操作 */
        handleGenTable(row) {
            const tableNames = row.tableName || this.tableNames;
            if (tableNames == '') {
                this.$modal.msgError(this.$t('gen.index.467583-6'));
                return;
            }
            if (row.genType === '1') {
                genCode(row.tableName).then((response) => {
                    this.$modal.msgSuccess(this.$t('gen.index.467583-7') + row.genPath);
                });
            } else {
                this.$download.zip('/tool/gen/batchGenCode?tables=' + tableNames, 'ruoyi.zip');
            }
        },
        /** 同步数据库操作 */
        handleSynchDb(row) {
            const tableName = row.tableName;
            this.$modal
                .confirm(this.$t('gen.index.467583-8') + tableName + this.$t('gen.index.467583-9'))
                .then(function () {
                    return synchDb(tableName);
                })
                .then(() => {
                    this.$modal.msgSuccess(this.$t('gen.index.467583-10'));
                })
                .catch(() => {});
        },
        /** 打开导入表弹窗 */
        openImportTable() {
            this.$refs.import.show();
        },
        /** 打开创建表弹窗 */
        openCreateTable() {
            this.$refs.create.show();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.dateRange = [];
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 预览按钮 */
        handlePreview(row) {
            previewTable(row.tableId).then((response) => {
                this.preview.data = response.data;
                this.preview.open = true;
                this.preview.activeName = 'domain.java';
            });
        },
        /** 高亮显示 */
        highlightedCode(code, key) {
            const vmName = key.substring(key.lastIndexOf('/') + 1, key.indexOf('.vm'));
            var language = vmName.substring(vmName.indexOf('.') + 1, vmName.length);
            const result = hljs.highlight(language, code || '', true);
            return result.value || '&nbsp;';
        },
        /** 复制代码成功 */
        clipboardSuccess() {
            this.$modal.msgSuccess(this.$t('gen.index.467583-11'));
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.tableId);
            this.tableNames = selection.map((item) => item.tableName);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        /** 修改按钮操作 */
        handleEditTable(row) {
            const tableId = row.tableId || this.ids[0];
            const tableName = row.tableName || this.tableNames[0];
            const params = { pageNum: this.queryParams.pageNum };
            this.$tab.openPage(this.$t('update') + '[' + tableName + ']' + this.$t('gen.index.467583-4'), '/tool/gen-edit/index/' + tableId, params);
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const tableIds = row.tableId || this.ids;
            this.$modal
                .confirm(this.$t('gen.index.467583-12', [tableIds]))
                .then(function () {
                    return delTable(tableIds);
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
.app-container {
    padding: 20px;
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

::v-deep .el-button--small {
    padding: 8px 15px;
    font-size: 13px;
}
</style>
