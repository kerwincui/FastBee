<template>
<div style="display:flex;margin-top:60px;">
    <div style="margin-left:10px;color:#32c5e9;">
        <dv-decoration-9 style="width:90px;height:90px;font-weight:600;" :dur="10" :color="['#32c5e9', '#238aa4']">{{deviceStatistic.deviceCount}}</dv-decoration-9>
        <div style="text-align: center;margin-top:25px;">设备总数</div>
    </div>
    <div style="margin:0 30px;color:#9fe6b8">
        <dv-decoration-9 style="width:90px;height:90px;font-weight:600;" :dur="10" :color="['#9fe6b8', '#70a181']">{{deviceStatistic.deviceOnlineCount}}</dv-decoration-9>
        <div style="text-align: center;margin-top:25px;font-weight:400;">在线设备</div>
    </div>
    <div style="margin-right:30px;color:#ffdb5c">
        <dv-decoration-9 style="width:90px;height:90px;font-weight:600;" :dur="10" :color="['#ffdb5c', '#b39a41']">{{deviceStatistic.deviceCount-deviceStatistic.deviceOnlineCount}}</dv-decoration-9>
        <div style="text-align: center;margin-top:25px;font-weight:400;">离线设备</div>
    </div>
    <div style="color:#fb7293;">
        <dv-decoration-9 style="width:90px;height:90px;font-weight:600;" :dur="10" :color="['#fb7293', '#ad4f65']">{{deviceStatistic.alertCount}}</dv-decoration-9>
        <div style="text-align: center;margin-top:25px;font-weight:400;">告警数量</div>
    </div>
</div>
</template>

<script>
import {
    getDeviceStatistic,
} from "@/api/iot/device";
export default {
    data() {
        return {
            // 设备统计信息
            deviceStatistic: {
                deviceCount: 100,
                productCount: 100,
                eventCount: 100,
                alertCount: 100,
                deviceOnlineCount:100
            },
            timer: null,
        };
    },
    created() {
        this.getDeviceStatic()
    },
    beforeDestroy() {
        this.clearData()
    },
    methods: {
        clearData() {
            if (this.timer) {
                clearInterval(this.timer)
                this.timer = null
            }
        },
        getDeviceStatic() {
            getDeviceStatistic().then(response => {
                if (response.code == 200) {
                    this.deviceStatistic = response.data;
                    // 轮询
                    this.switper()
                }
            });
        },
        //轮询
        switper() {
            if (this.timer) {
                return
            }
            let looper = (a) => {
                this.getDeviceStatic();
            };
            this.timer = setInterval(looper, 60000);
        },

    },
};
</script>
