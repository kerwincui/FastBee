<template>
<div style="padding:6px;">
    <el-card style="margin-bottom:6px;">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="75px" style="margin-bottom:-20px;">
            <el-form-item label="设备名称" prop="deviceName">
                <el-input v-model="queryParams.deviceName" placeholder="请输入设备名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="产品名称" prop="productName">
                <el-input v-model="queryParams.productName" placeholder="请输入产品名称" clearable size="small" @keyup.enter.native="handleQuery" />
            </el-form-item>
            <el-form-item label="设备状态" prop="status">
                <el-select v-model="queryParams.status" placeholder="请选择设备状态" clearable size="small">
                    <el-option v-for="dict in dict.type.iot_device_status" :key="dict.value" :label="dict.label" :value="dict.value" />
                </el-select>
            </el-form-item>
            <el-form-item label="激活时间">
                <el-date-picker v-model="daterangeActiveTime" size="small" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
            </el-form-item>
            <el-form-item style="float:right;">
                <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleEditDevice(0)" v-hasPermi="['iot:device:add']">新增</el-button>
            </el-form-item>
        </el-form>
    </el-card>

    <el-card style="padding-bottom:100px;">
        <el-row :gutter="30" v-loading="loading">
            <el-col :span="6" v-for="(item,index) in deviceList" :key="index" style="margin-bottom:30px;text-align:center;">
                <el-card :body-style="{ padding: '20px'}" shadow="always">
                    <el-row type="flex" :gutter="10" justify="space-between">
                        <el-col :span="20" style="text-align:left;">
                            <el-link type="" :underline="false" @click="handleEditDevice(item)" style="font-weight:bold;font-size:16px;line-height:32px;">
                                <svg-icon icon-class="device" /> {{item.deviceName}}
                                <el-tag size="mini" type="info">Version {{item.firmwareVersion}}</el-tag>
                            </el-link>
                        </el-col>
                        <el-col :span="4">
                            <div style="font-size:28px;color:#ccc;">
                                <svg-icon v-if="item.status==3 && item.rssi >= '-55'" icon-class="wifi_4" />
                                <svg-icon v-else-if="item.status==3 && item.rssi >= '-70' && item.rssi < '-55' " icon-class="wifi_3" />
                                <svg-icon v-else-if="item.status==3 && item.rssi >= '-85' && item.rssi < '-70' " icon-class="wifi_2" />
                                <svg-icon v-else-if="item.status==3 && item.rssi >= '-100' && item.rssi < '-85' " icon-class="wifi_1" />
                                <svg-icon v-else icon-class="wifi_0" />
                            </div>
                        </el-col>
                    </el-row>
                    <el-row :gutter="10">
                        <el-col :span="15">
                            <div style="text-align:left;line-height:40px;font-size:14px;">
                                <dict-tag :options="dict.type.iot_device_status" :value="item.status" size="small" style="width:60px;display:inline-block;" />
                                <el-tag type="success" size="small" v-if="item.isShadow==1">启用影子</el-tag>
                                <el-tag type="info" size="small" v-else>禁用影子</el-tag>
                            </div>
                            <el-descriptions :column="1" size="mini">
                                <el-descriptions-item label="编号">
                                    {{item.serialNumber}}
                                </el-descriptions-item>
                                <el-descriptions-item label="产品">
                                    {{item.productName}}
                                </el-descriptions-item>
                                <el-descriptions-item label="激活时间">
                                    {{ parseTime(item.activeTime, '{y}-{m}-{d}') }}
                                </el-descriptions-item>
                            </el-descriptions>
                        </el-col>
                        <el-col :span="9">
                            <div style="margin-top:10px;">
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" lazy :preview-src-list="[baseUrl+item.imgUrl]" :src="baseUrl+item.imgUrl" fit="cover" v-if="item.imgUrl!=null && item.imgUrl!=''"></el-image>
                                <!-- 用于显示本地计算机、手机、树莓派等设备图片-->
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/esp8266.jpg')]" :src="require('@/assets/images/esp8266.jpg')" fit="cover" v-else-if="item.productName.indexOf('ESP8266')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/esp32.jpg')]" :src="require('@/assets/images/esp32.jpg')" fit="cover" v-else-if="item.productName.indexOf('ESP32')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/raspberry.jpg')]" :src="require('@/assets/images/raspberry.jpg')" fit="cover" v-else-if="item.productName.indexOf('Raspberry')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/telphone.jpg')]" :src="require('@/assets/images/telphone.jpg')" fit="cover" v-else-if="item.productName.indexOf('Phone')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/computer.jpg')]" :src="require('@/assets/images/computer.jpg')" fit="cover" v-else-if="item.productName.indexOf('Computer')!=-1"></el-image>
                                <el-image style="width:100%;height:100px;border:1px solid #ccc;border-radius:5px;" :preview-src-list="[require('@/assets/images/product.jpg')]" :src="require('@/assets/images/product.jpg')" fit="cover" v-else></el-image>
                            </div>
                        </el-col>
                    </el-row>
                    <el-descriptions :column="2" border size="mini" style="height:82px;margin-top:10px;overflow:hidden;">
                        <el-descriptions-item v-for="subItem in item.readOnlyList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <span style="white-space: nowrap;text-overflow: ellipsis;width:40px;overflow:hidden;height:40px;">{{subItem.name}}</span>
                            </template>
                            <el-link type="primary" :underline="false" style="white-space: nowrap;">{{subItem.shadow==""?"0":subItem.shadow}} {{subItem.unit==null?"":subItem.unit}}</el-link>
                        </el-descriptions-item>
                        <el-descriptions-item v-for="subItem in item.boolList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <div style="white-space: nowrap;text-overflow:ellipsis;width:40px;overflow:hidden;" :title="subItem.name">{{subItem.name}}</div>
                            </template>
                            <el-switch v-model="subItem.shadow" @change="publishThingsModel(item,subItem)" :active-value="'1'" :inactive-value="'0'" :disabled="shadowUnEnable(item)" />
                        </el-descriptions-item>
                        <el-descriptions-item v-for="subItem in item.enumList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <div style="white-space: nowrap;text-overflow:ellipsis;width:40px;overflow:hidden;" :title="subItem.name">{{subItem.name}}</div>
                            </template>
                            <el-select v-model="subItem.shadow" placeholder="请选择" @change="publishThingsModel(item,subItem)" clearable size="mini" :title="subItem.name" :disabled="shadowUnEnable(item)">
                                <el-option v-for="children in subItem.enumList" :key="children.value" :label="children.text" :value="children.value" />
                            </el-select>
                        </el-descriptions-item>
                        <el-descriptions-item v-for="subItem in item.decimalList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <div style="white-space: nowrap;text-overflow:ellipsis;width:40px;overflow:hidden;" :title="subItem.name">{{subItem.name}}</div>
                            </template>
                            <el-input v-model="subItem.shadow" :placeholder="'小数：'+subItem.name" size="mini" :title="'小数：'+subItem.name" :disabled="shadowUnEnable(item)">
                                <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(item,subItem)" style="font-size:16px;padding:10px;" title="指令发送"></el-button>
                            </el-input>
                        </el-descriptions-item>
                        <el-descriptions-item v-for="subItem in item.integerList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <div style="white-space: nowrap;text-overflow:ellipsis;width:40px;overflow:hidden;" :title="subItem.name">{{subItem.name}}</div>
                            </template>
                            <el-input v-model="subItem.shadow" :placeholder="'整数：'+subItem.name" :title="'整数：'+subItem.name" size="mini" :disabled="shadowUnEnable(item)">
                                <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(item,subItem)" style="font-size:16px;padding:10px;" title="指令发送"></el-button>
                            </el-input>
                        </el-descriptions-item>
                        <el-descriptions-item v-for="subItem in item.arrayList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <div style="white-space: nowrap;text-overflow:ellipsis;width:40px;overflow:hidden;" :title="subItem.name">{{subItem.name}}</div>
                            </template>
                            <el-input v-model="subItem.shadow" :placeholder="'数组：'+subItem.name" :title="'数组：'+subItem.name" size="mini" :disabled="shadowUnEnable(item)">
                                <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(item,subItem)" style="font-size:16px;padding:10px;" title="指令发送"></el-button>
                            </el-input>
                        </el-descriptions-item>
                        <el-descriptions-item v-for="subItem in item.stringList" :key="subItem.id" :contentStyle="{height:'40px'}">
                            <template slot="label">
                                <div style="white-space: nowrap;text-overflow:ellipsis;width:40px;overflow:hidden;" :title="subItem.name">{{subItem.name}}</div>
                            </template>
                            <el-input v-model="subItem.shadow" :placeholder="'字符串：'+subItem.name" :title="'字符串：'+subItem.name" size="mini" :disabled="shadowUnEnable(item)">
                                <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(item,subItem)" style="font-size:16px;padding:10px;" title="指令发送"></el-button>
                            </el-input>
                        </el-descriptions-item>
                    </el-descriptions>
                    <el-button-group style="margin-top:15px;">
                        <el-button type="primary" size="mini" icon="el-icon-edit" @click="handleEditDevice(item)" v-hasPermi="['iot:device:edit']">详情 </el-button>
                        <el-button type="danger" size="mini" icon="el-icon-delete" @click="handleDelete(item)" v-hasPermi="['iot:device:remove']">删除</el-button>
                        <el-button type="success" size="mini" icon="el-icon-odometer" @click="handleMonitor(item)" v-hasPermi="['iot:device:edit']" :disabled="item.status!=3">实时监测</el-button>
                    </el-button-group>
                </el-card>
            </el-col>
        </el-row>

        <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

        <!-- 查看监测数据 -->
        <el-dialog title="实时监测" :visible.sync="open" width="800px">
            <div style="margin-top:-50px;">
                <el-divider></el-divider>
            </div>
            <el-form :inline="true" label-width="100px">
                <el-form-item label="监测间隔(ms)">
                    <el-tooltip class="item" effect="light" content="取值范围500-10000毫秒" placement="top">
                        <el-input v-model="monitorInterval" placeholder="请输入监测间隔" type="number" clearable size="small" style="width:180px;" />
                    </el-tooltip>
                </el-form-item>
                <el-form-item label="监测次数">
                    <el-tooltip class="item" effect="light" content="取值方位1-300" placement="top">
                        <el-input v-model="monitorNumber" placeholder="请输入监测次数" type="number" clearable size="small" style="width:180px;" />
                    </el-tooltip>
                </el-form-item>
                <el-form-item>
                    <el-button type="success" icon="el-icon-refresh" size="mini" @click="updateMonitorParameters()" style="margin-left:30px;" :disabled="monitorDevice.status !=3">更 新</el-button>
                </el-form-item>
            </el-form>
            <el-row :gutter="20" v-loading="chartLoading" element-loading-text="正在接收设备数据，请耐心等待......" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.8)">
                <el-col :span="12" v-for="(item,index) in monitorThings" :key="index" style="margin-bottom:20px;">
                    <el-card shadow="hover" :body-style="{ paddingTop: '10px',marginBottom:'-20px' }">
                        <div ref="monitor" style="height:210px;padding:0"></div>
                    </el-card>
                </el-col>
            </el-row>

            <div slot="footer" class="dialog-footer">
                <el-button @click="cancel">关 闭</el-button>
            </div>
        </el-dialog>

        <!-- Mqtt通讯 -->
        <mqtt-client ref="mqttClient" :publish="publish" :subscribes="subscribes" @callbackEvent="mqttCallback($event)" />
    </el-card>
