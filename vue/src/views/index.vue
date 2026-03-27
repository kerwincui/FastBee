<template>
    <div class="dashboard-container">
        <el-row :gutter="20" class="main-row">
            <el-col :xs="24" :sm="24" :md="24" :lg="14" :xl="14">
                <div ref="map" style="height: 650px; width: 100%"></div>
            </el-col>

            <el-col :xs="24" :sm="24" :md="24" :lg="10" :xl="10">
                <el-card shadow="hover" class="stat-card">
                    <div class="card-header">
                        <i class="el-icon-s-data"></i>
                        <span>{{ $t('home.equip') }}</span>
                    </div>
                    <el-row :gutter="10" class="panel-group">
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" class="card-panel-col">
                            <div class="card-panel">
                                <div class="card-panel-icon-wrapper icon-blue">
                                    <svg-icon icon-class="device" class-name="card-panel-icon" />
                                </div>
                                <div class="card-panel-description">
                                    <div class="card-panel-text">{{ $t('home.deviceCount') }}</div>
                                    <count-to :start-val="0" :end-val="deviceStatistic.deviceCount" :duration="3000" class="card-panel-num" />
                                </div>
                            </div>
                        </el-col>
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" class="card-panel-col">
                            <div class="card-panel">
                                <div class="card-panel-icon-wrapper icon-red">
                                    <svg-icon icon-class="monitor-a" class-name="card-panel-icon" />
                                </div>
                                <div class="card-panel-description">
                                    <div class="card-panel-text">{{ $t('home.monitorCount') }}</div>
                                    <count-to :start-val="0" :end-val="deviceStatistic.monitorCount" :duration="3000" class="card-panel-num" />
                                </div>
                            </div>
                        </el-col>
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" class="card-panel-col">
                            <div class="card-panel">
                                <div class="card-panel-icon-wrapper icon-blue">
                                    <svg-icon icon-class="model" class-name="card-panel-icon" />
                                </div>
                                <div class="card-panel-description">
                                    <div class="card-panel-text">{{ $t('home.productCount') }}</div>
                                    <count-to :start-val="0" :end-val="deviceStatistic.productCount" :duration="1000" class="card-panel-num" />
                                </div>
                            </div>
                        </el-col>
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" class="card-panel-col">
                            <div class="card-panel">
                                <div class="card-panel-icon-wrapper icon-red">
                                    <svg-icon icon-class="alert" class-name="card-panel-icon" />
                                </div>
                                <div class="card-panel-description">
                                    <div class="card-panel-text">{{ $t('home.alertCount') }}</div>
                                    <count-to :start-val="0" :end-val="deviceStatistic.alertCount" :duration="1000" class="card-panel-num" />
                                </div>
                            </div>
                        </el-col>
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" class="card-panel-col">
                            <div class="card-panel">
                                <div class="card-panel-icon-wrapper icon-blue">
                                    <svg-icon icon-class="log-a" class-name="card-panel-icon" />
                                </div>
                                <div class="card-panel-description">
                                    <div class="card-panel-text">{{ $t('home.functionCount') }}</div>
                                    <count-to :start-val="0" :end-val="deviceStatistic.functionCount" :duration="2000" class="card-panel-num" />
                                </div>
                            </div>
                        </el-col>
                        <el-col :xs="12" :sm="12" :md="12" :lg="12" class="card-panel-col">
                            <div class="card-panel">
                                <div class="card-panel-icon-wrapper icon-red">
                                    <svg-icon icon-class="event-a" class-name="card-panel-icon" />
                                </div>
                                <div class="card-panel-description">
                                    <div class="card-panel-text">{{ $t('home.eventCount') }}</div>
                                    <count-to :start-val="0" :end-val="deviceStatistic.eventCount" :duration="2000" class="card-panel-num" />
                                </div>
                            </div>
                        </el-col>
                    </el-row>
                </el-card>
                <el-card shadow="hover" class="notice-card" style="height: 250px">
                    <div class="card-header">
                        <i class="el-icon-s-order"></i>
                        <span>{{ $t('home.infoBoard') }}</span>
                    </div>
                    <div class="notice-list">
                        <div class="notice-item" @click="openDetail(item.noticeId)" v-for="item in noticeList" :key="item.noticeId">
                            <div class="notice-title">
                                <el-tag size="mini" effect="dark" type="warning" v-if="item.noticeType == 2">{{ $t('home.notice') }}</el-tag>
                                <el-tag size="mini" effect="dark" v-else>{{ $t('home.information') }}</el-tag>
                                <span>{{ item.noticeTitle }}</span>
                            </div>
                            <div class="notice-time">
                                <i class="el-icon-time"></i>
                                {{ parseTime(item.createTime, '{y}-{m}-{d}') }}
                            </div>
                        </div>
                    </div>
                </el-card>
            </el-col>
        </el-row>

        <el-card shadow="hover" class="server-card" v-if="isAdmin">
            <el-row :gutter="120">
                <el-col :xs="24" :sm="24" :md="8" :lg="8" :xl="8">
                    <div class="pie-chart">
                        <div ref="pieCpu" style="height: 161px"></div>
                    </div>
                </el-col>
                <el-col :xs="24" :sm="24" :md="8" :lg="8" :xl="8">
                    <div class="pie-chart">
                        <div ref="pieMemery" style="height: 161px"></div>
                    </div>
                </el-col>
                <el-col :xs="24" :sm="24" :md="8" :lg="8" :xl="8">
                    <div class="pie-chart">
                        <div ref="pieDisk" style="height: 161px"></div>
                    </div>
                </el-col>
            </el-row>
        </el-card>

        <!-- h5手机显示页面 -->
        <el-card shadow="hover" style="margin: 20px 0px 0px" class="phone-card">
            <el-row :gutter="40">
                <el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="12" style="padding: 10px">
                    <div style="padding: 30px; margin: 20px 0; font-size: 14px">
                        <div style="margin-bottom: 20px; font-family: PingFangSC, PingFang SC; font-weight: 600; font-size: 35px; color: #303133; line-height: 49px; text-align: left; font-style: normal">
                            {{ $t('views.index.394840-0') }}
                        </div>
                        <div style="display: table; font-size: 14px; margin-bottom: 10px">
                            <div style="display: table-cell; line-height: 22px">
                                <b style="margin-right: 10px; font-family: PingFangSC, PingFang SC; font-weight: 500; font-size: 13px; color: #67c23a; line-height: 18px; text-align: left; font-style: normal">
                                    {{ $t('views.index.394840-1') }}
                                </b>
                            </div>
                        </div>
                        <div style="margin-bottom: 10px">
                            <div style="width: 70px; font-weight: bold; display: table-cell; padding: 5px 0">
                                {{ $t('views.index.394840-2') }}
                            </div>
                            <div style="line-height: 22px">{{ $t('views.index.394840-3') }}</div>
                        </div>
                        <div style="margin: 10px 0">
                            <div style="width: 70px; font-weight: bold; display: table-cell; padding: 5px 0">
                                {{ $t('views.index.394840-4') }}
                            </div>
                            <div style="line-height: 22px">
                                {{ $t('views.index.394840-5') }}
                                <br />
                                <el-link target="_blank" href="https://fastbee.cn/doc/pages/sponsor">
                                    {{ $t('views.index.394840-6') }}
                                </el-link>
                            </div>
                        </div>
                    </div>
                    <div style="padding: 70px 30px 0 20px; font-size: 14px">
                        <div style="float: left; width: 200px">
                            <el-image style="width: 180px" :src="require('@/assets/images/code.jpg')"></el-image>
                        </div>
                        <div style="float: left">
                            <div class="mini-program">{{ $t('views.index.394840-7') }}</div>
                            <div style="display: table; margin-bottom: 5px">
                                <div class="web-site">{{ $t('views.index.394840-9') }}</div>
                                <div class="other-site">
                                    <el-link target="_blank" href="https://fastbee.cn/">www.fastbee.cn</el-link>
                                </div>
                            </div>
                            <div style="display: table; margin-bottom: 5px">
                                <div class="web-site">{{ $t('views.index.394840-10') }}</div>
                                <div class="other-site">
                                    <el-link target="_blank" href="https://fastbee.cn/doc">www.fastbee.cn/doc</el-link>
                                </div>
                            </div>
                            <div style="display: table; margin: 5px 0">
                                <div class="web-site">{{ $t('views.index.394840-11') }}</div>
                                <div class="other-site">
                                    <span>164770707@qq.com</span>
                                </div>
                            </div>
                            <div style="display: table; margin-bottom: 10px">
                                <div class="web-site">{{ $t('views.index.394840-12') }}</div>
                                <div class="other-site">
                                    <el-link target="_blank" href="https://gitee.com/kerwincui/wumei-smart" style="font-size: 12px">
                                        {{ $t('views.index.394840-13') }}
                                    </el-link>
                                    <el-link target="_blank" href="https://github.com/kerwincui/fastbee" style="margin-left: 20px; font-size: 12px">
                                        {{ $t('views.index.394840-14') }}
                                    </el-link>
                                </div>
                            </div>
                        </div>
                    </div>
                </el-col>
                <el-col :xs="24" :sm="24" :md="24" :lg="12" :xl="12" style="padding: 30px">
                    <div class="phone">
                        <iframe class="phone-container" src="https://iot.fastbee.cn/h5" id="iframe" frameborder="0" scrolling="auto"></iframe>
                        <div class="frame-remark">{{ $t('views.index.394840-8') }}</div>
                    </div>
                </el-col>
            </el-row>
        </el-card>

        <!--通知公告详情 -->
        <el-dialog :title="notice.noticeTitle" :visible.sync="open" width="800px" append-to-body>
            <div style="margin-top: -20px; margin-bottom: 10px">
                <el-tag size="mini" effect="dark" type="warning" v-if="notice.noticeType == 2">{{ $t('home.notice') }}</el-tag>
                <el-tag size="mini" effect="dark" v-else>{{ $t('home.information') }}</el-tag>
                <span style="margin-left: 20px">{{ notice.createTime }}</span>
            </div>
            <div v-loading="loading" class="content">
                <div v-html="notice.noticeContent"></div>
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="closeDetail">{{ $t('close') }}</el-button>
            </div>
        </el-dialog>

        <div style="width: 100%; text-align: center; font-size: 14px; color: #666; line-height: 32px; margin-top: 50px">
            <span>
                Copyright © 2021-2022
                <a href="https://fastbee.cn/" target="_blank">FastBee</a>
                |
                <a href="https://fastbee.cn/" target="_blank">{{ $t('home.fengxinIoT') }}</a>
                | Apache License
            </span>
            <br />
            <span>
                {{ $t('home.projectDocs') }}
                <a href="https://fastbee.cn/doc/" target="_blank">https://fastbee.cn/doc/</a>
            </span>
        </div>
    </div>
