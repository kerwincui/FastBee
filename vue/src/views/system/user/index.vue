<template>
    <div class="app-container">
        <el-row :gutter="20">
            <!--部门数据-->
            <el-col :span="4" :xs="24">
                <el-card shadow="never" class="dept-card">
                    <div class="head-container">
                        <el-input v-model="deptName" :placeholder="$t('user.index.098976-0')" clearable size="small" prefix-icon="el-icon-search" style="margin-bottom: 20px" />
                    </div>
                    <div class="head-container">
                        <el-tree
                            :data="deptOptions"
                            :props="defaultProps"
                            :expand-on-click-node="false"
                            :filter-node-method="filterNode"
                            ref="tree"
                            node-key="id"
                            default-expand-all
                            highlight-current
                            @node-click="handleNodeClick"
                        />
                    </div>
                </el-card>
            </el-col>
            <!--用户数据-->
            <el-col :span="20" :xs="24">
                <!-- 搜索栏 -->
                <el-card shadow="never" class="search-card">
                    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
                        <el-form-item :label="$t('user.index.098976-1')" prop="userName">
                            <el-input v-model="queryParams.userName" :placeholder="$t('user.index.098976-2')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                        </el-form-item>
                        <el-form-item :label="$t('user.index.098976-3')" prop="phonenumber">
                            <el-input v-model="queryParams.phonenumber" :placeholder="$t('user.index.098976-4')" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
                        </el-form-item>
                        <el-form-item :label="$t('user.index.098976-5')" prop="status">
                            <el-select v-model="queryParams.status" :placeholder="$t('user.index.098976-6')" clearable style="width: 240px">
                                <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
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
                            <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleAdd" v-hasPermi="['system:user:add']">{{ $t('add') }}</el-button>
                        </el-col>
                        <el-col :span="1.5">
                            <el-button type="success" plain icon="el-icon-edit" size="small" :disabled="single" @click="handleUpdate" v-hasPermi="['system:user:edit']">{{ $t('update') }}</el-button>
                        </el-col>
                        <el-col :span="1.5">
                            <el-button type="danger" plain icon="el-icon-delete" size="small" :disabled="multiple" @click="handleDelete" v-hasPermi="['system:user:remove']">{{ $t('del') }}</el-button>
                        </el-col>
                        <el-col :span="1.5">
                            <el-button type="info" plain icon="el-icon-upload2" size="small" @click="handleImport" v-hasPermi="['system:user:import']">{{ $t('import') }}</el-button>
                        </el-col>
                        <el-col :span="1.5">
                            <el-button type="warning" plain icon="el-icon-download" size="small" @click="handleExport" v-hasPermi="['system:user:export']">{{ $t('export') }}</el-button>
                        </el-col>
                        <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
                    </el-row>

                    <el-table v-loading="loading" :data="userList" @selection-change="handleSelectionChange" header-cell-class-name="table-header" :border="false">
                        <el-table-column type="selection" width="50" align="center" />
                        <el-table-column :label="$t('user.index.098976-30')" align="center" key="userId" prop="userId" v-if="columns[0].visible" />
                        <el-table-column :label="$t('user.index.098976-1')" align="center" key="userName" prop="userName" v-if="columns[1].visible" :show-overflow-tooltip="true" />
                        <el-table-column :label="$t('user.index.098976-11')" align="center" key="nickName" prop="nickName" v-if="columns[2].visible" :show-overflow-tooltip="true" />
                        <el-table-column :label="$t('user.index.098976-29')" align="center" key="deptName" prop="dept.deptName" v-if="columns[3].visible" :show-overflow-tooltip="true" />
                        <el-table-column :label="$t('user.index.098976-13')" align="center" key="phonenumber" prop="phonenumber" v-if="columns[4].visible" width="120" />
                        <el-table-column :label="$t('user.index.098976-5')" align="center" key="status" v-if="columns[5].visible">
                            <template slot-scope="scope">
                                <el-switch v-model="scope.row.status" active-value="0" inactive-value="1" @change="handleStatusChange(scope.row)"></el-switch>
                            </template>
                        </el-table-column>
                        <el-table-column :label="$t('creatTime')" align="center" prop="createTime" v-if="columns[6].visible" width="160">
                            <template slot-scope="scope">
                                <span>{{ parseTime(scope.row.createTime) }}</span>
                            </template>
                        </el-table-column>
                        <el-table-column :label="$t('opation')" align="center" width="160" class-name="small-padding fixed-width">
                            <template slot-scope="scope" v-if="scope.row.userId !== 1">
                                <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:user:edit']">{{ $t('update') }}</el-button>
                                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['system:user:remove']">{{ $t('del') }}</el-button>
                                <el-dropdown size="mini" @command="(command) => handleCommand(command, scope.row)" v-hasPermi="['system:user:resetPwd', 'system:user:edit']">
                                    <el-button size="mini" type="text" icon="el-icon-d-arrow-right">{{ $t('user.index.098976-14') }}</el-button>
                                    <el-dropdown-menu slot="dropdown">
                                        <el-dropdown-item command="handleResetPwd" icon="el-icon-key" v-hasPermi="['system:user:resetPwd']">{{ $t('user.index.098976-15') }}</el-dropdown-item>
                                        <el-dropdown-item command="handleAuthRole" icon="el-icon-circle-check" v-hasPermi="['system:user:edit']">{{ $t('user.index.098976-23') }}</el-dropdown-item>
                                    </el-dropdown-menu>
                                </el-dropdown>
                            </template>
                        </el-table-column>
                    </el-table>

                    <div class="pagination-container">
                        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
                    </div>
                </el-card>
            </el-col>
        </el-row>

        <!-- 添加或修改用户配置对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="680px" append-to-body :close-on-click-modal="false">
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item :label="$t('user.index.098976-11')" prop="nickName">
                            <el-input v-model="form.nickName" :placeholder="$t('user.index.098976-16')" maxlength="30" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item :label="$t('user.index.098976-12')" prop="deptId">
                            <treeselect v-model="form.deptId" :options="deptOptions" :show-count="true" :placeholder="$t('user.index.098976-17')" />
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item :label="$t('user.index.098976-13')" prop="phonenumber">
                            <el-input v-model="form.phonenumber" :placeholder="$t('user.index.098976-18')" maxlength="11" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item :label="$t('user.index.098976-19')" prop="email">
                            <el-input v-model="form.email" :placeholder="$t('user.index.098976-20')" maxlength="50" />
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item v-if="form.userId == undefined" :label="$t('user.index.098976-1')" prop="userName">
                            <el-input v-model="form.userName" :placeholder="$t('user.index.098976-2')" maxlength="30" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item v-if="form.userId == undefined" :label="$t('user.index.098976-21')" prop="password">
                            <el-input v-model="form.password" :placeholder="$t('user.index.098976-22')" type="password" maxlength="20" show-password />
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item :label="$t('user.index.098976-23')">
                            <el-select v-model="form.sex" :placeholder="$t('user.index.098976-24')">
                                <el-option v-for="dict in dict.type.sys_user_sex" :key="dict.value" :label="dict.label" :value="dict.value"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item :label="$t('user.index.098976-5')">
                            <el-radio-group v-model="form.status">
                                <el-radio v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
                            </el-radio-group>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item :label="$t('role.index.094567-0')">
                            <el-select v-model="form.postIds" multiple :placeholder="$t('role.index.094567-4')">
                                <el-option v-for="item in postOptions" :key="item.postId" :label="item.postName" :value="item.postId" :disabled="item.status == 1"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item :label="$t('role.index.094567-0')">
                            <el-select v-model="form.roleIds" multiple :placeholder="$t('role.index.094567-4')">
                                <el-option v-for="item in roleOptions" :key="item.roleId" :label="item.roleName" :value="item.roleId" :disabled="item.status == 1"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="24">
                        <el-form-item :label="$t('remark')">
                            <el-input v-model="form.remark" type="textarea" :placeholder="$t('plzInput')"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">{{ $t('confirm') }}</el-button>
                <el-button @click="cancel">{{ $t('cancel') }}</el-button>
            </div>
        </el-dialog>

        <!-- 用户导入对话框 -->
        <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
            <el-upload
                ref="upload"
                :limit="1"
                accept=".xlsx, .xls"
                :headers="upload.headers"
                :action="upload.url + '?updateSupport=' + upload.updateSupport"
                :disabled="upload.isUploading"
                :on-progress="handleFileUploadProgress"
                :on-success="handleFileSuccess"
                :auto-upload="false"
                drag
            >
                <i class="el-icon-upload"></i>
                <div class="el-upload__text">
                    {{ $t('dragFileHere') }}
                    <em>{{ $t('system.user.index.clickToUpload') }}</em>
                </div>
                <div class="el-upload__tip text-center" slot="tip">
                    <div class="el-upload__tip" slot="tip">
                        <el-checkbox v-model="upload.updateSupport" />
                        {{ $t('system.user.index.updateExistData') }}
                    </div>
                    <span>{{ $t('system.user.index.importFileType') }}</span>
                    <el-link type="primary" :underline="false" style="font-size: 12px; vertical-align: baseline" @click="importTemplate">{{ $t('downloadTemplate') }}</el-link>
                </div>
            </el-upload>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitFileForm">{{ $t('confirm') }}</el-button>
                <el-button @click="upload.open = false">{{ $t('cancel') }}</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import { listUser, getUser, delUser, addUser, updateUser, resetUserPwd, changeUserStatus, deptTreeSelect } from '@/api/system/user';
