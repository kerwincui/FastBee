<template>
<div style="padding-left:20px;">
    <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="selectUser" v-hasPermi="['iot:deviceUser:add']">分享设备</el-button>
        </el-col>
        <right-toolbar @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="deviceUserList" @selection-change="handleSelectionChange" size="mini">
        <el-table-column label="用户昵称" align="center" prop="userName" width="200" />
        <el-table-column label="手机号码" align="center" prop="phonenumber" width="200" />
        <el-table-column label="设备所有者" align="center" prop="isOwner" width="100">
            <template slot-scope="scope">
                <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isOwner" />
            </template>
        </el-table-column>
        <el-table-column label="创建时间" align="center" prop="createTime" width="150">
            <template slot-scope="scope">
                <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
            </template>
        </el-table-column>
        <el-table-column label="备注" align="left" prop="remark" al />
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
            <template slot-scope="scope">
                <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:deviceUser:edit']" v-if="scope.row.isOwner==0">备注</el-button>
                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:deviceUser:remove']" v-if="scope.row.isOwner==0">删除</el-button>
            </template>
        </el-table-column>
    </el-table>

    <!-- 添加或修改设备用户对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="8" />
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm">确 定</el-button>
            <el-button @click="cancel">取 消</el-button>
        </div>
    </el-dialog>

    <!-- 选择用户 -->
    <user-list ref="userList" :device="device" />

</div>
</template>

<script>
import userList from "./user-list"
import {
    listDeviceUser,
    getDeviceUser,
    delDeviceUser,
    updateDeviceUser
} from "@/api/iot/deviceuser";

export default {
    name: "device-user",
    dicts: ['iot_yes_no'],
    components: {
        userList
    },
    props: {
        device: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device后，刷新列表
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
            if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
                this.queryParams.deviceId = this.deviceInfo.deviceId;
                this.getList();
            }
        }
    },
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
            // 设备用户表格数据
            deviceUserList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                deviceName: null,
                userName: null,
                tenantName: null,
                isOwner: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                deviceName: [{
                    required: true,
                    message: "设备名称不能为空",
                    trigger: "blur"
                }],
                userName: [{
                    required: true,
                    message: "用户昵称不能为空",
                    trigger: "blur"
                }],
            }
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询设备用户列表 */
        getList() {
            this.loading = true;
            listDeviceUser(this.queryParams).then(response => {
                this.deviceUserList = response.rows;
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
                deviceId: null,
                userId: null,
                deviceName: null,
                userName: null,
                tenantId: null,
                tenantName: null,
                isOwner: null,
                limitNum: null,
                delFlag: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null
            };
            this.resetForm("form");
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm("queryForm");
            this.handleQuery();
        },
        // 多选框选中数据
        handleSelectionChange(selection) {
            this.ids = selection.map(item => item.deviceId)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加设备用户";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const deviceId = row.deviceId || this.ids
            getDeviceUser(deviceId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "用户备注";
            });
        },
        /** 提交按钮 */
        submitForm() {
            if (this.form.deviceId != null) {
                updateDeviceUser(this.form).then(response => {
                    this.$modal.msgSuccess("备注成功");
                    this.open = false;
                    this.getList();
                });
            }
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const deviceIds = row.deviceId || this.ids;
            this.$modal.confirm('是否确认删除设备用户编号为"' + deviceIds + '"的数据项？').then(function () {
                return delDeviceUser(deviceIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/deviceUser/export', {
                ...this.queryParams
            }, `deviceUser_${new Date().getTime()}.xlsx`)
        },
        // 选择用户
        selectUser() {
            this.$refs.userList.openSelectUser = true;
        },
    }
};
</script>
