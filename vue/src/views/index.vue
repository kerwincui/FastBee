<template>
<div class="app-container home">
    <el-row :gutter="40">
        <el-col :span="14">
            <el-card style="margin:-10px;" shadow="hover" body-style="background-color:#F8F8F8;">
                <div ref="map" style="height:650px;margin:-10px;margin-top:-5px;"></div>
            </el-card>
        </el-col>

        <el-col :span="10">
            <el-card style="margin:-10px;" shadow="hover">
                <h3 style="font-weight:bold">Mqtt 统计指标</h3>
                <el-row :gutter="40" class="panel-group">
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-message">
                                <svg-icon icon-class="guide" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    发送字节
                                </div>
                                <count-to :start-val="0" :end-val="this.static['bytes.sent']" :duration="3000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-shopping">
                                <svg-icon icon-class="receiver" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    接收字节
                                </div>
                                <count-to :start-val="0" :end-val="this.static['bytes.received']" :duration="3000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-message">
                                <svg-icon icon-class="authenticate" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    认证次数
                                </div>
                                <count-to :start-val="0" :end-val="this.static['client.authenticate']" :duration="1000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-shopping">
                                <svg-icon icon-class="connect" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    连接次数
                                </div>
                                <count-to :start-val="0" :end-val="this.static['client.connected']" :duration="1000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-message">
                                <svg-icon icon-class="subscribe1" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    订阅次数
                                </div>
                                <count-to :start-val="0" :end-val="this.static['client.subscribe']" :duration="2000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-shopping">
                                <svg-icon icon-class="message" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    接收消息
                                </div>
                                <count-to :start-val="0" :end-val="this.static['messages.received']" :duration="2000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </el-card>
            <el-card style="margin:-10px;margin-top:20px;" shadow="hover">
                <div ref="statsChart" style="height:296px;"></div>
            </el-card>
        </el-col>

    </el-row>

    <el-row :gutter="40" style="margin-top:80px;">
        <el-col :span="1">
            <el-card style="margin:-10px;height:218px;margin-right:-31px;padding-top:35px;text-align:center;font-weight:bold;" shadow="none">
                服<br />务<br />器<br />状<br />态
            </el-card>
        </el-col>
        <el-col :span="5">
            <el-card style="margin:-10px;height:218px;" shadow="hover">
                <el-descriptions :column="1">
                    <el-descriptions-item label="服务器名称"><strong>{{server.sys.computerName}}</strong></el-descriptions-item>
                    <el-descriptions-item label="服务器IP"><strong>{{server.sys.computerIp}}</strong></el-descriptions-item>
                    <el-descriptions-item label="操作系统"><strong>{{server.sys.osName}}</strong></el-descriptions-item>
                    <el-descriptions-item label="系统架构"><strong>{{server.sys.osArch}}</strong></el-descriptions-item>
                    <el-descriptions-item label="CPU核心"><strong>{{server.cpu.cpuNum}}核</strong></el-descriptions-item>
                    <el-descriptions-item label="总内存"><strong>{{server.mem.total}}G</strong></el-descriptions-item>
                </el-descriptions>
            </el-card>
        </el-col>
        <el-col :span="4">
            <el-card style="margin:-10px;" shadow="hover">
                <div ref="pieCpu" style="height:200px;margin-bottom:-20px;"></div>
            </el-card>
        </el-col>
        <el-col :span="4">
            <el-card style="margin:-10px;" shadow="hover">
                <div ref="pieMemery" style="height:200px;margin-bottom:-20px;"></div>
            </el-card>
        </el-col>
        <el-col :span="4">
            <el-card style="margin:-10px;" shadow="hover">
                <div ref="pieDisk" style="height:200px;margin-bottom:-20px;"></div>
            </el-card>
        </el-col>
        <el-col :span="6">
            <el-card style="margin:-10px;height:218px;" shadow="hover">
                <el-descriptions :column="1">
                    <el-descriptions-item label="Java名称"><strong>{{server.jvm.name}}</strong></el-descriptions-item>
                    <el-descriptions-item label="启动时间"><strong>{{ server.jvm.startTime }}</strong></el-descriptions-item>
                    <el-descriptions-item label="Java版本"><strong>{{ server.jvm.version }}</strong></el-descriptions-item>
                    <el-descriptions-item label="运行时长"><strong>{{ server.jvm.runTime }}</strong></el-descriptions-item>
                    <el-descriptions-item label="占用内存"><strong>{{server.jvm.used}}M</strong></el-descriptions-item>
                    <el-descriptions-item label="JVM总内存"><strong>{{server.jvm.total}}M</strong></el-descriptions-item>
                </el-descriptions>
            </el-card>
        </el-col>
    </el-row>

    <div style="margin:-21px;margin-top:100px;bottom:0;border:1px solid #ccc;padding:10px;margin-bottom:-21px;">
        <div>
            <el-link href="http://wumei.live" target="_blank" type="primary" style="margin-left:20px;">开源生活物联网平台 >></el-link>
            <el-link href="https://github.com/kerwincui/wumei-smart" target="_blank" type="danger" style="margin-left:30px;">Github源码 >></el-link>
            <el-link href="https://gitee.com/kerwincui/wumei-smart" target="_blank" type="success" style="margin-left:30px;">码云源码 >></el-link>
        </div>
    </div>

