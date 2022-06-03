<template>
<div style="padding: 6px">
    <el-card v-show="showSearch" style="margin-bottom: 6px">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom: -20px">
            <el-form-item label="客户端" prop="clientid">
                <el-input v-model="queryParams.clientid" placeholder="请输入客户端ID" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom: 100px">
        <el-table v-loading="loading" :data="clientList">
            <el-table-column label="客户端ID" align="left" header-align="center" prop="clientid">
                <template slot-scope="scope">
                    <el-link :underline="false" type="primary" @click.native="handleOpen(scope.row)">{{ scope.row.clientid }}</el-link>
                </template>
            </el-table-column>
            <el-table-column label="节点" align="center" prop="node" width="120" />
            <el-table-column label="IP地址" align="center" prop="ip_address" />
            <el-table-column label="类型" align="center" prop="type">
                <template slot-scope="scope">
                    <el-tag type="danger" v-if="scope.row.clientid.indexOf('server') == 0">服务端</el-tag>
                    <el-tag type="success" v-else-if="scope.row.clientid.indexOf('web') == 0">Web端</el-tag>
                    <el-tag type="warning" v-else-if="scope.row.clientid.indexOf('phone') == 0">移动端</el-tag>
                    <el-tag type="info" v-else-if="scope.row.clientid.indexOf('test') == 0">测试端</el-tag>
                    <el-tag type="primary" v-else>设备端</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="连接状态" align="center" prop="connected">
                <template slot-scope="scope">
                    <el-tag type="success" v-if="scope.row.connected">已连接</el-tag>
                    <el-tag type="info" v-else>已断开</el-tag>
                </template>
            </el-table-column>
            <el-table-column label="心跳(秒)" align="center" prop="keepalive" width="100" />
            <el-table-column label="会话过期间隔" align="center" prop="expiry_interval" width="100" />
            <el-table-column label="当前订阅数量" align="center" prop="subscriptions_cnt" width="100" />
            <el-table-column label="连接时间" align="center" prop="connected_at" />
            <el-table-column label="会话创建时间" align="center" prop="created_at" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
                <template slot-scope="scope">
                    <el-button size="small" type="danger" v-if="scope.row.connected" style="padding: 5px" v-hasPermi="['iot:emqx:remove']" @click="handleDelete(scope.row)">
                        <svg-icon icon-class="disconnect" /> 断开连接
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams._page" :limit.sync="queryParams._limit" @pagination="getList" />

        <!-- MQTT客户端详细 -->
        <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
            <el-tabs v-model="activeName" tab-position="top" style="padding: 10px">
                <el-tab-pane name="basic">
                    <span slot="label">基本信息</span>
                    <el-descriptions class="margin-top" :column="2" border size="medium">
                        <el-descriptions-item label="节点">{{form.node }}</el-descriptions-item>
                        <el-descriptions-item label="客户端ID">{{form.clientid}}</el-descriptions-item>
                        <el-descriptions-item label="清除Session">{{form.clean_start}}</el-descriptions-item>
                        <el-descriptions-item label="会话过期间隔(秒)">{{form.expiry_interval}}</el-descriptions-item>
                        <el-descriptions-item label="用户名">{{form.username}}</el-descriptions-item>
                        <el-descriptions-item label="协议类型">{{form.proto_ver}}</el-descriptions-item>
                        <el-descriptions-item label="会话创建时间">{{form.created_at}}</el-descriptions-item>
                        <el-descriptions-item label="订阅数量">{{ form.subscriptions_cnt }}/{{form.max_subscriptions}}</el-descriptions-item>
                        <el-descriptions-item label="IP地址">{{form.ip_address}}</el-descriptions-item>
                        <el-descriptions-item label="端口">{{form.port}}</el-descriptions-item>
                        <el-descriptions-item label="最大订阅数量">{{form.max_subscriptions}}</el-descriptions-item>
                        <el-descriptions-item label="飞行窗口">{{ form.inflight }}/{{ form.max_inflight }}</el-descriptions-item>
                        <el-descriptions-item label="心跳(秒)">{{form.keepalive}}</el-descriptions-item>
                        <el-descriptions-item label="是否为桥接">{{form.is_bridge}}</el-descriptions-item>
                        <el-descriptions-item label="最大飞行窗口">{{form.max_inflight}}</el-descriptions-item>
                        <el-descriptions-item label="消息队列">{{ form.mqueue_len }}/{{ form.max_mqueue }}</el-descriptions-item>
                        <el-descriptions-item label="连接时间">{{form.connected_at}}</el-descriptions-item>
                        <el-descriptions-item label="连接状态">
                            <div v-if="form.connected == true" style="color: green">
                                已连接
                            </div>
                            <div v-else-if="form.connected == false" style="color: red">
                                已断开
                            </div>
                        </el-descriptions-item>
                        <el-descriptions-item label="最大消息队列">{{form.max_mqueue}}</el-descriptions-item>
                        <el-descriptions-item label="未确认的PUBREC数据包计数">{{form.awaiting_rel}}</el-descriptions-item>
                        <el-descriptions-item label="Zone">{{form.zone}}</el-descriptions-item>
                        <el-descriptions-item label="最大未确认的PUBREC数据包计数">{{form.max_awaiting_rel}}</el-descriptions-item>
                        <el-descriptions-item label="接收的TCP报文数量">{{form.recv_cnt}}</el-descriptions-item>
                        <el-descriptions-item label="接收的PUBLISH报文数量">{{form.recv_msg}}</el-descriptions-item>
                        <el-descriptions-item label="接收的字节数量">{{form.recv_oct}}</el-descriptions-item>
                        <el-descriptions-item label="接收的MQTT报文数量">{{form.recv_pkt}}</el-descriptions-item>
                        <el-descriptions-item label="发送的TCP报文数量">{{form.send_cnt}}</el-descriptions-item>
                        <el-descriptions-item label="发送的PUBLISH报文数量">{{form.send_msg}}</el-descriptions-item>
                        <el-descriptions-item label="发送的字节数量">{{form.send_oct}}</el-descriptions-item>
                        <el-descriptions-item label="发送的MQTT报文数量">{{form.send_pkt}}</el-descriptions-item>
                    </el-descriptions>
                </el-tab-pane>

                <el-tab-pane name="subscribe">
                    <span slot="label">订阅列表</span>
                    <el-row :gutter="10" class="mb8">
                        <el-col :span="1.5">
                            <el-button type="primary" plain icon="el-icon-refresh" size="mini" @click="handleRefresh" v-hasPermi="['iot:emqx:query']">刷新</el-button>
                        </el-col>
                        <el-col :span="1.5">
                            <el-button type="success" plain icon="el-icon-plus" size="mini" :disabled="single" @click="handleAdd" v-hasPermi="['iot:emqx:add']">添加订阅</el-button>
                        </el-col>
                    </el-row>
                    <el-table v-loading="loadSubscribeing" :data="subscribeList">
                        <el-table-column label="主题" align="center" prop="topic" />
                        <el-table-column label="QoS" align="center" prop="qos" />
                        <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
                            <template slot-scope="scope">
                                <el-button size="small" type="danger" style="padding: 5px" v-hasPermi="['iot:emqx:remove']" @click="handleUnsubscribe(scope.row)">
                                    <svg-icon icon-class="disconnect" /> 取消订阅
                                </el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </el-tab-pane>
            </el-tabs>
        </el-dialog>
    </el-card>

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
import {
    listMqttClient,
    eliminateClient,
    getClientDetails,
    getSubscriptionsByClientId,
    unsubscribe,
    addSubscribe,
} from "@/api/iot/emqx";

