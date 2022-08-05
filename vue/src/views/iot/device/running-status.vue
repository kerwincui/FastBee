<template>
<div style="padding-left:20px;">
    <el-row :gutter="80">
        <el-col :xs="24" :sm="24" :md="24" :lg="10" :xl="10">
            <el-descriptions :column="1" border :title="title">
                <!-- 设备升级-->
                <el-descriptions-item :labelStyle="statusColor">
                    <template slot="label">
                        <svg-icon icon-class="ota" />
                        OTA升级
                    </template>
                    <el-link :underline="false" style="line-height:28px;font-size:16px;padding-right:10px;">Version {{deviceInfo.firmwareVersion}}</el-link>
                    <el-button type="success" size="mini" style="float:right;" @click="getLatestFirmware(deviceInfo.deviceId)" :disabled="deviceInfo.status!=3">检查更新</el-button>
                </el-descriptions-item>
                <!-- bool类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.boolList" :key="index" :labelStyle="statusColor">
                    <template slot="label">
                        <i class="el-icon-open"></i>
                        {{item.name}}
                    </template>
                    <el-switch v-model="item.shadow" @change="publishThingsModel(deviceInfo,item)" active-text="" inactive-text="" active-value="1" inactive-value="0" style="min-width:100px;" :disabled="shadowUnEnable" />
                </el-descriptions-item>

                <!-- enum类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.enumList" :key="index" :labelStyle="statusColor">
                    <template slot="label">
                        <i class="el-icon-s-unfold"></i>
                        {{item.name}}
                    </template>
                    <el-select v-model="item.shadow" placeholder="请选择" @change="publishThingsModel(deviceInfo,item)" clearable :disabled="shadowUnEnable">
                        <el-option v-for="subItem in item.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                    </el-select>
                </el-descriptions-item>

                <!-- string类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.stringList" :key="index" :labelStyle="statusColor">
                    <template slot="label">
                        <i class="el-icon-tickets"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.shadow" placeholder="请输入字符串" :disabled="shadowUnEnable">
                        <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(deviceInfo,item)" style="font-size:20px;" title="指令发送"></el-button>
                    </el-input>
                </el-descriptions-item>

                <!-- array类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.arrayList" :key="index" :labelStyle="statusColor">
                    <template slot="label">
                        <i class="el-icon-tickets"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.shadow" placeholder="请输入英文逗号分隔的字符串" :disabled="shadowUnEnable">
                        <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(deviceInfo,item)" style="font-size:20px;" title="指令发送"></el-button>
                    </el-input>
                </el-descriptions-item>

                <!-- decimal类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.decimalList" :key="index" :labelStyle="statusColor">
                    <template slot="label">
                        <i class="el-icon-star-off"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.shadow" type="number" placeholder="请输入小数 " :disabled="shadowUnEnable">
                        <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(deviceInfo,item)" style="font-size:20px;" title="指令发送"></el-button>
                    </el-input>
                </el-descriptions-item>

                <!-- integer类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.integerList" :key="index" :labelStyle="statusColor">
                    <template slot="label">
                        <i class="el-icon-paperclip"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.shadow" type="integer" placeholder="请输入整数 " :disabled="shadowUnEnable">
                        <el-button slot="append" icon="el-icon-s-promotion" @click="publishThingsModel(deviceInfo,item)" style="font-size:20px;" title="指令发送"></el-button>
                    </el-input>
                </el-descriptions-item>
            </el-descriptions>

            <!-- 监测数据-->
            <el-descriptions :column="2" border style="margin:40px 0;" title="监测数据">
                <el-descriptions-item v-for="(item,index) in deviceInfo.readOnlyList" :key="index">
                    <template slot="label">
                        <i class="el-icon-odometer"></i>
                        {{item.name}}
                    </template>
                    <el-link type="primary" :underline="false">{{item.shadow}} {{item.unit==null?"":item.unit}}</el-link>
                </el-descriptions-item>
            </el-descriptions>

            <!---设备状态(影子模式，value值不会更新)-->
            <el-descriptions :column="1" border size="mini" v-if="deviceInfo.isShadow==1 && deviceInfo.status!=3">
                <template slot="title">
                    <span style="font-size:14px;color:#606266;">设备离线时状态</span>
                </template>
                <!-- bool类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.boolList" :key="index">
                    <template slot="label">
                        <i class="el-icon-open"></i>
                        {{item.name}}
                    </template>
                    <el-switch v-model="item.value" size="mini" active-text="" inactive-text="" active-value="1" inactive-value="0" style="min-width:100px;" disabled />
                </el-descriptions-item>

                <!-- enum类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.enumList" :key="index">
                    <template slot="label">
                        <i class="el-icon-s-unfold"></i>
                        {{item.name}}
                    </template>
                    <el-select v-model="item.value" placeholder="请选择" clearable size="mini" disabled>
                        <el-option v-for="subItem in item.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                    </el-select>
                </el-descriptions-item>

                <!-- string类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.stringList" :key="index">
                    <template slot="label">
                        <i class="el-icon-tickets"></i>
                        {{item.name}}
                    </template>
                    {{item.value}} {{item.unit?item.unit:""}}
                </el-descriptions-item>

                <!-- array类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.arrayList" :key="index">
                    <template slot="label">
                        <i class="el-icon-tickets"></i>
                        {{item.name}}
                    </template>
                    {{item.value}} {{item.unit?item.unit:""}}
                </el-descriptions-item>

                <!-- decimal类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.decimalList" :key="index">
                    <template slot="label">
                        <i class="el-icon-star-off"></i>
                        {{item.name}}
                    </template>
                    {{item.value}} {{item.unit?item.unit:""}}
                </el-descriptions-item>

                <!-- integer类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.integerList" :key="index">
                    <template slot="label">
                        <i class="el-icon-paperclip"></i>
                        {{item.name}}
                    </template>
                    {{item.value}} {{item.unit?item.unit:""}}
                </el-descriptions-item>
            </el-descriptions>
        </el-col>

        <el-col :xs="24" :sm="24" :md="24" :lg="14" :xl="14" v-if="deviceInfo.readOnlyList.length > 0">
            <el-row :gutter="20" style="background-color:#F5F7FA;padding:20px 20px 10px 10px;border-radius:15px;margin-right:5px;">
                <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="8" v-for="(item,index) in deviceInfo.readOnlyList" :key="index">
                    <el-card shadow="hover" style="border-radius:30px;margin-bottom:20px;">
                        <div ref="map" style="height:230px;width:180px;margin:0 auto;"></div>
                    </el-card>
                </el-col>
            </el-row>
        </el-col>
    </el-row>

    <!-- 添加或修改产品固件对话框 -->
    <el-dialog title="设备固件升级" :visible.sync="openFirmware" width="600px" append-to-body>
        <div v-if="firmware==null || deviceInfo.firmwareVersion>=firmware.version" style="text-align:center;font-size:16px;"><i class="el-icon-success" style="color:#67C23A;"></i> 已经是最新版本，不需要升级</div>
        <el-descriptions :column="1" border size="large" v-if="firmware!=null && deviceInfo.firmwareVersion<firmware.version" :labelStyle='{"width":"100px","font-weight":"bold"}'>
            <template slot="title">
                <el-link icon="el-icon-success" type="success" :underline="false"> 可以升级到以下版本</el-link>
            </template>
            <el-descriptions-item label="固件名称">{{firmware.firmwareName}}</el-descriptions-item>
            <el-descriptions-item label="所属产品">{{firmware.productName}}</el-descriptions-item>
            <el-descriptions-item label="固件版本">Version {{firmware.version}}</el-descriptions-item>
            <el-descriptions-item label="下载地址">
                <el-link :href="getDownloadUrl(firmware.filePath)" :underline="false" type="primary">{{getDownloadUrl(firmware.filePath)}}</el-link>
            </el-descriptions-item>
            <el-descriptions-item label="固件描述">{{firmware.remark}}</el-descriptions-item>
        </el-descriptions>
        <div slot="footer" class="dialog-footer">
            <el-button type="success" @click="otaUpgrade" v-if="firmware!=null && deviceInfo.firmwareVersion<firmware.version">升 级</el-button>
            <el-button @click="cancel">取 消</el-button>
        </div>
    </el-dialog>
