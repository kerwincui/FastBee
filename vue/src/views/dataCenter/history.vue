<template>
    <div class="data-center-history">
        <div class="device-wrap">
            <div class="form-wrap">
                <el-form @submit.native.prevent :model="devQueryParams" ref="devQueryForm" :inline="true" label-width="68px">
                    <el-form-item prop="deviceId">
                        <el-select style="width: 100%" v-model="devQueryParams.deviceId" placeholder="请选择设备名称" filterable @change="handleDevDeviceChange" clearable>
                            <el-option v-for="(item, index) in devDeviceList" :key="index" :label="item.deviceName" :value="item.deviceId"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item prop="identifiers">
                        <el-select style="width: 100%" v-model="devQueryParams.identifiers" placeholder="请选择变量名称" filterable multiple collapse-tags>
                            <el-option v-for="(item, index) in devIdentifierList" :key="index" :label="item.name" :value="item.id" :disabled="item.isHistory === 0"></el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item prop="dayDaterange">
                        <el-date-picker
                            style="width: 354px"
                            v-model="devQueryParams.dayDaterange"
                            value-format="yyyy-MM-dd HH:mm:ss"
                            type="datetimerange"
                            range-separator="-"
                            start-placeholder="开始日期"
                            end-placeholder="结束日期"
                            :picker-options="pickerOptions"
                        ></el-date-picker>
                    </el-form-item>
                </el-form>
                <div class="search-btn-group">
                    <el-button type="primary" icon="el-icon-search" @click="handleDevQuery">搜索</el-button>
                    <el-button icon="el-icon-refresh" @click="handleDevResetQuery">重置</el-button>
                    <el-button
                        icon="el-icon-download"
                        @click="handleDeviceExport"
                        :disabled="devQueryParams.deviceId === '' || devQueryParams.identifiers.length === 0 || devQueryParams.dayDaterange === null"
                    > 导出
                    </el-button>
                </div>
            </div>

            <el-row>
                <el-col :span="24">
                    <el-card v-loading="loading" shadow="never">
                        <div slot="header">
                            <span>曲线趋势图</span>
                        </div>
                        <div class="el-table--enable-row-hover el-table--medium">
                            <div v-show="devDatas.length !== 0" ref="devLineChart" style="width: 100%; height: 480px; background: #fff"></div>
                            <el-empty v-if="devDatas.length === 0" style="height: 480px" description="暂无数据"></el-empty>
                            <el-table v-show="devTotal > 0" style="margin-top: 50px" :data="devTableList" :border="false">
                                <el-table-column label="更新时间" prop="time" width="200" />
                                <el-table-column v-for="item in this.devTableHeaderTemp" :key="item.value" :label="item.name" :prop="item.value" />
                            </el-table>
                            <pagination
                                style="margin-bottom: 20px"
                                v-show="devTotal > 0"
                                :autoScroll="false"
                                :total="devTotal"
                                :page.sync="devPageNum"
                                :limit.sync="devPageSize"
                                @pagination="getDevTableList"
                            />
                        </div>
                    </el-card>
                </el-col>
            </el-row>
        </div>
    </div>
    
</template>

<script>
import moment from 'moment';
import { listDeviceShort, listThingsModel } from '@/api/iot/device.js';
import { getDataCenterDeviceHistory } from '@/api/iot/center.js';

