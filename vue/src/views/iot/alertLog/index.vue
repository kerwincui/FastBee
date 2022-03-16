<template>
<div style="padding:6px;">
    <el-card v-show="showSearch" style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="告警名称" prop="alertName">
                <el-input v-model="queryParams.alertName" placeholder="请输入告警名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="告警级别" prop="alertLevel">
                <el-select v-model="queryParams.alertLevel" placeholder="请选择告警级别" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_alert_level" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item label="处理状态" prop="status">
                <el-select v-model="queryParams.status" placeholder="请选择处理状态" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_process_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-table v-loading="loading" :data="alertLogList" @selection-change="handleSelectionChange" border>
            <el-table-column label="告警名称" align="center" prop="alertName" />
            <el-table-column label="告警级别" align="center" prop="alertLevel">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_alert_level" :value="scope.row.alertLevel" />
                </template>
            </el-table-column>
            <el-table-column label="处理状态" align="center" prop="status">
                <template slot-scope="scope">
                    <dict-tag :options="dict.type.iot_process_status" :value="scope.row.status" />
                </template>
            </el-table-column>
            <el-table-column label="产品ID" align="center" prop="productId" />
            <el-table-column label="产品名称" align="center" prop="productName" />
            <el-table-column label="设备ID" align="center" prop="deviceId" />
            <el-table-column label="设备名称" align="center" prop="deviceName" />
            <el-table-column label="创建时间" align="center" prop="createTime" width="180">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="处理结果" align="center" prop="remark" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:alertLog:edit']">处理</el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改设备告警对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="处理结果" prop="remark">
                    <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="8" />
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
    listAlertLog,
    getAlertLog,
    delAlertLog,
    addAlertLog,
    updateAlertLog
} from "@/api/iot/alertLog";

export default {
    name: "AlertLog",
    dicts: ['iot_alert_level', 'iot_process_status'],
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
            // 设备告警表格数据
            alertLogList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                alertName: null,
                alertLevel: null,
                status: null,
                productId: null,
                productName: null,
                deviceId: null,
                deviceName: null,
            },
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                alertName: [{
                    required: true,
                    message: "告警名称不能为空",
                    trigger: "blur"
                }],
                alertLevel: [{
                    required: true,
                    message: "告警级别不能为空",
                    trigger: "change"
                }],
                status: [{
                    required: true,
                    message: "处理状态(0=不需要处理,1=未处理,2=已处理)不能为空",
                    trigger: "change"
                }],
                productId: [{
                    required: true,
                    message: "产品ID不能为空",
                    trigger: "blur"
                }],
                productName: [{
                    required: true,
                    message: "产品名称不能为空",
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
            }
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询设备告警列表 */
        getList() {
            this.loading = true;
            listAlertLog(this.queryParams).then(response => {
                this.alertLogList = response.rows;
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
                alertLogId: null,
                alertName: null,
                alertLevel: null,
                status: null,
                productId: null,
                productName: null,
                deviceId: null,
                deviceName: null,
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
            this.ids = selection.map(item => item.alertLogId)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加设备告警";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const alertLogId = row.alertLogId || this.ids
            getAlertLog(alertLogId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改设备告警";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.alertLogId != null) {
                        updateAlertLog(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addAlertLog(this.form).then(response => {
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
            const alertLogIds = row.alertLogId || this.ids;
            this.$modal.confirm('是否确认删除设备告警编号为"' + alertLogIds + '"的数据项？').then(function () {
                return delAlertLog(alertLogIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/alertLog/export', {
                ...this.queryParams
            }, `alertLog_${new Date().getTime()}.xlsx`)
        }
    }
};
</script>
