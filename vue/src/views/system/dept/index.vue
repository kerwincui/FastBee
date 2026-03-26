<template>
    <div class="app-container">
        <!-- 搜索栏 -->
        <el-card shadow="never" class="search-card" v-show="showSearch">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true">
                <el-form-item :label="$t('system.dept.780956-0')" prop="deptName">
                    <el-input v-model="queryParams.deptName" :placeholder="$t('system.dept.780956-1')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.dept.780956-2')" prop="status">
                    <el-select v-model="queryParams.status" :placeholder="$t('system.dept.780956-2')" clearable>
                        <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <!-- 操作按钮和数据表格 -->
        <el-card shadow="never" class="table-card">
            <el-row :gutter="10" style="margin-bottom: 16px">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['system:dept:add']">{{ $t('add') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="info" plain icon="el-icon-sort" size="small" @click="toggleExpandAll">{{ $t('expand') }}/{{ $t('collapse') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table
                v-if="refreshTable"
                v-loading="loading"
                :data="deptList"
                row-key="deptId"
                :default-expand-all="isExpandAll"
                :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
                header-cell-class-name="table-header"
                :border="false"
            >
                <el-table-column prop="deptName" :label="$t('system.dept.780956-0')" width="260"></el-table-column>
                <el-table-column prop="orderNum" :label="$t('system.dept.780956-2')" width="200"></el-table-column>
                <el-table-column prop="status" :label="$t('system.dept.780956-2')" width="100">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="200">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime) }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:dept:edit']">{{ $t('update') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-plus" @click="handleAdd(scope.row)" v-hasPermi="['system:dept:add']">{{ $t('add') }}</el-button>
                        <el-button v-if="scope.row.parentId != 0" size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:dept:remove']">{{ $t('del') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <!-- 添加或修改部门对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                    <el-row>
                        <el-col :span="24" v-if="form.parentId !== 0">
                            <el-form-item :label="$t('system.dept.780956-10')" prop="parentId">
                                <treeselect v-model="form.parentId" :options="deptOptions" :normalizer="normalizer" :placeholder="$t('system.dept.780956-11')" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.dept.780956-0')" prop="deptName">
                                <el-input v-model="form.deptName" :placeholder="$t('system.dept.780956-1')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.dept.780956-2')" prop="orderNum">
                                <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.dept.780956-4')" prop="leader">
                                <el-input v-model="form.leader" :placeholder="$t('system.dept.780956-13')" maxlength="20" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.dept.780956-21')" prop="phone">
                                <el-input v-model="form.phone" :placeholder="$t('system.dept.780956-22')" maxlength="11" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item :label="$t('user.index.098976-19')" prop="email">
                                <el-input v-model="form.email" :placeholder="$t('user.index.098976-20')" maxlength="50" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.dept.780956-2')">
                                <el-radio-group v-model="form.status">
                                    <el-radio v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                                </el-radio-group>
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
import { listDept, getDept, delDept, addDept, updateDept, listDeptExcludeChild } from '@/api/system/dept';
import Treeselect from '@riophae/vue-treeselect';
import '@riophae/vue-treeselect/dist/vue-treeselect.css';

export default {
    name: 'Dept',
    dicts: ['sys_normal_disable'],
    components: { Treeselect },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 显示搜索条件
            showSearch: true,
            // 表格树数据
            deptList: [],
            // 部门树选项
            deptOptions: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 是否展开，默认全部展开
            isExpandAll: true,
            // 重新渲染表格状态
            refreshTable: true,
            // 查询参数
            queryParams: {
                deptName: undefined,
                status: undefined,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                parentId: [{ required: true, message: this.$t('system.dept.780956-50'), trigger: 'blur' }],
                deptName: [{ required: true, message: this.$t('system.dept.780956-51'), trigger: 'blur' }],
                orderNum: [{ required: true, message: this.$t('system.dept.780956-44'), trigger: 'blur' }],
                email: [
                    {
                        type: 'email',
                        message: this.$t('system.dept.780956-45'),
                        trigger: ['blur', 'change'],
                    },
                ],
                phone: [
                    {
                        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
                        message: this.$t('system.dept.780956-46'),
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
        /** 查询部门列表 */
        getList() {
            this.loading = true;
            listDept(this.queryParams).then((response) => {
                this.deptList = this.handleTree(response.data, 'deptId');
                this.loading = false;
            });
        },
        /** 转换部门数据结构 */
        normalizer(node) {
            if (node.children && !node.children.length) {
                delete node.children;
            }
            return {
                id: node.deptId,
                label: node.deptName,
                children: node.children,
            };
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 表单重置
        reset() {
            this.form = {
                deptId: undefined,
                parentId: undefined,
                deptName: undefined,
                orderNum: undefined,
                leader: undefined,
                phone: undefined,
                email: undefined,
                status: '0',
            };
            this.resetForm('form');
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 新增按钮操作 */
        handleAdd(row) {
            this.reset();
            if (row != undefined) {
                this.form.parentId = row.deptId;
            }
            this.open = true;
            this.title = this.$t('system.dept.780956-52');
            listDept().then((response) => {
                this.deptOptions = this.handleTree(response.data, 'deptId');
            });
        },
        /** 展开/折叠操作 */
        toggleExpandAll() {
            this.refreshTable = false;
            this.isExpandAll = !this.isExpandAll;
            this.$nextTick(() => {
                this.refreshTable = true;
            });
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            getDept(row.deptId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.dept.780956-53');
                listDeptExcludeChild(row.deptId).then((response) => {
                    this.deptOptions = this.handleTree(response.data, 'deptId');
                    if (this.deptOptions.length == 0) {
                        const noResultsOptions = { deptId: this.form.parentId, deptName: this.form.parentName, children: [] };
                        this.deptOptions.push(noResultsOptions);
                    }
                });
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.deptId != undefined) {
                        updateDept(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addDept(this.form).then((response) => {
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
            this.$modal
                .confirm(this.$t('system.dept.780956-43', [row.deptName]))
                .then(function () {
                    return delDept(row.deptId);
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
