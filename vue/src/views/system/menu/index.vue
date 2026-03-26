<template>
    <div class="app-container">
        <!-- 搜索栏 -->
        <el-card shadow="never" class="search-card" v-show="showSearch">
            <el-form :model="queryParams" ref="queryForm" size="small" :inline="true">
                <el-form-item :label="$t('system.menu.034890-0')" prop="menuName">
                    <el-input v-model="queryParams.menuName" :placeholder="$t('system.menu.034890-1')" clearable @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item :label="$t('system.menu.034890-2')" prop="status">
                    <el-select v-model="queryParams.status" :placeholder="$t('system.menu.034890-2')" clearable>
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
            <el-row :gutter="10" style="margin-bottom: 15px">
                <el-col :span="1.5">
                    <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['system:menu:add']">{{ $t('add') }}</el-button>
                </el-col>
                <el-col :span="1.5">
                    <el-button type="info" plain icon="el-icon-sort" size="small" @click="toggleExpandAll">{{ $t('system.menu.034890-6') }}</el-button>
                </el-col>
                <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            </el-row>

            <el-table
                v-if="refreshTable"
                v-loading="loading"
                :data="menuList"
                row-key="menuId"
                :default-expand-all="isExpandAll"
                :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
                header-cell-class-name="table-header"
                :border="false"
            >
                <el-table-column prop="menuName" :label="$t('system.menu.034890-0')" :show-overflow-tooltip="true" width="160"></el-table-column>
                <el-table-column prop="icon" :label="$t('system.menu.034890-3')" align="center" width="100">
                    <template slot-scope="scope">
                        <svg-icon :icon-class="scope.row.icon" />
                    </template>
                </el-table-column>
                <el-table-column prop="orderNum" :label="$t('system.menu.034890-4')" width="60"></el-table-column>
                <el-table-column prop="perms" :label="$t('system.menu.034890-5')" :show-overflow-tooltip="true"></el-table-column>
                <el-table-column prop="component" :label="$t('system.menu.034890-6')" :show-overflow-tooltip="true"></el-table-column>
                <el-table-column prop="status" :label="$t('system.menu.034890-2')" width="80">
                    <template slot-scope="scope">
                        <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
                    </template>
                </el-table-column>
                <el-table-column :label="$t('creatTime')" align="center" prop="createTime">
                    <template slot-scope="scope">
                        <span>{{ parseTime(scope.row.createTime) }}</span>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width">
                    <template slot-scope="scope">
                        <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:menu:edit']">{{ $t('update') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-plus" @click="handleAdd(scope.row)" v-hasPermi="['system:menu:add']">{{ $t('add') }}</el-button>
                        <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:menu:remove']">{{ $t('del') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <!-- 添加或修改菜单对话框 -->
            <el-dialog :title="title" :visible.sync="open" width="680px" append-to-body>
                <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                    <el-row>
                        <el-col :span="24">
                            <el-form-item :label="$t('system.menu.034890-11')" prop="parentId">
                                <treeselect v-model="form.parentId" :options="menuOptions" :normalizer="normalizer" :show-count="true" :placeholder="$t('system.menu.034890-12')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="24">
                            <el-form-item :label="$t('system.menu.034890-13')" prop="menuType">
                                <el-radio-group v-model="form.menuType">
                                    <el-radio label="M">{{ $t('system.menu.034890-14') }}</el-radio>
                                    <el-radio label="C">{{ $t('system.menu.034890-15') }}</el-radio>
                                    <el-radio label="F">{{ $t('system.menu.034890-16') }}</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="24" v-if="form.menuType != 'F'">
                            <el-form-item :label="$t('system.menu.034890-7')" prop="icon">
                                <el-popover placement="bottom-start" width="460" trigger="click" @show="$refs['iconSelect'].reset()">
                                    <IconSelect ref="iconSelect" @selected="selected" />
                                    <el-input slot="reference" v-model="form.icon" :placeholder="$t('system.menu.034890-17')" readonly>
                                        <svg-icon v-if="form.icon" slot="prefix" :icon-class="form.icon" class="el-input__icon" style="height: 32px; width: 16px" />
                                        <i v-else slot="prefix" class="el-icon-search el-input__icon" />
                                    </el-input>
                                </el-popover>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.menu.034890-0')" prop="menuName">
                                <el-input v-model="form.menuName" :placeholder="$t('system.menu.034890-1')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item :label="$t('system.menu.034890-8')" prop="orderNum">
                                <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType != 'F'">
                            <el-form-item prop="isFrame">
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-16')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-17') }}
                                </span>
                                <el-radio-group v-model="form.isFrame">
                                    <el-radio label="0">{{ $t('system.menu.034890-19') }}</el-radio>
                                    <el-radio label="1">{{ $t('system.menu.034890-20') }}</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType != 'F'">
                            <el-form-item prop="path">
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-18')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-19') }}
                                </span>
                                <el-input v-model="form.path" :placeholder="$t('system.menu.034890-20')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType == 'C'">
                            <el-form-item prop="component">
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-21')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-22') }}
                                </span>
                                <el-input v-model="form.component" :placeholder="$t('system.menu.034890-23')" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType != 'M'">
                            <el-form-item prop="perms">
                                <el-input v-model="form.perms" :placeholder="$t('system.menu.034890-24')" maxlength="100" />
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-25')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-26') }}
                                </span>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType == 'C'">
                            <el-form-item prop="query">
                                <el-input v-model="form.query" :placeholder="$t('system.menu.034890-27')" maxlength="255" />
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-28')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-29') }}
                                </span>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType == 'C'">
                            <el-form-item prop="isCache">
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-30')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-31') }}
                                </span>
                                <el-radio-group v-model="form.isCache">
                                    <el-radio label="0">{{ $t('system.menu.034890-32') }}</el-radio>
                                    <el-radio label="1">{{ $t('system.menu.034890-33') }}</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType != 'F'">
                            <el-form-item prop="visible">
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-34')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-35') }}
                                </span>
                                <el-radio-group v-model="form.visible">
                                    <el-radio v-for="dict in dict.type.sys_show_hide" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                                </el-radio-group>
                            </el-form-item>
                        </el-col>
                        <el-col :span="12" v-if="form.menuType != 'F'">
                            <el-form-item prop="status">
                                <span slot="label">
                                    <el-tooltip :content="$t('system.menu.034890-36')" placement="top">
                                        <i class="el-icon-question"></i>
                                    </el-tooltip>
                                    {{ $t('system.menu.034890-2') }}
                                </span>
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
import { listMenu, getMenu, delMenu, addMenu, updateMenu } from '@/api/system/menu';
import Treeselect from '@riophae/vue-treeselect';
import '@riophae/vue-treeselect/dist/vue-treeselect.css';
import IconSelect from '@/components/IconSelect';

