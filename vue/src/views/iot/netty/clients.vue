<template>
    <div style="padding: 6px">
        <el-card v-show="showSearch" style="margin-bottom: 6px">
            <el-form @submit.native.prevent :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom: -20px">
                <el-form-item label="客户端" prop="clientId">
                    <el-input v-model="queryParams.clientId" placeholder="请输入客户端ID" clearable size="small" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item prop="isClient">
                    <el-checkbox v-model="queryParams.isClient" true-label="1" false-label="0">只看设备端</el-checkbox>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                    <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-tabs type="border-card" v-model="serverType" @tab-click="handleClick" style="flex: 1; height: 800px; margin-bottom: 5px">
            <el-tab-pane label="MQTT客户端" name="MQTT">
                <el-table v-loading="loading" :data="clientList">
                    <el-table-column label="客户端ID" align="left" header-align="center" prop="clientId">
                        <template slot-scope="scope">
                            <el-link :underline="false" type="primary" @click.native="handleOpen(scope.row)">{{ scope.row.clientId }}</el-link>
                        </template>
                    </el-table-column>
                    <el-table-column label="类型" align="center" prop="type">
                        <template slot-scope="scope">
                            <el-tag type="danger" v-if="scope.row.clientId.indexOf('server') == 0">服务端</el-tag>
                            <el-tag type="success" v-else-if="scope.row.clientId.indexOf('web') == 0">Web端</el-tag>
                            <el-tag type="warning" v-else-if="scope.row.clientId.indexOf('phone') == 0">移动端</el-tag>
                            <el-tag type="info" v-else-if="scope.row.clientId.indexOf('test') == 0">测试端</el-tag>
                            <el-tag type="primary" v-else>设备端</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column label="连接状态" align="center" prop="connected">
                        <template slot-scope="scope">
                            <el-tag type="success" v-if="scope.row.connected">已连接</el-tag>
                            <el-tag type="info" v-else>已断开</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column label="心跳(秒)" align="center" prop="keepAlive" width="100" />
                    <el-table-column label="账号" align="center" prop="username" width="100px" />
                    <el-table-column label="当前订阅数量" align="center" prop="topicCount" width="100" />
                    <el-table-column label="连接时间" align="center" prop="connected_at" />

                    <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                        <template #default="scope">
                            <el-button link type="primary" icon="Edit" @click="clickClientOut(scope.row)">踢出</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

                <!-- MQTT客户端详细 -->
                <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
                    <el-tabs v-model="activeName" tab-position="top" style="padding: 10px">
                        <el-tab-pane name="subscribe">
                            <span slot="label">订阅列表</span>
                            <el-row :gutter="10" class="mb8"></el-row>
                            <el-table :data="subscribeList" size="mini">
                                <el-table-column label="主题" align="center" prop="topicName" />
                                <el-table-column label="QoS" align="center" prop="qos" />
                            </el-table>
                        </el-tab-pane>
                    </el-tabs>
                </el-dialog>
            </el-tab-pane>
            <el-tab-pane label="TCP客户端" name="TCP">
                <el-table v-loading="loading" :data="clientList">
                    <el-table-column label="客户端ID" align="left" header-align="center" prop="clientId"></el-table-column>
                    <el-table-column label="类型" align="center" prop="type">
                        <template slot-scope="scope">
                            <el-tag type="danger" v-if="scope.row.clientId.indexOf('server') == 0">服务端</el-tag>
                            <el-tag type="success" v-else-if="scope.row.clientId.indexOf('web') == 0">Web端</el-tag>
                            <el-tag type="warning" v-else-if="scope.row.clientId.indexOf('phone') == 0">移动端</el-tag>
                            <el-tag type="info" v-else-if="scope.row.clientId.indexOf('test') == 0">测试端</el-tag>
                            <el-tag type="primary" v-else>设备端</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column label="连接状态" align="center" prop="connected">
                        <template slot-scope="scope">
                            <el-tag type="success" v-if="scope.row.connected">已连接</el-tag>
                            <el-tag type="info" v-else>已断开</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column label="心跳(秒)" align="center" prop="keepAlive" width="100" />
                    <el-table-column label="连接时间" align="center" prop="connected_at" />

                    <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                        <template #default="scope">
                            <el-button link type="primary" icon="Edit" @click="clickClientOut(scope.row)">踢出</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

                <!-- MQTT客户端详细 -->
                <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
                    <el-tabs v-model="activeName" tab-position="top" style="padding: 10px">
                        <el-tab-pane name="subscribe">
                            <span slot="label">订阅列表</span>
                            <el-row :gutter="10" class="mb8"></el-row>
                            <el-table :data="subscribeList" size="mini">
                                <el-table-column label="主题" align="center" prop="topicName" />
                                <el-table-column label="QoS" align="center" prop="qos" />
                            </el-table>
                        </el-tab-pane>
                    </el-tabs>
                </el-dialog>
            </el-tab-pane>
        </el-tabs>

        <!-- 添加或修改订阅对话框 -->
        <el-dialog title="添加订阅" :visible.sync="subscribeOpen" width="800px" append-to-body>
            <el-form ref="subscribeForm" :model="subscribeForm" :rules="rules" label-width="60px">
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item label="主题" prop="topic">
                            <el-input v-model="subscribeForm.topic" placeholder="请输入主题" />
                        </el-form-item>
                        <el-form-item label="Qos" prop="qos">
                            <el-select v-model="subscribeForm.qos" placeholder="请选择消息类型">
                                <el-option key="0" label="0" value="0"></el-option>
                                <el-option key="1" label="1" value="1"></el-option>
                                <el-option key="2" label="2" value="2"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">添 加 订 阅</el-button>
                <el-button @click="cancelSubscribe">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import { clientOut, listNettyMqttClient } from '@/api/iot/netty';

