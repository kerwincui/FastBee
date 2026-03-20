<template>
    <!-- 导入表 -->
    <el-dialog :title="$t('tool.import.670901-0')" :visible.sync="visible" width="800px" top="5vh" append-to-body>
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true">
            <el-form-item :label="$t('tool.import.670901-1')" prop="dataName">
                <el-select v-model="queryParams.dataName" size="small" :placeholder="$t('tool.import.670901-2')" style="width: 100%" :clearable="true">
                    <el-option v-for="(item, index) in dataSources" :key="index" :label="item" :value="item"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('tool.import.670901-3')" prop="tableName">
                <el-input v-model="queryParams.tableName" :placeholder="$t('tool.import.670901-4')" clearable @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('tool.import.670901-5')" prop="tableComment">
                <el-input v-model="queryParams.tableComment" :placeholder="$t('tool.import.670901-6')" clearable @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
            </el-form-item>
        </el-form>
        <el-row>
            <el-table @row-click="clickRow" ref="table" :data="dbTableList" @selection-change="handleSelectionChange" height="260px">
                <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column prop="tableName" :label="$t('tool.import.670901-3')" :show-overflow-tooltip="true"></el-table-column>
                <el-table-column prop="tableComment" :label="$t('tool.import.670901-5')" :show-overflow-tooltip="true"></el-table-column>
                <el-table-column prop="createTime" :label="$t('tool.import.670901-7')"></el-table-column>
                <el-table-column prop="updateTime" :label="$t('tool.import.670901-8')"></el-table-column>
            </el-table>
            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
        </el-row>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="handleImportTable">{{ $t('confirm') }}</el-button>
            <el-button @click="visible = false">{{ $t('cancel') }}</el-button>
        </div>
    </el-dialog>
</template>

<script>
import { listDbTable, importTable, listDataSource } from '@/api/tool/gen';
export default {
    data() {
        return {
            // 遮罩层
            visible: false,
            // 选中数组值
            tables: [],
            // 总条数
            total: 0,
            // 表数据
            dbTableList: [],
            dataSources: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                tableName: undefined,
                tableComment: undefined,
                dataName: 'master',
            },
        };
    },
    methods: {
        // 显示弹框
        show() {
            this.getList();
            this.visible = true;
        },
        clickRow(row) {
            this.$refs.table.toggleRowSelection(row);
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.tables = selection.map((item) => item.tableName);
        },
        // 查询表数据
        getList() {
            listDbTable(this.queryParams).then((res) => {
                if (res.code === 200) {
                    this.dbTableList = res.rows;
                    this.total = res.total;
                }
            });
        },
        //获取数据源
        handleDataSource() {
            this.loading = true;
            listDataSource().then((response) => {
                this.dataSources = response.data;
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
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 导入按钮操作 */
        handleImportTable() {
            const tableNames = this.tables.join(',');
            const params = {
                tables: tableNames,
                dataName: this.queryParams.dataName,
            };
            if (tableNames == '') {
                this.$modal.msgError(this.$i18n.t('tool.import.670901-9'));
                return;
            }
            importTable(params).then((res) => {
                this.$modal.msgSuccess(res.msg);
                if (res.code === 200) {
                    this.visible = false;
                    this.$emit('ok');
                }
            });
        },
    },
};
</script>
