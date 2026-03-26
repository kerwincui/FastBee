<template>
    <div class="app-container">
        <!-- 搜索栏 -->
        <el-card shadow="never" class="search-card" v-show="showSearch">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true">
                <el-form-item :label="$t('role.index.094567-0')" prop="roleName">
                    <el-input v-model="queryParams.roleName" :placeholder="$t('role.index.094567-1')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('role.index.094567-0')" prop="roleKey">
                    <el-input v-model="queryParams.roleKey" :placeholder="$t('role.index.094567-1')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('role.index.094567-2')" prop="status">
                    <el-select v-model="queryParams.status" :placeholder="$t('role.index.094567-2')" clearable style="width: 240px">
                        <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('creatTime')">
                    <el-date-picker v-model="dateRange" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <!-- 操作按钮和数据表格 -->
        <el-card shadow="never" class="table-card">
            <el-button type="primary" plain icon="el-icon-plus" style="margin-bottom: 20px" size="small" @click="handleAdd" v-hasPermi="['system:role:add']">{{ $t('add') }}</el-button>
            <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['system:role:edit']">{{ $t('update') }}</el-button>
            <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:role:remove']">{{ $t('del') }}</el-button>
            <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['system:role:export']">{{ $t('export') }}</el-button>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>

            <el-table v-loading="loading" :data="roleList" @selection-change="handleSelectionChange" header-cell-class-name="table-header" :border="false">
                <el-table-column type="selection" width="55" align="center" />
                <el-table-column label="id" prop="roleId" width="120" />
                <el-table-column :label="$t('role.index.094567-0')" prop="roleName" :show-overflow-tooltip="true" width="150" />
                <el-table-column :label="$t('role.index.094567-0')" prop="roleKey" :show-overflow-tooltip="true" width="150" />
                <el-table-column :label="$t('role.index.094567-16')" prop="roleSort" width="100" />
                <el-table-column :label="$t('role.index.094567-2')" align="center" width="100">
                    <template slot-scope="scope">
                        <el-switch v-model="scope.row.status" active-value="0" inactive-value="1" @change="handleStatusChange(scope.row)"></el-switch>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime" width="180">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime) }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <!-- v-if="scope.row.roleId !== 1 && scope.row.roleId !== 2 && scope.row.roleId !== 3" -->
                    <template slot-scope="scope" v-if="scope.row.roleId !== 1">
                        <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:role:edit']">{{ $t('update') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:role:remove']">{{ $t('del') }}</el-button>
                        <el-dropdown size="mini" @command="(command) => handleCommand(command, scope.row)" v-hasPermi="['system:role:edit']">
                            <el-button size="mini" type="text" icon="el-icon-d-arrow-right">{{ $t('role.index.094567-11') }}</el-button>
                            <el-dropdown-menu slot="dropdown">
                                <el-dropdown-item command="handleDataScope" icon="el-icon-circle-check" v-hasPermi="['system:role:edit']">{{ $t('role.index.094567-6') }}</el-dropdown-item>
                                <el-dropdown-item command="handleAuthUser" icon="el-icon-user" v-hasPermi="['system:role:edit']">{{ $t('role.index.094567-7') }}</el-dropdown-item>
                            </el-dropdown-menu>
                        </el-dropdown>
                    </template>
                </el-table-column>
            </el-table>
            <div class="pagination-container">
                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
            </div>

            <!-- 添加或修改角色配置对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                    <el-form-item :label="$t('role.index.094567-0')" prop="roleName">
                        <el-input v-model="form.roleName" :placeholder="$t('role.index.094567-1')" />
                    </el-form-item>
                    <el-form-item prop="roleKey">
                        <span slot="label">
                            <el-tooltip :content="$t('role.index.094567-14')" placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                            {{ $t('role.index.094567-0') }}
                        </span>
                        <el-input v-model="form.roleKey" :placeholder="$t('role.index.094567-1')" />
                    </el-form-item>
                    <el-form-item :label="$t('role.index.094567-16')" prop="roleSort">
                        <el-input-number v-model="form.roleSort" controls-position="right" :min="0" />
                    </el-form-item>
                    <el-form-item :label="$t('role.index.094567-2')">
                        <el-radio-group v-model="form.status">
                            <el-radio v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item :label="$t('role.index.094567-8')">
                        <el-checkbox v-model="menuExpand" @change="handleCheckedTreeExpand($event, 'menu')">{{ $t('role.index.094567-9') }}</el-checkbox>
                        <el-checkbox v-model="menuNodeAll" @change="handleCheckedTreeNodeAll($event, 'menu')">{{ $t('role.index.094567-10') }}</el-checkbox>
                        <el-checkbox v-model="form.menuCheckStrictly" @change="handleCheckedTreeConnect($event, 'menu')">{{ $t('role.index.094567-11') }}</el-checkbox>
                        <el-tree class="tree-border" :data="menuOptions" show-checkbox ref="menu" node-key="id" :check-strictly="!form.menuCheckStrictly" :empty-text="$t('loading')" :props="defaultProps"></el-tree>
                    </el-form-item>
                    <el-form-item :label="$t('remark')">
                        <el-input v-model="form.remark" type="textarea" :placeholder="$t('plzInput')"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitForm">{{ $t('confirm') }}</el-button>
                    <el-button @click="cancel">{{ $t('cancel') }}</el-button>
                </div>
            </el-dialog>

            <!-- 分配角色数据权限对话框 -->
            <el-dialog :title="title" :visible.sync="openDataScope" width="500px" append-to-body>
                <el-form :model="form" label-width="80px">
                    <el-form-item :label="$t('role.index.094567-0')">
                        <el-input v-model="form.roleName" :disabled="true" />
                    </el-form-item>
                    <el-form-item :label="$t('role.index.094567-0')">
                        <el-input v-model="form.roleKey" :disabled="true" />
                    </el-form-item>
                    <el-form-item :label="$t('role.index.094567-12')">
                        <el-select v-model="form.dataScope" @change="dataScopeSelectChange">
                            <el-option v-for="item in dataScopeOptions" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item :label="$t('role.index.094567-6')" v-show="form.dataScope == 2">
                        <el-checkbox v-model="deptExpand" @change="handleCheckedTreeExpand($event, 'dept')">{{ $t('expand') }}/{{ $t('collapse') }}</el-checkbox>
                        <el-checkbox v-model="deptNodeAll" @change="handleCheckedTreeNodeAll($event, 'dept')">{{ $t('selectAll') }}/{{ $t('deselectAll') }}</el-checkbox>
                        <el-checkbox v-model="form.deptCheckStrictly" @change="handleCheckedTreeConnect($event, 'dept')">{{ $t('parentChildLink') }}</el-checkbox>
                        <el-tree
                            class="tree-border"
                            :data="deptOptions"
                            show-checkbox
                            default-expand-all
                            ref="dept"
                            node-key="id"
                            :check-strictly="!form.deptCheckStrictly"
                            :empty-text="$t('loading')"
                            :props="defaultProps"
                        ></el-tree>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submitDataScope">{{ $t('confirm') }}</el-button>
                    <el-button @click="cancelDataScope">{{ $t('cancel') }}</el-button>
                </div>
            </el-dialog>
        </el-card>
    </div>
