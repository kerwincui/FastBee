<template>
    <div class="data-center-analysis">
        <el-card class="search-card">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px" class="search-form">
                <el-form-item prop="deviceId">
                    <el-select v-model="queryParams.deviceId" placeholder="请选择设备名称" filterable @change="handleDevDeviceChange">
                        <el-option v-for="(item, index) in deviceList" :key="index" :label="item.deviceName" :value="item.deviceId"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item prop="dayDaterange">
                    <el-date-picker
                        style="width: 356px"
                        v-model="queryParams.dayDaterange"
                        value-format="yyyy-MM-dd HH:mm:ss"
                        type="datetimerange"
                        range-separator="-"
                        start-placeholder="开始时间"
                        end-placeholder="结束时间"
                        :picker-options="pickerOptions"
                    ></el-date-picker>
                </el-form-item>
                <div style="float: right">
                    <el-button type="primary" icon="el-icon-search" @click="handleQuery">搜索</el-button>
                    <el-button icon="el-icon-refresh" @click="handleResetQuery">重置</el-button>
                </div>
            </el-form>
        </el-card>

        <el-row :gutter="20" v-loading="loading">
            <!-- 折线图占据整行以获得最大宽度 -->
            <el-col :span="24">
                <el-card class="card-box" style="margin-bottom: 20px">
                    <div slot="header" class="clearfix">
                        <span>变量历史数据折线图</span>
                    </div>
                    <div v-show="deviceLineList.length !== 0" ref="deviceLineChart" style="width: 100%; height: 400px"></div>
                    <el-empty v-if="deviceLineList.length === 0" style="height: 400px" description="暂无数据"></el-empty>
                </el-card>
            </el-col>
        </el-row>

        <!-- 新的一行用于统计和实时表格，每个各占半宽 -->
        <el-row :gutter="20" v-loading="loading">
            <el-col :span="12">
                <el-card class="card-box" style="margin-bottom: 0">
                    <div slot="header" class="clearfix">
                        <span>变量下发次数统计</span>
                    </div>
                    <div v-show="deviceBarList.length !== 0" ref="deviceBarChart" style="width: 100%; height: 480px"></div>
                    <el-empty v-if="deviceBarList.length === 0" style="height: 480px" description="暂无数据"></el-empty>
                </el-card>
            </el-col>

            <el-col :span="12">
                <el-card class="card-box" style="margin-bottom: 0">
                    <div slot="header" class="clearfix">
                        <span>变量实时数值表</span>
                    </div>
                    <div class="scroll-board-wrap">
                        <dv-scroll-board v-show="realTimeConfig.data && realTimeConfig.data.length !== 0" :config="realTimeConfig" style="width: 100%; height: 100%" />
                        <el-empty v-if="!realTimeConfig.data || realTimeConfig.data.length === 0" style="height: 100%" description="暂无数据"></el-empty>
                    </div>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script>
import moment from 'moment';

import { listDeviceShort, listThingsModel } from '@/api/iot/device.js';
import { getDataCenterDeviceHistory, getDataCenterCountThingsModelInvoke } from '@/api/iot/center.js';

