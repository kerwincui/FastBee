<template>
<el-card style="margin:6px;padding-bottom:100px;">
    <el-tabs v-model="activeName" tab-position="left" style="padding:10px;">
        <el-tab-pane name="basic">
            <span slot="label"> * 基本信息</span>
            <el-form ref="form" :model="form" :rules="rules" label-width="100px">
                <el-row :gutter="100">
                    <el-col :span="7">
                        <el-form-item label="设备名称" prop="deviceName">
                            <el-input v-model="form.deviceName" placeholder="请输入设备名称" />
                        </el-form-item>
                        <el-form-item label="" prop="serialNumber">
                            <template slot="label">
                                <span style="color:red;">* </span>设备编号
                            </template>
                            <el-input v-model="form.serialNumber" placeholder="请输入设备编号" :disabled="form.status!=1">
                                <el-button slot="append" @click="generateNum" :loading="genDisabled" :disabled="form.status!=1">生成</el-button>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="" prop="productName">
                            <template slot="label">
                                <span style="color:red;">* </span>所属产品
                            </template>
                            <el-input readonly v-model="form.productName" placeholder="请选择产品" :disabled="form.status!=1">
                                <el-button slot="append" @click="selectProduct()" :disabled="form.status!=1">选择</el-button>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="固件版本" prop="firmwareVersion">
                            <el-input v-model="form.firmwareVersion" placeholder="请输入固件版本" type="number" :disabled="form.status!=1">
                                <template slot="prepend">Version</template>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="禁用设备" prop="deviceStatus">
                            <el-switch v-model="deviceStatus" active-text="" inactive-text="" :disabled="form.status==1" :active-value="1" :inactive-value="0" active-color="#F56C6C">
                            </el-switch>
                        </el-form-item>
                        <el-form-item label="设备影子" prop="isShadow">
                            <el-switch v-model="form.isShadow" active-text="" inactive-text="" :active-value="1" :inactive-value="0">
                            </el-switch>
                        </el-form-item>
                        <el-form-item label="备注信息" prop="remark">
                            <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" rows="4" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="7">
                        <!--
                        <el-form-item label="设备图片" prop="imageUrl">
                            <el-image style="height:225px;border:1px solid #dee4ed;border-radius:5px;padding:5px;" :src="imageUrl" :preview-src-list="[imageUrl]" fit="cover"></el-image>
                        </el-form-item>
                        -->
                        <el-form-item label="自定义位置" prop="isCustomLocation">
                            <el-switch v-model="form.isCustomLocation" active-text="" inactive-text="" :active-value="1" :inactive-value="0">
                            </el-switch>
                        </el-form-item>
                        <el-form-item label="设备经度" prop="longitude">
                            <el-input v-model="form.longitude" placeholder="请输入设备经度" type="number" :disabled="form.isCustomLocation==0">
                                <el-link slot="append" :underline="false" href="https://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">坐标拾取</el-link>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="设备纬度" prop="latitude">
                            <el-input v-model="form.latitude" placeholder="请输入设备纬度" type="number" :disabled="form.isCustomLocation==0">
                                <el-link slot="append" :underline="false" href="https://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">坐标拾取</el-link>
                            </el-input>
                        </el-form-item>
                        <el-form-item label="所在地址" prop="networkAddress">
                            <el-input v-model="form.networkAddress" placeholder="请输入设备所在地址" :disabled="form.isCustomLocation==0" />
                        </el-form-item>
                        <el-form-item label="入网地址" prop="networkIp">
                            <el-input v-model="form.networkIp" placeholder="设备入网IP" disabled />
                        </el-form-item>
                        <el-form-item label="激活时间" prop="activeTime">
                            <el-date-picker clearable v-model="form.activeTime" type="date" value-format="yyyy-MM-dd" placeholder="设备激活时间" disabled style="width:100%">
                            </el-date-picker>
                        </el-form-item>
                        <el-form-item label="设备信号" prop="rssi">
                            <el-input v-model="form.rssi" placeholder="设备信号强度" disabled />
                        </el-form-item>
                        <el-form-item label="设备状态" prop="status">
                            <dict-tag :options="dict.type.iot_device_status" :value="form.status" style="width:60px;display:inline-block;" />
                        </el-form-item>
                    </el-col>

                    <el-col :span="10">
                        <div style="border:1px solid #dfe4ed;border-radius:5px;padding:5px;text-align:center;line-height:400px;">
                            <div id="map" style="height:435px;width:100%;">地图展示区域，新增后显示</div>
                        </div>
                    </el-col>
                </el-row>
            </el-form>

            <el-form label-width="100px" style="margin-top:50px;">
                <el-form-item style="text-align: center;margin-left:-100px;margin-top:10px;">
                    <el-button size="small" type="primary" @click="submitForm">保 存</el-button>
                </el-form-item>
            </el-form>

            <!-- 选择产品 -->
            <product-list ref="productList" :productId="form.productId" @productEvent="getProductData($event)" />
        </el-tab-pane>

        <el-tab-pane name="runningStatus" :disabled="form.deviceId==0">
            <span slot="label">运行状态</span>
            <running-status ref="runningStatus" :device="form" />
        </el-tab-pane>

        <el-tab-pane name="deviceTimer" :disabled="form.deviceId==0">
            <span slot="label">设备定时</span>
            <device-timer ref="deviceTimer" :device="form" />
        </el-tab-pane>

        <!--
         <el-tab-pane name="deviceUser" :disabled="form.deviceId==0">
            <span slot="label">设备用户</span>
            <device-user ref="deviceUser" :device="form" @userEvent="getUserData($event)" />
        </el-tab-pane>
        -->

        <el-tab-pane name="deviceLog" :disabled="form.deviceId==0">
            <span slot="label">设备日志</span>
            <device-log ref="deviceLog" :device="form" />
        </el-tab-pane>

        <el-tab-pane name="deviceStastic" :disabled="form.deviceId==0">
            <span slot="label">监测统计</span>
            <device-statistic ref="deviceStatistic" :device="form" />
        </el-tab-pane>

        <el-tab-pane label="" disabled name="device01" />
        <el-tab-pane label="" disabled name="device02" />
        <el-tab-pane label="" disabled name="device03" />
        <el-tab-pane name="device04">
            <span slot="label">
                <el-tooltip class="item" effect="dark" content="用于查看发送的指令，设备是否已经响应" placement="right-start">
                    <el-button type="success" size="mini" @click="dataSynchronization()" :disabled="form.deviceId==0">数据同步</el-button>
                </el-tooltip>
            </span>
        </el-tab-pane>
        <el-tab-pane name="device05">
            <span slot="label">
                <el-button type="info" size="mini" @click="goBack()" :disabled="!isLoaded">返回列表</el-button>
            </span>
        </el-tab-pane>
    </el-tabs>

