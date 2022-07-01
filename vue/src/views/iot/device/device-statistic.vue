<template>
<div style="padding-left:20px;">
    <el-row>
        <el-col :span="24">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="75px" style="">
                <el-form-item label="时间范围">
                    <el-date-picker v-model="daterangeTime" size="small" style="width: 240px" value-format="yyyy-MM-dd" type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
                </el-form-item>
                <el-form-item label="最大数量">
                    <el-input v-model="queryParams.total"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" icon="el-icon-search" size="mini" @click="getStatisticData">查询</el-button>
                </el-form-item>
            </el-form>
        </el-col>
        <el-col :span="23">
            <div v-for="(item,index) in monitorThings" :key="index" style="margin-bottom:30px;">
                <el-card shadow="hover" :body-style="{ padding: '10px 0px',overflow:'auto' }" v-loading="loading">
                    <div ref="statisticMap" style="height:300px;width:1080px;"></div>
                </el-card>
            </div>
        </el-col>
    </el-row>

</div>
</template>

<script>
import * as echarts from 'echarts';
import {
    cacheJsonThingsModel
} from "@/api/iot/model";
import {
    listMonitor
} from "@/api/iot/deviceLog";

export default {
    name: "device-statistic",
    props: {
        device: {
            type: Object,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的device后
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
            if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
                this.getCacheThingsModdel(this.deviceInfo.productId);
            }
        }
    },
    data() {
        return {
            loading: false,
            // 设备信息
            deviceInfo: {},
            // 监测物模型
            monitorThings: [],
            // 图表集合
            chart: [],
            // 激活时间范围
            daterangeTime: [],
            // 查询参数
            queryParams: {
                deviceId: 0,
                identity: "",
                total: 1000,
            },
        };
    },
    mounted() {

    },
    methods: {
        /** 获取物模型*/
        getCacheThingsModdel(productId) {
            // 获取缓存的Json物模型
            cacheJsonThingsModel(productId).then(response => {
                let thingsModel = JSON.parse(response.data);
                // 筛选监测数据
                this.monitorThings = thingsModel.properties.filter(item => item.isMonitor == 1);
                // 加载图表
                this.$nextTick(function () {
                    // 绘制图表
                    this.getStatistic();
                    // 获取统计数据
                    this.getStatisticData(this.monitorThings);
                });

            });
        },
        /** 获取统计数据 */
        getStatisticData() {
            this.loading = true;
            for (let i = 0; i < this.monitorThings.length; i++) {
                this.queryParams.deviceId = this.deviceInfo.deviceId;
                this.queryParams.identity = this.monitorThings[i].id;
                if (null != this.daterangeTime && '' != this.daterangeTime) {
                    this.queryParams.beginTime = this.daterangeTime[0];
                    this.queryParams.endTime = this.daterangeTime[1]+" 23:59";
                }
                listMonitor(this.queryParams).then(response => {
                    let data = response.rows;
                    // 对象转数组
                    let dataList = [];
                    for (let j = 0; j < data.length; j++) {
                        let item = [];
                        item[0] = data[j].time;
                        item[1] = data[j].value;
                        dataList.push(item);
                    }
                    this.chart[i].setOption({
                        series: [{
                            data: dataList
                        }]
                    });
                    this.loading = false;
                });
            }
        },
        /**监测统计数据 */
        getStatistic() {
            let color = ['#1890FF', '#91CB74', '#FAC858', '#EE6666', '#73C0DE', '#3CA272', '#FC8452', '#9A60B4', '#ea7ccc'];
            for (let i = 0; i < this.monitorThings.length; i++) {
                // 设置宽度
                this.$refs.statisticMap[i].style.width = (document.documentElement.clientWidth - 510) + "px";
                console.log(this.$refs.statisticMap[i]);

                this.chart[i] = echarts.init(this.$refs.statisticMap[i]);
                var option;
                option = {
                    animationDurationUpdate: 3000,
                    tooltip: {
                        trigger: 'axis',
                    },
                    title: {
                        left: 'center',
                        text: this.monitorThings[i].name + '统计 （单位 ' + (this.monitorThings[i].datatype.unit != undefined ? this.monitorThings[i].datatype.unit : "无") + "）",
                    },
                    grid: {
                        top: '80px',
                        left: '40px',
                        right: '20px',
                        bottom: '60px',
                        containLabel: true
                    },
                    toolbox: {
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            restore: {},
                            saveAsImage: {}
                        }
                    },
                    xAxis: {
                        type: 'time',
                    },
                    yAxis: {
                        type: 'value',
                    },
                    dataZoom: [{
                            type: 'inside',
                            start: 0,
                            end: 100
                        },
                        {
                            start: 0,
                            end: 100
                        }
                    ],
                    series: [{
                        name: this.monitorThings[i].name,
                        type: 'line',
                        symbol: 'none',
                        sampling: 'lttb',
                        itemStyle: {
                            color: i > 9 ? color[0] : color[i]
                        },
                        areaStyle: {},
                        data: []
                    }]
                };
                option && this.chart[i].setOption(option);
            }
        },
    }
};
</script>
