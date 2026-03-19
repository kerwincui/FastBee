<template>
<div style="padding:6px;">
    <el-card v-show="showSearch" style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item :label="$t('iot.log.index.902341-0')" prop="logName">
                <el-input v-model="queryParams.logName" :placeholder="$t('iot.log.index.902341-1')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-2')" prop="logType">
                <el-select v-model="queryParams.logType" :placeholder="$t('iot.log.index.902341-3')" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_things_type" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-4')" prop="logLevel">
                <el-input v-model="queryParams.logLevel" :placeholder="$t('iot.log.index.902341-5')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-6')" prop="deviceId">
                <el-input v-model="queryParams.deviceId" :placeholder="$t('iot.log.index.902341-7')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-8')" prop="deviceName">
                <el-input v-model="queryParams.deviceName" :placeholder="$t('iot.log.index.902341-9')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-10')" prop="userName">
                <el-input v-model="queryParams.userName" :placeholder="$t('iot.log.index.902341-11')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-12')" prop="tenantName">
                <el-input v-model="queryParams.tenantName" :placeholder="$t('iot.log.index.902341-13')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-14')" prop="isAlert">
                <el-input v-model="queryParams.isAlert" :placeholder="$t('iot.log.index.902341-15')" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item :label="$t('iot.log.index.902341-16')" prop="status">
                <el-select v-model="queryParams.status" :placeholder="$t('iot.log.index.902341-17')" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">{{ $t('device.index.105953-8') }}</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">{{ $t('device.index.105953-9') }}</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:log:add']">{{ $t('iot.group.index.637432-5') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:log:edit']">{{ $t('iot.group.index.637432-17') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['iot:log:remove']">{{ $t('iot.group.index.637432-14') }}</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['iot:log:export']">{{ $t('export') }}</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="logList" @selection-change="handleSelectionChange" border>
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column :label="$t('iot.log.index.902341-0')" align="center" prop="logName" />
            <el-table-column :label="$t('iot.log.index.902341-18')" align="center" prop="logValue" />
            <el-table-column :label="$t('iot.log.index.902341-2')" align="center" prop="logType">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_things_type" :value="scope.row.logType" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.log.index.902341-4')" align="center" prop="logLevel">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.logLevel" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.log.index.902341-6')" align="center" prop="deviceId" />
            <el-table-column :label="$t('iot.log.index.902341-8')" align="center" prop="deviceName" />
            <el-table-column :label="$t('iot.log.index.902341-19')" align="center" prop="userId" />
            <el-table-column :label="$t('iot.log.index.902341-10')" align="center" prop="userName" />
            <el-table-column :label="$t('iot.log.index.902341-20')" align="center" prop="tenantId" />
            <el-table-column :label="$t('iot.log.index.902341-12')" align="center" prop="tenantName" />
            <el-table-column :label="$t('iot.log.index.902341-21')" align="center" prop="triggerSource">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.triggerSource" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.log.index.902341-14')" align="center" prop="isAlert">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.isAlert" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.log.index.902341-16')" align="center" prop="status">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_yes_no" :value="scope.row.status" />
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.group.index.637432-7')" align="center" prop="createTime" width="180">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column :label="$t('iot.group.index.637432-9')" align="center" prop="remark" />
            <el-table-column :label="$t('iot.group.index.637432-10')" align="center" class-name="small-padding fixed-width" width="150">
                <template slot-scope="scope">
                    <el-button size="small" type="primary" style="padding:5px;" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:log:edit']">{{ $t('iot.log.index.902341-22') }}</el-button>
                    <!-- <el-button size="small" type="danger" style="padding:5px;" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:log:remove']">{{ $t('iot.group.index.637432-14') }}</el-button> -->
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改设备日志对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item :label="$t('iot.log.index.902341-0')" prop="logName">
                    <el-input v-model="form.logName" :placeholder="$t('iot.log.index.902341-1')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-2')" prop="logType">
                    <el-select v-model="form.logType" :placeholder="$t('iot.log.index.902341-3')">
                        <el-option v-for="dict in dict.type.iot_things_type" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-4')" prop="logLevel">
                    <el-input v-model="form.logLevel" :placeholder="$t('iot.log.index.902341-5')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-6')" prop="deviceId">
                    <el-input v-model="form.deviceId" :placeholder="$t('iot.log.index.902341-7')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-8')" prop="deviceName">
                    <el-input v-model="form.deviceName" :placeholder="$t('iot.log.index.902341-9')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-19')" prop="userId">
                    <el-input v-model="form.userId" :placeholder="$t('iot.log.index.902341-23')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-10')" prop="userName">
                    <el-input v-model="form.userName" :placeholder="$t('iot.log.index.902341-11')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-20')" prop="tenantId">
                    <el-input v-model="form.tenantId" :placeholder="$t('iot.log.index.902341-24')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-12')" prop="tenantName">
                    <el-input v-model="form.tenantName" :placeholder="$t('iot.log.index.902341-13')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-21')" prop="triggerSource">
                    <el-input v-model="form.triggerSource" :placeholder="$t('iot.log.index.902341-25')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-26')" prop="isAlert">
                    <el-input v-model="form.isAlert" :placeholder="$t('iot.log.index.902341-15')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-16')">
                    <el-radio-group v-model="form.status">
                        <el-radio v-for="dict in dict.type.iot_yes_no" :key="dict.value" :label="parseInt(dict.value)">{{dict.label}}</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item :label="$t('iot.group.index.637432-9')" prop="remark">
                    <el-input v-model="form.remark" :placeholder="$t('iot.group.index.637432-16')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-27')" prop="logValue">
                    <el-input v-model="form.logValue" :placeholder="$t('iot.log.index.902341-28')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-29')" prop="istop">
                    <el-input v-model="form.istop" :placeholder="$t('iot.log.index.902341-30')" />
                </el-form-item>
                <el-form-item :label="$t('iot.log.index.902341-31')" prop="ismonitor">
                    <el-input v-model="form.ismonitor" :placeholder="$t('iot.log.index.902341-32')" />
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">{{ $t('device.index.105953-56') }}</el-button>
                <el-button @click="cancel">{{ $t('iot.group.index.637432-19') }}</el-button>
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
                    message: this.$t('iot.log.index.902341-33'),
                    trigger: "blur"
                }],
                logType: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-34'),
                    trigger: "change"
                }],
                logLevel: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-35'),
                    trigger: "blur"
                }],
                deviceId: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-36'),
                    trigger: "blur"
                }],
                deviceName: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-37'),
                    trigger: "blur"
                }],
                userId: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-38'),
                    trigger: "blur"
                }],
                userName: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-39'),
                    trigger: "blur"
                }],
                tenantId: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-40'),
                    trigger: "blur"
                }],
                tenantName: [{
                    required: true,
                    message: this.$t('iot.log.index.902341-41'),
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
            this.title = this.$t('iot.log.index.902341-42');
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const deviceLogId = row.deviceLogId || this.ids
            getLog(deviceLogId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('iot.log.index.902341-43');
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.deviceLogId != null) {
                        updateLog(this.form).then(response => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-24'));
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addLog(this.form).then(response => {
                            this.$modal.msgSuccess(this.$t('iot.group.index.637432-25'));
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
            this.$modal.confirm(this.$t('iot.log.index.902341-44', [deviceLogIds])).then(function () {
                return delLog(deviceLogIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess(this.$t('iot.group.index.637432-27'));
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