</div>
</template>

<script>
import {
    getDeviceRunningStatus
} from "@/api/iot/device"
import {
    getLatestFirmware,
} from "@/api/iot/firmware";
import {
    cacheJsonThingsModel
} from "@/api/iot/model";
import * as echarts from 'echarts';

export default {
    name: "running-status",
    components: {},
    props: {
        device: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device后，刷新列表
        device: function (newVal, oldVal) {
            if (newVal && newVal.deviceId != 0) {
                getDeviceRunningStatus(newVal.deviceId).then(response => {
                    this.deviceInfo = response.data;
                    this.updateDeviceStatus(this.deviceInfo);
                    this.$nextTick(function () {
                        this.MonitorChart();
                    });
                });
                this.connectMqtt();
            }
        }
    },
    data() {
        return {
            // 控制模块标题
            title: "设备控制 ",
            // 未启用设备影子
            shadowUnEnable: false,
            // 控制项标题背景
            statusColor: {
                background: '#67C23A',
                color: '#fff',
            },
            // 最新固件信息
            firmware: {},
            // 打开固件对话框
            openFirmware: false,
            // 遮罩层
            loading: true,
            // 设备信息
            deviceInfo: {
                boolList: [],
                enumList: [],
                stringList: [],
                integerList: [],
                decimalList: [],
                arrayList: [],
                readOnlyList: []
            },
            // 监测图表
            monitorChart: [{
                chart: {},
                data: {
                    id: '',
                    name: '',
                    value: ''
                },
            }],
        }
    },
    created() {

    },
    methods: {
        /* 连接Mqtt消息服务器 */
		async connectMqtt() {
			if (this.$mqttTool.client == null) {
				await this.$mqttTool.connect(this.vuex_token);
			}
			this.mqttCallback();
		},
        /* Mqtt回调处理 */
        mqttCallback() {
            this.$mqttTool.client.on('message', (topic, message, buffer) => {
                let topics = topic.split('/');
                let productId = topics[1];
                let deviceNum = topics[2];
                message = JSON.parse(message.toString());
                if (topics[3] == 'status') {
                    console.log('接收到【设备状态-运行】主题：', topic);
                    console.log('接收到【设备状态-运行】内容：', message);
                    // 更新列表中设备的状态
                    if (this.deviceInfo.serialNumber == deviceNum) {
                        this.deviceInfo.status = message.status;
                        this.deviceInfo.isShadow = message.isShadow;
                        this.deviceInfo.rssi = message.rssi;
                        this.updateDeviceStatus(this.deviceInfo);
                    }
                }
                if (topics[3] == 'property' || topics[3] == 'function') {
                    console.log('接收到【物模型】主题：', topic);
                    console.log('接收到【物模型】内容：', message);
                    // 更新列表中设备的属性
                    if (this.deviceInfo.serialNumber == deviceNum) {
                        for (let j = 0; j < message.length; j++) {
                            let isComplete = false;
                            // 布尔类型
                            for (let k = 0; k < this.deviceInfo.boolList.length && !isComplete; k++) {
                                if (this.deviceInfo.boolList[k].id == message[j].id) {
                                    this.deviceInfo.boolList[k].shadow = message[j].value;
                                    isComplete = true;
                                    break;
                                }
                            }
                            // 枚举类型
                            for (let k = 0; k < this.deviceInfo.enumList.length && !isComplete; k++) {
                                if (this.deviceInfo.enumList[k].id == message[j].id) {
                                    this.deviceInfo.enumList[k].shadow = message[j].value;
                                    isComplete = true;
                                    break;
                                }
                            }
                            // 字符串类型
                            for (let k = 0; k < this.deviceInfo.stringList.length && !isComplete; k++) {
                                if (this.deviceInfo.stringList[k].id == message[j].id) {
                                    this.deviceInfo.stringList[k].shadow = message[j].value;
                                    isComplete = true;
                                    break;
                                }
                            }
                            // 数组类型
                            for (let k = 0; k < this.deviceInfo.arrayList.length && !isComplete; k++) {
                                if (this.deviceInfo.arrayList[k].id == message[j].id) {
                                    this.deviceInfo.arrayList[k].shadow = message[j].value;
                                    isComplete = true;
                                    break;
                                }
                            }
                            // 整数类型
                            for (let k = 0; k < this.deviceInfo.integerList.length && !isComplete; k++) {
                                if (this.deviceInfo.integerList[k].id == message[j].id) {
                                    this.deviceInfo.integerList[k].shadow = message[j].value;
                                    isComplete = true;
                                    break;
                                }
                            }
                            // 小数类型
                            for (let k = 0; k < this.deviceInfo.decimalList.length && !isComplete; k++) {
                                if (this.deviceInfo.decimalList[k].id == message[j].id) {
                                    this.deviceInfo.decimalList[k].shadow = message[j].value;
                                    isComplete = true;
                                    break;
                                }
                            }
                            // 监测数据
                            for (let k = 0; k < this.deviceInfo.readOnlyList.length && !isComplete; k++) {
                                if (this.deviceInfo.readOnlyList[k].id == message[j].id) {
                                    this.deviceInfo.readOnlyList[k].shadow = message[j].value;
                                    // 更新图表
                                    for (let m = 0; m < this.monitorChart.length; m++) {
                                        if (message[j].id == this.monitorChart[m].data.id) {
                                            let data = [{
                                                value: message[j].value,
                                                name: this.monitorChart[m].data.name
                                            }];
                                            this.monitorChart[m].chart.setOption({
                                                series: [{
                                                    data: data
                                                }]
                                            });
                                            break;
                                        }
                                    }
                                    isComplete = true;
                                    break;
                                }
                            }
                        }
                    }
                }
            });
        },
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
            });
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
                message = '{"version":' + this.firmware.version + ',"downloadUrl":"' + this.getDownloadUrl(this.firmware.filePath) + '"}';
            } else {
                return;
            }
            if (topic != "") {
                // 发布
                this.$mqttTool.publish(topic, message, model.name).then(res => {
                    this.$modal.notifySuccess(res);
                }).catch(res => {
                    this.$modal.notifyError(res);
                });
            }
        },

        /** 更新设备状态 */
        updateDeviceStatus(device) {
            if (device.status == 3) {
                this.statusColor.background = '#12d09f';
                this.title = "在线模式";
            } else {
                if (device.isShadow == 1) {
                    this.statusColor.background = '#409EFF';
                    this.title = "影子模式";
                } else {
                    this.statusColor.background = '#909399';
                    this.title = "离线模式";
                    this.shadowUnEnable = true;
                }
            }
            this.$emit('statusEvent', this.deviceInfo.status);
        },
        /** 设备升级 */
        otaUpgrade() {
            let model = {};
            model.name = "设备升级"
            this.mqttPublish(3, this.deviceInfo, model);
            this.openFirmware = false;
        },
        /** 获取最新固件 */
        getLatestFirmware(deviceId) {
            getLatestFirmware(deviceId).then(response => {
                this.firmware = response.data;
                this.openFirmware = true;
            });
        },
        // 取消按钮
        cancel() {
            this.openFirmware = false;
        },
        // 获取下载路径前缀
        getDownloadUrl(path) {
            return window.location.origin + process.env.VUE_APP_BASE_API + path;
        },
        /**监测图表统计*/
        MonitorChart() {
            for (let i = 0; i < this.deviceInfo.readOnlyList.length; i++) {
                this.monitorChart[i] = {
                    chart: echarts.init(this.$refs.map[i]),
                    data: {
                        id: this.deviceInfo.readOnlyList[i].id,
                        name: this.deviceInfo.readOnlyList[i].name,
                        value: this.deviceInfo.readOnlyList[i].shadow
                    }
                };
                var option;
                option = {
                    tooltip: {
                        formatter: ' {b} <br/> {c}' + this.deviceInfo.readOnlyList[i].unit
                    },
                    series: [{
                        name: this.deviceInfo.readOnlyList[i].type,
                        type: 'gauge',
                        min: this.deviceInfo.readOnlyList[i].min,
                        max: this.deviceInfo.readOnlyList[i].max,
                        colorBy: 'data',
                        splitNumber: 10,
                        radius: '100%',
                        // 分割线
                        splitLine: {
                            distance: 4,
                        },
                        axisLabel: {
                            fontSize: 10,
                            distance: 10
                        },
                        // 刻度线
                        axisTick: {
                            distance: 4,
                        },
                        // 仪表盘轴线
                        axisLine: {
                            lineStyle: {
                                width: 8,
                                color: [
                                    [0.2, '#409EFF'], // 0~20% 
                                    [0.8, '#12d09f'], // 40~60%
                                    [1, '#F56C6C'], // 80~100%
                                ],
                                opacity: 0.3
                            }

                        },
                        pointer: {
                            icon: 'triangle',
                            length: '60%',
                            width: 7
                        },
                        progress: {
                            show: true,
                            width: 8,
                        },
                        detail: {
                            valueAnimation: true,
                            formatter: '{value}' + ' ' + this.deviceInfo.readOnlyList[i].unit,
                            offsetCenter: [0, "80%"],
                            fontSize: 20,
                        },
                        data: [{
                            value: this.deviceInfo.readOnlyList[i].shadow,
                            name: this.deviceInfo.readOnlyList[i].name
                        }],
                        title: {
                            offsetCenter: [0, "115%"],
                            fontSize: 16
                        }
                    }]
                };
                option && this.monitorChart[i].chart.setOption(option);
            }
        }
    },
}
</script>
