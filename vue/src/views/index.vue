<template>
<div style="padding:10px;background-color:#f8f8f8;">
    <el-row :gutter="20" style="margin:10px 0px 20px 0px;">
        <el-col :xs="24" :sm="24" :md="24" :lg="14" :xl="14">
            <div style="overflow:hidden;border:1px solid #ccc;">
                <div ref="map" style="height:650px;"></div>
            </div>
        </el-col>

        <el-col :xs="24" :sm="24" :md="24" :lg="10" :xl="10">
            <el-card shadow="none" style="">
                <h3 style="font-weight:bold"><i class="el-icon-s-data"></i> 设备统计</h3>
                <el-row :gutter="40" class="panel-group">
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-blue">
                                <svg-icon icon-class="device" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    设备数量
                                </div>
                                <count-to :start-val="0" :end-val="deviceStatistic.deviceCount" :duration="3000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-red">
                                <svg-icon icon-class="monitor-a" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    监测数据
                                </div>
                                <count-to :start-val="0" :end-val="deviceStatistic.monitorCount" :duration="3000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-blue">
                                <svg-icon icon-class="model" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    产品数量
                                </div>
                                <count-to :start-val="0" :end-val="deviceStatistic.productCount" :duration="1000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-red">
                                <svg-icon icon-class="alert" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    告警数量
                                </div>
                                <count-to :start-val="0" :end-val="deviceStatistic.alertCount" :duration="1000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-blue">
                                <svg-icon icon-class="log-a" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    操作记录
                                </div>
                                <count-to :start-val="0" :end-val="deviceStatistic.functionCount" :duration="2000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                    <el-col :span="12" class="card-panel-col">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-red">
                                <svg-icon icon-class="event-a" class-name="card-panel-icon" />
                            </div>
                            <div class="card-panel-description">
                                <div class="card-panel-text">
                                    上报事件
                                </div>
                                <count-to :start-val="0" :end-val="deviceStatistic.eventCount" :duration="2000" class="card-panel-num" />
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </el-card>
            <el-card shadow="none" style="margin-top:22px;height:302px;">
                <h3 style="font-weight:bold;margin-bottom:10px;"><i class="el-icon-s-order"></i> 信息栏</h3>
                <div style="cursor:pointer;display:table;width:100%;line-height:36px;" @click="openDetail(item.noticeId)" v-for="item in noticeList" :key="item.noticeId">
                    <div style="display:table-cell;padding-right:10px;">
                        <el-tag size="mini" effect="dark" type="warning" v-if="item.noticeType==2">公告</el-tag>
                        <el-tag size="mini" effect="dark" v-else>信息</el-tag>
                        {{item.noticeTitle}}
                    </div>
                    <div style="display:table-cell;width:90px;font-size:14px;"><i class="el-icon-time"></i> {{ parseTime(item.createTime, '{y}-{m}-{d}') }}</div>
                </div>
            </el-card>
        </el-col>
    </el-row>

    <el-card shadow="none" style="margin:10px 10px 20px 10px;padding:20px 0;">
        <el-row :gutter="120" v-if="isAdmin">
            <el-col :xs="24" :sm="24" :md="24" :lg="7" :xl="7">
                <h3 style="font-weight:bold">Mqtt 统计指标</h3>
                <el-row :gutter="20" class="panel-group">
                    <el-col :span="24" class="card-panel-col" style="margin-bottom:17px;">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-orange">
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
                    <el-col :span="24" class="card-panel-col" style="margin-bottom:18px;">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-green">
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
                    <el-col :span="24" class="card-panel-col" style="margin-bottom:17px;">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-orange">
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
                    <el-col :span="24" class="card-panel-col" style="margin-bottom:18px;">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-green">
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
                    <el-col :span="24" class="card-panel-col" style="margin-bottom:17px;">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-orange">
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
                    <el-col :span="24" class="card-panel-col" style="margin-bottom:17px;">
                        <div class="card-panel">
                            <div class="card-panel-icon-wrapper icon-green">
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
            </el-col>
            <el-col :xs="24" :sm="24" :md="24" :lg="10" :xl="10">
                <div ref="statsChart" style="height:275px;margin:20px 0 40px 0;"></div>
                <el-table :data="tableData" border stripe size="mini" :show-header="false" style="width: 100%;margin-bottom:40px;">
                    <el-table-column prop="server" label="服务器信息" width="82">
                    </el-table-column>
                    <el-table-column prop="serverContent" label="详情" min-width="100">
                    </el-table-column>
                    <el-table-column prop="java" label="JAVA虚拟机" width="82">
                    </el-table-column>
                    <el-table-column prop="javaContent" label="详情" min-width="100">
                    </el-table-column>
                </el-table>
            </el-col>
            <el-col :xs="24" :sm="24" :md="24" :lg="6" :xl="6">
                <div style="padding:20px;">
                    <div ref="pieCpu" style="height:161px;border-bottom:1px solid #ddd;"></div>
                </div>
                <div style="padding:20px;">
                    <div ref="pieMemery" style="height:161px;border-bottom:1px solid #ddd;"></div>
                </div>
                <div style="padding:20px;">
                    <div ref="pieDisk" style="height:161px;"></div>
                </div>
            </el-col>

        </el-row>
    </el-card>

    <el-card shadow="none" style="margin:10px 10px 60px 10px;">
        <el-row :gutter="40">
            <el-col :xs="24" :sm="24" :md="10" :lg="10" :xl="10" style="padding:40px;">
                <div style="padding:30px;margin:20px 0;font-size:14px;">
                    <div style="font-size:28px;font-weight:bold;margin-bottom:20px;">物美智能生活物联网平台</div>
                    <div style="display:table;font-size:14px;margin-bottom:10px;">
                        <div style="display:table-cell;line-height:22px;"><b style="color:#67C23A;margin-right:10px;">开源版本采用AGPL-3.0许可协议，商业用途需要获得授权</b>
                           
                        </div>
                    </div>
                    <div style="display:table;margin-bottom:10px;">
                        <div style="width:70px;font-weight: bold;display:table-cell;">开源版本：</div>
                        <div style="display:table-cell;line-height:22px;">可用于个人学习和使用，非商业用途，系统会有小概率弹窗</div>
                    </div>
                    <div style="display:table;">
                        <div style="width:70px;font-weight: bold;display:table-cell;">商业版本：</div>
                        <div style="display:table-cell;line-height:22px;">可用于商业用途，并提供所有源码，无弹窗，功能优先开源版本发布。<br />
                            <el-link target="_blank" href="https://wumei.live/doc/pages/sponsor">查看详情 >></el-link>
                        </div>
                    </div>
                </div>
                <div style="padding:30px;font-size:14px;">
                    <div style="float:left;width:230px;">
                        <el-image style="width:210px;" :src="require('@/assets/images/code.jpg')"></el-image>
                    </div>
                    <div style="float:left;">
                        <div style="font-size:18px;font-weight:bold;margin:16px 0;">微信扫一扫，查看小程序端</div>
                        <div style="font-size:14px;font-weight:bold;margin:16px 0;color:#F56C6C">右侧是移动端H5版本演示 </div>
                        <div style="display:table;margin-bottom:10px;">
                            <div style="width:70px;font-weight: bold;display:table-cell;">官方网站</div>
                            <div style="display:table-cell;">
                                <el-link target="_blank" href="https://wumei.live/">www.wumei.live</el-link>
                            </div>
                        </div>
                        <div style="display:table;margin-bottom:10px;">
                            <div style="width:70px;font-weight: bold;display:table-cell;">在线文档</div>
                            <div style="display:table-cell;">
                                <el-link target="_blank" href="https://wumei.live/doc">www.wumei.live/doc</el-link>
                            </div>
                        </div>
                        <div style="display:table;margin-bottom:10px;">
                            <div style="width:70px;font-weight: bold;display:table-cell;">联系作者</div>
                            <div style="display:table-cell;">
                                <span>QQ 164770707</span>
                            </div>
                        </div>
                        <div style="display:table;margin-bottom:15px;">
                            <div style="width:70px;font-weight: bold;display:table-cell;">系统源码</div>
                            <div style="display:table-cell;">
                                <el-link target="_blank" href="https://gitee.com/kerwincui/wumei-smart" type="danger">Gitee源码</el-link>
                                <el-link target="_blank" href="https://github.com/kerwincui/wumei-smart" style="margin-left:20px;">Github源码</el-link>
                            </div>
                        </div>
                    </div>

                </div>
            </el-col>
            <el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="12" style="padding:40px;">
                <div class="phone">
                    <iframe src="https://wumei.live/h5" id="iframe" frameborder="0" scrolling="auto" height="100%" width="100%" class="phone-container"></iframe>
                </div>
            </el-col>
        </el-row>

    </el-card>

    <!--通知公告详情 -->
    <el-dialog :title="notice.noticeTitle" :visible.sync="open" width="800px" append-to-body>
        <div style="margin-top:-20px;margin-bottom:10px;">
            <el-tag size="mini" effect="dark" type="warning" v-if="notice.noticeType==2">公告</el-tag>
            <el-tag size="mini" effect="dark" v-else>信息</el-tag>
            <span style="margin-left:20px;">{{notice.createTime}}</span>
        </div>
        <div v-loading="loading" class="content">
            <div v-html="notice.noticeContent"></div>
        </div>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="closeDetail"> 关 闭 </el-button>
        </div>
    </el-dialog>

    <div style="width:100%;text-align:center;font-size:14px;color:#666;line-height:32px;margin-top:150px;">
        <span>Copyright © 2021-2022 <a href="https://wumei.live/" target="_blank">Wumei Smart</a> | <a href="https://wumei.live/" target="_blank">物美智能</a> | Apache License</span><br />
        <span>项目文档<a href="https://wumei.live/doc/" target="_blank"> https://wumei.live/doc/</a></span>
    </div>

