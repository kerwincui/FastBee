<template>
<div class="center_bottom">
    <div>
        <dv-scroll-board :config="config" style="width:360px;height:175px" />
    </div>
    <div style="display:flex;height:115px;margin-top:30px;">
        <div>
            <dv-water-level-pond :config="configCpu" style="width:115px;height:100%;" />
            <div style="text-align: center;margin-top:10px;color:#23cdd8;font-weight:600;">CPU</div>
        </div>
        <div style="margin:0 20px;">
            <dv-water-level-pond :config="configMemery" style="width:115px;height:100%;" />
            <div style="text-align: center;margin-top:10px;color:#23cdd8;font-weight:600;">内存</div>
        </div>
        <div style="">
            <dv-water-level-pond :config="configDisk" style="width:115px;height:100%;" />
            <div style="text-align: center;margin-top:10px;color:#23cdd8;font-weight:600;">系统盘</div>
        </div>
    </div>
</div>
</template>

<script>
import {
    getServer
} from "@/api/monitor/server";
export default {
    data() {
        return {
            timer: null,
            config: {},
            data: [
                ['服务器名称', ''],
                ['服务器IP', ""],
                ['操作系统', ''],
                ['系统架构', ""],
                ['CPU核心数', ''],
                ['服务器内存', ""],
                ['Java名称', ''],
                ['Java版本', ''],
                ['Java启动时间', ""],
                ['Java运行时长', ""],
                ['Java占用内存', ''],
                ['Java总内存', ""]
            ],
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
            configCpu: {
                data: [50],
                shape: 'roundRect',
                formatter: '{value}%',
                waveHeight: 10
            },
            configMemery: {
                data: [50],
                shape: 'roundRect',
                formatter: '{value}%',
                waveHeight: 10
            },
            configDisk: {
                data: [50],
                shape: 'roundRect',
                formatter: '{value}%',
                waveHeight: 10
            }
        };
    },
    props: {},
    mounted() {
        this.getServer();
    },
    beforeDestroy() {
        this.clearData();
    },
    methods: {
        /** 查询服务器信息 */
        getServer() {
            getServer().then(response => {
                this.server = response.data;
                this.config = {
                    rowNum: 6,
                    oddRowBGC: '',
                    evenRowBGC: '',
                    columnWidth: [105, 230],
                    data: [
                        ['服务器名：', this.server.sys.computerName],
                        ['服务器IP：', this.server.sys.computerIp],
                        ['操作系统：', this.server.sys.osName],
                        ['系统架构：', this.server.sys.osArch],
                        ['CPU核心：', this.server.cpu.cpuNum],
                        ['系统内存：', this.server.mem.total],
                        ['Java名称：', this.server.jvm.name],
                        ['Java版本：', this.server.jvm.version],
                        ['启动时间：', this.server.jvm.startTime],
                        ['运行时长：', this.server.jvm.runTime],
                        ['运行内存：', this.server.jvm.used],
                        ['JVM总内存：', this.server.jvm.total],
                    ],
                };
                // 计算CPU使用 
                let cpu = (this.server.cpu.used + this.server.cpu.sys) / (this.server.cpu.used + this.server.cpu.sys + this.server.cpu.free) * 100;
                this.configCpu = {
                    data: [cpu.toFixed(1), cpu.toFixed(1) - 10],
                    shape: 'roundRect',
                    formatter: '{value}%',
                    waveHeight: 10
                };
                // 计算内存
                let memery = this.server.mem.used / (this.server.mem.used + this.server.mem.free) * 100;
                this.configMemery = {
                    data: [memery.toFixed(1), memery.toFixed(1) - 10],
                    shape: 'roundRect',
                    formatter: '{value}%',
                    waveHeight: 10
                };
                // 计算硬盘
                let disk = Number(this.server.sysFiles[0].used.replace("GB", "")) / (Number(this.server.sysFiles[0].used.replace("GB", "")) + Number(this.server.sysFiles[0].free.replace("GB", ""))) * 100;
                this.configDisk = {
                    data: [disk.toFixed(1), disk.toFixed(1) - 10],
                    shape: 'roundRect',
                    formatter: '{value}%',
                    waveHeight: 10
                };
                // 轮询
                this.switper()
            });
        },
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
                this.getServer();
            };
            this.timer = setInterval(looper, 60000);
        },
    }
}
</script>

<style lang="scss" scoped>
.center_bottom {
    width: 100%;
    height: 100%;
    padding: 10px;
    display: flex;
}
</style>
