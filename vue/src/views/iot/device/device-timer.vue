<template>
<div style="padding-left:20px;">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="70px">
        <el-form-item label="定时名称" prop="jobName">
            <el-input v-model="queryParams.jobName" placeholder="请输入定时名称" clearable size="small" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="定时状态" prop="status" style="margin-left:20px;">
            <el-select v-model="queryParams.status" placeholder="请选择定时状态" clearable size="small">
                <el-option v-for="dict in dict.type.sys_job_status" :key="dict.value" :label="dict.label" :value="dict.value" />
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
        <el-form-item style="float:right;">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:device:timer']">新增</el-button>
        </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="jobList" @selection-change="handleSelectionChange" size="mini">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="名称" align="center" prop="jobName" :show-overflow-tooltip="true" />
        <el-table-column label="描述" align="center" prop="cronText">
            <template slot-scope="scope">
                <div v-html="formatCronDisplay(scope.row)"></div>
            </template>
        </el-table-column>
        <el-table-column label="CRON表达式" align="center" prop="cronExpression" :show-overflow-tooltip="true" />
        <el-table-column label="动作" align="left" prop="actions" :show-overflow-tooltip="true">
            <template slot-scope="scope">
                <div v-html="formatActionsDisplay(scope.row.actions)"></div>
            </template>
        </el-table-column>

        <el-table-column label="状态" align="center">
            <template slot-scope="scope">
                <el-switch v-model="scope.row.status" active-value="0" inactive-value="1" active-text="启用" @change="handleStatusChange(scope.row)"></el-switch>
            </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
                <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:device:timer']">修改</el-button>
                <el-button size="mini" type="text" icon="el-icon-caret-right" @click="handleView(scope.row)" v-hasPermi="['iot:device:timer']">定时详细</el-button><br />
                <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:device:timer']">删除</el-button>
                <el-button size="mini" type="text" icon="el-icon-caret-right" @click="handleRun(scope.row)" v-hasPermi="['iot:device:timer']">执行一次</el-button>
            </template>
        </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改定时定时对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="120px">
            <el-form-item label="定时名称" prop="jobName">
                <el-input v-model="form.jobName" placeholder="请输入定时名称" style="width:340px;" />
            </el-form-item>
            <el-form-item label="执行时间" prop="timerTimeValue">
                <el-time-picker v-model="timerTimeValue" value-format="HH:mm" placeholder="选择时间" style="width:340px;" @change="timeChange" :disabled="form.isAdvance==1"></el-time-picker>
            </el-form-item>
            <el-form-item label="重复执行" prop="timerWeek">
                <el-row>
                    <el-col :span="4">
                        <el-select v-model="timerRepeatValue" placeholder="请选择" @change="repeatChange" :disabled="form.isAdvance==1">
                            <el-option v-for="item in timerRepeats" :key="item.value" :label="item.label" :value="item.value">
                            </el-option>
                        </el-select>
                    </el-col>
                    <el-col :span="15" :offset="1" v-if="timerRepeatValue==2">
                        <el-select v-model="timerWeekValue" placeholder="请选择" multiple style="width:485px" @change="weekChange" :disabled="form.isAdvance==1">
                            <el-option v-for="item in timerWeeks" :key="item.value" :label="item.label" :value="item.value">
                            </el-option>
                        </el-select>
                    </el-col>
                </el-row>
            </el-form-item>
            <el-form-item label="cron表达式" prop="cron">
                <el-row>
                    <el-col :span="18">
                        <el-input v-model="form.cronExpression" placeholder="cron执行表达式" :disabled="form.isAdvance==0">
                            <template slot="append">
                                <el-button type="primary" @click="handleShowCron" :disabled="form.isAdvance==0">
                                    生成表达式
                                    <i class="el-icon-time el-icon--right"></i>
                                </el-button>
                            </template>
                        </el-input>
                    </el-col>
                    <el-col :span="4" :offset="1">
                        <el-checkbox v-model="form.isAdvance" :true-label="1" :false-label="0" @change="customerCronChange">自定义表达式</el-checkbox>
                    </el-col>
                </el-row>
            </el-form-item>
            <el-form-item label="定时状态" prop="status">
                <el-radio-group v-model="form.status">
                    <el-radio v-for="dict in dict.type.sys_job_status" :key="dict.value" :label="dict.value">{{dict.label}}</el-radio>
                </el-radio-group>
            </el-form-item>

            <div style="padding-bottom:15px;padding:0 20px;">
                <el-divider></el-divider>
            </div>
            <el-form-item label="执行动作" prop="actions">
                <el-row v-for="(actionItem,index) in actionList" :key="index+'action'" style="margin-bottom:10px;">
                    <el-col :span="4">
                        <el-select v-model="actionItem.type" placeholder="请选择类别">
                            <el-option v-for="(subItem,subIndex) in modelTypes" :key="subIndex+'type'" :label="subItem.label" :value="subItem.value">
                            </el-option>
                        </el-select>
                    </el-col>
                    <el-col :span="4" :offset="1">
                        <el-select v-model="actionItem.id" placeholder="请选择" v-if="actionItem.type==1" @change="thingsModelItemChange($event,index)">
                            <el-option v-for="(subItem,subIndex) in thingsModel.properties" :key="subIndex+'property'" :label="subItem.name" :value="subItem.id">
                            </el-option>
                        </el-select>
                        <el-select v-model="actionItem.id" placeholder="请选择" v-else-if="actionItem.type==2" @change="thingsModelItemChange($event,index)">
                            <el-option v-for="(subItem,subIndex) in thingsModel.functions" :key="subIndex+'func'" :label="subItem.name" :value="subItem.id">
                            </el-option>
                        </el-select>
                    </el-col>
                    <el-col :span="10" :offset="1">
                        <!--物模型项的值-->
                        <span v-if="actionItem.thingsModelItem &&(actionItem.thingsModelItem.datatype.type=='integer' || actionItem.thingsModelItem.datatype.type=='decimal')">
                            <el-input style="width:180px;" v-model="actionItem.value" placeholder="值" :max="actionItem.thingsModelItem.datatype.max" :min="actionItem.thingsModelItem.datatype.min" type="number" />
                            <el-input style="width:70px;margin-left:15px;" v-model="actionItem.thingsModelItem.datatype.unit" placeholder="请输入整数或小数" disabled />
                        </span>
                        <span v-else-if=" actionItem.thingsModelItem && actionItem.thingsModelItem.datatype.type=='bool'">
                            <el-switch v-model="actionItem.value" :active-text="actionItem.thingsModelItem.datatype.trueText" :inactive-text="actionItem.thingsModelItem.datatype.falseText" active-value="1" inactive-value="0">
                            </el-switch>
                        </span>
                        <span v-else-if="actionItem.thingsModelItem && actionItem.thingsModelItem.datatype.type=='enum'">
                            <el-select v-model="actionItem.value" placeholder="请选择" style="width:100%">
                                <el-option v-for="(subItem,subIndex) in actionItem.thingsModelItem.datatype.enumList" :key="subIndex+'things'" :label="subItem.text" :value="subItem.value">
                                </el-option>
                            </el-select>
                        </span>
                        <span v-else-if="actionItem.thingsModelItem && actionItem.thingsModelItem.datatype.type=='string'">
                            <el-input v-model="actionItem.value" placeholder="请输入字符串" :max="actionItem.thingsModelItem.datatype.maxLength" />
                        </span>
                        <span v-else-if="actionItem.thingsModelItem && actionItem.thingsModelItem.datatype.type=='array'">
                            <el-input v-model="actionItem.value" placeholder="请输入英文逗号分隔的数组" />
                        </span>
                    </el-col>
                    <el-col :span="2" :offset="1" v-if="index!=0"><a style="color:#F56C6C" @click="removeEnumItem(index)">删除</a></el-col>
                </el-row>
                <div>+ <a style="color:#409EFF" @click="addEnumItem()">添加执行动作</a></div>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm" :loading="submitButtonLoading">确 定</el-button>
            <el-button @click="cancel">取 消</el-button>
        </div>
    </el-dialog>

    <el-dialog title="Cron表达式生成器" :visible.sync="openCron" append-to-body destroy-on-close class="scrollbar">
        <crontab @hide="openCron=false" @fill="crontabFill" :expression="expression" style="padding-bottom:80px;"></crontab>
    </el-dialog>

    <!-- 定时日志详细 -->
    <el-dialog title="定时详细" :visible.sync="openView" width="700px" append-to-body>
        <el-form ref="form" :model="form" label-width="120px" size="mini">
            <el-row>
                <el-col :span="12">
                    <el-form-item label="定时编号：">{{ form.jobId }}</el-form-item>
                    <el-form-item label="定时名称：">{{ form.jobName }}</el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="定时分组：">{{ jobGroupFormat(form) }}</el-form-item>
                    <el-form-item label="创建时间：">{{ form.createTime }}</el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="是否并发：">
                        <div v-if="form.concurrent == 0">允许</div>
                        <div v-else-if="form.concurrent == 1">禁止</div>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="cron表达式：">{{ form.cronExpression }}</el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="执行策略：">
                        <div v-if="form.misfirePolicy == 0">默认策略</div>
                        <div v-else-if="form.misfirePolicy == 1">立即执行</div>
                        <div v-else-if="form.misfirePolicy == 2">执行一次</div>
                        <div v-else-if="form.misfirePolicy == 3">放弃执行</div>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="下次执行时间：">{{ parseTime(form.nextValidTime) }}</el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="定时状态：">
                        <div v-if="form.status == 0">正常</div>
                        <div v-else-if="form.status == 1">暂停</div>
                    </el-form-item>
                </el-col>

                <el-col :span="24">
                    <el-form-item label="执行动作：">
                        <div v-html="formatActionsDisplay(form.actions)" style="border:1px solid #ddd;padding:10px;border-radius:5px;width:465px;"></div>
                    </el-form-item>
                </el-col>

            </el-row>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="openView = false">关 闭</el-button>
        </div>
    </el-dialog>
