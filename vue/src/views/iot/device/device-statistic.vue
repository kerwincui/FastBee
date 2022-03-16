<template>
<div style="padding-left:20px;">
    <el-row>
        <el-col :span="24">
            <div v-for="(item,index) in monitorThings" :key="index" style="margin-bottom:50px;">
                <el-card shadow="hover" :body-style="{ padding: '10px 0px',overflow:'auto' }">
                    <div ref="statisticMap" style="height:250px;width:1470px;"></div>
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
            // 设备信息
            deviceInfo: {},
            // 监测物模型
            monitorThings: [],
            // 图表集合
            chart: [],
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
        getStatisticData(monitorThingsModel) {
            for (let i = 0; i < monitorThingsModel.length; i++) {
                let queryParams = {};
                queryParams.deviceId = this.deviceInfo.deviceId;
                queryParams.identity = monitorThingsModel[i].id;
                listMonitor(queryParams).then(response => {
                    let data = response.rows;
                    // 对象转数组
                    let dataList=[];
                    for(let j=0; j<data.length; j++) {
                        let item=[];
                        item[0]=data[j].time;
                        item[1]=data[j].value;
                        dataList.push(item);
                    }
                    this.chart[i].setOption({
                        series: [{
                            data:dataList
                        }]
                    });
                });
            }
        },
        /**监测统计数据 */
        getStatistic() {
            for (let i = 0; i < this.monitorThings.length; i++) {
                this.chart[i] = echarts.init(this.$refs.statisticMap[i]);
                var option;
                option = {
                    animationDurationUpdate:3000,
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
                        right: '80px',
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
                        boundaryGap: false,
                        name: "时间", //坐标名字
                        nameLocation: "end", //坐标位置，支持start,end，middle
                        nameTextStyle: { //字体样式            
                            fontSize: 16, //字体大小            
                            padding: 20 //距离坐标位置的距离    
                        },
                    },
                    yAxis: {
                        type: 'value',
                        boundaryGap: [0, '100%'],
                        name: this.monitorThings[i].name, //坐标名字
                        nameLocation: "end", //坐标位置，支持start,end，middle
                        nameTextStyle: { //字体样式            
                            fontSize: 16, //字体大小            
                            padding: 10 //距离坐标位置的距离    
                        },
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
                            color: 'rgb(64, 158, 255)'
                        },
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: 'rgb(64, 158, 255)'
                                },
                                {
                                    offset: 1,
                                    color: 'rgb(255, 255, 255)'
                                }
                            ])
                        },
                        data: []
                    }]
                };
                option && this.chart[i].setOption(option);
            }
        },
    }
};
</script>