export default {
    name: 'Menu',
    dicts: ['sys_show_hide', 'sys_normal_disable'],
    components: { Treeselect, IconSelect },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 显示搜索条件
            showSearch: true,
            // 菜单表格树数据
            menuList: [],
            // 菜单树选项
            menuOptions: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 是否展开，默认全部折叠
            isExpandAll: false,
            // 重新渲染表格状态
            refreshTable: true,
            // 查询参数
            queryParams: {
                menuName: undefined,
                visible: undefined,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                menuName: [{ required: true, message: this.$t('system.menu.034890-37'), trigger: 'blur' }],
                orderNum: [{ required: true, message: this.$t('system.menu.034890-38'), trigger: 'blur' }],
                path: [{ required: true, message: this.$t('system.menu.034890-39'), trigger: 'blur' }],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        // 选择图标
        selected(name) {
            this.form.icon = name;
        },
        /** 查询菜单列表 */
        getList() {
            this.loading = true;
            listMenu(this.queryParams).then((response) => {
                this.menuList = this.handleTree(response.data, 'menuId');
                this.loading = false;
            });
        },
        /** 转换菜单数据结构 */
        normalizer(node) {
            if (node.children && !node.children.length) {
                delete node.children;
            }
            return {
                id: node.menuId,
                label: node.menuName,
                children: node.children,
            };
        },
        /** 查询菜单下拉树结构 */
        getTreeselect() {
            listMenu().then((response) => {
                this.menuOptions = [];
                const menu = { menuId: 0, menuName: this.$t('system.menu.034890-40'), children: [] };
                menu.children = this.handleTree(response.data, 'menuId');
                this.menuOptions.push(menu);
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
                menuId: undefined,
                parentId: 0,
                menuName: undefined,
                icon: undefined,
                menuType: 'M',
                orderNum: undefined,
                isFrame: '1',
                isCache: '0',
                visible: '0',
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
            this.getTreeselect();
            if (row != null && row.menuId) {
                this.form.parentId = row.menuId;
            } else {
                this.form.parentId = 0;
            }
            this.open = true;
            this.title = this.$t('system.menu.034890-41');
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
            this.getTreeselect();
            getMenu(row.menuId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('system.menu.034890-42');
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.menuId != undefined) {
                        updateMenu(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addMenu(this.form).then((response) => {
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
                .confirm(this.$t('system.menu.034890-43', [row.menuName]))
                .then(function () {
                    return delMenu(row.menuId);
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