</div>
</template>

<script>
import CountTo from 'vue-count-to'
import * as echarts from 'echarts';
require('echarts/theme/macarons') // echarts theme
import {
    loadBMap
} from './iot/map.js'
//安装的是echarts完整包，里面包含百度地图扩展，路径为 echarts/extension/bmap/bmap.js，将其引入
//ECharts的百度地图扩展，可以在百度地图上展现点图，线图，热力图等可视化
require('echarts/extension/bmap/bmap')
import {
    getServer
} from "@/api/monitor/server";
import {
    getMqttStats,
    statisticMqtt
} from "@/api/iot/emqx";
import {
    listAllDeviceShort,
} from "@/api/iot/device";

export default {
    name: "Index",
    components: {
        CountTo
    },
    data() {
        return {
            // 设备列表
            deviceList: [],
            // 设备总数
            deviceCount:0,
            // emqx状态数据
            stats: {},
            // emqx统计信息
            static: {},
            // 版本号
            version: "3.8.0",
            // 服务器信息
            server: {
                jvm: {
                    name: "",
                    version: "",
                    startTime: "",
                    runTime: "",
                    used: "",
                    total: 100
                },
                sys: {
                    computerName: "",
                    osName: "",
                    computerIp: "",
                    osArch: ""
                },
                cpu: {
                    cpuNum: 1
                },
                mem: {
                    total: 2
                }
            }
        };
    },
    created() {
        // this.deviceList = [{
        //         id: 21,
        //         name: '海门',
        //         value: 9,
        //         long: 121.15,
        //         lat: 31.89,
        //         address: "海门",
        //         product: "测试产品",
        //         version: 1.0,
        //         status: 1,
        //     },
        //     {
        //         id: 21,
        //         name: '鄂尔多斯',
        //         value: 12,
        //         long: 109.781327,
        //         lat: 39.608266,
        //         address: "海门",
        //         product: "测试产品",
        //         version: 2.0,
        //         status: 2
        //     },
        //     {
        //         id: 21,
        //         name: '招远',
        //         value: 12,
        //         long: 120.38,
        //         lat: 37.35,
        //         address: "海门",
        //         product: "测试产品",
        //         version: 1.0,
        //         status: 3
        //     },
        //     {
        //         id: 21,
        //         name: '海口',
        //         value: 12,
        //         long: 110.38,
        //         lat: 20.35,
        //         address: "测试",
        //         product: "测试产品",
        //         version: 1.0,
        //         status: 4
        //     }
        // ];
        this.getAllDevice();
        this.getServer();
        this.getMqttStats();
        this.statisticMqtt();

    },
    methods: {
        /**查询所有设备 */
        getAllDevice() {
            listAllDeviceShort().then(response => {
                this.deviceList = response.rows;
                this.deviceCount=response.total;
                this.$nextTick(() => {
                    loadBMap().then(() => {
                        this.getmap();
                    });
                })
            })
        },
        /** 查询emqx统计*/
        statisticMqtt() {
            statisticMqtt().then(response => {
                this.static = response.data.data[0].metrics;
            })
        },
        /** 查询emqx状态数据*/
        getMqttStats() {
            getMqttStats().then(response => {
                this.stats = response.data.data[0].stats;
                this.drawStats();
            })
        },
        /** 查询服务器信息 */
        getServer() {
            getServer().then(response => {
                this.server = response.data;
                this.$nextTick(() => {
                    this.drawPieCpu();
                    this.drawPieMemery();
                    this.drawPieDisk();
                })
            });
        },

        /** 地图 */
        getmap() {
            var myChart = echarts.init(this.$refs.map);
            var option;

            // 格式化数据
            let convertData = function (data, status) {
                var res = [];
                for (var i = 0; i < data.length; i++) {
                    var geoCoord = [data[i].longitude, data[i].latitude];
                    if (geoCoord && data[i].status == status) {
                        res.push({
                            name: data[i].deviceName,
                            value: geoCoord,
                            serialNumber: data[i].serialNumber,
                            status: data[i].status,
                            isShadow: data[i].isShadow,
                            firmwareVersion: data[i].firmwareVersion,
                            networkAddress: data[i].networkAddress,
                            productName: data[i].productName,
                            activeTime: data[i].activeTime,
                        });
                    }
                }
                return res;
            };
            option = {
                title: {
                    text: '设备分布和状态（数量 '+this.deviceCount+'）',
                    subtext: 'wumei-smart open source living iot platform',
                    sublink: 'https://iot.wumei.live',
                    target: "_blank",
                    textStyle: {
                        color: '#333',
                        textBorderColor: '#fff',
                        textBorderWidth: 10,
                    },
                    top: 10,
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: function (params) {
                        var htmlStr = '<div style="padding:5px;line-height:28px;">';
                        htmlStr += "设备名称： <span style='color:#409EFF'>" + params.data.name + "</span><br />";
                        htmlStr += "设备状态： ";
                        if (params.data.status == 1) {
                            htmlStr += "<span style='color:#E6A23C'>未激活</span>" + "<br />";
                        } else if (params.data.status == 2) {
                            htmlStr += "<span style='color:#F56C6C'>禁用</span>" + "<br />";
                        } else if (params.data.status == 3) {
                            htmlStr += "<span style='color:#67C23A'>在线</span>" + "<br />";
                        } else if (params.data.status == 4) {
                            htmlStr += "<span style='color:#909399'>离线</span>" + "<br />";
                        }
                        if (params.data.isShadow == 1) {
                            htmlStr += "设备影子： " + "<span style='color:#67C23A'>启用</span>" + "<br />";
                        } else {
                            htmlStr += "设备影子： " + "<span style='color:#909399'>未启用</span>" + "<br />";
                        }
                        htmlStr += "产品名称： " + params.data.productName + "<br />";
                        htmlStr += "固件版本： Version " + params.data.firmwareVersion + "<br />";
                        htmlStr += "激活时间： " + params.data.activeTime + "<br />";
                        htmlStr += "所在地址： " + params.data.networkAddress + "<br />";
                        htmlStr += '</div>';
                        return htmlStr;
                    }
                },
                bmap: {
                    center: [133, 37],
                    zoom: 5,
                    roam: true,
                    mapStyle: {
                        styleJson: [{
                                featureType: 'water',
                                elementType: 'all',
                                stylers: {
                                    color: '#a0cfff'
                                }
                            },
                            {
                                featureType: 'land',
                                elementType: 'all',
                                stylers: {
                                    color: '#FFFFFF'
                                }
                            },
                            {
                                featureType: 'railway',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'highway',
                                elementType: 'all',
                                stylers: {
                                    color: '#fdfdfd'
                                }
                            },
                            {
                                featureType: 'highway',
                                elementType: 'labels',
                                stylers: {
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'arterial',
                                elementType: 'geometry',
                                stylers: {
                                    color: '#fefefe'
                                }
                            },
                            {
                                featureType: 'arterial',
                                elementType: 'geometry.fill',
                                stylers: {
                                    color: '#fefefe'
                                }
                            },
                            {
                                featureType: 'poi',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'green',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'subway',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'manmade',
                                elementType: 'all',
                                stylers: {
                                    color: '#d1d1d1'
                                }
                            },
                            {
                                featureType: 'local',
                                elementType: 'all',
                                stylers: {
                                    color: '#d1d1d1'
                                }
                            },
                            {
                                featureType: 'arterial',
                                elementType: 'labels',
                                stylers: {
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'boundary',
                                elementType: 'all',
                                stylers: {
                                    color: '#999999'
                                }
                            },
                            {
                                featureType: 'building',
                                elementType: 'all',
                                stylers: {
                                    color: '#d1d1d1'
                                }
                            },
                            {
                                featureType: 'label',
                                elementType: 'labels.text.fill',
                                stylers: {
                                    color: '#999999'
                                }
                            }
                        ]
                    }
                },
                series: [{
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 1),
                        symbolSize: 15,
                        itemStyle: {
                            color: '#E6A23C'
                        }
                    },
                    {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 2),
                        symbolSize: 15,
                        itemStyle: {
                            color: '#F56C6C'
                        }
                    }, {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 4),
                        symbolSize: 15,
                        itemStyle: {
                            color: '#909399'
                        }
                    }, {
                        type: 'effectScatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 3),
                        symbolSize: 15,
                        showEffectOn: 'render',
                        rippleEffect: {
                            brushType: 'stroke',
                            scale: 5
                        },
                        label: {
                            formatter: '{b}',
                            position: 'right',
                            show: false
                        },
                        itemStyle: {
                            color: '#67C23A',
                            shadowBlur: 100,
                            shadowColor: '#333'
                        },
                        zlevel: 1
                    }
                ]
            };

            option && myChart.setOption(option);

        },
        /** EMQX状态统计 */
        drawStats() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = echarts.init(this.$refs.statsChart);
            var option;

            option = {
                title: {
                    text: 'Mqtt 状态数据'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {},
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'value',
                    boundaryGap: [0, 0.01]
                },
                yAxis: {
                    type: 'category',
                    axisLabel: {
                        fontSize: 14
                    },
                    data: ['连接数量', '会话数量', '主题数量', '订阅数量', '路由数量', '保留消息']
                },
                series: [{
                        name: '历史最大数',
                        type: 'bar',
                        data: [this.stats["connections.max"], this.stats["sessions.max"], this.stats["topics.max"], this.stats["subscribers.max"], this.stats["routes.max"], this.stats["retained.max"]],
                        itemStyle: {
                            color: '#409EFF'
                        }
                    },
                    {
                        name: '当前数量',
                        type: 'bar',
                        data: [this.stats["connections.count"], this.stats["sessions.count"], this.stats["topics.count"], this.stats["subscribers.count"], this.stats["routes.count"], this.stats["retained.count"]],
                        itemStyle: {
                            color: '#67C23A'
                        }
                    }
                ]
            };

            option && myChart.setOption(option);

        },
        drawPieCpu() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = echarts.init(this.$refs.pieCpu);
            var option;
            option = {
                title: {
                    text: 'CPU使用率 %',
                    left: 'left'
                },
                tooltip: {
                    trigger: 'item',
                },
                legend: {
                    orient: 'vertical',
                    left: 'right'
                },
                color: ['#E6A23C', '#F56C6C', '#DDD'],
                series: [{
                    name: 'CPU使用率 %',
                    type: 'pie',
                    radius: '55%',
                    label: {
                        show: false
                    },
                    labelLine: {
                        normal: {
                            position: "inner",
                            show: false
                        }
                    },
                    data: [{
                            value: this.server.cpu.used,
                            name: '用户'
                        },
                        {
                            value: this.server.cpu.sys,
                            name: '系统'
                        },
                        {
                            value: this.server.cpu.free,
                            name: '空闲'
                        }
                    ],
                }]
            };
            option && myChart.setOption(option);
        },
        drawPieMemery() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = echarts.init(this.$refs.pieMemery);
            var option;
            option = {
                title: {
                    text: '内存使用 G',
                    left: 'left'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'right'
                },
                color: ['#F56C6C', '#DDD'],
                series: [{
                    name: '内存使用率 G',
                    type: 'pie',
                    radius: '55%',
                    label: {
                        show: false
                    },
                    labelLine: {
                        normal: {
                            position: "inner",
                            show: false
                        }
                    },
                    data: [{
                            value: this.server.mem.used,
                            name: '已用'
                        },
                        {
                            value: this.server.mem.free,
                            name: '剩余'
                        }
                    ]
                }]
            };
            option && myChart.setOption(option);
        },
        drawPieDisk() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = echarts.init(this.$refs.pieDisk);
            var option;
            let one = this.server.sysFiles[0].used.replace("GB", "");
            let two = this.server.sysFiles[0].free.replace("GB", "");;
            option = {
                title: {
                    text: 'C盘状态 G',
                    left: 'left'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'right'
                },
                color: ['#F56C6C', '#DDD'],
                series: [{
                    name: '磁盘状态 G',
                    type: 'pie',
                    radius: '55%',
                    label: {
                        show: false
                    },
                    labelLine: {
                        normal: {
                            position: "inner",
                            show: false
                        }
                    },
                    data: [{
                            value: one,
                            name: '已用'
                        },
                        {
                            value: two,
                            name: '可用'
                        }
                    ]
                }]
            };
            option && myChart.setOption(option);
        }
    },
};
</script>

<style lang="scss" scoped>
.panel-group {
    .card-panel-col {
        margin-bottom: 10px;
    }

    .card-panel {
        height: 68px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        color: #666;
        box-shadow: 2px 2px 10px rgba(0, 0, 0, .1);

        &:hover {
            .card-panel-icon-wrapper {
                color: #fff;
            }

            .icon-message {
                background: #36a3f7;
            }

            .icon-shopping {
                background: #34bfa3
            }
        }

        .icon-message {
            color: #36a3f7;
        }

        .icon-shopping {
            color: #34bfa3
        }

        .card-panel-icon-wrapper {
            float: left;
            margin: 10px;
            padding: 10px;
            transition: all 0.38s ease-out;
            border-radius: 6px;
        }

        .card-panel-icon {
            float: left;
            font-size: 32px;
        }

        .card-panel-description {
            float: right;
            font-weight: bold;
            margin: 15px;
            margin-left: 0px;

            .card-panel-text {
                line-height: 14px;
                color: rgba(0, 0, 0, 0.45);
                font-size: 14px;
                margin-bottom: 12px;
                text-align: right;
            }

            .card-panel-num {
                font-size: 18px;
            }
        }
    }
}
</style>
