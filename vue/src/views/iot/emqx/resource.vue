<template>
<div style="padding: 6px">
    <el-card style="padding-bottom: 100px">
        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button type="success" plain icon="el-icon-refresh" size="mini" @click="getList" v-hasPermi="['iot:emqx:query']">刷新</el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="addResource" v-hasPermi="['iot:emqx:add']">新增</el-button>
            </el-col>
        </el-row>
        <el-table v-loading="loading" :data="resourceList">
            <el-table-column label="ID" align="center" header-align="center" prop="id">
                <template slot-scope="scope">
                    <el-link :underline="false" type="primary" @click="handleQuery(scope.row)">{{ scope.row.id }}</el-link>
                </template>
            </el-table-column>
            <el-table-column label="资源类型" align="center" prop="type" />
            <el-table-column label="备注" align="center" prop="description" />
            <el-table-column label="操作" align="center" width="200">
                <template slot-scope="scope">
                    <el-button size="small" type="text" icon="el-icon-connection" style="padding: 5px" v-hasPermi="['iot:emqx:edit']" @click="checkStatus(scope.row)">状态
                    </el-button>
                    <el-button size="small" type="text" icon="el-icon-delete" style="padding: 5px" v-hasPermi="['iot:emqx:remove']" @click="handleDelete(scope.row)">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
    </el-card>

    <!-- 资源详细 -->
    <el-dialog title="资源详细" :visible.sync="openView" width="800px" append-to-body>
        <el-form ref="form" :model="form" label-width="180px" size="mini">
            <el-card style="padding-bottom: 10px">
                <div slot="header" class="clearfix">
                    <span>基础信息</span>
                </div>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="ID：">{{ form.id }}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="资源类型：">{{ form.type }}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="备注：">{{ form.description }}</el-form-item>
                    </el-col>
                </el-row>
            </el-card>
            <el-card style="padding-bottom: 10px; margin-top: 10px">
                <div slot="header" class="clearfix">
                    <span>配置信息</span>
                </div>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="reconnect_interval：">{{ form.config.reconnect_interval}}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="pool_size：">{{ form.config.pool_size }}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="mountpoint：">{{ form.config.mountpoint}}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="disk_cache：">{{ form.config.disk_cache }}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="batch_size：">{{ form.config.batch_size }}</el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="20">
                        <el-form-item label="address：">{{ form.config.address}}</el-form-item>
                    </el-col>
                </el-row>
            </el-card>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="openView = false" type="success">确 认</el-button>
        </div>
    </el-dialog>

    <!-- 测试重连 -->
    <el-dialog title="检测状态" :visible.sync="openStatusView" width="600px" append-to-body>
        <el-form ref="statusForm" :model="statusForm" label-width="180px" size="mini" v-if="statusForm.status[0]">
            {{ statusForm.status[0].node }}
            <el-tag type="success" v-if="statusForm.status[0].is_alive == true" style="margin-left: 10px">可用</el-tag>
            <el-tag type="danger" v-if="statusForm.status[0].is_alive == false" style="margin-left: 10px">不可用</el-tag>
            <el-button size="small" type="primary" icon="el-icon-connection" style="padding: 5px; margin-left: 10px" v-hasPermi="['iot:emqx:edit']" @click="checkNode(statusForm.id)">重新连接
            </el-button>
        </el-form>
    </el-dialog>

    <!-- 添加资源 -->
    <el-dialog title="资源管理" :visible.sync="openAddView" width="800px" append-to-body :before-close="cancel">
        <el-form ref="addResourceForm" :model="addResourceForm" label-width="180px" :rules="rule">
            <el-card style="padding-bottom: 10px">
                <div slot="header" class="clearfix">
                    <span>择取资源类型</span>
                </div>
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="资源类型" prop="resource.title">
                            <el-select v-model="addResourceForm.resource.title" @change="selectTitle" placeholder="请选择资源类型">
                                <el-option v-for="(resource, index) in addResourceForm.resource" :key="index" :label="resource.title.zh" :value="resource.name"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item>
                            <el-button type="success" @click="testConnect('addResourceForm')">测试连接</el-button>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-card>
        </el-form>
        <el-form ref="EMQXForm" :model="EMQXForm" label-width="180px" :rules="ruleEMQX">
            <el-card style="padding-bottom: 10px; margin-top: 10px" v-if="EMQXForm.params" v-show="openEMQXView">
                <div slot="header" class="clearfix">
                    <span>具体信息</span>
                </div>

                <el-row>
                    <el-col :span="10">
                        <el-form-item prop="params.address.default">
                            <span slot="label">
                                <el-tooltip :content="EMQXForm.params.address.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                EMQ X节点名称：
                            </span>
                            <el-input v-model="EMQXForm.params.address.default" />
                        </el-form-item>
                        <el-form-item prop="params.pool_size.default">
                            <span slot="label">
                                <el-tooltip :content="EMQXForm.params.pool_size.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                连接池大小：
                            </span>
                            <el-input v-model="EMQXForm.params.pool_size.default" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item prop="params.mountpoint.default">
                            <span slot="label">
                                <el-tooltip :content="EMQXForm.params.mountpoint.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                桥接挂载点：
                            </span>
                            <el-input v-model="EMQXForm.params.mountpoint.default" />
                        </el-form-item>
                        <el-form-item prop="EMQreconnect_interval">
                            <span slot="label">
                                <el-tooltip :content="EMQXForm.params.reconnect_interval.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                重连间隔：
                            </span>
                            <el-input v-model="EMQXForm.params.reconnect_interval.default" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item prop="EMQbatch_size">
                            <span slot="label">
                                <el-tooltip :content="EMQXForm.params.batch_size.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                批处理大小：
                            </span>
                            <el-input v-model="EMQXForm.params.batch_size.default" />
                        </el-form-item>
                        <el-form-item label="备注：">
                            <el-input v-model="EMQXForm.description" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item prop="EMQdisk_cache">
                            <span slot="label">
                                <el-tooltip :content="EMQXForm.params.disk_cache.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                磁盘缓存：
                            </span>
                            <el-select v-model="EMQXForm.params.disk_cache.default">
                                <el-option v-for="(enums, index) in EMQXForm.params.disk_cache.enum" :key="index" :label="enums" :value="enums"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-card>
        </el-form>
        <el-form ref="MQTTForm" :model="MQTTForm" label-width="180px" :rules="ruleMQTT">
            <el-card style="padding-bottom: 10px; margin-top: 10px" v-if="MQTTForm.params" v-show="openMQTTView">
                <div slot="header" class="clearfix">
                    <span>具体信息</span>
                </div>
                <el-row>
                    <el-col :span="10">
                        <el-form-item prop="params.address.default">
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.address.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                远程broker地址：
                            </span>
                            <el-input v-model="MQTTForm.params.address.default" />
                        </el-form-item>
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.disk_cache.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                磁盘缓存：
                            </span>
                            <el-select v-model="MQTTForm.params.disk_cache.default">
                                <el-option v-for="(enums, index) in MQTTForm.params.disk_cache.enum" :key="index" :label="enums" :value="enums"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.proto_ver.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                协议版本：
                            </span>
                            <el-select v-model="MQTTForm.params.proto_ver.default">
                                <el-option v-for="(enums, index) in MQTTForm.params.proto_ver.enum" :key="index" :label="enums" :value="enums"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.clientid.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                客户端ID：
                            </span>
                            <el-input v-model="MQTTForm.params.clientid.default" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.username.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                用户名：
                            </span>
                            <el-input v-model="MQTTForm.params.username.default" />
                        </el-form-item>
                        <el-form-item prop="params.mountpoint.default">
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.mountpoint.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                桥接挂载点：
                            </span>
                            <el-input v-model="MQTTForm.params.mountpoint.default" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.password.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                密码：
                            </span>
                            <el-input v-model="MQTTForm.params.password.default" />
                        </el-form-item>
                        <el-form-item prop="params.keepalive.default">
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.keepalive.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                心跳间隔：
                            </span>
                            <el-input v-model="MQTTForm.params.keepalive.default" />
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.reconnect_interval.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                重连间隔：
                            </span>
                            <el-input v-model="MQTTForm.params.reconnect_interval.default" />
                        </el-form-item>
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.bridge_mode.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                桥接模式：
                            </span>
                            <el-select v-model="MQTTForm.params.bridge_mode.default">
                                <el-option key="false" label="false" value="false"></el-option>
                                <el-option key="true" label="true" value="true"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.retry_interval.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                重传间隔：
                            </span>
                            <el-input v-model="MQTTForm.params.retry_interval.default" />
                        </el-form-item>
                        <el-form-item prop="params.ssl.default">
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.ssl.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                Bridge SSL：
                            </span>
                            <el-select v-model="MQTTForm.params.ssl.default">
                                <el-option v-for="(enums, index) in MQTTForm.params.ssl.enum" :key="index" :label="enums" :value="enums"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.cacertfile.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                CA证书：
                            </span>
                            <el-input v-model="MQTTForm.params.cacertfile.default" />
                        </el-form-item>
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.keyfile.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                SSL 密钥文件：
                            </span>
                            <el-input v-model="MQTTForm.params.keyfile.default" />
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.certfile.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                SSL 客户端证书：
                            </span>
                            <el-input v-model="MQTTForm.params.certfile.default" />
                        </el-form-item>
                        <el-form-item>
                            <span slot="label">
                                <el-tooltip :content="MQTTForm.params.ciphers.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                SSL 加密算法 ：
                            </span>
                            <el-input v-model="MQTTForm.params.ciphers.default" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="10">
                        <el-form-item label="备注：">
                            <el-input v-model="MQTTForm.description" />
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-card>
        </el-form>
        <el-form ref="WebHookForm" :model="WebHookForm" label-width="180px" :rules="ruleWebHook">
            <el-card style="padding-bottom: 10px; margin-top: 10px" v-if="WebHookForm.params" v-show="openWebView">
                <div slot="header" class="clearfix">
                    <span>具体信息</span>
                </div>
                <el-row>
                    <el-col :span="12">
                        <el-form-item prop="params.url.default">
                            <span slot="label">
                                <el-tooltip :content="WebHookForm.params.url.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                请求 URL：
                            </span>
                            <el-input v-model="WebHookForm.params.url.default" placeholder="http://" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="请求方法：">
                            <span slot="label">
                                <el-tooltip :content="WebHookForm.params.method.description.zh" placement="top">
                                    <i class="el-icon-question"></i>
                                </el-tooltip>
                                请求方法：
                            </span>
                            <el-select v-model="WebHookForm.params.method.default">
                                <el-option v-for="(enums, index) in WebHookForm.params.method.enum" :key="index" :label="enums" :value="enums"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="20">
                        <el-form-item label="请求头：" prop="ket_value">
                            <el-row v-for="(item, index) in ket_value" :key="index" style="margin-bottom: 10px">
                                <el-col :span="8">
                                    <el-input v-model="item.key" placeholder="键" />
                                </el-col>
                                <el-col :span="12" :offset="1">
                                    <el-input v-model="item.value" placeholder="值" />
                                </el-col>
                                <el-col :span="2" :offset="1" v-if="index != 0"><a style="color: #f56c6c" @click="removeHeaderItem(index)">删除</a></el-col>
                            </el-row>
                            <div>
                                +
                                <a style="color: #409eff" @click="addHeader()">添加请求头</a>
                            </div>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="备注：">
                            <el-input v-model="WebHookForm.description" />
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-card>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="cancel">取 消</el-button>
            <el-button type="success" @click="saveResource('EMQXForm')" v-if="openEMQXView" :loading="showloading">新建</el-button>
            <el-button type="success" @click="saveResource('MQTTForm')" v-if="openMQTTView" :loading="showloading">新建</el-button>
            <el-button type="success" @click="saveResource('WebHookForm')" v-if="openWebView" :loading="showloading">新建</el-button>
        </div>
    </el-dialog>