</div>
</template>

<script>
import {
    getDeviceStatistic,
} from "@/api/iot/device";
import {
    listNotice,
    getNotice,
} from "@/api/system/notice";
import CountTo from 'vue-count-to'
import * as echarts from 'echarts';
require('echarts/theme/macarons') // echarts theme
import {
    loadBMap
} from '@/utils/map.js'
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
            },
            tableData: []
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
            if (this.$store.state.user.roles.indexOf("tenant") === -1 && this.$store.state.user.roles.indexOf("general") === -1) {
                this.isAdmin = true
                this.getServer();
                this.getMqttStats();
                this.statisticMqtt();
            }
        },
        //刷新iframe
        flushIframe() {
            var iframe = window.parent.document.getElementById('iframe');
            iframe.contentWindow.location.reload(true);
        },
        /** 查询设备统计信息 */
        getDeviceStatistic() {
            getDeviceStatistic().then(response => {
                this.deviceStatistic = response.data;
            });
        },
        /** 查询公告列表 */
        getNoticeList() {
            let queryParams = {
                pageNum: 1,
                pageSize: 6,
            };
            listNotice(queryParams).then(response => {
                this.noticeList = response.rows.splice(0, 6);
            });
        },
        // 打开信息详情
        openDetail(id) {
            this.open = true;
            this.loading = true;
            getNotice(id).then(response => {
                this.notice = response.data;
                this.open = true;
                this.loading = false;
            });
        },
        // 取消按钮
        closeDetail() {
            this.title = "";
            this.open = false;
        },
        /**查询所有设备 */
        getAllDevice() {
            listAllDeviceShort(this.queryParams).then(response => {
                this.deviceList = response.rows;
                this.deviceCount = response.total;
                this.loadMap();
            })
        },
        /**加载地图*/
        loadMap() {
            this.$nextTick(() => {
                loadBMap().then(() => {
                    this.getmap();
                });
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
                this.tableData = [{
                    server: '服务器名',
                    serverContent: this.server.sys.computerName,
                    java: 'Java名称',
                    javaContent: this.server.jvm.name
                }, {
                    server: '服务器IP',
                    serverContent: this.server.sys.computerIp,
                    java: '启动时间',
                    javaContent: this.server.jvm.startTime
                }, {
                    server: '操作系统',
                    serverContent: this.server.sys.osName,
                    java: 'Java版本',
                    javaContent: this.server.jvm.version
                }, {
                    server: '系统架构',
                    serverContent: this.server.sys.osArch,
                    java: '运行时长',
                    javaContent: this.server.jvm.runTime
                }, {
                    server: 'CPU核心',
                    serverContent: this.server.cpu.cpuNum,
                    java: '占用内存',
                    javaContent: this.server.jvm.used
                }, {
                    server: '内存大小',
                    serverContent: this.server.mem.total,
                    java: 'JVM总内存',
                    javaContent: this.server.jvm.total
                }, ]
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
                title: {
                    text: '设备分布（在线数 ' + this.deviceList.filter(x => x.status == 3).length + '）',
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
                    center: [133, 38],
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
                                    color: '#fafafa' // #fffff8 淡黄色
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
                    text: 'Mqtt 状态数据',
                    textStyle: {
                        fontSize: 18,
                        color: "#000",
                        fontWeight: 800,
                    }
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
                    name: '当前数量',
                    type: 'bar',
                    data: [this.stats["connections.count"], this.stats["sessions.count"], this.stats["topics.count"], this.stats["subscribers.count"], this.stats["routes.count"], this.stats["retained.count"]],
                    itemStyle: {
                        color: '#67C23A'
                    }
                }, {
                    name: '历史最大数',
                    type: 'bar',
                    data: [this.stats["connections.max"], this.stats["sessions.max"], this.stats["topics.max"], this.stats["subscribers.max"], this.stats["routes.max"], this.stats["retained.max"]],
                    itemStyle: {
                        color: '#409EFF'
                    }
                }]
            };

            option && myChart.setOption(option);

        },
        drawPieCpu() {
            // 基于准备好的dom，初始化echarts实例
            let myChart = echarts.init(this.$refs.pieCpu);
            var option;
            option = {
                title: {
                    text: 'CPU使用率',
                    left: 'left',
                    textStyle: {
                        fontSize: 16
                    }
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
                    text: '内存使用率',
                    left: 'left',
                    textStyle: {
                        fontSize: 16
                    }
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
                    text: '系统盘使用率',
                    left: 'left',
                    textStyle: {
                        fontSize: 16
                    }
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
        },
    },
};
</script>

<style lang="scss" scoped>
.phone {
    height: 729px;
    width: 370px;
    background-image: url("../assets/images/phone.png");
    background-size: cover;
    margin: 0 auto;
}

.phone-container {
    height: 618px;
    width: 343px;
    position: relative;
    top: 46px;
    left: 12px;
    background-color: #fff;
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
        margin-bottom: 10px;
    }

    .card-panel {
        height: 68px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        color: #666;
        border: 1px solid #eee;
        border-radius: 5px;
        //box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.08);
        background-color: #fff;

        &:hover {
            .card-panel-icon-wrapper {
                color: #fff;
            }

            .icon-blue {
                background: #36a3f7;
            }

            .icon-green {
                background: #34bfa3
            }

            .icon-red {
                background: #F56C6C;
            }

            .icon-orange {
                background: #E6A23C;
            }
        }

        .icon-blue {
            color: #36a3f7;
        }

        .icon-green {
            color: #34bfa3
        }

        .icon-red {
            color: #F56C6C;
        }

        .icon-orange {
            color: #E6A23C;
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
            font-size: 30px;
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