import { getToken } from '@/utils/auth';
import Treeselect from '@riophae/vue-treeselect';
import '@riophae/vue-treeselect/dist/vue-treeselect.css';

export default {
    name: 'User',
    dicts: ['sys_normal_disable', 'sys_user_sex'],
    components: { Treeselect },
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
            // 用户表格数据
            userList: null,
            // 弹出层标题
            title: '',
            // 部门树选项
            deptOptions: undefined,
            // 是否显示弹出层
            open: false,
            // 部门名称
            deptName: undefined,
            // 默认密码
            initPassword: undefined,
            // 日期范围
            dateRange: [],
            // 岗位选项
            postOptions: [],
            // 角色选项
            roleOptions: [],
            // 表单参数
            form: {},
            defaultProps: {
                children: 'children',
                label: 'label',
            },
            // 用户导入参数
            upload: {
                // 是否显示弹出层（用户导入）
                open: false,
                // 弹出层标题（用户导入）
                title: '',
                // 是否禁用上传
                isUploading: false,
                // 是否更新已经存在的用户数据
                updateSupport: 0,
                // 设置上传的请求头部
                headers: { Authorization: 'Bearer ' + getToken() },
                // 上传的地址
                url: process.env.VUE_APP_BASE_API + '/system/user/importData',
            },
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                userName: undefined,
                phonenumber: undefined,
                status: undefined,
                deptId: undefined,
            },
            // 列信息
            columns: [
                { key: 0, label: this.$t('system.user.index.userId'), visible: true },
                { key: 1, label: this.$t('userName'), visible: true },
                { key: 2, label: this.$t('nickName'), visible: true },
                { key: 3, label: this.$t('system.user.index.dept'), visible: true },
                { key: 4, label: this.$t('phone'), visible: true },
                { key: 5, label: this.$t('status'), visible: true },
                { key: 6, label: this.$t('creatTime'), visible: true },
            ],
            // 表单校验
            rules: {
                userName: [
                    { required: true, message: this.$t('system.user.index.userNameRequired'), trigger: 'blur' },
                    { min: 2, max: 20, message: this.$t('system.user.index.userNameLength'), trigger: 'blur' },
                ],
                nickName: [{ required: true, message: this.$t('system.user.index.nickNameRequired'), trigger: 'blur' }],
                password: [
                    { required: true, message: this.$t('system.user.index.userPasswordRequired'), trigger: 'blur' },
                    { min: 5, max: 20, message: this.$t('system.user.index.passwordLength'), trigger: 'blur' },
                ],
                email: [
                    {
                        type: 'email',
                        message: this.$t('system.user.index.emailFormat'),
                        trigger: ['blur', 'change'],
                    },
                ],
                phonenumber: [
                    {
                        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
                        message: this.$t('system.user.index.phoneFormat'),
                        trigger: 'blur',
                    },
                ],
            },
        };
    },
    watch: {
        // 根据名称筛选部门树
        deptName(val) {
            this.$refs.tree.filter(val);
        },
    },
    created() {
        this.getList();
        this.getDeptTree();
        this.getConfigKey('sys.user.initPassword').then((response) => {
            this.initPassword = response.msg;
        });
    },
    methods: {
        /** 查询用户列表 */
        getList() {
            this.loading = true;
            listUser(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
                this.userList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        /** 查询部门下拉树结构 */
        getDeptTree() {
            deptTreeSelect().then((response) => {
                this.deptOptions = response.data;
            });
        },
        // 筛选节点
        filterNode(value, data) {
            if (!value) return true;
            return data.label.indexOf(value) !== -1;
        },
        // 节点单击事件
        handleNodeClick(data) {
            this.queryParams.deptId = data.id;
            this.handleQuery();
        },
        // 用户状态修改
        handleStatusChange(row) {
            let text = row.status === '0' ? this.$t('system.user.index.disable') : this.$t('system.user.index.enable');
            this.$modal
                .confirm(this.$t('system.user.index.confirmStatusChange', [text, row.userName]))
                .then(function () {
                    return changeUserStatus(row.userId, row.status);
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
        // 表单重置
        reset() {
            this.form = {
                userId: undefined,
                deptId: undefined,
                userName: undefined,
                nickName: undefined,
                password: undefined,
                phonenumber: undefined,
                email: undefined,
                sex: undefined,
                status: '0',
                remark: undefined,
                postIds: [],
                roleIds: [],
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
            this.queryParams.deptId = undefined;
            this.$refs.tree.setCurrentKey(null);
            this.handleQuery();
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map((item) => item.userId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        // 更多操作触发
        handleCommand(command, row) {
            switch (command) {
                case 'handleResetPwd':
                    this.handleResetPwd(row);
                    break;
                case 'handleAuthRole':
                    this.handleAuthRole(row);
                    break;
                default:
                    break;
            }
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            getUser().then((response) => {
                this.postOptions = response.posts;
                this.roleOptions = response.roles;
                this.open = true;
                this.title = this.$t('system.user.index.addUser');
                this.form.password = this.initPassword;
            });
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const userId = row.userId || this.ids;
            getUser(userId).then((response) => {
                this.form = response.data;
                this.postOptions = response.posts;
                this.roleOptions = response.roles;
                this.$set(this.form, 'postIds', response.postIds);
                this.$set(this.form, 'roleIds', response.roleIds);
                this.open = true;
                this.title = this.$t('system.user.index.editUser');
                this.form.password = '';
            });
        },
        /** 重置密码按钮操作 */
        handleResetPwd(row) {
            this.$prompt(this.$t('system.user.index.resetPwdConfirm', [row.userName]), this.$t('system.user.index.resetPwd'), {
                confirmButtonText: this.$t('confirm'),
                cancelButtonText: this.$t('cancel'),
                closeOnClickModal: false,
                inputPattern: /^.{5,20}$/,
                inputErrorMessage: this.$t('user.index.098976-35'),
            })
                .then(({ value }) => {
                    resetUserPwd(row.userId, value).then((response) => {
                        this.$modal.msgSuccess(this.$t('resetPwdSuccess', [value]));
                    });
                })
                .catch(() => {});
        },
        /** 分配角色操作 */
        handleAuthRole: function (row) {
            const userId = row.userId;
            this.$router.push('/system/user-auth/role/' + userId);
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs['form'].validate((valid) => {
                if (valid) {
                    if (this.form.userId != undefined) {
                        updateUser(this.form).then((response) => {
                            this.$modal.msgSuccess(this.$t('updateSuccess'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addUser(this.form).then((response) => {
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
            const userIds = row.userId || this.ids;
            this.$modal
                .confirm(this.$t('system.user.index.confirmDel', [userIds]))
                .then(function () {
                    return delUser(userIds);
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
                'system/user/export',
                {
                    ...this.queryParams,
                },
                `user_${new Date().getTime()}.xlsx`
            );
        },
        /** 导入按钮操作 */
        handleImport() {
            this.upload.title = this.$t('system.user.index.userImport');
            this.upload.open = true;
        },
        /** 下载模板操作 */
        importTemplate() {
            this.download('system/user/importTemplate', {}, `user_template_${new Date().getTime()}.xlsx`);
        },
        // 文件上传中处理
        handleFileUploadProgress(event, file, fileList) {
            this.upload.isUploading = true;
        },
        // 文件上传成功处理
        handleFileSuccess(response, file, fileList) {
            this.upload.open = false;
            this.upload.isUploading = false;
            this.$refs.upload.clearFiles();
            this.$alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + response.msg + '</div>', this.$t('system.user.index.importResult'), { dangerouslyUseHTMLString: true });
            this.getList();
        },
        // 提交上传文件
        submitFileForm() {
            this.$refs.upload.submit();
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

.dept-card {
    margin-bottom: 15px;
    border-radius: 8px;
    height: 810px;

    ::v-deep .el-card__body {
        padding: 18px;
    }
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

::v-deep .el-tree {
    background-color: transparent;
}
</style>