</el-card>
</template>

<script>
import productList from "./product-list"
import deviceLog from './device-log';
import deviceUser from './device-user';
import runningStatus from './running-status';
import deviceStatistic from './device-statistic'
import deviceTimer from './device-timer'
import {
    loadBMap
} from '../map.js'
import {
    getDevice,
    addDevice,
    updateDevice,
    generatorDeviceNum
} from "@/api/iot/device";

export default {
    name: "device-edit",
    dicts: ['iot_device_status'],
    components: {
        deviceLog,
        deviceUser,
        deviceStatistic,
        runningStatus,
        productList,
        deviceTimer,
    },
    watch: {
        activeName(val) {
            if (val == "deviceStastic") {
                this.$nextTick(() => {
                    // TODO 重置统计表格的尺寸

                })
            }
        }
    },
    data() {
        return {
            // 是否加载完成
            isLoaded: false,
            // 生成设备编码是否禁用
            genDisabled: false,
            // 选中选项卡
            activeName: 'basic',
            // 遮罩层
            loading: true,
            // 设备状态（1=禁用，0=不禁用）
            deviceStatus: 0,
            // 表单参数
            form: {
                productId: 0,
                status: 1,
            },
            // 图片地址
            imageUrl: require('@/assets/images/product.jpg'),
            // 地址
            baseUrl: process.env.VUE_APP_BASE_API,
            // 地图相关
            map: null,
            local: null,
            mk: null,
            latitude: '',
            longitude: '',
            keyWords: '',
            // 表单校验
            rules: {
                deviceName: [{
                    required: true,
                    message: "设备名称不能为空",
                    trigger: "blur"
                }],
                firmwareVersion: [{
                    required: true,
                    message: "固件版本不能为空",
                    trigger: "blur"
                }],
            }
        };
    },
    created() {
        // 获取设备信息
        this.form.deviceId = this.$route.query && this.$route.query.deviceId;
        if (this.form.deviceId != 0) {
            this.getDevice(this.form.deviceId);
        }
        // 未加载完，直接返回会报错
        setTimeout(() => {
            this.isLoaded = true;
        }, 2000);
    },
    methods: {
        /** 数据同步*/
        dataSynchronization(){
            getDevice(this.form.deviceId).then(response => {
                this.form = response.data;
                // 选项卡切换
                this.activeName='runningStatus';
                // 禁用状态
                if (this.form.status == 2) {
                    this.deviceStatus = 1;
                }
                if (this.form.imgUrl != null && this.form.imgUrl != "") {
                    this.imageUrl = this.form.imgUrl;
                }
                this.loadMap();

            });
        },
        /**获取设备详情*/
        getDevice(deviceId) {
            getDevice(deviceId).then(response => {
                this.form = response.data;
                // 禁用状态
                if (this.form.status == 2) {
                    this.deviceStatus = 1;
                }
                if (this.form.imgUrl != null && this.form.imgUrl != "") {
                    this.imageUrl = this.form.imgUrl;
                }
                this.loadMap();

            });
        },
        /**加载地图*/
        loadMap() {
            this.$nextTick(() => {
                loadBMap().then(() => {
                    this.getmap();
                });
            })
        },
        /** 返回按钮 */
        goBack() {
            const obj = {
                path: "/iot/device",
                query: {
                    t: Date.now(),
                    pageNum: this.$route.query.pageNum
                }
            };
            this.$tab.closeOpenPage(obj);
            this.reset();
        },
        // 表单重置
        reset() {
            this.form = {
                deviceId: 0,
                deviceName: null,
                productId: null,
                productName: null,
                userId: null,
                userName: null,
                tenantId: null,
                tenantName: null,
                serialNumber: null,
                firmwareVersion: null,
                status: 1,
                rssi: null,
                networkAddress: null,
                networkIp: null,
                longitude: null,
                latitude: null,
                activeTime: null,
                createBy: null,
                createTime: null,
                updateBy: null,
                updateTime: null,
                remark: null,
                isCustomLocation: 0,
            };
            this.deviceStatus = 0;
            this.resetForm("form");
        },
        /** 提交按钮 */
        submitForm() {
            this.$refs["form"].validate(valid => {
                if (valid) {
                    if (this.form.deviceId != 0) {
                        // 设置设备状态
                        this.setDeviceStatus();
                        console.log(this.form);
                        updateDevice(this.form).then(response => {
                            this.$modal.alertSuccess("修改成功");
                            this.open = false;
                            this.loadMap();
                        });
                    } else {
                        addDevice(this.form).then(response => {
                            this.$modal.alertSuccess("新增成功, 可以烧录sdk到设备了");
                            this.open = false;
                            this.form = response.data;
                            if (this.form.status == 2) {
                                this.deviceStatus = 1;
                            }
                            this.loadMap();
                        });
                    }
                }
            });
        },
        /**选择产品 */
        selectProduct() {
            this.$refs.productList.open = true;
            this.$refs.productList.getList();
        },
        /**获取选中的产品 */
        getProductData(product) {
            this.form.productId = product.productId;
            this.form.productName = product.productName;
            console.log(product);
        },
        // 获取选中的用户
        getUserData(user) {

        },

        // 地图定位
        getmap() {
            this.map = new BMap.Map('map')
            let point = null;
            if (this.form.longitude != null && this.form.longitude != "" && this.form.latitude != null && this.form.latitude != "") {
                point = new BMap.Point(this.form.longitude, this.form.latitude)
            } else {
                point = new BMap.Point(116.404, 39.915)
            }
            this.map.centerAndZoom(point, 19)
            this.map.enableScrollWheelZoom(true) // 开启鼠标滚轮缩放
            this.map.addControl(new BMap.NavigationControl())

            // 标注设备位置
            this.mk = new BMap.Marker(point)
            this.map.addOverlay(this.mk)
            this.map.panTo(point)
        },
        // 设置设备的状态
        setDeviceStatus() {
            if (this.deviceStatus == 1) {
                this.form.status = 2;
            } else {
                // 禁用状态，启用后状态是离线
                if (this.form.status == 2) {
                    this.form.status = 4;
                }
            }
        },
        // 生成随机字母和数字
        generateNum() {
            this.genDisabled = true;
            generatorDeviceNum().then(response => {
                this.form.serialNumber = response.data;
                this.genDisabled = false;
            })
        }

    }
};
</script>