</template>

<script>
import { listRole, getRole, delRole, addRole, updateRole, dataScope, changeRoleStatus, deptTreeSelect } from '@/api/system/role';
import { treeselect as menuTreeselect, roleMenuTreeselect } from '@/api/system/menu';

export default {
    name: 'Role',
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
            // 角色表格数据
            roleList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 是否显示弹出层（数据权限）
            openDataScope: false,
            menuExpand: false,
            menuNodeAll: false,
            deptExpand: true,
            deptNodeAll: false,
            // 日期范围
            dateRange: [],
            // 数据范围选项
            dataScopeOptions: [
                {
                    value: '1',
                    label: this.$t('system.role.index.allDataScope'),
                },
                {
                    value: '2',
                    label: this.$t('system.role.index.customDataScope'),
                },
                {
                    value: '3',
                    label: this.$t('system.role.index.deptDataScope'),
                },
                {
                    value: '4',
                    label: this.$t('system.role.index.deptBelowDataScope'),
                },
                {
                    value: '5',
                    label: this.$t('system.role.index.selfDataScope'),
                },
            ],
            // 菜单列表
            menuOptions: [],
            // 部门列表
            deptOptions: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                roleName: undefined,
                roleKey: undefined,
                status: undefined,
            },
            // 表单参数
            form: {},
            defaultProps: {
                children: 'children',
                label: 'label',
            },
            // 表单校验
            rules: {
                roleName: [{ required: true, message: this.$t('system.role.index.roleNameRequired'), trigger: 'blur' }],
                roleKey: [{ required: true, message: this.$t('system.role.index.roleKeyRequired'), trigger: 'blur' }],
                roleSort: [{ required: true, message: this.$t('system.role.index.roleSortRequired'), trigger: 'blur' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询角色列表 */
        getList() {
            this.loading = true;
            listRole(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.roleList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /** 查询菜单树结构 */
        getMenuTreeselect() {
            menuTreeselect().then((response) => {
                this.menuOptions = response.data;
            });
        },
        // 所有菜单节点数据
        getMenuAllCheckedKeys() {
            // 目前被选中的菜单节点
            let checkedKeys = this.$refs.menu.getCheckedKeys();
            // 半选中的菜单节点
            let halfCheckedKeys = this.$refs.menu.getHalfCheckedKeys();
            checkedKeys.unshift.apply(checkedKeys, halfCheckedKeys);
            return checkedKeys;
        },
        // 所有部门节点数据
        getDeptAllCheckedKeys() {
            // 目前被选中的部门节点
            let checkedKeys = this.$refs.dept.getCheckedKeys();
            // 半选中的部门节点
            let halfCheckedKeys = this.$refs.dept.getHalfCheckedKeys();
            checkedKeys.unshift.apply(checkedKeys, halfCheckedKeys);
            return checkedKeys;
        },
        /** 根据角色ID查询菜单树结构 */
        getRoleMenuTreeselect(roleId) {
            return roleMenuTreeselect(roleId).then((response) => {
                this.menuOptions = response.menus;
                return response;
            });
        },
        /** 根据角色ID查询部门树结构 */
        getDeptTree(roleId) {
            return deptTreeSelect(roleId).then((response) => {
                this.deptOptions = response.depts;
                return response;
            });
        },
        // 角色状态修改
        handleStatusChange(row) {
            let text = row.status === '0' ? this.$t('system.role.index.disable') : this.$t('system.role.index.enable');
            this.$modal
                .confirm(this.$t('system.role.index.confirmStatusChange', [text, row.roleName]))
                .then(function () {
                    return changeRoleStatus(row.roleId, row.status);
                })
                .then(() => {
                    this.$modal.msgSuccess(text + this.$t('updateSuccess'));
                })
                .catch(function () {
                    row.status = row.status === '0' ? '1' : '0';
                });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 取消按钮（数据权限）
        cancelDataScope() {
            this.openDataScope = false;
            this.reset();
        },
        // 表单重置
        reset() {
            if (this.$refs.menu != undefined) {
                this.$refs.menu.setCheckedKeys([]);
            }
            (this.menuExpand = false),
                (this.menuNodeAll = false),
                (this.deptExpand = true),
                (this.deptNodeAll = false),
                (this.form = {
                    roleId: undefined,
                    roleName: undefined,
                    roleKey: undefined,
                    roleSort: 0,
                    status: '0',
                    menuIds: [],
                    deptIds: [],
                    menuCheckStrictly: true,
                    deptCheckStrictly: true,
                    remark: undefined,
                });
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
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.roleId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        // 更多操作触发
        handleCommand(command, row) {
            switch (command) {
                case 'handleDataScope':
                    this.handleDataScope(row);
                    break;
                case 'handleAuthUser':
                    this.handleAuthUser(row);
                    break;
                default:
                    break;
            }
        },
        // 树权限（展开/折叠）
        handleCheckedTreeExpand(value, type) {
            if (type == 'menu') {
                let treeList = this.menuOptions;
                for (let i = 0; i < treeList.length; i++) {
                    this.$refs.menu.store.nodesMap[treeList[i].id].expanded = value;
                }
            } else if (type == 'dept') {
                let treeList = this.deptOptions;
                for (let i = 0; i < treeList.length; i++) {
                    this.$refs.dept.store.nodesMap[treeList[i].id].expanded = value;
                }
            }
        },
        // 树权限（全选/全不选）
        handleCheckedTreeNodeAll(value, type) {
            if (type == 'menu') {
                this.$refs.menu.setCheckedNodes(value ? this.menuOptions : []);
            } else if (type == 'dept') {
                this.$refs.dept.setCheckedNodes(value ? this.deptOptions : []);
            }
        },
        // 树权限（父子联动）
        handleCheckedTreeConnect(value, type) {
            if (type == 'menu') {
                this.form.menuCheckStrictly = value ? true : false;
            } else if (type == 'dept') {
                this.form.deptCheckStrictly = value ? true : false;
            }
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.getMenuTreeselect();
            this.open = true;
            this.title = this.$t('system.role.index.addRole');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const roleId = row.roleId || this.ids;
            const roleMenu = this.getRoleMenuTreeselect(roleId);
            getRole(roleId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.$nextTick(() => {
                    roleMenu.then((res) => {
                        let checkedKeys = res.checkedKeys;
                        checkedKeys.forEach((v) => {
                            this.$nextTick(() => {
                                this.$refs.menu.setChecked(v, true, false);
                            });
                        });
                    });
                });
                this.title = this.$t('system.role.index.editRole');
            });
        },
        /** 选择角色权限范围触发 */
        dataScopeSelectChange(value) {
            if (value !== '2') {
                this.$refs.dept.setCheckedKeys([]);
            }
        },
        /** 分配数据权限操作 */
        handleDataScope(row) {
            this.reset();
            const deptTreeSelect = this.getDeptTree(row.roleId);
            getRole(row.roleId).then((response) => {
                this.form = response.data;
                this.openDataScope = true;
                this.$nextTick(() => {
                    deptTreeSelect.then((res) => {
                        this.$refs.dept.setCheckedKeys(res.checkedKeys);
                    });
                });
                this.title = this.$t('system.role.index.dataPermission');
            });
        },
        /** 分配用户操作 */
        handleAuthUser: function (row) {
            const roleId = row.roleId;
            this.$router.push('/system/role-auth/user/' + roleId);
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.roleId != undefined) {
                        this.form.menuIds = this.getMenuAllCheckedKeys();
                        updateRole(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        this.form.menuIds = this.getMenuAllCheckedKeys();
                        addRole(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('addSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 提交按钮（数据权限） */
        submitDataScope: function () {
            if (this.form.roleId != undefined) {
                this.form.deptIds = this.getDeptAllCheckedKeys();
                dataScope(this.form).then((response) => {
                    this.$modal.msgSuccess(this.$t('updateSuccess'));
                    this.openDataScope = false;
                    this.getList();
                });
            }
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const roleIds = row.roleId || this.ids;
            this.$modal
                .confirm(this.$t('system.role.index.confirmDel', [roleIds]))
                .then(function () {
                    return delRole(roleIds);
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
                'system/role/export',
                {
                    ...this.queryParams,
                },
                `role_${new Date().getTime()}.xlsx`
            );
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

::v-deep .el-button--small {
    padding: 8px 15px;
    font-size: 13px;
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
    border-radius: 4px;
}

::v-deep .el-form-item {
    margin-bottom: 18px;
}
</style>
