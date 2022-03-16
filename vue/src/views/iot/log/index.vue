<template>
<div style="padding:6px;">
    <el-card v-show="showSearch" style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="日志名称" prop="logName">
                <el-input v-model="queryParams.logName" placeholder="请输入日志名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="类型" prop="logType">
                <el-select v-model="queryParams.logType" placeholder="请选择类型" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_things_type" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item label="日志级别" prop="logLevel">
                <el-input v-model="queryParams.logLevel" placeholder="请输入日志级别" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="设备ID" prop="deviceId">
                <el-input v-model="queryParams.deviceId" placeholder="请输入设备ID" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="设备名称" prop="deviceName">
                <el-input v-model="queryParams.deviceName" placeholder="请输入设备名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="用户昵称" prop="userName">
                <el-input v-model="queryParams.userName" placeholder="请输入用户昵称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="租户名称" prop="tenantName">
                <el-input v-model="queryParams.tenantName" placeholder="请输入租户名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="生成告警" prop="isAlert">
                <el-input v-model="queryParams.isAlert" placeholder="请输入是否生成告警" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="告警处理" prop="status">
                <el-select v-model="queryParams.status" placeholder="请选择告警处理" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:log:add']">新增</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:log:edit']">修改</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:log:remove']">删除</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['iot:log:export']">导出</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="logList" @selection-change="handleSelectionChange" border>
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="日志名称" align="center" prop="logName" />
            <el-table-column label="值" align="center" prop="logValue" />
            <el-table-column label="类型" align="center" prop="logType">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_things_type" :value="scope.row.logType" />
                </template>
            </el-table-column>
            <el-table-column label="日志级别" align="center" prop="logLevel">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.logLevel" />
                </template>
            </el-table-column>
            <el-table-column label="设备ID" align="center" prop="deviceId" />
            <el-table-column label="设备名称" align="center" prop="deviceName" />
            <el-table-column label="用户ID" align="center" prop="userId" />
            <el-table-column label="用户昵称" align="center" prop="userName" />
            <el-table-column label="租户ID" align="center" prop="tenantId" />
            <el-table-column label="租户名称" align="center" prop="tenantName" />
            <el-table-column label="触发源" align="center" prop="triggerSource">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.triggerSource" />
                </template>
            </el-table-column>
            <el-table-column label="生成告警" align="center" prop="isAlert">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isAlert" />
                </template>
            </el-table-column>
            <el-table-column label="告警处理" align="center" prop="status">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.status" />
                </template>
            </el-table-column>
            <el-table-column label="创建时间" align="center" prop="createTime" width="180">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="备注" align="center" prop="remark" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
                <template slot-scope="scope">
                    <el-button size="small" type="primary" style="padding:5px;" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:log:edit']">处理</el-button>
                    <!-- <el-button size="small" type="danger" style="padding:5px;" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:log:remove']">删除</el-button> -->
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改设备日志对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="日志名称" prop="logName">
                    <el-input v-model="form.logName" placeholder="请输入日志名称" />
                </el-form-item>
                <el-form-item label="类型" prop="logType">
                    <el-select v-model="form.logType" placeholder="请选择类型">
                        <el-option v-for="dict in dict.type.iot_things_type" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="日志级别" prop="logLevel">
                    <el-input v-model="form.logLevel" placeholder="请输入日志级别" />
                </el-form-item>
                <el-form-item label="设备ID" prop="deviceId">
                    <el-input v-model="form.deviceId" placeholder="请输入设备ID" />
                </el-form-item>
                <el-form-item label="设备名称" prop="deviceName">
                    <el-input v-model="form.deviceName" placeholder="请输入设备名称" />
                </el-form-item>
                <el-form-item label="用户ID" prop="userId">
                    <el-input v-model="form.userId" placeholder="请输入用户ID" />
                </el-form-item>
                <el-form-item label="用户昵称" prop="userName">
                    <el-input v-model="form.userName" placeholder="请输入用户昵称" />
                </el-form-item>
                <el-form-item label="租户ID" prop="tenantId">
                    <el-input v-model="form.tenantId" placeholder="请输入租户ID" />
                </el-form-item>
                <el-form-item label="租户名称" prop="tenantName">
                    <el-input v-model="form.tenantName" placeholder="请输入租户名称" />
                </el-form-item>
                <el-form-item label="触发源" prop="triggerSource">
                    <el-input v-model="form.triggerSource" placeholder="请输入触发源" />
                </el-form-item>
                <el-form-item label="是否生成告警" prop="isAlert">
                    <el-input v-model="form.isAlert" placeholder="请输入是否生成告警" />
                </el-form-item>
                <el-form-item label="告警处理">
                    <el-radio-group v-model="form.status">
                        <el-radio v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="parseInt(dict.value)">{{dict.label}}</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="备注" prop="remark">
                    <el-input v-model="form.remark" placeholder="请输入备注" />
                </el-form-item>
                <el-form-item label="日志收到的值" prop="logValue">
                    <el-input v-model="form.logValue" placeholder="请输入日志收到的值" />
                </el-form-item>
                <el-form-item label="是否置顶" prop="istop">
                    <el-input v-model="form.istop" placeholder="请输入是否置顶" />
                </el-form-item>
                <el-form-item label="是否监测" prop="ismonitor">
                    <el-input v-model="form.ismonitor" placeholder="请输入是否监测" />
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>

    </el-card>