</div>
</template>

<script>
import * as echarts from 'echarts';
import {
    listDeviceShort,
    delDevice,
} from "@/api/iot/device";
import {
    cacheJsonThingsModel
} from "@/api/iot/model";

export default {
    name: "Device",
    dicts: ['iot_device_status', 'iot_is_enable'],
    data() {
        return {
            // 实时监测间隔
            monitorInterval: 1000,
            // 实时监测次数
            monitorNumber: 30,
            // 选中的实时监测设备
            monitorDevice: {},
            // 发布消息
            publish: {},
            // 订阅集合
            subscribes: [],
            // 图表集合
            chart: [],
            // 图表数据集合
            dataList: [],
            // 监测物模型
            monitorThings: [],
            // mqtt客户端
            client: {},
            // 遮罩层
            loading: true,
            // 图表遮罩层
            chartLoading: true,
            // 总条数
            total: 0,
            // 设备列表数据
            deviceList: [],
            // 弹出层标题
            title: "",
            // 是否显示弹出层
            open: false,
            // 激活时间范围
            daterangeActiveTime: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
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
        };
    },
    created() {
        this.getList();

    },
    activated() {
        const time = this.$route.query.t;
        if (time != null && time != this.uniqueId) {
            this.uniqueId = time;
            this.queryParams.pageNum = Number(this.$route.query.pageNum);
            // 产品筛选
            let productId = this.$route.query.productId
            if (productId != null) {
                this.queryParams.productId = Number(productId);
            }
            this.getList();
        }
    },
    methods: {
        /** 发布物模型 类型(1=属性，2=功能) */
        publishThingsModel(device, model) {
            // 获取缓存的Json物模型
            cacheJsonThingsModel(device.productId).then(response => {
                let thingsModel = JSON.parse(response.data);
                let type = 0;
                for (let i = 0; i < thingsModel.functions.length; i++) {
                    if (model.id == thingsModel.functions[i].id) {
                        type = 2;
                        break;
                    }
                }
                if (type == 0) {
                    for (let i = 0; i < thingsModel.properties.length; i++) {
                        if (model.id == thingsModel.properties[i].id) {
                            type = 1;
                            break;
                        }
                    }
                }
                if (type != 0) {
                    this.mqttPublish(type, device, model);
                }
            })
        },
        /** 
         * Mqtt发布消息
         * @type 类型(1=属性，2=功能，3=OTA升级，4=实时监测)
         * @device 设备
         * @model 物模型
         * */
        mqttPublish(type, device, model) {
            let topic = "";
            let message = ""
            if (type == 1) {
                if (device.status == 3) {
                    // 属性,在线模式
                    topic = "/" + device.productId + "/" + device.serialNumber + "/property-online/get";
                } else if (device.isShadow) {
                    // 属性,离线模式
                    topic = "/" + device.productId + "/" + device.serialNumber + "/property-offline/post";
                }
                message = '[{"id":"' + model.id + '","value":"' + model.shadow + '"}]';
            } else if (type == 2) {
                if (device.status == 3) {
                    // 功能,在线模式
                    topic = "/" + device.productId + "/" + device.serialNumber + "/function-online/get";

                } else if (device.isShadow) {
                    // 功能,离线模式
                    topic = "/" + device.productId + "/" + device.serialNumber + "/function-offline/post";
                }
                message = '[{"id":"' + model.id + '","value":"' + model.shadow + '"}]';
            } else if (type == 3) {
                // OTA升级
                topic = "/" + device.productId + "/" + device.serialNumber + "/ota/get";
                message = '{"version":1.1}';
            } else if (type == 4) {
                // 实时监测
                topic = "/" + device.productId + "/" + device.serialNumber + "/monitor/get";
                message = '{"count":' + model.value + ',"interval":' + this.monitorInterval + '}'
            } else {
                return;
            }
            if (topic != "") {
                // 发布
                this.publish = {
                    topic: topic,
                    message: message
                };
                if (model.name != "") {
                    this.$modal.notifySuccess("[ " + model.name + " ] 指令发送成功");
                }
            }
        },
        /** 接收到Mqtt回调 */
        mqttCallback(data) {
            let topics = [];
            topics = data.topic.split("/");
            let productId = topics[1];
            let deviceNum = topics[2]
            if (topics[3] == "status") {
                // 更新列表中设备的状态
                for (let i = 0; i < this.deviceList.length; i++) {
                    if (this.deviceList[i].serialNumber == deviceNum) {
                        this.deviceList[i].status = data.message.status;
                        this.deviceList[i].isShadow = data.message.isShadow;
                    }
                }
                // 更新实时监测模型的状态
                if (this.monitorDevice.serialNumber == deviceNum) {
                    this.monitorDevice.status = data.message.status;
                    this.monitorDevice.isShadow = data.message.isShadow;
                }
            } else if (topics[3] == "monitor") {
                // 实时监测
                this.chartLoading = false;
                for (let k = 0; k < data.message.length; k++) {
                    let value = data.message[k].value;
                    let id = data.message[k].id;
                    let remark = data.message[k].remark;
                    // 数据加载到图表
                    for (let i = 0; i < this.dataList.length; i++) {
                        if (id == this.dataList[i].id) {
                            if (this.dataList[i].length > 50) {
                                this.dataList[i].shift();
                            }
                            this.dataList[i].data.push([this.getTime(), value]);
                            // 更新图表
                            this.chart[i].setOption({
                                series: [{
                                    data: this.dataList[i].data
                                }]
                            });
                        }
                    }
                }
            }
        },
        /** Mqtt订阅主题 */
        mqttSubscribe(list) {
            // 订阅当前页面设备状态和实时监测
            let topics = [];
            for (let i = 0; i < list.length; i++) {
                let topicStatus = "/" + list[i].productId + "/" + list[i].serialNumber + "/status/post";
                let topicMonitor = "/" + list[i].productId + "/" + list[i].serialNumber + "/monitor/post";
                topics.push(topicStatus);
                topics.push(topicMonitor);
            }
            this.subscribes = topics;
        },
        /** 更新实时监测参数*/
        updateMonitorParameters() {
            // 清空图表数据
            for (let i = 0; i < this.dataList.length; i++) {
                this.dataList[i].data = [];
            }
            if (this.monitorInterval < 500 || this.monitorInterval > 10000) {
                this.$modal.alertError("实时监测的间隔范围500-10000毫秒");
            }
            if (this.monitorNumber == 0 || this.monitorNumber > 300) {
                this.$modal.alertError("实时监测数量范围1-300");
            }
            // Mqtt发布实时监测消息
            let model = {};
            model.name = "更新实时监测";
            model.value = this.monitorNumber;
            this.mqttPublish(4, this.monitorDevice, model);
            this.chartLoading = true;
        },
        /** 查看监测数据 */
        handleMonitor(item) {
            this.open = true;
            this.monitorLoading = true;
            this.monitorDevice = item;
            // 获取物模型
            this.getCacheThingsModdel(item.productId);
            // Mqtt发布实时监测
            let model = {};
            model.name = "";
            model.value = this.monitorNumber;
            this.mqttPublish(4, item, model);
        },
        /** 停止实时监测 */
        stopMonitor() {
            // 清空图表数据
            this.dataList = [];
            this.chartLoading = true;
            // Mqtt发布实时监测
            let model = {};
            model.name = "";
            model.value = 0;
            this.mqttPublish(4, this.monitorDevice, model);
        },
        /** 查询设备列表 */
        getList() {
            this.loading = true;
            if (null != this.daterangeActiveTime && '' != this.daterangeActiveTime) {
                this.queryParams.params["beginActiveTime"] = this.daterangeActiveTime[0];
                this.queryParams.params["endActiveTime"] = this.daterangeActiveTime[1];
            }
            listDeviceShort(this.queryParams).then(response => {
                this.deviceList = response.rows;
                this.total = response.total;
                // 订阅设备状态
                this.mqttSubscribe(this.deviceList);
                this.loading = false;
            });
        },
        // 取消按钮
        cancel() {
            this.open = false;
            this.stopMonitor();
        },
        /** 搜索按钮操作 */
        handleQuery() {
            this.queryParams.pageNum = 1;
            this.getList();
        },
        /** 重置按钮操作 */
        resetQuery() {
            this.daterangeActiveTime = [];
            this.queryParams.productId = null;
            this.resetForm("queryForm");
            this.handleQuery();
        },
        /** 修改按钮操作 */
        handleEditDevice(row) {
            let deviceId = 0;
            if (row != 0) {
                deviceId = row.deviceId || this.ids
            }
            this.$router.push({
                path: '/iot/device-edit',
                query: {
                    deviceId: deviceId,
                    pageNum: this.queryParams.pageNum
                }
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const deviceIds = row.deviceId || this.ids;
            this.$modal.confirm('是否确认删除设备编号为"' + deviceIds + '"的数据项？').then(function () {
                return delDevice(deviceIds);
            }).then(() => {
                this.getList();
                this.$modal.msgSuccess("删除成功");
            }).catch(() => {});
        },
        /** 未启用设备影子*/
        shadowUnEnable(item) {
            // 1-未激活，2-禁用，3-在线，4-离线
            if (item.status != 3 && item.isShadow == 0) {
                return true;
            }
            return false;
        },
        /** 获取物模型*/
        getCacheThingsModdel(productId) {
            // 获取缓存的Json物模型
            cacheJsonThingsModel(productId).then(response => {
                let thingsModel = JSON.parse(response.data);
                // 筛选监测数据
                this.monitorThings = thingsModel.properties.filter(item => item.isMonitor == 1);
                // 监测数据集合初始化
                for (let i = 0; i < this.monitorThings.length; i++) {
                    this.dataList.push({
                        id: this.monitorThings[i].id,
                        name: this.monitorThings[i].name,
                        data: []
                    });
                    // this.dataList[i].data.push(["2022-03-14 23:32:09", "30"]);
                }
                // 绘制监测图表
                this.$nextTick(function () {
                    this.getMonitorChart();
                });
            });
        },
        /**监测数据 */
        getMonitorChart() {
            for (let i = 0; i < this.monitorThings.length; i++) {
                this.chart[i] = echarts.init(this.$refs.monitor[i]);
                var option;
                option = {
                    title: {
                        left: 'center',
                        text: this.monitorThings[i].name + ' 单位 ' + (this.monitorThings[i].datatype.unit != undefined ? this.monitorThings[i].datatype.unit : "无") + "）",
                        textStyle: {
                            fontSize: 14,
                        }
                    },
                    grid: {
                        top: '40px',
                        left: '20px',
                        right: '20px',
                        bottom: '10px',
                        containLabel: true
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            animation: true
                        }
                    },
                    xAxis: {
                        type: 'time',
                        show: false,
                        splitLine: {
                            show: false
                        }
                    },
                    yAxis: {
                        type: 'value',
                        boundaryGap: [0, '100%'],
                        splitLine: {
                            show: true
                        }
                    },
                    series: [{
                        name: this.monitorThings[i].name,
                        type: 'line',
                        showSymbol: false,
                        data: this.dataList[i].data
                    }]
                };
                option && this.chart[i].setOption(option);
            }
        },
        getTime() {
            let date = new Date();
            let y = date.getFullYear();
            let m = date.getMonth() + 1;
            let d = date.getDate();
            let H = date.getHours();
            let mm = date.getMinutes();
            let s = date.getSeconds()
            m = m < 10 ? "0" + m : m;
            d = d < 10 ? "0" + d : d;
            H = H < 10 ? "0" + H : H;
            return y + "-" + m + "-" + d + " " + H + ":" + mm + ":" + s;
        },
    }
};
</script>