export default {
    name: 'History',
    data() {
        return {
            devDeviceList: [],
            devIdentifierList: [],
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
            devQueryParams: {
                deviceId: null,
                identifiers: [],
                dayDaterange: [new Date(new Date().getTime() - 3600 * 1000 * 2), new Date()],
            },
            loading: false,
            devDatas: [],
            devTableComTemp: [],
            devTableHeaderTemp: [],
            devPageNum: 1,
            devPageSize: 10,
            devTotal: 0,
        };
    },
    computed: {
        devTableList() {
            const start = (this.devPageNum - 1) * this.devPageSize;
            const end = start + this.devPageSize;
            return this.devTableComTemp.slice(start, end);
        },
    },
    mounted() {
        this.getDevDeviceList();
        const deviceId = this.$route.query.deviceId || this.$route.params.deviceId;
        const identifier = this.$route.query.identifier || this.$route.params.identifier;
        
        if (deviceId) {
            this.devQueryParams.deviceId = Number(deviceId);
            this.getDevIdentifierList(Number(deviceId));
            if (identifier) {
                this.devQueryParams.identifiers = [identifier];
            }
            setTimeout(() => {
                this.handleDevQuery();
            }, 500);
        } else {
            this.getDevDeviceList();
        }
    },
    methods: {
        getDevDeviceList() {
            console.log("11",this.devDeviceList);
            const params = {
                showChild: true,
                pageNum: 1,
                pageSize: 9999,
            };
            listDeviceShort(params).then((res) => {
                if (res.code === 200) {
                    this.devDeviceList = res.rows;
                }
            });
        },
        handleDevDeviceChange(val) {
            this.devQueryParams.identifiers = [];
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
                    this.devIdentifierList = res.rows;
                }
            });
        },
        getDevChartDatas() {
            this.loading = true;
            const devices = this.devDeviceList.find((item) => item.deviceId === this.devQueryParams.deviceId);
            const identifierList = this.devQueryParams.identifiers.map((item) => {
                const identifiers = this.devIdentifierList.find((chil) => chil.id === item);
                return { identifier: identifiers.id, type: identifiers.type };
            });
            const params = {
                deviceId: devices.deviceId,
                serialNumber: devices.serialNumber,
                identifierList: identifierList,
                beginTime: moment(this.devQueryParams.dayDaterange[0]).format('YYYY-MM-DD HH:mm:ss'),
                endTime: moment(this.devQueryParams.dayDaterange[1]).format('YYYY-MM-DD HH:mm:ss'),
            };
            getDataCenterDeviceHistory(params).then((res) => {
                if (res.code === 200) {
                    this.devDatas = res.data;
                    this.formatDevTableDatas();
                    if (this.devDatas.length !== 0) {
                        setTimeout(() => {
                            this.drawDevLine();
                        }, 500);
                    }
                }
                setTimeout(() => {
                    this.loading = false;
                }, 500);
            });
        },
        handleDevQuery() {
            const isField = this.areAllFields(this.devQueryParams);
            if (isField) {
                this.getDevChartDatas();
            }
        },
        handleDevResetQuery() {
            this.resetForm('devQueryForm');
            this.devQueryParams.identifiers = [];
            this.devDatas = [];
            this.devTableComTemp = [];
            this.devTotal = 0;
            this.devIdentifierList = [];
            this.handleDevQuery();
        },
        getDevTableList(e) {
            this.devPageNum = e.page;
            this.devPageSize = e.limit;
        },
        handleDeviceExport() {
            const isField = this.areAllFields(this.devQueryParams);
            if (isField) {
                const devices = this.devDeviceList.find((item) => item.deviceId === this.devQueryParams.deviceId);
                const identifierList = this.devQueryParams.identifiers.map((item) => {
                    const identifiers = this.devIdentifierList.find((chil) => chil.id === item);
                    return {  id: identifiers.id, type: identifiers.type };
                });
                const params = {
                    deviceId: devices.deviceId,
                    serialNumber: devices.serialNumber,
                    identifierStr: JSON.stringify(identifierList),
                    beginTime: moment(this.devQueryParams.dayDaterange[0]).format('YYYY-MM-DD HH:mm:ss'),
                    endTime: moment(this.devQueryParams.dayDaterange[1]).format('YYYY-MM-DD HH:mm:ss'),
                };
                this.download(
                    '/data/center/deviceExport',
                    {
                        ...params,
                    },
                    `deviceData_${new Date().getTime()}.xlsx`
                );
            }
        },
        drawDevLine() {
            this.charts = this.$echarts.init(this.$refs.devLineChart);
            this.charts.clear();
            this.charts.setOption({
                tooltip: {
                    trigger: 'axis',
                },
                legend: {
                    align: 'right',
                    left: '4.5%',
                    top: '15%',
                },
                grid: {
                    top: '30%',
                    left: '8%',
                    right: '10.5%',
                    bottom: '5%',
                    containLabel: true,
                },
                toolbox: {
                    feature: {
                        restore: {},
                        saveAsImage: {},
                    },
                },
                dataZoom: [
                    {
                        type: 'inside',
                        start: 0,
                        end: 100,
                    },
                    {
                        start: 0,
                        end: 100,
                    },
                ],
                xAxis: {
                    type: 'category',
                    boundaryGap: true,
                    axisTick: {
                        alignWithLabel: true,
                    },
                    data: this.devDatas.length !== 0 && this.devDatas.map((item) => Object.keys(item)[0]),
                },
                yAxis: {
                    type: 'value',
                    scale: true,
                },
                series: this.getDevSeries(),
            });
        },
        getDevSeries() {
            return this.devQueryParams.identifiers.map((item, index) => {
                return {
                    name: this.devIdentifierList.find((chil) => chil.id === item).modelName,
                    type: 'line',
                    stack: '总量' + index,
                    data: this.devDatas.map((d) => {
                        const ide = Object.values(d)[0].find((f) => Object.keys(f)[0] === item);
                        return Object.values(ide)[0];
                    }),
                };
            });
        },
        formatDevTableDatas() {
            this.devTableComTemp = this.devDatas.map((item) => {
                const time = Object.keys(item)[0];
                let obj = {};
                Object.values(item)[0].forEach((chil) => {
                    obj[Object.keys(chil)[0]] = Object.values(chil)[0];
                });
                return { time, ...obj };
            });
            this.devTotal = this.devDatas.length;
            this.devTableHeaderTemp = this.devQueryParams.identifiers.map((item) => ({
                name: this.devIdentifierList.find((chil) => chil.id === item).modelName,
                value: item,
            }));
        },
        areAllFields(obj) {
            for (const key in obj) {
                if (obj.hasOwnProperty(key)) {
                    if (!obj[key] || obj[key] === '' || obj[key].length === 0) {
                        return false;
                    }
                }
            }
            return true;
        },
    },
};
</script>

<style lang="scss" scoped>
.data-center-history{
    padding: 20px;
    .device-wrap {
        margin-top: 5px;
    }

    .form-wrap {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: flex-end;

        .search-btn-group {
            display: flex;
            flex-direction: row;
            margin-bottom: 22px;
        }
    }
}
</style>
