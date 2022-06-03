<template>
<div style="padding: 6px">
    <el-card style="padding-bottom: 100px">
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-refresh" size="mini" @click="getList" v-hasPermi="['iot:emqx:query']">刷新</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="getAddRules" v-hasPermi="['iot:emqx:add']">新增</el-button>
            </el-col>
        </el-row>
        <el-table v-loading="loading" :data="rulesList">
            <el-table-column label="ID" align="center" header-align="center" prop="id" width="150">
                <template slot-scope="scope">
                    <el-link :underline="false" type="primary" @click="handleQuery(scope.row)">{{scope.row.id }}</el-link>
                </template>
            </el-table-column>
            <el-table-column label="主题" align="center" prop="for">
                <template slot-scope="scope">
                    <p v-for="(topic, index) in scope.row.for" :key="index">
                        <el-tag type="warning">{{ topic }}</el-tag>
                    </p>
                </template>
            </el-table-column>
            <el-table-column label="SQL" align="center" prop="rawsql" />
            <el-table-column label="响应动作" align="center" prop="actions" width="250">
                <template slot-scope="scope">
                    <p v-for="(action, index) in scope.row.actions" :key="index">
                        <el-tag type="success">{{ action.name }}</el-tag>
                    </p>
                </template>
            </el-table-column>
            <el-table-column label="已命中" align="center" prop="matched" width="100">
                <template slot-scope="scope">
                    {{ scope.row.metrics[0].matched }}
                </template>
            </el-table-column>
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="100">
                <template slot-scope="scope">
                    <el-button size="small" type="danger" icon="el-icon-delete" style="padding: 5px" v-hasPermi="['iot:emqx:remove']" @click="handleDelete(scope.row)">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>

    <!-- 规则引擎详细 -->
    <el-dialog title="规则引擎详细" :visible.sync="openView" width="800px" append-to-body>
        <el-form ref="form" :model="form" label-width="120px" size="mini">
            <el-card style="padding-bottom: 10px">
                <div slot="header" class="clearfix">
                    <span>基本信息</span>
                </div>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="主题：">
                            <el-tag type="success" v-for="(topic, index) in form.for" :key="index">{{ topic }}</el-tag>
                        </el-form-item>
                    </el-col>
                    <el-col :span="20">
                        <el-form-item label="备注：">{{ form.description }}</el-form-item>
                    </el-col>
                    <el-col :span="20">
                        <el-form-item label="规则SQL:">{{ form.rawsql }}</el-form-item>
                    </el-col>
                </el-row>
            </el-card>
            <el-card style="padding-bottom: 10px; margin-top: 10px">
                <div slot="header" class="clearfix">
                    <span>度量指标</span>
                </div>
                <el-table :data="form.metrics">
                    <el-table-column label="节点" align="center" prop="node" />
                    <el-table-column label="已命中" align="center" prop="matched" />
                    <el-table-column label="命中速度" align="center" prop="speed" />
                    <el-table-column label="最大命中速度" align="center" prop="speed_max" />
                    <el-table-column label="5分钟平均速度" align="center" prop="speed_last5m" />
                </el-table>
            </el-card>
            <el-card style="padding-bottom: 10px; margin-top: 10px">
                <div slot="header" class="clearfix">
                    <span>响应动作</span>
                </div>
                <el-table :data="form.actions">
                    <el-table-column label="类型" align="center" prop="name" />
                    <el-table-column label="参数" align="center" prop="params">
                        <template slot-scope="scope">
                            {{scope.row.params}}
                        </template>
                    </el-table-column>
                    <el-table-column label="度量指标" align="center">
                        <template slot-scope="scope">
                            <el-tag type="success">{{ scope.row.metrics[0].node }}</el-tag><br />
                            合计： 成功：<el-tag type="success">{{ scope.row.metrics[0].success  }}</el-tag>
                            失败：<el-tag type="danger">{{ scope.row.metrics[0].failed  }}</el-tag>
                        </template>
                    </el-table-column>
                </el-table>
            </el-card>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="openView = false">关 闭</el-button>
        </div>
    </el-dialog>

    <!-- 添加规则引擎 -->
    <el-dialog title="添加规则引擎" :visible.sync="openAddView" width="1000px" append-to-body :before-close="cancel">
        <el-card style="margin-bottom:10px;">
            <div slot="header" class="clearfix">
                <span style="font-size:16px;font-weight:bold;">条件</span>
                <span style="font-size:12px;margin-left:12px;">使用 SQL 定义规则条件与数据处理方式</span>
            </div>
            <el-form ref="form" :model="form" label-width="90px">
                <el-row :gutter="30">
                    <el-col :span="13">
                        <el-form-item prop="sql_example">
                            <span slot="label"> 规则 SQL： </span>
                            <CodeMirrorEditor :value="form.sql_example" myMode="text/x-mysql" height="400" style="border:1px solid #ddd;" />
                        </el-form-item>
                        <el-form-item prop="sql_example">
                            <span slot="label"> 备注： </span>
                            <el-input v-model="form.note" placeholder="e.g.消息转发到WebHook" />
                        </el-form-item>
                        <el-form-item prop="SQLtest">
                            <span slot="label">
                                SQL测试：
                            </span>
                            <el-switch v-model="form.SQLtest" active-text="" inactive-text="" :active-value="true" :inactive-value="false" active-color="#13ce66">
                            </el-switch>
                            <span style="font-size:12px;margin-left:10px;">自定义模拟数据进行 SQL 命令测试，仅用于测试功能</span>
                        </el-form-item>

                    </el-col>
                    <el-col :span="11">
                        <div class="sql-tips">
                            <div>编写 SQL 进行条件过滤与数据处理</div>
                            <div class="doc-wrapper">
                                <p>
                                    EMQ X
                                    在消息发布、事件触发时将触发规则引擎，满足触发条件的规则将执行各自的
                                    SQL 语句筛选并处理消息和事件的上下文信息。
                                </p>
                                <p>
                                    规则引擎借助响应动作可将特定主题的消息处理结果存储到数据库，发送到
                                    HTTP Server，转发到消息队列 Kafka 或
                                    RabbitMQ，重新发布到新的主题甚至是另一个 Broker
                                    集群中，每个规则可以配置多个响应动作。
                                </p>
                                <p>
                                    1. 选择发布到 't/#' 主题的消息，并筛选出全部字段：
                                </p>
                                <div class="code">
                                    <code>SELECT * FROM "t/#"</code>
                                </div>
                                <p>
                                    2. 选择发布到 't/a' 主题的消息，并从 JSON
                                    格式的消息内容中筛选出 "x" 字段：
                                </p>
                                <div class="code">
                                    <code>SELECT payload.x as x FROM "t/a"</code>
                                </div>
                                <p>
                                    规则引擎使用 $events/ 开头的虚拟主题（事件主题）处理
                                    EMQ X
                                    内置事件，内置事件提供更精细的消息控制和客户端动作处理能力，可用在
                                    QoS 1 QoS 2 的消息抵达记录、设备上下线记录等业务中。
                                </p>
                                <p>
                                    1. 选择客户端连接事件，筛选 Username 为 'emqx'
                                    的设备并获取连接信息：
                                </p>
                                <div class="code">
                                    <code>SELECT clientid, connected_at FROM
                                        "$events/client_connected" WHERE username =
                                        'emqx'</code>
                                </div>
                                <p>规则引擎和 SQL 语句的详细教程参见 EMQ X 文档。</p>
                            </div>
                        </div>
                    </el-col>
                </el-row>
                <el-row v-if="form.SQLtest" style="background-color:#f8f8f8;margin:-20px;">
                    <el-col :span="13">
                        <el-form-item prop="test_columns.username" v-if="form.test_columns">
                            <span slot="label"> username </span>
                            <el-input v-model="form.test_columns.username" />
                        </el-form-item>
                        <el-form-item prop="test_columns.topic" v-if="form.test_columns">
                            <span slot="label"> topic</span>
                            <el-input v-model="form.test_columns.topic" />
                        </el-form-item>
                        <el-form-item prop="test_columns.payload" v-if="form.test_columns">
                            <span slot="label"> payload</span>
                            <CodeMirrorEditor :value="form.test_columns.payload" myMode="application/json" height="150" style="border:1px solid #ddd;" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="11">
                        <el-form-item prop="test_columns.clientid" v-if="form.test_columns">
                            <span slot="label"> clientid </span>
                            <el-input v-model="form.test_columns.clientid" />
                        </el-form-item>
                        <el-form-item prop="test_columns.qos" v-if="form.test_columns">
                            <span slot="label"> qos </span>
                            <el-input v-model="form.test_columns.qos" />
                        </el-form-item>
                        <el-form-item v-if="form.test_columns">
                            <span slot="label"> 测试结果： </span>
                            <el-input type="textarea" v-model="content" :rows="4"></el-input>
                        </el-form-item>
                        <el-form-item v-if="form.test_columns">
                            <el-button @click="testConnect" type="success" size="mini" style="width:100px;">测 试</el-button>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </el-card>

        <el-card style="padding-bottom: 10px">
            <div slot="header" class="clearfix">
                <div slot="header" class="clearfix">
                    <span style="font-size:16px;font-weight:bold;">响应动作</span>
                    <span style="font-size:12px;margin-left:12px;">处理命中规则的消息</span>
                </div>
            </div>
            <el-table ref="singleTable" :data="actions" highlight-current-row>
                <el-table-column property="name" label="类型"> </el-table-column>
                <el-table-column property="param" label="参数">
                    <template slot-scope="scope">
                        {{ scope.row.param }}
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="danger" @click="deleteAction(scope.$index)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div style="margin-top: 20px">
                <el-button @click="addActionPage()">添加</el-button>
            </div>
        </el-card>
        <div slot="footer" class="dialog-footer">
            <el-button @click="cancel">取 消</el-button>
            <el-button type="success" @click="saveRule" :loading="addRuleLoading">新建</el-button>
        </div>
    </el-dialog>

    <!-- 添加响应动作 -->
    <el-dialog title="响应动作" :visible.sync="openAddActionView" width="600px" append-to-body :before-close="cancelAction">
        <el-form ref="actionForm" :model="actionForm" label-width="180px" v-if="actionForm.actions" :rules="ruleActions">
            <el-row>
                <el-col>
                    <el-form-item prop="actions.title">
                        <span slot="label">
                            动作：
                            <el-tooltip :content="prompt" placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                        </span>
                        <el-select v-model="actionForm.actions.title" @change="selectTitle" placeholder="请选择">
                            <el-option v-for="(action, index) in actionForm.actions" :key="index" :label="action.title.zh" :value="action.name"></el-option>
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>

        <el-form ref="republishForm" :model="republishForm" label-width="180px" v-if="republishForm.params" v-show="republishView" :rules="ruleRepublish">
            <el-row>
                <el-col :span="20">
                    <el-form-item prop="params.target_topic.default">
                        <span slot="label">
                            目的主题：
                            <el-tooltip :content="republishForm.params.target_topic.description.zh" placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                        </span>
                        <el-input v-model="republishForm.params.target_topic.default" />
                    </el-form-item>
                    <el-form-item prop="params.target_qos.default">
                        <span slot="label">
                            目的 QoS：
                            <el-tooltip :content="republishForm.params.target_qos.description.zh" placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                        </span>
                        <el-input v-model="republishForm.params.target_qos.default" />
                    </el-form-item>
                    <el-form-item prop="params.payload_tmpl.default">
                        <span slot="label">
                            消息内容模板：
                            <el-tooltip :content="republishForm.params.payload_tmpl.description.zh" placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                        </span>
                        <textarea style="width: 300px; height: 120px" v-model="republishForm.params.payload_tmpl.default"></textarea>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>

        <el-form ref="data_to_mqtt_broker_Form" :model="data_to_mqtt_broker_Form" label-width="180px" v-if="data_to_mqtt_broker_Form.params" v-show="data_to_mqtt_broker_View" :rules="rule_data_to_mqtt_broker">
            <el-row>
                <el-col :span="20">
                    <el-form-item prop="resourceId">
                        <span slot="label"> 关联资源： </span>
                        <el-select v-model="data_to_mqtt_broker_Form.resourceId" placeholder="请选择">
                            <el-option v-for="(
                    resource, index
                  ) in data_to_mqtt_broker_Form.resources" :key="index" :label="resource.id" :value="resource.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item prop="params.payload_tmpl.default" v-if="data_to_mqtt_broker_Form.params.payload_tmpl">
                        <span slot="label">
                            消息内容模板：
                            <el-tooltip :content="
                    data_to_mqtt_broker_Form.params.payload_tmpl.description.zh
                  " placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                        </span>
                        <textarea style="width: 300px; height: 120px" v-model="data_to_mqtt_broker_Form.params.payload_tmpl.default"></textarea>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>

        <el-form ref="data_to_webserver_Form" :model="data_to_webserver_Form" label-width="180px" v-if="data_to_webserver_Form.params" v-show="data_to_webserver_View" :rules="rule_data_to_webserver">
            <el-row>
                <el-col :span="20">
                    <el-form-item prop="resourceId">
                        <span slot="label"> 关联资源： </span>
                        <el-select v-model="data_to_webserver_Form.resourceId" placeholder="请选择">
                            <el-option v-for="(resource, index) in data_to_webserver_Form.resources" :key="index" :label="resource.id" :value="resource.id"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item prop="params.payload_tmpl.default" v-if="data_to_webserver_Form.params.payload_tmpl">
                        <span slot="label">
                            消息内容模板：
                            <el-tooltip :content="
                    data_to_webserver_Form.params.payload_tmpl.description.zh
                  " placement="top">
                                <i class="el-icon-question"></i>
                            </el-tooltip>
                        </span>
                        <textarea style="width: 300px; height: 120px" v-model="data_to_webserver_Form.params.payload_tmpl.default"></textarea>
                    </el-form-item>
                </el-col>
            </el-row>
        </el-form>

        <div slot="footer" class="dialog-footer">
            <el-button @click="cancelAction">取 消</el-button>
            <el-button type="success" @click="saveAction('republishForm')" v-if="republishView" :loading="showloading">新建</el-button>
            <el-button type="success" @click="saveAction('data_to_mqtt_broker_Form')" v-if="data_to_mqtt_broker_View" :loading="showloading">新建</el-button>
            <el-button type="success" @click="saveAction('data_to_webserver_Form')" v-if="data_to_webserver_View" :loading="showloading">新建</el-button>
            <el-button type="success" @click="saveAction('do_nothing_Form')" v-if="do_nothing_View" :loading="showloading">新建</el-button>
            <el-button type="success" @click="saveAction('inspectForm')" v-if="inspectView" :loading="showloading">新建</el-button>
        </div>
    </el-dialog>