export default {
    name: 'AnalysisNoAlert',
    dicts: ['iot_process_status'],
    data() {
        return {
            loading: false,
            loadingCount: 0,
            deviceList: [],
            identifierList: [], // 变量列表
            pickerOptions: {
                shortcuts: [
                    {
                        text: "最近2小时",
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 2);
                            picker.$emit('pick', [start, end]);
                        },
                    },
                    {
                        text: "最近1天",
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24);
                            picker.$emit('pick', [start, end]);
                        },
                    },
                    {
                        text: "最近7天",
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                            picker.$emit('pick', [start, end]);
                        },
                    },
                    {
                        text: "最近30天",
                        onClick(picker) {
                            const end = new Date();
                            const start = new Date();
                            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                            picker.$emit('pick', [start, end]);
                        },
                    },
                ],
            },
            // 查询参数
            queryParams: {
                deviceId: null,
                dayDaterange: [new Date(new Date().getTime() - 3600 * 1000 * 2), new Date()],
            },
            deviceLineList: [], // 设备折线图数据
            deviceBarList: [], // 设备柱状数据列表
            realTimeConfig: {}, // 实时数据
        };
    },
    mounted() {
        this.getDeviceList();
    },
    methods: {
        // 获取设备列表
        getDeviceList() {
            const params = {
                showChild: true,
                pageNum: 1,
                pageSize: 9999,
            };
            listDeviceShort(params).then((res) => {
                if (res.code === 200) {
                    this.deviceList = res.rows;
                }
            });
        },
        // 选择设备后
        handleDevDeviceChange(val) {
            this.getDevIdentifierList(val);
        },
        getDevIdentifierList(deviceId) {
            const params = {
                deviceId: deviceId,
                pageNum: 1,
                pageSize: 9999,
            };
            listThingsModel(params).then((res) => {
                if (res.code === 200) {
                    this.identifierList = res.rows;
                }
            });
        },
        // 查询设备的历史数据
        getDevChartDatas() {
            const devices = this.deviceList.find((item) => item.deviceId === this.queryParams.deviceId);
            if (!devices) {
                return;
            }
            this.myLoading();
            const params = {
                deviceId: devices.deviceId,
                serialNumber: devices.serialNumber,
                beginTime: moment(this.queryParams.dayDaterange[0]).format('YYYY-MM-DD HH:mm:ss'),
                endTime: moment(this.queryParams.dayDaterange[1]).format('YYYY-MM-DD HH:mm:ss'),
            };
            getDataCenterDeviceHistory(params).then((res) => {
                if (res.code === 200) {
                    this.deviceLineList = res.data;
                    if (this.deviceLineList.length !== 0) {
                        setTimeout(() => {
                            this.drawDevLineChart();
                        }, 200);
                    }
                }
                this.myLoadingClose();
            });
        },
        // 折线图
        drawDevLineChart() {
            this.deviceLineChart = this.$echarts.init(this.$refs.deviceLineChart);
            this.deviceLineChart.clear();
            // 设置折线图数据和样式
            this.deviceLineChart.setOption({
                tooltip: {
                    trigger: 'axis',
                },
                legend: {
                    align: 'right',
                    left: '3%',
                    top: '6%',
                },
                grid: {
                    top: '20%',
                    left: '5%',
                    right: '5%',
                    bottom: '5%',
                    containLabel: true,
                },
                // 自定义：设置x轴刻度
                xAxis: {
                    type: 'category',
                    boundaryGap: true,
                    axisTick: {
                        alignWithLabel: true,
                    },
                    // 自定义标签
                    data: this.deviceLineList.length !== 0 && this.deviceLineList.map((item) => Object.keys(item)[0]),
                },
                // 自定义：设置y轴刻度
                yAxis: {
                    type: 'value',
                    scale: true, //自适应
                },
                // 设置数据
                series: this.getDevSeries(),
            });
        },
        // 获取设备的series
        getDevSeries() {
            if (this.deviceLineList && this.deviceLineList.length !== 0) {
                const identifiers = Object.values(this.deviceLineList[0])[0].map((item) => Object.keys(item)[0]) || [];
                return identifiers.map((item, index) => {
                    return {
                        name: this.identifierList.find((chil) => chil.id === item).name,
                        type: 'line',
                        stack: '总量' + index,
                        data: this.deviceLineList.map((d) => {
                            const ide = d[Object.keys(d)[0]].find((itm) => Object.keys(itm)[0] === item);
                            return Object.values(ide)[0];
                        }),
                    };
                });
            }
        },
        // 获取设备物模型指令下发数量
        getThingsModelInvoke() {
            const devices = this.deviceList.find((item) => item.deviceId === this.queryParams.deviceId);
            if (!devices) {
                return;
            }
            this.myLoading();
            const params = {
                serialNumber: devices.serialNumber,
            };
            getDataCenterCountThingsModelInvoke(params).then((res) => {
                if (res.code === 200) {
                    this.deviceBarList = res.data;
                    if (this.deviceBarList.length !== 0) {
                        setTimeout(() => {
                            this.drawDeviceBarChart();
                        }, 200);
                    }
                }
                this.myLoadingClose();
            });
        },
        // 柱状图
        drawDeviceBarChart() {
            this.deviceBarChart = this.$echarts.init(this.$refs.deviceBarChart);
            this.deviceBarChart.clear();
            this.deviceBarChart.setOption({
                title: {
                    text: "设备使用统计",
                    left: 'center',
                },
                color: ['#1890FF'],
                textStyle: {
                    fontStyle: 'normal',
                },
                grid: {
                    left: '3%',
                    right: '3%',
                    bottom: '3%',
                    containLabel: true,
                    borderWidth: 0,
                },
                xAxis: {
                    type: 'value',
                    axisLine: {
                        show: false,
                    },
                    axisTick: {
                        show: false,
                    },
                    splitLine: {
                        lineStyle: {
                            color: '#EBEEF5',
                        },
                    },
                },
                yAxis: {
                    type: 'category',
                    axisTick: {
                        show: false,
                    },
                    axisLine: {
                        show: false,
                    },
                    data: this.deviceBarList.length !== 0 && this.deviceBarList.map((item) => item.modelName),
                },
                series: [
                    {
                        label: {
                            show: true,
                            position: 'right',
                            color: '#909399',
                        },
                        itemStyle: {
                            normal: {
                                color: '#1890FF',
                            },
                        },
                        data: this.deviceBarList.length !== 0 && this.deviceBarList.map((item) => item.counts),
                        type: 'bar',
                        barWidth: 30, //柱图宽度
                    },
                ],
            });
        },
        // 查询实时上传数据
        getDataRealTimeUpload() {
            if (!this.queryParams.deviceId) {
                return;
            }
            this.myLoading();
            const params = {
                deviceId: this.queryParams.deviceId,
                pageNum: 1,
                pageSize: 9999,
            };
            listThingsModel(params).then((res) => {
                if (res.code === 200) {
                    const header = ["变量名称", "当前值", "更新时间"];
                    let data = [];
                    if (res.rows && res.rows.length !== 0) {
                        data = res.rows.map((item) => {
                            return [item.name, item.value, item.ts];
                        });
                    }
                    this.realTimeConfig = {
                        rowNum: 10,
                        columnWidth: [100, 80, 190],
                        header: header,
                        data: data,
                    };
                }
                this.myLoadingClose();
            });
        },
        // 搜索按钮操作
        handleQuery() {
            this.getDevChartDatas(); // 查询设备的历史数据
            this.getThingsModelInvoke(); // 设备使用统计
            this.getDataRealTimeUpload(); // 获取数据实时上传
        },
        // 重置按钮操作
        handleResetQuery() {
            this.resetForm('queryForm');
            this.deviceLineList = [];
            this.deviceBarList = [];
            this.realTimeConfig = {};
            this.loading = false;
            this.loadingCount = 0;
        },
        myLoading() {
            if (this.loading === false) {
                this.loading = true;
            }
        },
        myLoadingClose() {
            if (this.loadingCount === 2) {
                this.loadingCount = 0;
                this.loading = false;
                return;
            }
            this.loadingCount = this.loadingCount + 1;
        },
    },
};
</script>

<style lang="scss" scoped>
.data-center-analysis {
    padding: 20px;

    .search-card {
        margin-bottom: 15px;
        padding: 3px 0;
    }

    .search-form {
        margin-bottom: -22.5px;
    }

    .card-box {
        padding: 0px;

        .scroll-board-wrap {
            width: 100%;
            height: 480px;

            ::v-deep .header {
                background-color: #f6f8fa !important;
                color: #909399;
                font-weight: bold; 
            } 
        }
    }
    .clearfix {
        font-size: 18px;
    }
    .clearfix:before,
    .clearfix:after {
        display: table;
        content: '';
    }
    .clearfix:after {
        clear: both;
    }
}
</style>
