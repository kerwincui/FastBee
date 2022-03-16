<template>
<div style="padding:6px;">

    <el-card v-show="showSearch" style="margin-bottom:6px;">
    <div style="height:50px; color:#F56C6C;margin-left:20px;">该功能下个版本发布</div>
        <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px" style="margin-bottom:-20px;">
            <el-form-item label="场景名称" prop="sceneName">
                <el-input v-model="queryParams.sceneName" placeholder="请输入场景名称" clearable size="small" @keyup.enter.native="handleQuery" />
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
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['iot:scene:add']">新增</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['iot:scene:edit']">修改</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="danger" plain icon="el-icon-delete" size="mini" disabled @click="handleDelete" v-hasPermi="['iot:scene:remove']">删除</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['iot:scene:export']">导出</el-button>
            </el-col>
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="sceneList" @selection-change="handleSelectionChange" border>
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="场景名称" align="center" prop="sceneName" />
            <el-table-column label="用户ID" align="center" prop="userId" />
            <el-table-column label="用户名称" align="center" prop="userName" />
            <el-table-column label="触发器" align="center" prop="triggers" />
            <el-table-column label="执行动作" align="center" prop="actions" />
            <el-table-column label="创建时间" align="center" prop="createTime" width="180">
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
            </el-table-column>
            <el-table-column label="备注" align="center" prop="remark" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                    <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['iot:scene:edit']">修改</el-button>
                    <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:scene:remove']" disabled>删除</el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 添加或修改场景联动对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                <el-row>
                    <el-col :span="16">
                        <el-form-item label="场景名称" prop="sceneName">
                            <el-input v-model="form.sceneName" placeholder="请输入场景名称" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item label="触发器" prop="griggers">
                            <el-select v-model="form.condition" placeholder="请选择" size="small" style="margin-bottom:10px;">
                                <el-option v-for="item in triggerConditions" :key="item.value" :label="item.label" :value="item.value">
                                </el-option>
                            </el-select>
                            <div v-for="(item,index) in form.triggers" :key="index" style="margin-bottom:15px;border:1px solid #ddd;padding:10px;">
                                <el-row>
                                    <el-col :span="4">
                                        <el-select v-model="item.source" placeholder="请选择" size="small" @change="changeTriggerSource">
                                            <el-option v-for="subItem in triggerSource" :key="subItem.value" :label="subItem.label" :value="subItem.value">
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="16" :offset="1" v-if="item.source==1">
                                        <el-link :underline="false">请选择一个设备<i class="el-icon-edit el-icon--right"></i></el-link>
                                    </el-col>
                                    <el-col :span="16" :offset="1" v-if="item.source==2">
                                        <el-time-picker v-model="timerTimeValue" size="small" value-format="HH:mm" placeholder="选择执行时间" @change="timeChange" :disabled="item.isAdvance==1"></el-time-picker>
                                    </el-col>
                                    <el-col :span="2" :offset="1" v-if="index!=0"><a style="color:#F56C6C" @click="removeTriggerItem(index)">删除</a></el-col>
                                </el-row>
                                <!--设备-->
                                <el-row v-if="item.source==1">
                                    <el-col :span="4">
                                        <el-select v-model="item.modelType" placeholder="请选择" size="small">
                                            <el-option v-for="subItem in modelTypes" :key="subItem.value" :label="subItem.label" :value="subItem.value">
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="4" :offset="1">
                                        <el-select v-model="item.modelType" placeholder="请选择" size="small">
                                            <el-option v-for="subItem in modelTypes" :key="subItem.value" :label="subItem.label" :value="subItem.value">
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="5" :offset="1">
                                        <el-select v-model="item.operator" placeholder="请选择操作符" size="small">
                                            <el-option key="=" label="等于(=)" value="=" />
                                            <el-option key="!=" label="不等于(!=)" value="!=" />
                                            <el-option key=">" label="大于(>)" value=">" />
                                            <el-option key="<" label="小于(<)" value="<" />
                                            <el-option key=">=" label="大于等于(>=)" value=">=" />
                                            <el-option key="<=" label="小于等于(<=)" value="<=" />
                                            <el-option key="contain" label="包含(contain)" value="contain" />
                                            <el-option key="notcontain" label="不包含(not contain)" value="notcontain" />
                                        </el-select>
                                    </el-col>
                                    <el-col :span="5" :offset="1">
                                        <el-input v-model="item.value" placeholder="值" size="small" />
                                    </el-col>                                    
                                </el-row>
                                <!--定时-->
                                <el-row v-if="item.source==2">
                                    <el-col :span="24">
                                        <el-row style="margin-bottom:5px;">
                                            <el-col :span="4">
                                                <el-select v-model="timerWeekRepeatValue" placeholder="请选择" @change="repeatChange" size="small" :disabled="item.isAdvance==1">
                                                    <el-option v-for="item in timerWeekRepeats" :key="item.value" :label="item.label" :value="item.value">
                                                    </el-option>
                                                </el-select>
                                            </el-col>
                                            <el-col :span="15" :offset="1" v-if="timerWeekRepeatValue==3">
                                                <el-select v-model="timerWeekValue" placeholder="请选择" multiple style="width:485px" @change="weekChange" size="small" :disabled="item.isAdvance==1">
                                                    <el-option v-for="item in timerWeeks" :key="item.value" :label="item.label" :value="item.value">
                                                    </el-option>
                                                </el-select>
                                            </el-col>
                                        </el-row>
                                    </el-col>
                                    <el-col :span="24">
                                        <el-row>
                                            <el-col :span="18">
                                                <el-input v-model="item.cronExpression" placeholder="cron执行表达式" :disabled="item.isAdvance==0" size="small">
                                                    <template slot="append">
                                                        <el-button type="primary" @click="handleShowCron(item,index)" :disabled="item.isAdvance==0">
                                                            生成表达式
                                                            <i class="el-icon-time el-icon--right"></i>
                                                        </el-button>
                                                    </template>
                                                </el-input>
                                            </el-col>
                                            <el-col :span="4" :offset="1">
                                                <el-checkbox v-model="item.isAdvance" :true-label="1" :false-label="0" @change="customerCronChange">自定义表达式</el-checkbox>
                                            </el-col>
                                        </el-row>
                                    </el-col>
                                </el-row>
                            </div>
                            <div>+ <a style="color:#409EFF" @click="addTriggerItem()">添加触发器</a></div>
                        </el-form-item>
                    </el-col>

                    <el-col :span="24">
                        <el-form-item label="执行动作">
                            <div v-for="(item,index) in form.actions" :key="index" style="margin-bottom:15px;border:1px solid #ddd;padding:10px;">
                                <el-row>
                                    <el-col :span="4">
                                        <el-select v-model="item.source" placeholder="请选择" size="small">
                                            <el-option v-for="subItem in actionSource" :key="subItem.value" :label="subItem.label" :value="subItem.value">
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="10" :offset="1" v-if="item.source==1">
                                        <el-link :underline="false">请选择一个设备<i class="el-icon-edit el-icon--right"></i></el-link>
                                    </el-col>
                                </el-row>
                                <!---设备-->
                                <el-row v-if="item.source==1">
                                    <el-col :span="4">
                                        <el-select v-model="item.modelType" placeholder="请选择" size="small">
                                            <el-option v-for="subItem in modelTypes" :key="subItem.value" :label="subItem.label" :value="subItem.value">
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="4" :offset="1">
                                        <el-select v-model="item.modelType" placeholder="请选择" size="small">
                                            <el-option v-for="subItem in modelTypes" :key="subItem.value" :label="subItem.label" :value="subItem.value">
                                            </el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="11" :offset="1">
                                        <el-input v-model="item.value" placeholder="值" size="small" />
                                    </el-col>
                                    <el-col :span="2" :offset="1" v-if="index!=0"><a style="color:#F56C6C" @click="removeActionItem(index)">删除</a></el-col>
                                </el-row>
                                <!--告警输出-->
                                <el-row v-if="item.source==3">
                                    <el-col :span="4">
                                        <el-select v-model="item.alertLevel" placeholder="告警级别" size="small">
                                            <el-option v-for="dict in dict.type.iot_alert_level" :key="dict.value" :label="dict.label" :value="parseInt(dict.value)"></el-option>
                                        </el-select>
                                    </el-col>
                                    <el-col :span="16" :offset="1">
                                        <el-input v-model="item.alertName" placeholder="请输入告警名称" size="small" />
                                    </el-col>
                                </el-row>
                            </div>
                            <div>+ <a style="color:#409EFF" @click="addActionItem()">添加执行动作</a></div>
                        </el-form-item>
                    </el-col>
                    <el-col>
                        <el-form-item label="备注" prop="remark">
                            <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm" disabled>确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>

        <el-dialog title="Cron表达式生成器" :visible.sync="openCron" append-to-body destroy-on-close class="scrollbar">
            <crontab @hide="openCron=false" @fill="crontabFill" :expression="expression" style="padding-bottom:80px;"></crontab>
        </el-dialog>
    </el-card>