</div>
</template>

<script>
import {
    listLog,
    getLog,
    delLog,
    addLog,
    updateLog
} from "@/api/iot/log";

export default {
    name: "Log",
    dicts: ['iot_things_type', 'iot_yes_no'],
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
            // 设备日志表格数据
            logList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                logName: null,
                logType: null,
                logLevel: null,
                deviceId: null,
                deviceName: null,
                userName: null,
                tenantName: null,
                triggerSource: null,
                isAlert: null,
                status: null,
                istop: null,
                ismonitor: null
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                logName: [{
                    required: true,
                    message: "日志名称不能为空",
                    trigger: "blur"
                }],
                logType: [{
                    required: true,
                    message: "类型不能为空",
                    trigger: "change"
                }],
                logLevel: [{
                    required: true,
                    message: "日志级别不能为空",
                    trigger: "blur"
                }],
                deviceId: [{
                    required: true,
                    message: "设备ID不能为空",
                    trigger: "blur"
                }],
                deviceName: [{
                    required: true,
                    message: "设备名称不能为空",
                    trigger: "blur"
                }],
                userId: [{
                    required: true,
                    message: "用户ID不能为空",
                    trigger: "blur"
                }],
                userName: [{
                    required: true,
                    message: "用户昵称不能为空",
                    trigger: "blur"
                }],
                tenantId: [{
                    required: true,
                    message: "租户ID不能为空",
                    trigger: "blur"
                }],
                tenantName: [{
                    required: true,
                    message: "租户名称不能为空",
                    trigger: "blur"
                }],
            }
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询设备日志列表 */
        getList() {
            this.loading = true;
            listLog(this.queryParams).then(response => {
                this.logList = response.rows;
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
                deviceLogId: null,
                logName: null,
                logType: null,
                logLevel: null,
                deviceId: null,
                deviceName: null,
                userId: null,
                userName: null,
                tenantId: null,
                tenantName: null,
                triggerSource: null,
                isAlert: null,
                status: 0,
                createBy: null,
                createTime: null,
                remark: null,
                logValue: null,
                istop: null,
                ismonitor: null
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
            this.ids = selection.map(item => item.deviceLogId)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加设备日志";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const deviceLogId = row.deviceLogId || this.ids
            getLog(deviceLogId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改设备日志";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.deviceLogId != null) {
                        updateLog(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addLog(this.form).then(response => {
                            this.$modal.msgSuccess("新增成功");
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const deviceLogIds = row.deviceLogId || this.ids;
            this.$modal.confirm('是否确认删除设备日志编号为"' + deviceLogIds + '"的数据项？').then(function () {
                return delLog(deviceLogIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/log/export', {
                ...this.queryParams
            }, `log_${new Date().getTime()}.xlsx`)
        }
    }
};
</script>
