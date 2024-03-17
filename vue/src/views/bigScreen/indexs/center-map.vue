<template>
<div class="centermap">
    <div class="maptitle">
        <div class="zuo"></div>
        <span class="titletext">设备分布图</span>
        <div class="you"></div>
    </div>
    <div style="height:640px;background-color:#0e2e87;">
        <dv-border-box-8>
            <div ref="map" style="height:600px;width:760px;padding:10px;"></div>
        </dv-border-box-8>
    </div>
</div>
</template>

<script>
import {
    loadBMap
} from '@/utils/map.js'
//安装的是echarts完整包，里面包含百度地图扩展，路径为 echarts/extension/bmap/bmap.js，将其引入
//ECharts的百度地图扩展，可以在百度地图上展现点图，线图，热力图等可视化
require('echarts/extension/bmap/bmap')
import {
    listAllDeviceShort,
} from "@/api/iot/device";
export default {
    data() {
        return {
            // 设备列表
            deviceList: [],
        };
    },
    created() {
        this.getAllDevice();
    },
    beforeDestroy() {
        this.clearData();
    },
    methods: {
        clearData() {
            if (this.timer) {
                clearInterval(this.timer)
                this.timer = null
            }
        },
        //轮询
        switper() {
            if (this.timer) {
                return
            }
            let looper = (a) => {
                this.getAllDevice();
            };
            this.timer = setInterval(looper, 120000);
        },
        /**查询所有设备 */
        getAllDevice() {
            listAllDeviceShort(this.queryParams).then(response => {
                this.deviceList = response.rows;
                this.deviceCount = response.total;
                this.loadMap();
                // 轮询
                this.switper()
            })
        },
        /**加载地图*/
        loadMap() {
            loadBMap().then(() => {
                this.getmap();
            });
        },

        /** 地图 */
        getmap() {
            var myChart = this.$echarts.init(this.$refs.map);
            var option;

            // 单击事件
            myChart.on('click', (params) => {
                if (params.data.deviceId) {
                    this.$router.push({
                        path: '/iot/device-edit',
                        query: {
                            t: Date.now(),
                            deviceId: params.data.deviceId,
                        }
                    });
                }
            });

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
                            activeTime: data[i].activeTime == null ? '' : data[i].activeTime,
                            deviceId: data[i].deviceId,
                            serialNumber: data[i].serialNumber,
                            locationWay: data[i].locationWay,
                        });
                    }
                }
                return res;
            };
            option = {
                tooltip: {
                    trigger: 'item',
                    backgroundColor: "rgba(58,73,116,0.7)",
                    textStyle: {
                        color: "rgba(65,235,246,1)"
                    },
                    formatter: function (params) {
                        var htmlStr = '<div style="padding:5px;line-height:28px;">';
                        htmlStr += "设备名称： <span style='color:#FFF'>" + params.data.name + "</span><br />";
                        htmlStr += "设备编号： " + params.data.serialNumber + "<br />";
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
                        htmlStr += "定位方式： ";
                        if (params.data.locationWay == 1) {
                            htmlStr += "自动定位" + "<br />";
                        } else if (params.data.locationWay == 2) {
                            htmlStr += "设备定位" + "<br />";
                        } else if (params.data.locationWay == 3) {
                            htmlStr += "自定义位置" + "<br />";
                        } else {
                            htmlStr += "未知" + "<br />";
                        }
                        htmlStr += "所在地址： " + params.data.networkAddress + "<br />";
                        htmlStr += '</div>';
                        return htmlStr;
                    }
                },
                bmap: {
                    center: [106, 37.5],
                    zoom: 5,
                    // 大屏用zomm缩放，导致地图缩放中心点会偏移
                    roam: 'move',
                    mapStyle: {
                        styleJson: [{
                                featureType: 'water',
                                elementType: 'all',
                                stylers: {
                                    color: '#3863db'
                                }
                            },
                            {
                                featureType: 'land',
                                elementType: 'all',
                                stylers: {
                                    color: '#0e2e87'
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
                                    visibility: 'off',
                                    color: '#fdfdfd'
                                }
                            },
                            {
                                featureType: 'highway',
                                elementType: 'labels',
                                stylers: {
                                    visibility: 'off',
                                    visibility: 'off'
                                }
                            },
                            {
                                featureType: 'arterial',
                                elementType: 'geometry',
                                stylers: {
                                    visibility: 'off',
                                    color: '#fefefe'
                                }
                            },
                            {
                                featureType: 'arterial',
                                elementType: 'geometry.fill',
                                stylers: {
                                    visibility: 'off',
                                    color: '#fefefe'
                                }
                            },
                            {
                                featureType: 'poi',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off',
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
                                    visibility: 'off',
                                    color: '#d1d1d1'
                                }
                            },
                            {
                                featureType: 'local',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off',
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
                                    color: '#23cdd8'
                                }
                            },
                            {
                                featureType: 'building',
                                elementType: 'all',
                                stylers: {
                                    visibility: 'off',
                                    color: '#d1d1d1'
                                }
                            },
                            {
                                featureType: 'label',
                                elementType: 'labels.text.fill',
                                stylers: {
                                    color: '#264194',
                                    visibility: 'off'
                                }
                            }
                        ]
                    }
                },
                series: [{
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 1),
                        symbolSize: 10,
                        itemStyle: {
                            color: '#e8fc05'
                        }
                    },
                    {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 2),
                        symbolSize: 10,
                        itemStyle: {
                            color: '#fc3464'
                        }
                    }, {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 4),
                        symbolSize: 10,
                        itemStyle: {
                            color: '#eee'
                        }
                    }, {
                        type: 'effectScatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 3),
                        symbolSize: 12,
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
                            color: '#5de88e',
                            shadowBlur: 100,
                            shadowColor: '#333'
                        },
                        zlevel: 1
                    }
                ]
            };
            option && myChart.setOption(option, true);
        },
    },
};
</script>

<style lang="scss">
/* 清除地图LOGO */
.BMap_cpyCtrl {
    display: none !important;
}

.anchorBL {
    display: none !important;
}

.centermap {
    .maptitle {
        height: 60px;
        display: flex;
        justify-content: center;
        padding-top: 10px;
        box-sizing: border-box;

        .titletext {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: 6px;
            background: linear-gradient(92deg,
                    #0072ff 0%,
                    #00eaff 48.8525390625%,
                    #01aaff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0 10px;
        }

        .zuo,
        .you {
            background-size: 100% 100%;
            width: 29px;
            height: 20px;
            margin-top: 8px;
        }

        .zuo {
            background: url("../../../assets/bigScreen/img/xiezuo.png") no-repeat;
        }

        .you {
            background: url("../../../assets/bigScreen/img/xieyou.png") no-repeat;
        }
    }
}
</style>
