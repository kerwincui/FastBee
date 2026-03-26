<template>
    <div class="clients_wrap">
        <el-card v-show="showSearch" style="margin-bottom: 10px">
            <el-form @submit.native.prevent :model="queryParams" ref="queryForm" :inline="true" label-width="68px" style="margin-bottom: -20px">
                <el-form-item :label="$t('netty.clients.654908-0')" prop="clientId">
                    <el-input v-model="queryParams.clientId" :placeholder="$t('netty.clients.654908-1')" clearable size="small" @keyup.enter.native="handleQuery" />
                </el-form-item>
                <el-form-item prop="isClient">
                    <el-checkbox v-model="queryParams.isClient" true-label="1" false-label="0">{{ $t('netty.clients.654908-2') }}</el-checkbox>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('device.index.105953-8') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('device.index.105953-9') }}</el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card style="padding-bottom: 100px">
            <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
            <el-table v-loading="loading" :data="clientList" :border="false">
                <el-table-column :label="$t('netty.clients.654908-4')" align="left" header-align="center" prop="clientId">
                    <template slot-scope="scope">
                        <el-link :underline="false" type="primary" @click.native="handleOpen(scope.row)">{{ scope.row.clientId }}</el-link>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('netty.clients.654908-5')" align="center" prop="type">
                    <template slot-scope="scope">
                        <el-tag type="danger" v-if="scope.row.clientId.indexOf('server') == 0">{{ $t('netty.clients.654908-6') }}</el-tag>
                        <el-tag type="success" v-else-if="scope.row.clientId.indexOf('web') == 0">{{ $t('netty.clients.654908-7') }}</el-tag>
                        <el-tag type="warning" v-else-if="scope.row.clientId.indexOf('phone') == 0">{{ $t('netty.clients.654908-8') }}</el-tag>
                        <el-tag type="info" v-else-if="scope.row.clientId.indexOf('test') == 0">{{ $t('netty.clients.654908-9') }}</el-tag>
                        <el-tag type="primary" v-else>{{ $t('netty.clients.654908-10') }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('netty.clients.654908-11')" align="center" prop="connected">
                    <template slot-scope="scope">
                        <el-tag type="success" v-if="scope.row.connected">{{ $t('netty.clients.654908-12') }}</el-tag>
                        <el-tag type="info" v-else>{{ $t('netty.clients.654908-13') }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column :label="$t('netty.clients.654908-14')" align="center" prop="keepAlive" width="100" />
                <el-table-column :label="$t('netty.clients.654908-15')" align="center" prop="username" width="100px" />
                <el-table-column :label="$t('netty.clients.654908-16')" align="center" prop="topicCount" width="100" />
                <el-table-column :label="$t('netty.clients.654908-17')" align="center" prop="connected_at" />

                <el-table-column :label="$t('iot.group.index.637432-10')" align="center" class-name="small-padding fixed-width">
                    <template #default="scope">
                        <el-button type="primary" icon="edit" @click="clickClientOut(scope.row)" size="small">{{ $t('netty.clients.654908-18') }}</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

            <!-- MQTT客户端详细 -->
            <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
                <el-tabs v-model="activeName" tab-position="top" style="padding: 10px">
                    <el-tab-pane name="subscribe">
                        <span slot="label">{{ $t('netty.clients.654908-19') }}</span>
                        <el-row :gutter="10" class="mb8"></el-row>
                        <el-table :data="subscribeList" size="mini">
                            <el-table-column :label="$t('netty.clients.654908-20')" align="center" prop="topicName" />
                            <el-table-column label="QoS" align="center" prop="qos" />
                        </el-table>
                    </el-tab-pane>
                </el-tabs>
            </el-dialog>
        </el-card>

        <!-- 添加或修改订阅对话框 -->
        <el-dialog :title="$t('netty.clients.654908-22')" :visible.sync="subscribeOpen" width="800px" append-to-body>
            <el-form ref="subscribeForm" :model="subscribeForm" :rules="rules" label-width="60px">
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item :label="$t('netty.clients.654908-20')" prop="topic">
                            <el-input v-model="subscribeForm.topic" :placeholder="$t('netty.clients.654908-23')" />
                        </el-form-item>
                        <el-form-item label="Qos" prop="qos">
                            <el-select v-model="subscribeForm.qos" :placeholder="$t('netty.clients.654908-24')">
                                <el-option key="0" label="0" value="0"></el-option>
                                <el-option key="1" label="1" value="1"></el-option>
                                <el-option key="2" label="2" value="2"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">{{ $t('netty.clients.654908-25') }}</el-button>
                <el-button @click="cancelSubscribe">{{ $t('iot.group.device-list.849593-12') }}</el-button>
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
                        message: this.$t('netty.clients.654908-26'),
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
                .confirm(this.$t('netty.clients.654908-27', [clientId]))
                .then(function () {
                    return eliminateClient(clientId);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('iot.group.index.637432-27'));
                })
                .catch(() => {});
        },
        //取消主题订阅
        handleUnsubscribe(row) {
            const clientId = row.clientId;
            const topic = row.topic;
            this.$modal
                .confirm(this.$t('netty.clients.654908-28', [topic]))
                .then(function () {
                    const param = {};
                    param.topic = topic;
                    param.clientId = clientId;
                    return unsubscribe(param);
                })
                .then(() => {
                    this.getSubscribeList(clientId);
                    this.$modal.msgSuccess(this.$t('netty.clients.654908-29'));
                })
                .catch(() => {});
        },
        //查看客户端详情
        handleOpen(row) {
            this.open = true;
            this.title = this.$t('iot.group.index.637432-13');
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
                        this.$modal.msgSuccess(this.$t('netty.clients.654908-30'));
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

<style lang="scss" scoped>
.clients_wrap {
    padding: 15px;
    min-height: 100vh;
    background-color: #f5f7fa;
}
</style>