</div>
</template>

<script>
import {
    listJob,
    getJob,
    delJob,
    addJob,
    updateJob,
    runJob,
    changeJobStatus
} from "@/api/iot/deviceJob";
import Crontab from '@/components/Crontab'
import {
    cacheJsonThingsModel
} from "@/api/iot/model";
export default {
    components: {
        Crontab
    },
    name: "device-timer",
    dicts: ['sys_job_group', 'sys_job_status'],
    props: {
        device: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device后
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
            if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
                // 获取缓存的Json物模型
                cacheJsonThingsModel(this.deviceInfo.productId).then(response => {
                    this.thingsModel = JSON.parse(response.data);
                    // 过滤监测数据，监测数据为只读
                    this.thingsModel.properties = this.thingsModel.properties.filter(item => item.isMonitor == 0);
                    this.queryParams.deviceId = this.deviceInfo.deviceId;
                    this.getList();
                });
            }
        }
    },
    data() {
        return {
            // 物模型JSON
            thingsModel: {},
            // 动作列表
            actionList: [],
            // 设备
            deviceInfo: {},
            // 遮罩层
            loading: false,
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
            // 定时定时表格数据
            jobList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 是否显示详细弹出层
            openView: false,
            // 是否显示Cron表达式弹出层
            openCron: false,
            // 传入的表达式
            expression: "",
            // 提交按钮加载
            submitButtonLoading: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                deviceId: 0,
                jobName: undefined,
                jobGroup: undefined,
                status: undefined
            },
            // 重复执行项
            timerRepeats: [{
                value: 1,
                label: '每天'
            }, {
                value: 2,
                label: '指定'
            }],
            timerRepeatValue: 1,
            // 周
            timerWeeks: [{
                value: 1,
                label: '周一'
            }, {
                value: 2,
                label: '周二'
            }, {
                value: 3,
                label: '周三'
            }, {
                value: 4,
                label: '周四'
            }, {
                value: 5,
                label: '周五'
            }, {
                value: 6,
                label: '周六'
            }, {
                value: 7,
                label: '周日'
            }],
            timerWeekValue: [1, 2, 3, 4, 5, 6, 7],
            // 时间
            timerTimeValue: '',
            // 物模型类别
            modelTypes: [{
                value: 1,
                label: '属性'
            }, {
                value: 2,
                label: '功能'
            }],
            // 表单参数
            form: {},
            // 表单校验
            rules: {
                jobName: [{
                    required: true,
                    message: "定时名称不能为空",
                    trigger: "blur"
                }],
            }
        };
    },
    created() {

    },
    methods: {
        /** 查询定时定时列表 */
        getList() {
            this.loading = true;
            listJob(this.queryParams).then(response => {
                this.jobList = response.rows;
                this.total = response.total;
                this.loading = false;
            });
        },
        // 定时组名字典翻译
        jobGroupFormat(row, column) {
            return this.selectDictLabel(this.dict.type.sys_job_group, row.jobGroup);
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        // 表单重置
        reset() {
            this.form = {
                jobId: undefined,
                jobName: undefined,
                cronExpression: undefined,
                status: "0",
                jobGroup: "DEFAULT", // 定时分组
                misfirePolicy: 2, // 1=立即执行，2=执行一次，3=放弃执行
                concurrent: 1, // 是否并发，1=禁止，0=允许
                isAdvance: 0, // 是否详细cron表达式
                jobType: 1, // 任务类型 1=设备定时，2=设备告警，3=场景联动
                productId: 0,
                productName: "",
                sceneId: 0, //场景ID
                alertId: 0, // 告警ID
                actions: "",
            };
            this.submitButtonLoading = false;
            this.timerRepeatValue = 1;
            this.timerWeekValue = [1, 2, 3, 4, 5, 6, 7];
            this.timerTimeValue = "";
            this.actionList = [{
                id: "",
                name: "",
                value: "",
                type: 2, // 1=属性，2=功能，3=事件，5=设备上线，6=设备下线
                source: 2, // 1=设备，2=定时，3=告警输出
                deviceId: this.deviceInfo.deviceId,
                deviceName: this.deviceInfo.deviceName,
                alertName: "", // 告警名称 可选
                alertLevel: 1, // 告警级别 告警级别（1=提醒通知，2=轻微问题，3=严重警告）
                thingsModelItem: {
                    id: "",
                    name: "",
                    datatype: {
                        type: "",
                    }
                }
            }];
            // 物模型项,对应actions
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
            this.ids = selection.map(item => item.jobId);
            this.single = selection.length != 1;
            this.multiple = !selection.length;
        },
        // 定时状态修改
        handleStatusChange(row) {
            let text = row.status === "0" ? "启用" : "停用";
            this.$modal.confirm('确认要"' + text + '""' + row.jobName + '"定时吗？').then(function () {
                return changeJobStatus(row.jobId, row.status);
            }).then(() => {
                this.$modal.msgSuccess(text + "成功");
            }).catch(function () {
                row.status = row.status === "0" ? "1" : "0";
            });
        },
        /* 立即执行一次 */
        handleRun(row) {
            this.$modal.confirm('确认要立即执行一次"' + row.jobName + '"定时吗？').then(function () {
                return runJob(row.jobId, row.jobGroup);
            }).then(() => {
                this.$modal.msgSuccess("执行成功");
            }).catch(() => {});
        },
        /** 定时详细信息 */
        handleView(row) {
            getJob(row.jobId).then(response => {
                this.form = response.data;
                this.openView = true;
            });
        },
        /** cron表达式按钮操作 */
        handleShowCron() {
            this.expression = this.form.cronExpression;
            this.openCron = true;
        },
        /** 确定后回传值 */
        crontabFill(value) {
            this.form.cronExpression = value;
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加定时";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const jobId = row.jobId || this.ids;
            getJob(jobId).then(response => {
                this.form = response.data;
                // actionList赋值
                this.actionList = JSON.parse(this.form.actions);
                for (let i = 0; i < this.actionList.length; i++) {
                    if (this.actionList[i].type == 1) {
                        for (let j = 0; j < this.thingsModel.properties.length; j++) {
                            if (this.actionList[i].id == this.thingsModel.properties[j].id) {
                                this.actionList[i].thingsModelItem = this.thingsModel.properties[j];
                                break;
                            }
                        }
                    } else if (this.actionList[i].type == 2) {
                        for (let j = 0; j < this.thingsModel.functions.length; j++) {
                            if (this.actionList[i].id == this.thingsModel.functions[j].id) {
                                this.actionList[i].thingsModelItem = this.thingsModel.functions[j];
                                break;
                            }
                        }
                    }
                }
                if (this.form.isAdvance == 0) {
                    // 解析执行时间和重复执行项
                    if (this.form.cronExpression.substring(12) == "1,2,3,4,5,6,7") {
                        this.timerRepeatValue = 1; // 每天
                    } else {
                        this.timerRepeatValue = 2; // 指定
                    }
                    let arrayValue = this.form.cronExpression.substring(12).split(",").map(Number);
                    this.timerWeekValue = arrayValue;
                    this.timerTimeValue = this.form.cronExpression.substring(5, 7) + ":" + this.form.cronExpression.substring(2, 4)
                }
                this.open = true;
                this.title = "修改定时";
            });
        },
        /** 提交按钮 */
        submitForm: function () {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    // 验证不能为空
                    if (this.form.isAdvance == 0) {
                        if (this.timerTimeValue == "" || this.timerTimeValue == null) {
                            this.$modal.alertError("执行时间不能空");
                            return;
                        }
                        if (this.timerRepeatValue == 2 && (this.timerWeekValue == null || this.timerWeekValue == "")) {
                            this.$modal.alertError("请选择要执行的星期");
                            return;
                        }
                    } else if (this.form.isAdvance == 1) {
                        if (this.form.cronExpression == "") {
                            this.$modal.alertError("cron表达式不能为空");
                            return;
                        }
                    }
                    for (let i = 0; i < this.actionList.length; i++) {
                        if (this.actionList[i].id == "" || this.actionList[i].name == "" || this.actionList[i].value == "") {
                            this.$modal.alertError("执行动作中的选项和值不能为空");
                            return;
                        }
                    }
                    // 动作
                    this.actionList[0].deviceId = this.deviceInfo.deviceId;
                    this.actionList[0].deviceName = this.deviceInfo.deviceName;
                    // 删除对象中的物模型属性
                    for (let i = 0; i < this.actionList.length; i++) {
                        this.$delete(this.actionList[i], 'thingsModelItem');
                    }
                    this.form.actions = JSON.stringify(this.actionList);
                    // 设备信息
                    this.form.deviceId = this.deviceInfo.deviceId;
                    this.form.deviceName = this.deviceInfo.deviceName;
                    this.form.serialNumber = this.deviceInfo.serialNumber;
                    this.form.productId = this.deviceInfo.productId;
                    this.form.productName = this.deviceInfo.productName;
                    console.log("this.form:", this.form);
                    // 按钮等待后端加载完
                    this.submitButtonLoading = true;
                    if (this.form.jobId != undefined) {
                        updateJob(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.submitButtonLoading = false;
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addJob(this.form).then(response => {
                            this.$modal.msgSuccess("新增成功");
                            this.submitButtonLoading = false;
                            this.open = false;
                            this.getList();
                        });
                    }
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const jobIds = row.jobId || this.ids;
            this.$modal.confirm('是否确认删除定时定时编号为"' + jobIds + '"的数据项？').then(function () {
                return delJob(jobIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/job/export', {
                ...this.queryParams
            }, `job_${new Date().getTime()}.xlsx`)
        },

        /** 添加枚举项 */
        addEnumItem() {
            this.actionList.push({
                id: "",
                name: "",
                value: "",
                type: 2, // 1=属性，2=功能，3=事件，5=设备上线，6=设备下线
                source: 2, // 1=设备，2=定时，3=告警输出
                deviceId: this.deviceInfo.deviceId,
                deviceName: this.deviceInfo.deviceName,
                alertName: "", // 告警名称 可选
                alertLevel: 1, // 告警级别 告警级别（1=提醒通知，2=轻微问题，3=严重警告）
                thingsModelItem: {
                    id: "",
                    name: "",
                    datatype: {
                        type: "",
                    }
                }
            });
        },
        /** 删除枚举项 */
        removeEnumItem(index) {
            this.actionList.splice(index, 1);
        },
        /** 修改重复事件 **/
        repeatChange(data) {
            if (data == 1) {
                // 每天
                this.timerWeekValue = [1, 2, 3, 4, 5, 6, 7];
            } else if (data == 2) {
                // 指定
                this.timerWeekValue = [1, 2, 3, 4, 5, 6, 7];
            }
            this.gentCronExpression();
        },
        /** 星期改变事件 **/
        weekChange(data) {
            this.gentCronExpression();
        },
        /** 时间改变事件 **/
        timeChange(data) {
            this.gentCronExpression();
        },
        /**自定义cron表达式选项改变事件 */
        customerCronChange(data) {
            if (data == 0) {
                this.gentCronExpression();
            }
        },
        /** 生成cron表达式**/
        gentCronExpression() {
            let hour = "00";
            let minute = "00";
            if (this.timerTimeValue != null && this.timerTimeValue != "") {
                hour = this.timerTimeValue.substring(0, 2);
                minute = this.timerTimeValue.substring(3);
            }
            let week = "*";
            if (this.timerWeekValue.length > 0) {
                week = this.timerWeekValue.sort();
            }
            this.form.cronExpression = "0 " + minute + " " + hour + " ? * " + week;
        },

        /** 物模型项改变事件 **/
        thingsModelItemChange(identifier, index) {
            this.actionList[index].value = "";
            if (this.actionList[index].type == 1) {
                //属性
                for (let i = 0; i < this.thingsModel.properties.length; i++) {
                    if (this.thingsModel.properties[i].id == identifier) {
                        this.actionList[index].name = this.thingsModel.properties[i].name;
                        this.actionList[index].thingsModelItem = this.thingsModel.properties[i];
                        break;
                    }
                }
            } else if (this.actionList[index].type == 2) {
                //事件
                for (let i = 0; i < this.thingsModel.functions.length; i++) {
                    if (this.thingsModel.functions[i].id == identifier) {
                        this.actionList[index].name = this.thingsModel.functions[i].name;
                        this.actionList[index].thingsModelItem = this.thingsModel.functions[i];
                        break;
                    }
                }
            }
        },
        /** 格式化显示动作 */
        formatActionsDisplay(json) {
            if (json == null || json == "") {
                return;
            }
            let actions = JSON.parse(json);
            let result = "";
            for (let i = 0; i < actions.length; i++) {
                let value = actions[i].value;
                if (actions[i].type == 1) {
                    // 属性
                    for (let j = 0; j < this.thingsModel.properties.length; j++) {
                        if (actions[i].id == this.thingsModel.properties[j].id) {
                            if (this.thingsModel.properties[j].datatype == "decimal" || this.thingsModel.properties[j].datatype == "integer") {
                                value = actions[i].value + this.thingsModel.properties[j].datatype.unit;
                            } else if (this.thingsModel.properties[j].datatype == "enum") {
                                for (let k = 0; k < this.thingsModel.properties[j].datatype.enumList.length; k++) {
                                    if (actions[i].value == this.thingsModel.properties[j].datatype.enumList[k].value) {
                                        value = this.thingsModel.properties[j].datatype.enumList[k].text;
                                        break;
                                    }
                                }
                            } else if (this.thingsModel.properties[j].datatype == "bool") {
                                value = actions[i].value == "1" ? this.thingsModel.properties[j].datatype.trueText : this.thingsModel.properties[j].datatype.falseText;
                            }
                            break;
                        }
                    }
                } else if (actions[i].type == 2) {
                    // 功能
                    for (let j = 0; j < this.thingsModel.functions.length; j++) {
                        if (actions[i].id == this.thingsModel.functions[j].id) {
                            if (this.thingsModel.functions[j].datatype.type == "decimal" || this.thingsModel.functions[j].datatype.type == "integer") {
                                value = actions[i].value + this.thingsModel.functions[j].datatype.unit;
                            } else if (this.thingsModel.functions[j].datatype.type == "enum") {
                                for (let k = 0; k < this.thingsModel.functions[j].datatype.enumList.length; k++) {
                                    if (actions[i].value == this.thingsModel.functions[j].datatype.enumList[k].value) {
                                        value = this.thingsModel.functions[j].datatype.enumList[k].text;
                                        break;
                                    }
                                }
                            } else if (this.thingsModel.functions[j].datatype.type == "bool") {
                                value = actions[i].value == "1" ? this.thingsModel.functions[j].datatype.trueText : this.thingsModel.functions[j].datatype.falseText;
                            }
                            break;
                        }
                    }
                }
                result = result + actions[i].name + "：</span><span style=\"color:#F56C6C\">" + value + "</span><br />";
            }
            return result;
        },
        /** 格式化显示CRON描述 */
        formatCronDisplay(item) {
            let result = "";
            if (item.isAdvance == 0) {
                let time = "<br /><span style=\"color:#F56C6C\">时间 " + item.cronExpression.substring(5, 7) + ":" + item.cronExpression.substring(2, 4) + "</span>";
                let week = item.cronExpression.substring(12);
                if (week == "1,2,3,4,5,6,7") {
                    result = "每天 " + time;
                } else {
                    let weekArray = week.split(",");
                    for (let i = 0; i < weekArray.length; i++) {
                        if (weekArray[i] == "1") {
                            result = result + "周一、";
                        } else if (weekArray[i] == "2") {
                            result = result + "周二、";
                        } else if (weekArray[i] == "3") {
                            result = result + "周三、";
                        } else if (weekArray[i] == "4") {
                            result = result + "周四、";
                        } else if (weekArray[i] == "5") {
                            result = result + "周五、";
                        } else if (weekArray[i] == "6") {
                            result = result + "周六、";
                        } else if (weekArray[i] == "7") {
                            result = result + "周日、";
                        }
                    }
                    result = result.substring(0, result.length - 1) + " " + time;
                }
            } else {
                result = "自定义Cron表达式";
            }
            return result;
        },

    }
};
</script>