</div>
</template>

<script>
import {
    getResources,
    getResourcesStatus,
    getConnectResource,
    deleteResource,
    getResourcesType,
    getResourcesConnect,
    saveResources,
} from "@/api/iot/emqx";

export default {
    name: "Resource",
    data() {
        return {
            // 遮罩层
            loading: true,
            // 新建按钮等待效果
            showloading: false,
            // 总条数
            total: 0,
            // 规则表格数据
            resourceList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 是否显示详细弹出层
            openView: false,
            // 是否显示检测状态弹出层
            openStatusView: false,
            // 是否显示添加资源弹出层
            openAddView: false,
            // 是否显示EMQX Bridge弹出层
            openEMQXView: false,
            // 是否显示MQTT Bridge弹出层
            openMQTTView: false,
            // 是否显示WebHook弹出层
            openWebView: false,
            //表单数据
            form: {
                config: {},
            },
            statusForm: {
                status: [],
            },
            //添加资源表单数据
            addResourceForm: {
                resource: [],
                type: "",
            },
            //添加EMQX资源表单数据
            EMQXForm: {
                description: "",
            },
            //添加MQTT资源表单数据
            MQTTForm: {
                description: "",
            },
            //添加WebHook资源表单数据
            WebHookForm: {
                description: "",
            },
            ket_value: [],
            //添加资源表单数据
            emqxParam: {
                description: "",
                name: "",
                type: "",
                config: {},
            },
            ruleEMQX: {
                params: {
                    address: {
                        default: [{
                            required: true,
                            message: "请输入EMQ X节点名称",
                            trigger: "blur",
                        }, ],
                    },
                    pool_size: {
                        default: [{
                            required: true,
                            message: "请输入连接池大小",
                            trigger: "blur",
                        }, ],
                    },
                    mountpoint: {
                        default: [{
                            required: true,
                            message: "请输入桥接挂载点",
                            trigger: "blur",
                        }, ],
                    },
                },
            },
            ruleMQTT: {
                params: {
                    address: {
                        default: [{
                            required: true,
                            message: "请输入远程 broker 地址",
                            trigger: "blur",
                        }, ],
                    },
                    mountpoint: {
                        default: [{
                            required: true,
                            message: "请输入桥接挂载点",
                            trigger: "blur",
                        }, ],
                    },
                    ssl: {
                        default: [{
                            required: true,
                            message: "请选择Bridge SSL",
                            trigger: "change",
                        }, ],
                    },
                    keepalive: {
                        default: [{
                            required: true,
                            message: "请输入心跳间隔",
                            trigger: "blur",
                        }, ],
                    },
                },
            },
            ruleWebHook: {
                params: {
                    url: {
                        default: [{
                            required: true,
                            message: "请输入请求 URL",
                            trigger: "blur",
                        }, ],
                    },
                },
            },
            rule: {
                resource: {
                    title: [{
                        required: true,
                        message: "请选择资源类型",
                        trigger: "change"
                    }, ],
                },
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
            getResources("").then((response) => {
                this.resourceList = response.data.data;
                this.loading = false;
            });
        },
        /** 查看按钮操作 */
        handleQuery(row) {
            this.form = row;
            this.openView = true;
        },
        /** 状态按钮操作 */
        checkStatus(row) {
            let resourceId = row.id;
            getResourcesStatus(resourceId).then((response) => {
                this.statusForm = response.data.data;
                this.openStatusView = true;
            });
        },
        //删除按钮操作
        handleDelete(row) {
            let resourceId = row.id;
            this.$modal
                .confirm('是否确认删除ID为"' + resourceId + '"的规则引擎？')
                .then(function () {
                    return deleteResource(resourceId);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess("删除资源成功");
                })
                .catch(() => {});
        },
        /** 重新连接资源按钮操作 */
        checkNode(resourceId) {
            getConnectResource(resourceId).then((response) => {
                let code = response.data.code;
                if (code !== 0) {
                    this.$modal.msgError(response.data.message);
                } else {
                    this.$modal.msgSuccess("连接资源成功");
                }
            });
        },
        /** 跳转添加资源页面 */
        addResource() {
            getResourcesType().then((res) => {
                this.addResourceForm.resource = res.data.data;
                this.EMQXForm.params = res.data.data[0].params;
                this.MQTTForm.params = res.data.data[1].params;
                this.WebHookForm.params = res.data.data[2].params;
                this.openAddView = true;
            });
        },

        /** 选择资源类型 */
        selectTitle(val) {
            this.addResourceForm.type = val;
            if ("bridge_rpc" === val) {
                this.openEMQXView = true;
                this.openMQTTView = false;
                this.openWebView = false;
            } else if ("bridge_mqtt" === val) {
                this.openEMQXView = false;
                this.openMQTTView = true;
                this.openWebView = false;
            } else if ("web_hook" === val) {
                this.openEMQXView = false;
                this.openMQTTView = false;
                this.openWebView = true;
            }
        },

        // 取消按钮
        cancel() {
            //初始化
            this.openEMQXView = false;
            this.openMQTTView = false;
            this.openWebView = false;
            this.openAddView = false;
            this.EMQXForm = {};
            this.MQTTForm = {};
            this.WebHookForm = {};
            this.addResourceForm.resource = [];
            this.addResourceForm.description = "";
            this.$refs['addResourceForm'].resetFields();
        },

        //测试连接
        testConnect(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    this.insertOrTestResourceUtils('test');
                } else {
                    return false;
                }
            });
        },
        /** 添加请求头 */
        addHeader() {
            this.ket_value.push({
                key: "",
                value: "",
            });
        },
        /** 删除请求头 */
        removeHeaderItem(index) {
            this.ket_value.splice(index, 1);
        },

        //新建资源
        saveResource(formName) {
            this.showloading = true;
            //校验表单
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    this.insertOrTestResourceUtils('save');
                } else {
                    return false;
                }
            });
        },
        // 新增资源或者测试连接公共方法
        insertOrTestResourceUtils(type) {
            this.emqxParam.type = this.addResourceForm.type;
            //判断选择的资源类型
            if ("bridge_rpc" === this.addResourceForm.type) {
                this.emqxParam.description = this.EMQXForm.description;
                this.emqxParam.config.address = this.EMQXForm.params.address.default;
                this.emqxParam.config.batch_size =
                    this.EMQXForm.params.batch_size.default;
                this.emqxParam.config.disk_cache =
                    this.EMQXForm.params.disk_cache.default;
                this.emqxParam.config.mountpoint =
                    this.EMQXForm.params.mountpoint.default;
                this.emqxParam.config.pool_size =
                    this.EMQXForm.params.pool_size.default;
                this.emqxParam.config.reconnect_interval =
                    this.EMQXForm.params.reconnect_interval.default;
                if ("test" == type) {
                    getResourcesConnect(this.emqxParam).then((res) => {
                        let code = res.data.code;
                        if (0 == code) {
                            this.$modal.msgSuccess("连接成功");
                        } else {
                            this.$modal.msgError(res.data.message);
                        }
                    });
                } else {
                    saveResources(this.emqxParam).then((res) => {
                        this.showloading = false;
                        let code = res.data.code;
                        if (0 == code) {
                            this.$modal.msgSuccess("添加资源成功");
                            this.getList();
                            this.cancel();
                        } else {
                            this.$modal.msgError(res.data.message);
                        }
                    });
                }
            } else if ("bridge_mqtt" === this.addResourceForm.type) {
                this.emqxParam.description = this.MQTTForm.description;
                this.emqxParam.config.address = this.MQTTForm.params.address.default;
                this.emqxParam.config.bridge_mode =
                    this.MQTTForm.params.bridge_mode.default;
                this.emqxParam.config.cacertfile =
                    this.MQTTForm.params.cacertfile.default;
                this.emqxParam.config.certfile = this.MQTTForm.params.certfile.default;
                this.emqxParam.config.ciphers = this.MQTTForm.params.ciphers.default;
                this.emqxParam.config.clientid = this.MQTTForm.params.clientid.default;
                this.emqxParam.config.disk_cache =
                    this.MQTTForm.params.disk_cache.default;
                this.emqxParam.config.keepalive =
                    this.MQTTForm.params.keepalive.default;
                this.emqxParam.config.keyfile = this.MQTTForm.params.keyfile.default;
                this.emqxParam.config.mountpoint =
                    this.MQTTForm.params.mountpoint.default;
                this.emqxParam.config.password = this.MQTTForm.params.password.default;
                this.emqxParam.config.proto_ver =
                    this.MQTTForm.params.proto_ver.default;
                this.emqxParam.config.reconnect_interval =
                    this.MQTTForm.params.reconnect_interval.default;
                this.emqxParam.config.retry_interval =
                    this.MQTTForm.params.retry_interval.default;
                this.emqxParam.config.ssl = this.MQTTForm.params.ssl.default;
                this.emqxParam.config.username = this.MQTTForm.params.username.default;
                if ("test" == type) {
                    getResourcesConnect(this.emqxParam).then((res) => {
                        let code = res.data.code;
                        if (0 == code) {
                            this.$modal.msgSuccess("连接成功");
                        } else {
                            this.$modal.msgError(res.data.message);
                        }
                    });
                } else {
                    saveResources(this.emqxParam).then((res) => {
                        this.showloading = false;
                        let code = res.data.code;
                        if (0 == code) {
                            this.$modal.msgSuccess("添加资源成功");
                            this.getList();
                            this.cancel();
                        } else {
                            this.$modal.msgError(res.data.message);
                        }
                    });
                }
            } else if ("web_hook" === this.addResourceForm.type) {
                this.emqxParam.description = this.WebHookForm.description;
                this.emqxParam.config.url = this.WebHookForm.params.url.default;
                this.emqxParam.config.method = this.WebHookForm.params.method.default;

                //解析数据转换成后端需要的数据格式
                let headers = {};
                this.ket_value.forEach((item) => {
                    headers[item.key] = item.value;
                });
                this.emqxParam.config.headers = headers;
                if ("test" == type) {
                    getResourcesConnect(this.emqxParam).then((res) => {
                        let code = res.data.code;
                        if (0 == code) {
                            this.$modal.msgSuccess("连接成功");
                        } else {
                            this.$modal.msgError(res.data.message);
                        }
                    });
                } else {
                    saveResources(this.emqxParam).then((res) => {
                        this.showloading = false;
                        let code = res.data.code;
                        if (0 == code) {
                            this.$modal.msgSuccess("添加资源成功");
                            this.getList();
                            this.cancel();
                        } else {
                            this.$modal.msgError(res.data.message);
                        }
                    });
                }
            }
        },
    },
};
</script>