export default {
    name: 'Category',
    data() {
        return {
            // 非单个禁用
            single: true,
            // 遮罩层
            loading: true,
            loadSubscribeing: true,
            // 显示搜索条件
            showSearch: true,
            // 总条数
            total: 0,
            // 产品分类表格数据
            clientList: [],
            // 弹出层标题
            title: '',
            // 是否显示弹出层
            open: false,
            // 是否显示添加订阅弹出层
            subscribeOpen: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                clientId: null,
                isClient: 0,
                serverCode: 'MQTT',
            },
            // 表单参数
            form: {},
            // 选中选项卡
            activeName: 'subscribe',
            //订阅列表数据
            subscribeList: [],
            //订阅数据
            subscribe: {
                topic: '',
                clientId: '',
            },
            //添加订阅表单参数
            subscribeForm: {
                qos: '0',
            },
            //客户端ID
            clientId: '',
            //服务协议类型
            serverType: 'MQTT',
            // 表单校验
            rules: {
                topic: [
                    {
                        required: true,
                        message: '主题不能为空',
                        trigger: 'blur',
                    },
                ],
            },
        };
    },
    created() {
        this.getList();
    },
    methods: {
        /** 查询客户端列表 */
        getList() {
            this.loading = true;
            listNettyMqttClient(this.queryParams).then((response) => {
                this.clientList = response.data;
                this.total = response.total;
                this.loading = false;
            });
        },

        /*将客户端踢出*/
        clickClientOut(row) {
            const params = { clientId: row.clientId };
            clientOut(params).then((res) => {
                //刷新列表
                this.getList();
            });
        },

        /*tabs切换*/
        handleClick() {
            this.queryParams.serverCode = this.serverType;
            this.getList();
        },

        /** 查询客户端订阅列表 */
        getSubscribeList(clientId) {
            this.clientId = clientId;
            this.loadSubscribeing = true;
            getSubscriptionsByClientId(clientId).then((res) => {
                this.subscribeList = res.data.data;
                this.loadSubscribeing = false;
            });
        },

        // 取消按钮
        cancel() {
            this.open = false;
            this.reset();
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 断开客户端连接 */
        handleDelete(row) {
            const clientId = row.clientId;
            this.$modal
                .confirm('是否确认删除MQTT客户端编号为"' + clientId + '"的数据项？')
                .then(function () {
                    return eliminateClient(clientId);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess('删除成功');
                })
                .catch(() => {});
        },
        //取消主题订阅
        handleUnsubscribe(row) {
            const clientId = row.clientId;
            const topic = row.topic;
            this.$modal
                .confirm('是否确认取消订阅主题为"' + topic + '"的数据项？')
                .then(function () {
                    const param = {};
                    param.topic = topic;
                    param.clientId = clientId;
                    return unsubscribe(param);
                })
                .then(() => {
                    this.getSubscribeList(clientId);
                    this.$modal.msgSuccess('取消订阅成功');
                })
                .catch(() => {});
        },
        //查看客户端详情
        handleOpen(row) {
            this.open = true;
            this.title = '详情';
            this.subscribeList = row.topics;
            console.log(this.subscribeList);
        },

        //添加订阅
        handleAdd() {
            this.subscribeOpen = true;
        },
        //提交添加订阅表单
        submitForm() {
            this.subscribeForm.clientId = this.clientId;
            console.log(this.subscribeForm);
            this.$refs['subscribeForm'].validate((valid) => {
                if (valid) {
                    addSubscribe(this.subscribeForm).then((response) => {
                        this.$modal.msgSuccess('新增订阅成功');
                        this.subscribeOpen = false;
                        this.getSubscribeList(this.clientId);
                    });
                }
            });
        },
        cancelSubscribe() {
            this.subscribeOpen = false;
            this.resetForm('subscribeForm');
            //刷新列表
            this.getSubscribeList(this.clientId);
        },
    },
};
</script>