</div>
</template>

<script>
import {
    getRules,
    deleteRule,
    getRulesEvent,
    getActionsEvent,
    getResources,
    saveRule,
    testConnectRule,
} from "@/api/iot/emqx";
import CodeMirrorEditor from "@/components/Codemirror/index";
export default {
    name: "Rules",
    components: {
        CodeMirrorEditor,
    },
    data() {
        return {
            // 遮罩层
            loading: true,
            //遮罩层
            showloading: false,
            // 遮罩层
            addRuleLoading: false,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 规则表格数据
            rulesList: [],
            // 弹出层标题
            title: "",
            // 是否显示详细弹出层
            openView: false,
            // 是否显示添加规则弹出层
            openAddView: false,
            // 是否显示添加响应动作弹出层
            openAddActionView: false,
            //是否显示消息重新发布表单参数
            republishView: false,
            //是否显示桥接数据到 MQTT Broker表单参数
            data_to_mqtt_broker_View: false,
            //是否显示发送数据到 Web 服务表单参数
            data_to_webserver_View: false,
            //是否显示空动作 (调试)表单按钮
            do_nothing_View: false,
            //是否显示检查 (调试)表单按钮
            inspectView: false,
            // 添加规则表单参数
            form: {
                note: "",
                SQLtest: false,
            },
            //测试结果
            content: "",
            // 响应动作列表
            actions: [],
            //响应动作列表表单参数
            actionForm: {
                actions: [],
            },
            //动作的提示语
            prompt: "动作类型",
            // 响应动作规则
            ruleActions: {
                actions: {
                    title: [{
                        required: true,
                        message: "请选择动作类型",
                        trigger: "change"
                    }, ],
                },
            },
            ruleRepublish: {
                params: {
                    target_topic: {
                        default: [{
                            required: true,
                            message: "请输入目的主题",
                            trigger: "blur"
                        }, ],
                    },
                    target_qos: {
                        default: [{
                            required: true,
                            message: "请输入目的 QoS",
                            trigger: "blur"
                        }, ],
                    },
                    payload_tmpl: {
                        default: [{
                            required: true,
                            message: "请输入消息内容模板",
                            trigger: "blur",
                        }, ],
                    },
                },
            },
            rule_data_to_mqtt_broker: {
                resourceId: [{
                    required: true,
                    message: "请关联资源类型",
                    trigger: "blur"
                }, ],
            },
            rule_data_to_webserver: {
                resourceId: [{
                    required: true,
                    message: "请关联资源类型",
                    trigger: "change"
                }, ],
            },
            //空动作 (调试)表单参数
            do_nothing_Form: {},
            //检查 (调试)表单参数
            inspectForm: {},
            //消息重新发布表单参数
            republishForm: {},
            //桥接数据到 MQTT Broker表单参数
            data_to_mqtt_broker_Form: {
                resources: [],
                resourceId: "",
            },
            //发送数据到 Web 服务表单参数
            data_to_webserver_Form: {
                resources: [],
                resourceId: "",
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询规则列表 */
        getList() {
            this.loading = true;
            getRules("").then((response) => {
                this.rulesList = response.data.data;
                // this.total = response.data.meta.count;
                this.loading = false;
            });
        },
        // 取消按钮
        cancel() {
            //初始化
            this.openAddView = false;
            this.actions = [];
            this.$refs["form"].resetFields();
        },
        //关闭动作页面
        cancelAction() {
            //初始化所有数据
            this.do_nothing_View = false;
            this.republishView = false;
            this.data_to_mqtt_broker_View = false;
            this.data_to_webserver_View = false;
            this.inspectView = false;
            this.openAddActionView = false;

            this.do_nothing_Form = {};
            this.inspectForm = {};
            this.republishForm = {};
            this.data_to_mqtt_broker_Form.resources = [];
            this.data_to_mqtt_broker_Form.resourceId = "";
            this.data_to_mqtt_broker_Form = {};
            this.data_to_webserver_Form.resources = [];
            this.data_to_webserver_Form.resourceId = "";
            this.data_to_webserver_Form = {};

            this.actionForm.actions = [];

            this.$refs["actionForm"].resetFields();
        },
        /** 查看按钮操作 */
        handleQuery(row) {
            let ruleId = row.id;
            getRules(ruleId).then((response) => {
                this.form = response.data.data;
                this.openView = true;
            });
        },
        //删除规则
        handleDelete(row) {
            debugger;
            let ruleId = row.id;
            this.$modal
                .confirm('是否确认删除ID为"' + ruleId + '"的规则引擎？')
                .then(function () {
                    return deleteRule(ruleId);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess("删除规则引擎成功");
                })
                .catch(() => {});
        },
        //跳转到添加规则引擎页面
        getAddRules() {
            getRulesEvent().then((res) => {
                this.form = res.data.data[0];
                this.openAddView = true;
            });
        },
        //添加响应动作
        addActionPage() {
            getActionsEvent().then((res) => {
                //赋值
                this.actionForm.actions = res.data.data;
                this.do_nothing_Form = res.data.data[0];
                //检查 (调试)表单参数
                this.inspectForm = res.data.data[2];
                //消息重新发布表单参数
                this.republishForm = res.data.data[1];
                //桥接数据到 MQTT Broker表单参数
                this.data_to_mqtt_broker_Form = res.data.data[3];
                //发送数据到 Web 服务表单参数
                this.data_to_webserver_Form = res.data.data[4];
                this.openAddActionView = true;
            });
        },
        /** 选择响应动作类型 */
        selectTitle(val) {
            if ("do_nothing" === val) {
                this.data_to_webserver_View = false;
                this.data_to_mqtt_broker_View = false;
                this.republishView = false;
                this.inspectView = false;
                this.do_nothing_View = true;
                this.prompt = this.actionForm.actions[0].description.zh;
            } else if ("republish" === val) {
                this.data_to_webserver_View = false;
                this.data_to_mqtt_broker_View = false;
                this.do_nothing_View = false;
                this.inspectView = false;
                this.republishView = true;
                this.prompt = this.actionForm.actions[1].description.zh;
            } else if ("inspect" === val) {
                this.data_to_webserver_View = false;
                this.data_to_mqtt_broker_View = false;
                this.do_nothing_View = false;
                this.republishView = false;
                this.inspectView = true;
                this.prompt = this.actionForm.actions[2].description.zh;
            } else if ("data_to_mqtt_broker" === val) {
                getResources("").then((res) => {
                    this.data_to_mqtt_broker_Form.resources = res.data.data;
                    this.prompt = this.actionForm.actions[3].description.zh;

                    this.data_to_webserver_View = false;
                    this.do_nothing_View = false;
                    this.republishView = false;
                    this.inspectView = false;
                    this.data_to_mqtt_broker_View = true;
                });
            } else if ("data_to_webserver" === val) {
                getResources("").then((res) => {
                    this.data_to_webserver_Form.resources = res.data.data;
                    this.prompt = this.actionForm.actions[4].description.zh;

                    this.data_to_mqtt_broker_View = false;
                    this.do_nothing_View = false;
                    this.republishView = false;
                    this.inspectView = false;
                    this.data_to_webserver_View = true;
                });
            }
        },
        //添加响应动作
        saveAction(formName) {
            const action = {};
            const param = {};
            if ("do_nothing_Form" === formName) {
                action.name = this.do_nothing_Form.name;
                action.params = {};
                this.actions.push(action);
                this.cancelAction();
            } else if ("republishForm" === formName) {
                //校验表单
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        param.payload_tmpl = this.republishForm.params.payload_tmpl.default;
                        param.target_topic = this.republishForm.params.target_topic.default;
                        param.target_qos = this.republishForm.params.target_qos.default;
                        action.name = this.republishForm.name;
                        action.params = param;
                        this.actions.push(action);
                        this.cancelAction();
                    } else {
                        return false;
                    }
                });
            } else if ("inspectForm" === formName) {
                action.name = this.inspectForm.name;
                action.params = {};
                this.actions.push(action);
                this.cancelAction();
            } else if ("data_to_mqtt_broker_Form" === formName) {
                //校验表单
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        param.$resource = this.data_to_mqtt_broker_Form.resourceId;
                        if (this.data_to_mqtt_broker_Form.params.payload_tmpl != null) {
                            param.payload_tmpl =
                                this.data_to_mqtt_broker_Form.params.payload_tmpl.default;
                        }
                        action.params = param;
                        action.name = this.data_to_mqtt_broker_Form.name;
                        this.actions.push(action);
                        this.cancelAction();
                    } else {
                        return false;
                    }
                });
            } else if ("data_to_webserver_Form" === formName) {
                //校验表单
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        param.$resource = this.data_to_webserver_Form.resourceId;
                        if (this.data_to_webserver_Form.params.payload_tmpl != null) {
                            param.payload_tmpl =
                                this.data_to_webserver_Form.params.payload_tmpl.default;
                        }
                        action.params = param;
                        action.name = this.data_to_webserver_Form.name;
                        this.actions.push(action);
                        this.cancelAction();
                    } else {
                        return false;
                    }
                });
            }
        },
        //删除动作参数
        deleteAction(index) {
            this.actions.splice(index, 1);
        },
        //添加规则引擎
        saveRule() {
            this.addRuleLoading = true;
            this.insertOrTestRule("insert");
        },
        testConnect() {
            this.insertOrTestRule("test");
        },

        //公共方法
        insertOrTestRule(type) {
            //将需要的参数进行赋值
            const ruleParam = {
                ctx: {}
            };
            ruleParam.description = this.form.note;
            ruleParam.rawsql = this.form.sql_example;
            ruleParam.actions = this.actions;
            ruleParam.ctx.clientid = this.form.test_columns.clientid;
            ruleParam.ctx.payload = this.form.test_columns.payload;
            ruleParam.ctx.qos = this.form.test_columns.qos;
            ruleParam.ctx.topic = this.form.test_columns.topic;
            ruleParam.ctx.username = this.form.test_columns.username;
            ruleParam.ctx.clientid = this.form.test_columns.clientid;
            if ("test" === type) {
                testConnectRule(ruleParam).then((res) => {
                    const code = res.data.code;
                    if (0 === code) {
                        this.content = JSON.stringify(res.data.data);
                    } else {
                        this.$modal.msgError(res.data.message);
                    }
                });
            } else {
                saveRule(ruleParam).then((res) => {
                    const code = res.data.code;
                    if (0 === code) {
                        this.$modal.msgSuccess("添加规则引擎成功");
                        this.cancel();
                        this.getList();
                    } else {
                        this.$modal.msgError(res.data.message);
                    }
                    this.addRuleLoading = false;
                });
            }
        },
    },
};
</script>

<style scoped>
.sql-tips {
    border: 4px dashed #d8d8d8;
    color: #71737d;
    font-size: 12px;
    padding: 10px;
    border-radius: 4px;
    height: 510px;
    overflow: hidden;
    margin-right: -10px;
}

.code {
    line-height: 1.4;
    padding: 6px;
    border-radius: 4px;
    background-color: hsla(0, 0%, 87%, 0.8);
}
</style>