</template>

<script>
import { getDeviceStatistic } from '@/api/iot/device';
import { listNotice, getNotice } from '@/api/system/notice';
import CountTo from 'vue-count-to';
import { loadBMap } from '@/utils/map.js';
//安装的是echarts完整包，里面包含百度地图扩展，路径为 echarts/extension/bmap/bmap.js，将其引入
//ECharts的百度地图扩展，可以在百度地图上展现点图，线图，热力图等可视化
require('echarts/extension/bmap/bmap');
import { getServer } from '@/api/monitor/server';
import { listAllDeviceShort } from '@/api/iot/device';

export default {
    name: 'Index',
    components: {
        CountTo,
    },
    data() {
        return {
            // 遮罩层
            loading: true,
            // 是否显示弹出层
            open: false,
            // 信息列表
            noticeList: [],
            // 信息详情
            notice: {},
            // 是否为管理员
            isAdmin: false,
            // 设备列表
            deviceList: [],
            // 设备统计信息
            deviceStatistic: {},
            // 设备总数
            deviceCount: 0,
            // 版本号
            version: '3.8.0',
            // 服务器信息
            server: {
                jvm: {
                    name: '',
                    version: '',
                    startTime: '',
                    runTime: '',
                    used: '',
                    total: 100,
                },
                sys: {
                    computerName: '',
                    osName: '',
                    computerIp: '',
                    osArch: '',
                },
                cpu: {
                    cpuNum: 1,
                },
                mem: {
                    total: 2,
                },
            },
            tableData: [],
        };
    },
    created() {
        this.init();
        this.getAllDevice();
        this.getNoticeList();
        this.getDeviceStatistic();
    },
    methods: {
        init() {
            if (this.$store.state.user.roles.indexOf('tenant') === -1 && this.$store.state.user.roles.indexOf('general') === -1) {
                this.isAdmin = true;
                this.getServer();
            }
        },
        //刷新iframe
        flushIframe() {
            var iframe = window.parent.document.getElementById('iframe');
            iframe.contentWindow.location.reload(true);
        },
        /** 查询设备统计信息 */
        getDeviceStatistic() {
            getDeviceStatistic().then((response) => {
                this.deviceStatistic = response.data;
            });
        },
        /** 查询公告列表 */
        getNoticeList() {
            let queryParams = {
                pageNum: 1,
                pageSize: 6,
            };
            listNotice(queryParams).then((response) => {
                this.noticeList = response.rows.splice(0, 6);
            });
        },
        // 打开信息详情
        openDetail(id) {
            this.open = true;
            this.loading = true;
            getNotice(id).then((response) => {
                this.notice = response.data;
                this.open = true;
                this.loading = false;
            });
        },
        // 取消按钮
        closeDetail() {
            this.title = '';
            this.open = false;
        },
        /**查询所有设备 */
        getAllDevice() {
            listAllDeviceShort(this.queryParams).then((response) => {
                this.deviceList = response.rows;
                this.deviceCount = response.total;
                this.loadMap();
            });
        },
        /**加载地图*/
        loadMap() {
            loadBMap().then(() => {
                setTimeout(() => {
                    this.getmap(); // 里面有 setOption
                }, 500);
            });
        },
        /** 查询服务器信息 */
        getServer() {
            getServer().then((response) => {
                this.server = response.data;
                this.tableData = [
                    {
                        server: this.$t('home.serverName'),
                        serverContent: this.server.sys.computerName,
                        java: this.$t('home.javaName'),
                        javaContent: this.server.jvm.name,
                    },
                    {
                        server: this.$t('home.serverIp'),
                        serverContent: this.server.sys.computerIp,
                        java: this.$t('home.startTime'),
                        javaContent: this.server.jvm.startTime,
                    },
                    {
                        server: this.$t('home.os'),
                        serverContent: this.server.sys.osName,
                        java: this.$t('home.javaVersion'),
                        javaContent: this.server.jvm.version,
                    },
                    {
                        server: this.$t('home.osArch'),
                        serverContent: this.server.sys.osArch,
                        java: this.$t('home.runTime'),
                        javaContent: this.server.jvm.runTime,
                    },
                    {
                        server: this.$t('home.cpuCore'),
                        serverContent: this.server.cpu.cpuNum,
                        java: this.$t('home.usedMemory'),
                        javaContent: this.server.jvm.used,
                    },
                    {
                        server: this.$t('home.memSize'),
                        serverContent: this.server.mem.total,
                        java: this.$t('home.jvmTotalMemory'),
                        javaContent: this.server.jvm.total,
                    },
                ];
                this.$nextTick(() => {
                    this.drawPieCpu();
                    this.drawPieMemery();
                    this.drawPieDisk();
                });
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
                        },
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
                title: {
                    text: this.$t('home.deviceDistribution') + '（' + this.$t('home.onlineCount') + ' ' + this.deviceList.filter((x) => x.status == 3).length + '）',
                    subtext: 'fastbee open source iot platform',
                    sublink: 'https://iot.fastbee.cn',
                    target: '_blank',
                    textStyle: {
                        color: '#333',
                        textBorderColor: '#fff',
                        textBorderWidth: 10,
                    },
                    top: 10,
                    left: 'center',
                },
                tooltip: {
                    trigger: 'item',
                    formatter: function (params) {
                        var htmlStr = '<div style="padding:5px;line-height:28px;">';
                        htmlStr += this.$t('home.deviceName') + ': <span style="color:#409EFF">' + params.data.name + '</span><br />';
                        htmlStr += this.$t('home.deviceSerial') + ': ' + params.data.serialNumber + '<br />';
                        htmlStr += this.$t('home.deviceStatus') + ': ';
                        if (params.data.status == 1) {
                            htmlStr += "<span style='color:#E6A23C'>" + this.$t('home.notActive') + '</span>' + '<br />';
                        } else if (params.data.status == 2) {
                            htmlStr += "<span style='color:#F56C6C'>" + this.$t('home.disabled') + '</span>' + '<br />';
                        } else if (params.data.status == 3) {
                            htmlStr += "<span style='color:#67C23A'>" + this.$t('home.online') + '</span>' + '<br />';
                        } else if (params.data.status == 4) {
                            htmlStr += "<span style='color:#909399'>" + this.$t('home.offline') + '</span>' + '<br />';
                        }
                        if (params.data.isShadow == 1) {
                            htmlStr += this.$t('home.deviceShadow') + ': ' + "<span style='color:#67C23A'>" + this.$t('home.enabled') + '</span>' + '<br />';
                        } else {
                            htmlStr += this.$t('home.deviceShadow') + ': ' + "<span style='color:#909399'>" + this.$t('home.notEnabled') + '</span>' + '<br />';
                        }
                        htmlStr += this.$t('home.productName') + ': ' + params.data.productName + '<br />';
                        htmlStr += this.$t('home.firmwareVersion') + ': Version ' + params.data.firmwareVersion + '<br />';
                        htmlStr += this.$t('home.activeTime') + ': ' + params.data.activeTime + '<br />';
                        htmlStr += this.$t('home.locationWay') + ': ';
                        if (params.data.locationWay == 1) {
                            htmlStr += this.$t('home.autoLocation') + '<br />';
                        } else if (params.data.locationWay == 2) {
                            htmlStr += this.$t('home.deviceLocation') + '<br />';
                        } else if (params.data.locationWay == 3) {
                            htmlStr += this.$t('home.customLocation') + '<br />';
                        } else {
                            htmlStr += this.$t('home.unknown') + '<br />';
                        }
                        htmlStr += this.$t('home.address') + ': ' + params.data.networkAddress + '<br />';
                        htmlStr += '</div>';
                        return htmlStr;
                    }.bind(this),
                },
                bmap: {
                    center: [133, 38],
                    zoom: 5,
                    roam: true,
                    // mapStyle: {
                    //   styleJson: [
                    //     {
                    //       featureType: 'water',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#a0cfff',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'land',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#fafafa', // #fffff8 淡黄色
                    //       },
                    //     },
                    //     {
                    //       featureType: 'railway',
                    //       elementType: 'all',
                    //       stylers: {
                    //         visibility: 'off',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'highway',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#fdfdfd',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'highway',
                    //       elementType: 'labels',
                    //       stylers: {
                    //         visibility: 'off',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'arterial',
                    //       elementType: 'geometry',
                    //       stylers: {
                    //         color: '#fefefe',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'arterial',
                    //       elementType: 'geometry.fill',
                    //       stylers: {
                    //         color: '#fefefe',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'poi',
                    //       elementType: 'all',
                    //       stylers: {
                    //         visibility: 'off',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'green',
                    //       elementType: 'all',
                    //       stylers: {
                    //         visibility: 'off',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'subway',
                    //       elementType: 'all',
                    //       stylers: {
                    //         visibility: 'off',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'manmade',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#d1d1d1',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'local',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#d1d1d1',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'arterial',
                    //       elementType: 'labels',
                    //       stylers: {
                    //         visibility: 'off',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'boundary',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#999999',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'building',
                    //       elementType: 'all',
                    //       stylers: {
                    //         color: '#d1d1d1',
                    //       },
                    //     },
                    //     {
                    //       featureType: 'label',
                    //       elementType: 'labels.text.fill',
                    //       stylers: {
                    //         color: '#999999',
                    //       },
                    //     },
                    //   ],
                    // },
                },
                series: [
                    {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 1),
                        symbolSize: 15,
                        itemStyle: {
                            color: '#E6A23C',
                        },
                    },
                    {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 2),
                        symbolSize: 15,
                        itemStyle: {
                            color: '#F56C6C',
                        },
                    },
                    {
                        type: 'scatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 4),
                        symbolSize: 15,
                        itemStyle: {
                            color: '#909399',
                        },
                    },
                    {
                        type: 'effectScatter',
                        coordinateSystem: 'bmap',
                        data: convertData(this.deviceList, 3),
                        symbolSize: 15,
                        showEffectOn: 'render',
                        rippleEffect: {
                            brushType: 'stroke',
                            scale: 5,
                        },
                        label: {
                            formatter: '{b}',
                            position: 'right',
                            show: false,
                        },
                        itemStyle: {
                            color: '#67C23A',
                            shadowBlur: 100,
                            shadowColor: '#333',
                        },
                        zlevel: 1,
                    },
                ],
            };

            option && myChart.setOption(option);
        },

        drawPieCpu() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = this.$echarts.init(this.$refs.pieCpu);
            var option;
            option = {
                title: {
                    text: this.$t('home.cpuUsage'),
                    left: 'left',
                    textStyle: {
                        fontSize: 16,
                    },
                },
                tooltip: {
                    trigger: 'item',
                },
                legend: {
                    orient: 'vertical',
                    left: 'right',
                },
                color: ['#E6A23C', '#F56C6C', '#DDD'],
                series: [
                    {
                        name: this.$t('home.cpuUsage') + ' %',
                        type: 'pie',
                        radius: '55%',
                        label: {
                            show: false,
                        },
                        labelLine: {
                            normal: {
                                position: 'inner',
                                show: false,
                            },
                        },
                        data: [
                            {
                                value: this.server.cpu.used,
                                name: this.$t('home.user'),
                            },
                            {
                                value: this.server.cpu.sys,
                                name: this.$t('home.system'),
                            },
                            {
                                value: this.server.cpu.free,
                                name: this.$t('home.idle'),
                            },
                        ],
                    },
                ],
            };
            option && myChart.setOption(option);
        },
        drawPieMemery() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = this.$echarts.init(this.$refs.pieMemery);
            var option;
            option = {
                title: {
                    text: this.$t('home.memUsage'),
                    left: 'left',
                    textStyle: {
                        fontSize: 16,
                    },
                },
                tooltip: {
                    trigger: 'item',
                },
                legend: {
                    orient: 'vertical',
                    left: 'right',
                },
                color: ['#F56C6C', '#DDD'],
                series: [
                    {
                        name: this.$t('home.memUsage') + ' G',
                        type: 'pie',
                        radius: '55%',
                        label: {
                            show: false,
                        },
                        labelLine: {
                            normal: {
                                position: 'inner',
                                show: false,
                            },
                        },
                        data: [
                            {
                                value: this.server.mem.used,
                                name: this.$t('home.used'),
                            },
                            {
                                value: this.server.mem.free,
                                name: this.$t('home.free'),
                            },
                        ],
                    },
                ],
            };
            option && myChart.setOption(option);
        },
        drawPieDisk() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = this.$echarts.init(this.$refs.pieDisk);
            var option;
            let one = this.server.sysFiles[0].used.replace('GB', '');
            let two = this.server.sysFiles[0].free.replace('GB', '');
            option = {
                title: {
                    text: this.$t('home.diskUsage'),
                    left: 'left',
                    textStyle: {
                        fontSize: 16,
                    },
                },
                tooltip: {
                    trigger: 'item',
                },
                legend: {
                    orient: 'vertical',
                    left: 'right',
                },
                color: ['#F56C6C', '#DDD'],
                series: [
                    {
                        name: this.$t('home.diskStatus') + ' G',
                        type: 'pie',
                        radius: '55%',
                        label: {
                            show: false,
                        },
                        labelLine: {
                            normal: {
                                position: 'inner',
                                show: false,
                            },
                        },
                        data: [
                            {
                                value: one,
                                name: this.$t('home.used'),
                            },
                            {
                                value: two,
                                name: this.$t('home.available'),
                            },
                        ],
                    },
                ],
            };
            option && myChart.setOption(option);
        },
    },
};
</script>

