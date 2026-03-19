<template>
    <div class="app-container">
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
            <el-form-item :label="$t('system.dict.data.879098-0')" prop="dictType">
                <el-select v-model="queryParams.dictType">
                    <el-option v-for="item in typeOptions" :key="item.dictId" :label="item.dictName" :value="item.dictType" />
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('system.dict.data.879098-1')" prop="dictLabel">
                <el-input v-model="queryParams.dictLabel" :placeholder="$t('system.dict.data.879098-2')" clearable @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('status')" prop="status">
                <el-select v-model="queryParams.status" :placeholder="$t('system.dict.data.879098-3')" clearable>
                    <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
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
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:dict:remove']">{{ $t('del') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['system:dict:export']">{{ $t('export') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-close" size="mini" @click="handleClose">{{ $t('close') }}</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column :label="$t('system.dict.data.879098-4')" align="center" prop="dictCode" />
            <el-table-column :label="$t('system.dict.data.879098-5')" align="center" prop="dictLabel">
                <template slot-scope="scope">
                    <span v-if="scope.row.listClass == '' || scope.row.listClass == 'default'">{{ scope.row.dictLabel }}</span>
                    <el-tag v-else :type="scope.row.listClass == 'primary' ? '' : scope.row.listClass">{{ scope.row.dictLabel }}</el-tag>
                </template>
            </el-table-column>
            <el-table-column :label="$t('system.dict.data.879098-6')" align="center" prop="dictValue" />
            <el-table-column :label="$t('system.dict.data.879098-7')" align="center" prop="dictSort" />
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
                <el-form-item :label="$t('system.dict.data.879098-8')">
                    <el-input v-model="form.dictType" :disabled="true" />
                </el-form-item>
                <el-form-item :label="$t('system.dict.data.879098-9')" prop="dictLabel">
                    <el-input v-model="form.dictLabel" :placeholder="$t('system.dict.data.879098-10')" />
                </el-form-item>
                <el-form-item :label="$t('system.dict.data.879098-11')" prop="dictValue">
                    <el-input v-model="form.dictValue" :placeholder="$t('system.dict.data.879098-12')" />
                </el-form-item>
                <el-form-item :label="$t('system.dict.data.879098-13')" prop="cssClass">
                    <el-input v-model="form.cssClass" :placeholder="$t('system.dict.data.879098-14')" />
                </el-form-item>
                <el-form-item :label="$t('system.dict.data.879098-15')" prop="dictSort">
                    <el-input-number v-model="form.dictSort" controls-position="right" :min="0" />
                </el-form-item>
                <el-form-item :label="$t('system.dict.data.879098-16')" prop="listClass">
                    <el-select v-model="form.listClass">
                        <el-option v-for="item in listClassOptions" :key="item.value" :label="item.label + '(' + item.value + ')'" :value="item.value"></el-option>
                    </el-select>
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
import { listData, getData, delData, addData, updateData } from '@/api/system/dict/data';
import { optionselect as getDictOptionselect, getType } from '@/api/system/dict/type';

export default {
    name: 'Data',
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
            dataList: [],
            // 默认字典类型
            defaultDictType: '',
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 数据标签回显样式
            listClassOptions: [
                {
                    value: 'default',
                    label: this.$t('system.dict.data.879098-17'),
                },
                {
                    value: 'primary',
                    label: this.$t('system.dict.data.879098-18'),
                },
                {
                    value: 'success',
                    label: this.$t('system.dict.data.879098-19'),
                },
                {
                    value: 'info',
                    label: this.$t('system.dict.data.879098-20'),
                },
                {
                    value: 'warning',
                    label: this.$t('system.dict.data.879098-21'),
                },
                {
                    value: 'danger',
                    label: this.$t('system.dict.data.879098-22'),
                },
            ],
            // 类型数据字典
            typeOptions: [],
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
                dictLabel: [{ required: true, message: this.$t('system.dict.data.879098-23'), trigger: 'blur' }],
                dictValue: [{ required: true, message: this.$t('system.dict.data.879098-24'), trigger: 'blur' }],
                dictSort: [{ required: true, message: this.$t('system.dict.data.879098-25'), trigger: 'blur' }],
            },
        };
    },
    created() {
        const dictId = this.$route.params && this.$route.params.dictId;
        this.getType(dictId);
        this.getTypeList();
    },
    methods: {
        /** 查询字典类型详细 */
        getType(dictId) {
            getType(dictId).then((response) => {
                this.queryParams.dictType = response.data.dictType;
                this.defaultDictType = response.data.dictType;
                this.getList();
            });
        },
        /** 查询字典类型列表 */
        getTypeList() {
            getDictOptionselect().then((response) => {
                this.typeOptions = response.data;
            });
        },
        /** 查询字典数据列表 */
        getList() {
            this.loading = true;
            listData(this.queryParams).then((response) => {
                this.dataList = response.rows;
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
                dictCode: undefined,
                dictLabel: undefined,
                dictValue: undefined,
                cssClass: undefined,
                listClass: 'default',
                dictSort: 0,
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
        /** 返回按钮操作 */
        handleClose() {
            const obj = { path: '/system/dict' };
            this.$tab.closeOpenPage(obj);
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm('queryForm');
            this.queryParams.dictType = this.defaultDictType;
            this.handleQuery();
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = this.$t('system.dict.data.879098-26');
            this.form.dictType = this.queryParams.dictType;
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.dictCode);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const dictCode = row.dictCode || this.ids;
            getData(dictCode).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.dict.data.879098-27');
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.dictCode != undefined) {
                        updateData(this.form).then((response) => {
                            this.$store.dispatch('dict/removeDict', this.queryParams.dictType);
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addData(this.form).then((response) => {
                            this.$store.dispatch('dict/removeDict', this.queryParams.dictType);
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
            const dictCodes = row.dictCode || this.ids;
            this.$modal
                .confirm(this.$t('system.dict.data.879098-28', [dictCodes]))
                .then(function () {
                    return delData(dictCodes);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('delSuccess'));
                    this.$store.dispatch('dict/removeDict', this.queryParams.dictType);
                })
                .catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download(
                'system/dict/data/export',
                {
                    ...this.queryParams,
                },
                `data_${new Date().getTime()}.xlsx`
            );
        },
    },
};
</script>
