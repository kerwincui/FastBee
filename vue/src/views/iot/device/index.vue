<template>
    <div class="device_wrap">
        <el-card shadow="never" style="margin-bottom: 10px">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="75px" style="margin-bottom: -20px">
                <el-form-item :label="$t('device.index.105953-0')" prop="deviceName">
                    <el-input v-model="queryParams.deviceName" :placeholder="$t('device.index.105953-1')" clearable size="small" @keyup.enter.native="handleQuery" style="width: 150px" />
                </el-form-item>
                <el-form-item :label="$t('device.index.105953-2')" prop="serialNumber">
                    <el-input v-model="queryParams.serialNumber" :placeholder="$t('device.index.105953-3')" clearable size="small" @keyup.enter.native="handleQuery" style="width: 150px" />
                </el-form-item>
                <el-form-item :label="$t('device.index.105953-4')" prop="status" v-if="searchShow">
                    <el-select v-model="queryParams.status" :placeholder="$t('device.index.105953-5')" clearable size="small" style="width: 150px">
                        <el-option v-for="dict in dict.type.iot_device_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                    </el-select>
                </el-form-item>
                <el-form-item :label="$t('device.index.105953-6')" v-if="searchShow">
                    <el-select v-model="queryParams.groupId" :placeholder="$t('device.index.105953-7')" clearable size="small" style="width: 150px">
                        <el-option v-for="group in myGroupList" :key="group.groupId" :label="group.groupName" :value="group.groupId" />
                    </el-select>
                </el-form-item>
                <el-form-item style="float: right">
                    <el-button type="primary" icon="el-icon-search" size="small" @click="handleQuery">{{ $t('search') }}</el-button>
                    <el-button icon="el-icon-refresh" size="small" @click="resetQuery">{{ $t('reset') }}</el-button>
                    <el-button type="text" @click="searchChange">
                        <span style="color: #486ff2; margin-left: 14px">
                            {{ searchShow ? $t('template.index.891112-113') : $t('template.index.891112-112') }}
                        </span>
                        <i style="color: #486ff2; margin-left: 10px" :class="{ 'el-icon-arrow-down': !searchShow, 'el-icon-arrow-up': searchShow }"></i>
                    </el-button>
                </el-form-item>
            </el-form>
        </el-card>

        <el-card shadow="never" style="padding-bottom: 100px">
            <el-button type="primary" plain icon="el-icon-plus" size="small" @click="handleEditDevice(0)" style="margin-bottom: 10px" v-hasPermi="['iot:device:add']">{{ $t('add') }}</el-button>
            <el-button type="primary" plain icon="el-icon-s-grid" size="small" @click="handleChangeShowType" v-hasPermi="['iot:device:add']">{{ $t('device.index.105953-17') }}</el-button>
            <div v-if="showType == 'list'">
                <el-table v-loading="loading" :data="deviceList" :border="false" header-cell-class-name="table-header">
                    <el-table-column :label="$t('device.index.105953-20')" align="center" header-align="center" prop="deviceId" width="50" />
                    <el-table-column :label="$t('device.index.105953-0')" align="center" header-align="center" prop="deviceName" min-width="120" />
                    <el-table-column :label="$t('device.index.105953-2')" align="center" prop="serialNumber" min-width="130" />
                    <el-table-column :label="$t('device.index.105953-21')" align="center" prop="productName" min-width="120" />
                    <el-table-column :label="$t('device.index.105953-22')" align="center" prop="transport" min-width="50" />
                    <el-table-column :label="$t('device.index.105953-23')" align="center" prop="protocolCode" min-width="100" />
                    <el-table-column :label="$t('device.index.105953-24')" align="center" prop="subDeviceCount" width="80">
                        <template slot-scope="scope">
                            {{ scope.row.subDeviceCount }}
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('device.device-edit.148398-15')" align="center" prop="isShadow" width="80">
                        <template slot-scope="scope">
                            <el-tag type="success" size="small" v-if="scope.row.isShadow == 1">{{ $t('device.index.105953-26') }}</el-tag>
                            <el-tag type="info" size="small" v-else>{{ $t('device.index.105953-27') }}</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('status')" align="center" prop="status" width="80">
                        <template slot-scope="scope">
                            <dict-tag :options="dict.type.iot_device_status" :value="scope.row.status" size="small" />
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('device.index.105953-29')" align="center" prop="rssi" width="60">
                        <template slot-scope="scope">
                            <svg-icon v-if="scope.row.status == 3 && scope.row.rssi >= '-55'" icon-class="wifi_4" />
                            <svg-icon v-else-if="scope.row.status == 3 && scope.row.rssi >= '-70' && scope.row.rssi < '-55'" icon-class="wifi_3" />
                            <svg-icon v-else-if="scope.row.status == 3 && scope.row.rssi >= '-85' && scope.row.rssi < '-70'" icon-class="wifi_2" />
                            <svg-icon v-else-if="scope.row.status == 3 && scope.row.rssi >= '-100' && scope.row.rssi < '-85'" icon-class="wifi_1" />
                            <svg-icon v-else icon-class="wifi_0" />
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('device.index.105953-30')" align="center" prop="locationWay">
                        <template slot-scope="scope">
                            <dict-tag :options="dict.type.iot_location_way" :value="scope.row.locationWay" size="small" />
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('device.index.105953-31')" align="center" prop="firmwareVersion">
                        <template slot-scope="scope">
                            <el-tag size="small" type="info">Ver {{ scope.row.firmwareVersion }}</el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('device.index.105953-32')" align="center" prop="activeTime">
                        <template slot-scope="scope">
                            <span>{{ parseTime(scope.row.activeTime, '{y}-{m}-{d}') }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column :label="$t('creatTime')" align="center" prop="createTime">
                        <template slot-scope="scope">
                            <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                        </template>
                    </el-table-column>

                    <el-table-column :label="$t('opation')" align="center" class-name="small-padding fixed-width" width="200">
                        <template slot-scope="scope">
                            <el-button type="text" size="small" style="padding: 5px" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['iot:device:remove']">{{ $t('del') }}</el-button>
                            <el-button type="text" size="small" style="padding: 5px" icon="el-icon-view" @click="handleEditDevice(scope.row)" v-hasPermi="['iot:device:add']">{{ $t('look') }}</el-button>
                            <el-button type="text" size="small" style="padding: 5px" @click="openSummaryDialog(scope.row)" v-if="form.deviceId != 0">{{ $t('device.index.105953-37') }}</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <div class="pagination-container">
                    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" :pageSizes="[12, 24, 36, 60]" @pagination="getList" />
                </div>
            </div>

            <div style="padding-bottom: 100px" v-if="showType == 'card'">
                <el-row :gutter="20" v-loading="loading">
                    <el-col :xs="24" :sm="12" :md="12" :lg="8" :xl="6" v-for="(item, index) in deviceList" :key="index" style="margin-bottom: 20px">
                        <el-card shadow="hover" class="device-card">
                            <div class="card-header">
                                <div class="device-name" @click="handleEditDevice(item)">
                                    <span>{{ item.deviceName }}</span>
                                </div>
                                <div class="header-status">
                                    <dict-tag :options="dict.type.iot_device_status" :value="item.status" size="mini" />
                                </div>
                            </div>

                            <div class="card-time">
                                {{ parseTime(item.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}
                            </div>

                            <div class="card-info">
                                <div class="info-row">
                                    <span class="info-value" style="width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
                                        {{ $t('device.device-edit.148398-4') }}：
                                        <el-tooltip :content="item.productName || '---'" placement="top">
                                            <span>{{ item.productName || '---' }}</span>
                                        </el-tooltip>
                                    </span>
                                </div>
                                <div class="info-row">
                                    <span class="info-value" style="width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
                                        {{ $t('device.device-edit.148398-7') }}：
                                        <el-tooltip :content="item.serialNumber || '---'" placement="top">
                                            <span>{{ item.serialNumber || '---' }}</span>
                                        </el-tooltip>
                                    </span>
                                </div>
                                <div class="info-row" v-if="item.transport">
                                    <span class="info-value">{{ $t('product.product-edit.473153-14') }}：{{ item.transport }}</span>
                                </div>

                                <div class="info-row">
                                    <span class="info-value" style="width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis">
                                        {{ $t('device.index.105953-23') }}：
                                        <el-tooltip :content="item.protocolCode || '--'" placement="top">
                                            <span>{{ item.protocolCode || '--' }}</span>
                                        </el-tooltip>
                                    </span>
                                </div>
                            </div>

                            <div class="card-footer">
                                <div class="footer-left">
                                    <el-tooltip :content="$t('device.device-edit.148398-56')" placement="top">
                                        <svg-icon icon-class="qrcode" @click="openSummaryDialog(item)" />
                                    </el-tooltip>
                                    <div class="wifi-signal">
                                        <svg-icon v-if="item.status == 3 && item.rssi >= '-55'" icon-class="wifi_4" />
                                        <svg-icon v-else-if="item.status == 3 && item.rssi >= '-70' && item.rssi < '-55'" icon-class="wifi_3" />
                                        <svg-icon v-else-if="item.status == 3 && item.rssi >= '-85' && item.rssi < '-70'" icon-class="wifi_2" />
                                        <svg-icon v-else-if="item.status == 3 && item.rssi >= '-100' && item.rssi < '-85'" icon-class="wifi_1" />
                                        <svg-icon v-else icon-class="wifi_0" />
                                    </div>
                                </div>
                                <div class="footer-actions">
                                    <el-tooltip :content="$t('edit')" placement="top">
                                        <i class="el-icon-edit-outline" @click="handleEditDevice(item)"></i>
                                    </el-tooltip>
                                    <el-tooltip :content="$t('look')" placement="top">
                                        <i class="el-icon-view" @click="handleEditDevice(item, 'basic')"></i>
                                    </el-tooltip>
                                    <el-tooltip :content="$t('del')" placement="top">
                                        <i class="el-icon-delete" @click="handleDelete(item)"></i>
                                    </el-tooltip>
                                    <el-tooltip :content="$t('device.index.105953-40')" placement="top">
                                        <i class="el-icon-odometer" @click="handleRunDevice(item)"></i>
                                    </el-tooltip>
                                </div>
                            </div>
                        </el-card>
                    </el-col>
                </el-row>
                <el-empty :description="$t('device.index.105953-41')" v-if="total == 0"></el-empty>
                <div class="pagination-container">
                    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" :pageSizes="[12, 24, 36, 60]" @pagination="getList" />
                </div>
            </div>
        </el-card>

        <!-- 二维码 -->
        <el-dialog :visible.sync="openSummary" width="300px" append-to-body>
            <div style="border: 1px solid #ccc; width: 220px; text-align: center; margin: 0 auto; margin-top: -15px">
                <vue-qr :text="qrText" :size="200"></vue-qr>
                <div style="padding-bottom: 10px">{{ $t('device.index.105953-42') }}</div>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import vueQr from 'vue-qr';
import { listDeviceShort, delDevice } from '@/api/iot/device';
import { listGroup } from '@/api/iot/group';
import { delSipDeviceBySipId } from '@/api/iot/sipdevice';

export default {
    name: 'Device',
    dicts: ['iot_device_status', 'iot_is_enable', 'iot_location_way', 'iot_transport_type'],
    components: {
        vueQr,
    },
    data() {
        return {
            // 二维码内容
            qrText: 'fastbee',
            // 打开设备配置对话框
            openSummary: false,
            // 展示方式
            showType: 'card',
            // 遮罩层
            loading: true,
            // 总条数
            total: 0,
            // 设备列表数据
            deviceList: [],
            // 我的分组列表数据
            myGroupList: [],
            // 根路径
            baseUrl: process.env.VUE_APP_BASE_API,
            searchShow: false,
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 12,
                deviceName: null,
                productId: null,
                groupId: null,
                productName: null,
                userId: null,
                userName: null,
                tenantId: null,
                tenantName: null,
                serialNumber: null,
                status: null,
                networkAddress: null,
                activeTime: null,
            },
            // 表单参数
            form: {
                productId: 0,
                status: 1,
                locationWay: 1,
                firmwareVersion: 1.0,
                serialNumber: '',
                deviceType: 1,
                isSimulate: 0,
            },
            isSubDev: false,
        };
    },
    created() {
        // 产品筛选
        let productId = this.$route.query.productId;
        if (productId != null) {
            this.queryParams.productId = Number(productId);
            this.queryParams.groupId = null;
            this.queryParams.serialNumber = null;
        }
        // 分组筛选
        let groupId = this.$route.query.groupId;
        if (groupId != null) {
            this.queryParams.groupId = Number(groupId);
            this.queryParams.productId = null;
            this.queryParams.serialNumber = null;
        }
        // 设备编号筛选
        let sn = this.$route.query.sn;
        if (sn != null) {
            this.queryParams.serialNumber = sn;
            this.queryParams.productId = null;
            this.queryParams.groupId = null;
        }
        this.connectMqtt();
    },
    activated() {
        const time = this.$route.query.t;
        if (time != null && time != this.uniqueId) {
            this.uniqueId = time;
            // 页码筛选
            let pageNum = this.$route.query.pageNum;
            if (pageNum != null) {
                this.queryParams.pageNum = Number(pageNum);
            }
            // 产品筛选
            let productId = this.$route.query.productId;
            if (productId != null) {
                this.queryParams.productId = Number(productId);
                this.queryParams.groupId = null;
                this.queryParams.serialNumber = null;
            }
            // 分组筛选
            let groupId = this.$route.query.groupId;
            if (groupId != null) {
                this.queryParams.groupId = Number(groupId);
                this.queryParams.productId = null;
                this.queryParams.serialNumber = null;
            }
            // 设备编号筛选
            let sn = this.$route.query.sn;
            if (sn != null) {
                this.queryParams.serialNumber = sn;
                this.queryParams.productId = null;
                this.queryParams.groupId = null;
            }
            this.getList();
        }
    },
    methods: {
        /* 连接Mqtt消息服务器 */
        async connectMqtt() {
            if (this.$mqttTool.client == null) {
                await this.$mqttTool.connect();
            }
            this.mqttCallback();
            this.getList();
        },
        /* Mqtt回调处理  */
        mqttCallback() {
            this.$mqttTool.client.on('message', (topic, message, buffer) => {
                let topics = topic.split('/');
                let productId = topics[1];
                let deviceNum = topics[2];
                message = JSON.parse(message.toString());
                if (!message) {
                    return;
                }
                if (topics[3] == 'status') {
                    console.log(this.$t('device.index.105953-43'), topic);
                    console.log(this.$t('device.index.105953-44'), message);
                    // 更新列表中设备的状态
                    for (let i = 0; i < this.deviceList.length; i++) {
                        if (this.deviceList[i].serialNumber == deviceNum) {
                            this.deviceList[i].status = message.status;
                            this.deviceList[i].isShadow = message.isShadow;
                            this.deviceList[i].rssi = message.rssi;
                            return;
                        }
                    }
                }
            });
        },
        // 搜索展开隐藏
        searchChange() {
            this.searchShow = !this.searchShow;
        },
        openSummaryDialog(row) {
            let json = {
                type: 1, // 1=扫码关联设备
                deviceNumber: row.serialNumber,
                productId: row.productId,
                productName: row.productName,
            };
            this.qrText = JSON.stringify(json);
            this.openSummary = true;
        },
        /* 订阅消息 */
        mqttSubscribe(list) {
            // 订阅当前页面设备状态和实时监测
            let topics = [];
            for (let i = 0; i < list.length; i++) {
                let topicStatus = '/' + '+' + '/' + list[i].serialNumber + '/status/post';
                topics.push(topicStatus);
            }
            this.$mqttTool.subscribe(topics);
        },
        /** 查询设备分组列表 */
        getGroupList() {
            this.loading = true;
            let queryParams = {
                pageSize: 30,
                pageNum: 1,
                userId: this.$store.state.user.userId,
            };
            listGroup(queryParams).then((response) => {
                this.myGroupList = response.rows;
            });
        },
        /** 查询所有简短设备列表 */
        getList() {
            this.loading = true;
            this.queryParams.params = {};
            this.getGroupList();
            listDeviceShort(this.queryParams).then((response) => {
                this.deviceList = response.rows;
                this.total = response.total - 1;
                // 订阅消息
                if (this.deviceList && this.deviceList.length > 0) {
                    this.mqttSubscribe(this.deviceList);
                }
                this.deviceList = this.deviceList.filter((device) => device.deviceId !== 118);
                this.loading = false;
            });
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.queryParams.productId = null;
            this.queryParams.groupId = null;
            this.queryParams.serialNumber = null;
            this.resetForm('queryForm');
            this.handleQuery();
        },
        /** 切换显示方式 */
        handleChangeShowType() {
            this.showType = this.showType == 'card' ? 'list' : 'card';
        },
        /** 修改按钮操作 */
        handleEditDevice(row, activeName) {
            let deviceId = 0;
            let isSubDev = 0;
            if (row != 0) {
                deviceId = row.deviceId || this.ids;
                isSubDev = row.subDeviceCount > 0 ? 1 : 0;
            }
            this.$router.push({
                path: '/iot/device-edit',
                query: {
                    deviceId: deviceId,
                    isSubDev: isSubDev,
                    pageNum: this.queryParams.pageNum,
                    activeName: activeName,
                },
            });
        },
        /** 运行状态按钮操作 */
        handleRunDevice(row) {
            let deviceId = 0;
            let isSubDev = 0;
            if (row != 0) {
                deviceId = row.deviceId || this.ids;
                isSubDev = row.subDeviceCount > 0 ? 1 : 0;
            }
            if (row.deviceType === 3) {
                this.$router.push({
                    path: '/iot/device-edit',
                    query: {
                        deviceId: deviceId,
                        isSubDev: isSubDev,
                        pageNum: this.queryParams.pageNum,
                        activeName: 'videoLive',
                    },
                });
            } else {
                this.$router.push({
                    path: '/iot/device-edit',
                    query: {
                        deviceId: deviceId,
                        isSubDev: isSubDev,
                        pageNum: this.queryParams.pageNum,
                        activeName: 'runningStatus',
                    },
                });
            }
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const deviceIds = row.deviceId || this.ids;
            this.$modal
                .confirm(this.$t('device.index.105953-45', [deviceIds]))
                .then(function () {
                    if (row.deviceType === 3) {
                        delSipDeviceBySipId(row.serialNumber);
                    }
                    return delDevice(deviceIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('delSuccess'));
                })
                .catch(() => {});
        },
        /** 未启用设备影子*/
        shadowUnEnable(device, thingsModel) {
            // 1-未激活，2-禁用，3-在线，4-离线
            if (device.status != 3 && device.isShadow == 0) {
                return true;
            }
            if (thingsModel.isReadonly) {
                return true;
            }
            return false;
        },
    },
};
</script>

<style lang="scss" scoped>
.device_wrap {
    padding: 15px;
    min-height: 100vh;
    background-color: #f5f7fa;
}

.table-header {
    background-color: #f5f7fa !important;
    color: #606266;
    font-weight: 600;
    text-align: center;
}

::v-deep .el-table {
    th {
        color: #606266;
        font-weight: 600;
        text-align: center;
    }

    td {
        padding: 12px 0;
    }

    .el-table__body tr:hover > td {
        background-color: #f5f7fa !important;
    }
}

.device-card {
    border-radius: 8px;
    border: 1px solid #e8e8e8;
    transition: all 0.3s;

    &:hover {
        box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
        border-color: #409eff;
    }

    .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;

        .device-name {
            cursor: pointer;
            font-weight: 600;
            font-size: 15px;
            color: #303133;

            &:hover {
                color: #409eff;
            }
        }

        .header-status {
            flex-shrink: 0;
        }
    }

    .card-time {
        font-size: 12px;
        color: #909399;
        margin-bottom: 16px;
    }

    .card-info {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        margin-bottom: 16px;

        .info-row {
            display: flex;
            flex-direction: column;

            .info-label {
                font-size: 12px;
                color: #909399;
                margin-bottom: 4px;
            }

            .info-value {
                font-size: 13px;
                color: #606266;
            }
        }
    }

    .card-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-top: 1px solid #f0f0f0;
        padding-top: 12px;

        .footer-left {
            display: flex;
            align-items: center;
            gap: 8px;

            .wifi-signal {
                font-size: 18px;
                color: #909399;
            }

            .el-icon-qr-code {
                font-size: 18px;
                color: #409eff;
                cursor: pointer;

                &:hover {
                    color: #66b1ff;
                }
            }
        }

        .footer-actions {
            display: flex;
            align-items: center;
            gap: 12px;

            i {
                font-size: 18px;
                color: #606266;
                cursor: pointer;
                transition: all 0.3s;

                &:hover {
                    color: #409eff;
                }

                &.el-icon-delete:hover {
                    color: #f56c6c;
                }
            }
        }
    }
}
</style>
