<template>
    <div class="app-container">
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
            <el-form-item :label="$t('system.dict.index.880996-0')" prop="dictName">
                <el-input v-model="queryParams.dictName" :placeholder="$t('system.dict.index.880996-0')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('system.dict.index.880996-1')" prop="dictType">
                <el-input v-model="queryParams.dictType" :placeholder="$t('system.dict.index.880996-1')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('system.dict.index.880996-2')" prop="status">
                <el-select v-model="queryParams.status" :placeholder="$t('system.dict.index.880996-2')" clearable style="width: 240px">
                    <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('system.dict.index.880996-3')" prop="createTimeTime">
                <el-date-picker
                    v-model="dateRange"
                    style="width: 240px"
                    value-format="yyyy-MM-dd"
                    type="daterange"
                    range-separator="-"
                    start-placeholder="$t('system.dict.index.880996-3')"
                    end-placeholder="$t('system.dict.index.880996-4')"
                ></el-date-picker>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('search') }}</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('reset') }}</el-button>
            </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['system:dict:add']">{{ $t('add') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['system:dict:edit']">{{ $t('edit') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:dict:remove']">{{ $t('delete') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['system:dict:export']">{{ $t('export') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-refresh" size="mini" @click="handleRefreshCache" v-hasPermi="['system:dict:remove']">{{ $t('system.dict.index.880996-5') }}</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="typeList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column :label="$t('system.dict.index.880996-6')" align="center" prop="dictId" />
            <el-table-column :label="$t('system.dict.index.880996-0')" align="center" prop="dictName" :show-overflow-tooltip="true" />
            <el-table-column :label="$t('system.dict.index.880996-1')" align="center" :show-overflow-tooltip="true">
                <template slot-scope="scope">
                    <router-link :to="'/system/dict-data/index/' + scope.row.dictId" class="link-type">
                        <span>{{ scope.row.dictType }}</span>
                    </router-link>
                </template>
            </el-table-column>
            <el-table-column :label="$t('status')" align="center" prop="status">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
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
                    <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:dict:edit']">{{ $t('edit') }}</el-button>
                    <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:dict:remove']">{{ $t('del') }}</el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改参数配置对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item :label="$t('system.dict.index.880996-0')" prop="dictName">
                    <el-input v-model="form.dictName" :placeholder="$t('system.dict.index.880996-0')" />
                </el-form-item>
                <el-form-item :label="$t('system.dict.index.880996-1')" prop="dictType">
                    <el-input v-model="form.dictType" :placeholder="$t('system.dict.index.880996-1')" />
                </el-form-item>
                <el-form-item :label="$t('status')" prop="status">
                    <el-radio-group v-model="form.status">
                        <el-radio v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item :label="$t('remark')" prop="remark">
                    <el-input v-model="form.remark" type="textarea" :placeholder="$t('plzInput')"></el-input>
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
import { listType, getType, delType, addType, updateType, refreshCache } from '@/api/system/dict/type';

export default {
    name: 'Dict',
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
            // 字典表格数据
            typeList: [],
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
                dictName: undefined,
                dictType: undefined,
                status: undefined,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                dictName: [{ required: true, message: this.$t('system.dict.index.880996-7'), trigger: 'blur' }],
                dictType: [{ required: true, message: this.$t('system.dict.index.880996-8'), trigger: 'blur' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询字典类型列表 */
        getList() {
            this.loading = true;
            listType(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.typeList = response.rows;
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
                dictId: undefined,
                dictName: undefined,
                dictType: undefined,
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
            this.dateRange = [];
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.dict.index.880996-9');
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.dictId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const dictId = row.dictId || this.ids;
            getType(dictId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.dict.index.880996-10');
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.dictId != undefined) {
                        updateType(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addType(this.form).then((response) => {
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
            const dictIds = row.dictId || this.ids;
            this.$modal
                .confirm(this.$t('system.dict.index.880996-11', [dictIds]))
                .then(function () {
                    return delType(dictIds);
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
                'system/dict/type/export',
                {
                    ...this.queryParams,
                },
                `type_${new Date().getTime()}.xlsx`
            );
        },
        /** 刷新缓存按钮操作 */
        handleRefreshCache() {
            refreshCache().then(() => {
                this.$modal.msgSuccess(this.$t('refreshSuccess'));
                this.$store.dispatch('dict/cleanDict');
            });
        },
    },
};
</script>