<style lang="scss" scoped>
.dashboard-container {
    padding: 20px;
    background-color: #f5f7fa;
    min-height: calc(100vh - 84px);

    .main-row {
        margin-bottom: 0;
    }

    .map-card,
    .stat-card,
    .notice-card,
    .server-card {
        border-radius: 8px;
        border: none;
        height: 100%;
    }

    .stat-card {
        margin-bottom: 20px;

        .card-header {
            font-size: 16px;
            font-weight: 600;
            color: #303133;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ebeef5;

            i {
                margin-right: 8px;
                color: #409eff;
            }
        }
    }

    .notice-card {
        .card-header {
            font-size: 16px;
            font-weight: 600;
            color: #303133;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ebeef5;

            i {
                margin-right: 8px;
                color: #409eff;
            }
        }

        .notice-list {
            .notice-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid #f5f7fa;
                cursor: pointer;
                transition: all 0.3s;

                &:last-child {
                    border-bottom: none;
                }

                &:hover {
                    background-color: #f5f7fa;
                    padding-left: 10px;
                }

                .notice-title {
                    display: flex;
                    align-items: center;
                    flex: 1;

                    .el-tag {
                        margin-right: 10px;
                        color: #fff !important;

                        &.el-tag--mini {
                            padding: 0 8px;
                        }
                    }

                    span {
                        color: #606266;
                        font-size: 14px;
                    }
                }

                .notice-time {
                    color: #909399;
                    font-size: 13px;

                    i {
                        margin-right: 5px;
                    }
                }
            }
        }
    }

    .server-card {
        margin-top: 20px;
        border-radius: 8px;
        border: none;

        .pie-chart {
            padding: 20px;
        }
    }
}

