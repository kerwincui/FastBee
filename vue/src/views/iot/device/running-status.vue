<template>
<div style="padding-left:20px;">
    <el-row :gutter="80">
        <el-col :span="9">
            <el-descriptions :column="1" border :title="title">
                <!-- 设备升级-->
                <el-descriptions-item :labelStyle="statusColor">
                    <template slot="label">
                        <svg-icon icon-class="ota" />
                        OTA升级
                    </template>
                    <el-link :underline="false" style="line-height:28px;font-size:16px;padding-right:10px;">Version {{deviceInfo.firmwareVersion}}</el-link>
                    <el-link type="success" :underline="false" style="font-size:12px;display:none;">已经是最新版本</el-link>
                    <el-button type="success" size="mini" style="float:right;" @click="otaUpgrade()" :disabled="deviceInfo.status!=3">升级</el-button>
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
                    <span style="font-size:14px;color:#606266;">设备处于离线状态</span>
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
                    <el-select v-model="item.value" placeholder="请选择" clearable size="mini" disabled >
                        <el-option v-for="subItem in item.enumList" :key="subItem.value" :label="subItem.text" :value="subItem.value" />
                    </el-select>
                </el-descriptions-item>

                <!-- string类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.stringList" :key="index">
                    <template slot="label">
                        <i class="el-icon-tickets"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.value" placeholder="请输入字符串" size="mini" disabled></el-input>
                </el-descriptions-item>

                <!-- array类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.arrayList" :key="index">
                    <template slot="label">
                        <i class="el-icon-tickets"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.value" placeholder="请输入英文逗号分隔的字符串" size="mini" disabled></el-input>
                </el-descriptions-item>

                <!-- decimal类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.decimalList" :key="index">
                    <template slot="label">
                        <i class="el-icon-star-off"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.value" type="number" placeholder="请输入小数" size="mini" disabled></el-input>
                </el-descriptions-item>

                <!-- integer类型-->
                <el-descriptions-item v-for="(item,index) in deviceInfo.integerList" :key="index">
                    <template slot="label">
                        <i class="el-icon-paperclip"></i>
                        {{item.name}}
                    </template>
                    <el-input v-model="item.value" type="integer" placeholder="请输入整数 " size="mini" disabled></el-input>
                </el-descriptions-item>
            </el-descriptions>

            <!-- Mqtt通讯 -->
            <mqtt-client ref="mqttClient" :publish="publish" :subscribes="subscribes" @callbackEvent="mqttCallback($event)" />
        </el-col>

        <el-col :span="14" :offset="1">
            <el-row :gutter="20" style="background-color:#F5F7FA;padding:20px;padding-left:10px;">
                <el-col :span="8" v-for="(item,index) in deviceInfo.readOnlyList" :key="index" style="margin-bottom:20px;">
                    <el-card shadow="hover" style="border-radius:30px;">
                        <div ref="map" style="height:230px;width:180px;margin:0 auto;margin-top:-10px;"></div>
                    </el-card>
                </el-col>
            </el-row>
        </el-col>
    </el-row>
</div>
</template>

<script>
import {
    getDeviceRunningStatus
} from "@/api/iot/device"
import {
    cacheJsonThingsModel
} from "@/api/iot/model";
import * as echarts from 'echarts';

export default {
    name: "running-status",
    dicts: ['iot_yes_no'],
    props: {
        device: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device后，刷新列表
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
            if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
                getDeviceRunningStatus(this.deviceInfo.deviceId).then(response => {
                    this.deviceInfo = response.data;
                    this.updateDeviceStatus(this.deviceInfo);
                    this.$nextTick(function () {
                        this.MonitorChart();
                    });
                    // Mqtt订阅主题
                    this.mqttSubscribe(this.deviceInfo);
                });
            }
        }
    },
    data() {
        return {
            // 发布消息
            publish: {},
            // 订阅集合
            subscribes: [],
            // 控制模块标题
            title: "设备控制 ",
            // 未启用设备影子
            shadowUnEnable: false,
            // 控制项标题背景
            statusColor: {
                background: '#67C23A',
                color: '#fff',
            },
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
                readonlyList: []
            },
        }
    },
    created() {

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
                message = '{"version":' + device.firmwareVersion + '}';
            } else {
                return;
            }
            if (topic != "") {
                // 发布
                this.publish = {
                    topic: topic,
                    message: message
                }
                if (model) {
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
                this.deviceInfo.status = data.message.status;
                this.deviceInfo.isShadow = data.message.isShadow;
                this.updateDeviceStatus(this.deviceInfo);
            }
        },
        /** Mqtt订阅主题 */
        mqttSubscribe(device) {
            // 订阅当前设备状态
            let topic = "/" + device.productId + "/" + device.serialNumber + "/status/post";
            this.subscribes = [topic];
        },
        /** 更新设备状态 */
        updateDeviceStatus(device) {
            if (device.status == 3) {
                this.statusColor.background = '#67C23A';
                this.title = "设备控制（在线）";
            } else {
                if (device.isShadow == 1) {
                    this.statusColor.background = '#409EFF';
                    this.title = "设备控制（影子模式）";
                } else {
                    this.statusColor.background = '#909399';
                    this.title = "设备控制（设备不在线 未启用影子）";
                    this.shadowUnEnable = true;
                }
            }
        },
        /** 设备升级 */
        otaUpgrade() {
            let model = {};
            model.name = "设备升级"
            this.mqttPublish(3, this.deviceInfo, model);
        },
        /**监测图表*/
        MonitorChart() {
            for (let i = 0; i < this.deviceInfo.readOnlyList.length; i++) {
                var myChart = echarts.init(this.$refs.map[i]);
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
                                    [0.3, '#409EFF'], // 0~30% 
                                    [0.7, '#67C23A'], // 30~70%
                                    [1, '#F56C6C'], // 70~100%
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
                option && myChart.setOption(option);
            }
        }
    },
}
</script>