export default {
    name: "Category",
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
            title: "",
            // 是否显示弹出层
            open: false,
            // 是否显示添加订阅弹出层
            subscribeOpen: false,
            // 查询参数
            queryParams: {
                _limit: 10,
                _page: 1,
                clientid:null,
            },
            // 表单参数
            form: {},
            // 选中选项卡
            activeName: "basic",
            //订阅列表数据
            subscribeList: [],
            //订阅数据
            subscribe: {
                topic: "",
                clientid: "",
            },
            //添加订阅表单参数
            subscribeForm: {
                qos: "0",
            },
            //客户端ID
            clientid: "",
            // 表单校验
            rules: {
                topic: [{
                    required: true,
                    message: "主题不能为空",
                    trigger: "blur",
                }, ],
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
            listMqttClient(this.queryParams).then((response) => {
                this.clientList = response.data.data;
                this.total = response.data.meta.count;
                this.loading = false;
            });
        },
        /** 查询客户端订阅列表 */
        getSubscribeList(clientid) {
            this.clientid = clientid;
            this.loadSubscribeing = true;
            getSubscriptionsByClientId(clientid).then((res) => {
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
            this.resetForm("queryForm");
            this.handleQuery();
        },
        /** 断开客户端连接 */
        handleDelete(row) {
            const clientid = row.clientid;
            this.$modal
                .confirm('是否确认删除MQTT客户端编号为"' + clientid + '"的数据项？')
                .then(function () {
                    return eliminateClient(clientid);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess("删除成功");
                })
                .catch(() => {});
        },
        //取消主题订阅
        handleUnsubscribe(row) {
            const clientid = row.clientid;
            const topic = row.topic;
            this.$modal
                .confirm('是否确认取消订阅主题为"' + topic + '"的数据项？')
                .then(function () {
                    const param = {};
                    param.topic = topic;
                    param.clientid = clientid;
                    return unsubscribe(param);
                })
                .then(() => {
                    this.getSubscribeList(clientid);
                    this.$modal.msgSuccess("取消订阅成功");
                })
                .catch(() => {});
        },
        //查看客户端详情
        handleOpen(row) {
            const clientid = row.clientid;
            this.getSubscribeList(clientid);
            getClientDetails(clientid).then((response) => {
                this.form = response.data.data[0];
                this.open = true;
                this.title = "详情";
            });
        },
        //刷新订阅列表
        handleRefresh() {
            this.getSubscribeList(this.clientid);
        },
        //添加订阅
        handleAdd() {
            this.subscribeOpen = true;
        },
        //提交添加订阅表单
        submitForm() {
            this.subscribeForm.clientid = this.clientid;
            console.log(this.subscribeForm);
            this.$refs["subscribeForm"].validate((valid) => {
                if (valid) {
                    addSubscribe(this.subscribeForm).then((response) => {
                        this.$modal.msgSuccess("新增订阅成功");
                        this.subscribeOpen = false;
                        this.getSubscribeList(this.clientid);
                    });
                }
            });
        },
        cancelSubscribe() {
            this.subscribeOpen = false;
            this.resetForm("subscribeForm");
            //刷新列表
            this.getSubscribeList(this.clientid);
        },
    },
};
</script>