$shadow-color: rgba(0, 0, 0, 0.1);

//小程序，h5
.phone-card {
    border-radius: 5px;
    // box-shadow: 0 4px 20px $shadow-color;
    // transition: transform 0.3s, box-shadow 0.3s;

    .mini-program {
        margin: 8px 0px 35px;
        font-family: PingFangSC, PingFang SC;
        font-weight: 600;
        font-size: 14px;
        color: #303133;
        line-height: 20px;
        text-align: left;
        font-style: normal;
    }
    .web-site {
        width: 70px;
        font-weight: bold;
        display: table-cell;
        font-family: PingFangSC, PingFang SC;
        font-weight: 500;
        font-size: 12px;
        color: #606266;
        line-height: 24px;
        text-align: left;
        font-style: normal;
    }
    .other-site {
        display: table-cell;
        font-family: PingFangSC, PingFang SC;
        font-weight: 400;
        font-size: 12px;
        color: #606266;
        line-height: 24px;
        text-align: left;
        font-style: normal;
    }
}
.phone {
    height: 650px;
    width: 320px;
    margin-left: 100px;
    background-image: url('../assets/images/phone.png');
    background-size: cover;

    .frame-remark {
        font-family: PingFangSC, PingFang SC;
        font-weight: 400;
        font-size: 12px;
        color: #909399;
        line-height: 17px;
        text-align: center;
        font-style: normal;
        margin: 20px auto;
    }
    @media screen and (max-width: 968px) {
        height: 530px;
        width: 260px;
        background-image: url('../assets/images/phone.png');
        background-size: cover;
    }
}