</div>
</template>

<script>
import {
    listScene,
    getScene,
    delScene,
    addScene,
    updateScene
} from "@/api/iot/scene";
import Crontab from '@/components/Crontab'

export default {
    components: {
        Crontab
    },
    name: "Scene",
    dicts: ['iot_alert_level'],
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
            // 场景联动表格数据
            sceneList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 是否显示Cron表达式弹出层
            openCron: false,
            // 传入的表达式
            expression: "",
            // 触发器的索引，用于接收传入的表达式
            triggerIndex:0,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                sceneName: null,
                userId: null,
                userName: null,
            },
            // 周
            timerWeekRepeats: [{
                value: '1',
                label: '每天'
            }, {
                value: '2',
                label: '仅此一次'
            }, {
                value: '3',
                label: '指定'
            }],
            timerWeekRepeatValue: "1",

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
            // 触发器源 1=设备，2=定时，3=告警输出
            triggerSource: [{
                value: 1,
                label: '设备'
            }, {
                value: 2,
                label: '定时'
            }],
            // 执行动作源
            actionSource: [{
                value: 1,
                label: '设备'
            }, {
                value: 3,
                label: '告警输出'
            }],
            // 物模型类别
            modelTypes: [{
                value: 1,
                label: '属性'
            }, {
                value: 2,
                label: '功能'
            }],
            // 触发器条件
            triggerConditions: [{
                value: "all",
                label: '满足所有条件'
            }, {
                value: "any",
                label: '满足任一条件'
            }],
            // 表单参数
            form: {
                condition: "all", // 触发器条件
                triggers: [],
                actions: []
            },
            // 表单校验
            rules: {
                sceneName: [{
                    required: true,
                    message: "场景名称不能为空",
                    trigger: "blur"
                }],
                userId: [{
                    required: true,
                    message: "用户ID不能为空",
                    trigger: "blur"
                }],
                userName: [{
                    required: true,
                    message: "用户名称不能为空",
                    trigger: "blur"
                }],
                triggers: [{
                    required: true,
                    message: "触发器不能为空",
                    trigger: "blur"
                }],
                actions: [{
                    required: true,
                    message: "执行动作不能为空",
                    trigger: "blur"
                }],
            }
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询场景联动列表 */
        getList() {
            this.loading = true;
            listScene(this.queryParams).then(response => {
                this.sceneList = response.rows;
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
                sceneId: null,
                sceneName: null,
                userId: null,
                userName: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null,
                condition: "all", // 触发器条件
                triggers: [{
                    id: "",
                    name: "",
                    value: "",
                    deviceId: 0,
                    deviceName: "请选择一个设备",
                    source: 1, //1=设备，2=定时，3=告警输出
                    modelType: 1, // 1=属性，2=功能
                    jobId: 0,
                    cronExpression: "",
                    isAdvance: 0
                }],
                actions: [{
                    id: "",
                    name: "",
                    value: "",
                    deviceId: 0,
                    deviceName: "请选择一个设备",
                    source: 1, //1=设备，2=定时，3=告警输出
                    modelType: 1, // 1=属性，2=功能
                }]
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
            this.ids = selection.map(item => item.sceneId)
            this.single = selection.length !== 1
            this.multiple = !selection.length
        },
        /** 新增按钮操作 */
        handleAdd() {
            this.reset();
            this.open = true;
            this.title = "添加场景联动";
        },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const sceneId = row.sceneId || this.ids
            getScene(sceneId).then(response => {
                this.form = response.data;
                this.open = true;
                this.title = "修改场景联动";
            });
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.sceneId != null) {
                        updateScene(this.form).then(response => {
                            this.$modal.msgSuccess("修改成功");
                            this.open = false;
                            this.getList();
                        });
                    } else {
                        addScene(this.form).then(response => {
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
            const sceneIds = row.sceneId || this.ids;
            this.$modal.confirm('是否确认删除场景联动编号为"' + sceneIds + '"的数据项？').then(function () {
                return delScene(sceneIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 导出按钮操作 */
        handleExport() {
            this.download('iot/scene/export', {
                ...this.queryParams
            }, `scene_${new Date().getTime()}.xlsx`)
        },
        /** 添加动作 */
        addActionItem() {
            this.form.actions.push({
                id: "",
                name: "",
                value: ""
            })
        },
        /** 删除动作 */
        removeActionItem(index) {
            this.form.actions.splice(index, 1);
        },
        /** 触发器源改变事件 **/
        changeTriggerSource(data) {
            this.setTriggerSource();
        },
        /** 设置触发器源 **/
        setTriggerSource() {
            // 触发器智能包含一个定时
            let hasTimer = false;
            for (let i = 0; i < this.form.triggers.length; i++) {
                if (this.form.triggers[i].source == 2) {
                    hasTimer = true;
                    this.triggerIndex=i;
                }
            }
            if (hasTimer) {
                this.triggerSource = [{
                    value: 1,
                    label: '设备'
                }];
            } else {
                //定时
                this.triggerSource = [{
                    value: 1,
                    label: '设备'
                }, {
                    value: 2,
                    label: '定时'
                }];

            }
        },
        /** 添加触发器 */
        addTriggerItem() {
            this.setTriggerSource();
            this.form.triggers.push({
                id: "",
                name: "",
                value: "",
                deviceId: 0,
                deviceName: "请选择一个设备",
                source: 1, //1=设备，2=定时，3=告警输出
                modelType: 1, // 1=属性，2=功能
                jobId: 0,
                cronExpression: "",
                isAdvance: 0
            })

        },
        /** 删除触发器 */
        removeTriggerItem(index) {
            this.form.triggers.splice(index, 1);
            this.setTriggerSource();
        },
        /** cron表达式按钮操作 */
        handleShowCron(item,index) {
            this.expression=item.cronExpression;
            this.triggerIndex=index;
            this.openCron = true;
        },
        /** 确定后回传值 */
        crontabFill(value) {
            this.form.triggers[this.triggerIndex].cronExpression = value;
        },
        /** 修改重复事件 **/
        repeatChange(data) {
            if (this.timerWeekRepeatValue == 1) {
                // 每天
                this.timerWeekValue = [1, 2, 3, 4, 5, 6, 7];
                this.form.isRepeat = 1;
            } else if (this.timerWeekRepeatValue == 2) {
                // 仅此一次
                this.timerWeekValue = [];
                this.form.isRepeat = 0;
            } else {
                // 指定
                this.form.isRepeat = 1;
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
        customerCronChange(data){
            this.gentCronExpression();
        },
        /** 生成cron表达式**/
        gentCronExpression() {
            if (this.timerTimeValue == "") {
                this.$modal.alertError("执行时间不能为空");
            }
            let minute = this.timerTimeValue.substring(0, 2);
            let hour = this.timerTimeValue.substring(3);
            let week = "*";
            if (this.timerWeekValue.length > 0) {
                week = this.timerWeekValue;
            }
            this.form.triggers[this.triggerIndex].cronExpression = "0 " + minute + " " + hour + " ? * " + week;
        }
    }
};
</script>