.phone-container {
    height: 635px;
    width: 291px;
    position: relative;
    border-radius: 35px;
    top: 8px;
    left: 15px;
    background-color: #fff;
    padding-bottom: 0%;

    @media screen and (max-width: 968px) {
        height: 519px;
        width: 240px;
        position: relative;
        border-radius: 30px;
        top: 5px;
        bottom: 10px;
        left: 10px;
        background-color: #fff;
        padding-bottom: 0%;
    }
}

.content {
    line-height: 24px;
    padding: 10px;
    border: 1px solid #eee;
    border-radius: 10px;
}

.description {
    font-size: 12px;

    tr {
        line-height: 20px;
    }
}

.panel-group {
    .card-panel-col {
        margin-bottom: 15px;
    }

    .card-panel {
        height: 80px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        color: #666;
        border: none;
        border-radius: 8px;
        background-color: #f9fafc;
        transition: all 0.3s;

        &:hover {
            background-color: #f5f7fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);

            .card-panel-icon-wrapper {
                color: #fff;
            }

            .icon-blue {
                background: #36a3f7;
            }

            .icon-green {
                background: #34bfa3;
            }

            .icon-red {
                background: #f56c6c;
            }

            .icon-orange {
                background: #e6a23c;
            }
        }

        .icon-blue {
            color: #36a3f7;
        }

        .icon-green {
            color: #34bfa3;
        }

        .icon-red {
            color: #f56c6c;
        }

        .icon-orange {
            color: #e6a23c;
        }

        .card-panel-icon-wrapper {
            float: left;
            margin: 12px;
            padding: 10px;
            transition: all 0.38s ease-out;
            border-radius: 8px;
            background-color: #fff;
        }

        .card-panel-icon {
            float: left;
            font-size: 28px;
        }

        .card-panel-description {
            float: right;
            font-weight: bold;
            margin: 12px;
            margin-left: 0px;

            .card-panel-text {
                line-height: 14px;
                color: #909399;
                font-size: 13px;
                margin-bottom: 10px;
                text-align: right;
            }

            .card-panel-num {
                font-size: 24px;
                font-weight: 600;
                color: #303133;
            }
        }
    }
}

// 响应式布局
@media screen and (max-width: 768px) {
    .dashboard-container {
        padding: 10px;

        .map-card {
            height: 400px;
        }

        .card-panel {
            height: 70px;

            .card-panel-num {
                font-size: 20px !important;
            }
        }
    }
}

@media screen and (max-width: 576px) {
    .dashboard-container {
        .map-card {
            height: 300px;
        }

        .panel-group {
            .card-panel-col {
                :xs {
                    span: 24;
                }
            }
        }
    }
}
</style>
