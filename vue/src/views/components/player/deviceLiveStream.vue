<template>
    <div>
        <el-row :gutter="20" style="margin-bottom: 16px">
            <el-col :span="1.5">
                <el-select v-model="channelId" placeholder="请选择通道" @change="changeChannel()">
                    <el-option v-for="option in channelList" :key="option.value" :label="option.label" :value="option.value"></el-option>
                </el-select>
            </el-col>
            <el-col :span="1.5" style="line-height: 36px">
                <span style="font-size: 14px">开启拉流：</span>
                <el-switch v-model="pushStream" :disabled="channelId === ''" @change="startPushStream"></el-switch>
            </el-col>
        </el-row>

        <player ref="player" :playerinfo="playinfo"></player>
    </div>
</template>
<script>
import player from '@/views/components/player/player.vue';
import { startPlay, closeStream, listChannel } from '@/api/iot/channel';

export default {
    name: 'device-live-stream',
    components: {
        player,
    },
    props: {
        device: {
            type: Object,
            default: null,
        },
    },
    watch: {
        // 获取到父组件传递的device后
        device: function (newVal, oldVal) {
            this.deviceInfo = newVal;
            if (this.deviceInfo.channelId) {
                this.channelId = this.deviceInfo.channelId;
                this.changeChannel();
            }
            if (this.deviceInfo && this.deviceInfo.deviceId !== 0) {
                this.queryParams.deviceSipId = this.deviceInfo.serialNumber;
                this.deviceId = this.device.serialNumber;
            }
        },
    },
    data() {
        return {
            deviceInfo: {},
            deviceId: '',
            channelId: '',
            streamId: '',
            ssrc: '',
            playurl: '',
            playinfo: { playtype: 'play' },
            playing: false,
            pushStream: false,
            retrycount: 0,
            channelList: [],
            // 查询参数
            queryParams: {
                pageNum: 1,
                pageSize: 10,
                deviceSipId: null,
                channelSipId: null,
            },
        };
    },
    created() {
        this.queryParams.deviceSipId = this.device.serialNumber;
        this.deviceId = this.device.serialNumber;
        this.getList();
        this.playinfo = {
            playtype: 'play',
            deviceId: this.device.serialNumber,
        };
    },
    beforeDestroy() {
        console.log('beforeDestroy');
        this.closeDestroy(false);
    },
    methods: {
        /** 查询监控设备通道信息列表 */
        getList() {
            this.loading = true;
            listChannel(this.queryParams).then((response) => {
                this.channelList = response.rows.map((item) => {
                    return { value: item.channelSipId, label: item.channelName };
                });
                console.log(this.channelList);
            });
        },
        changeChannel() {
            this.playinfo.channelId = this.channelId;
            this.startPlayer();
        },
        // 直播播放
        TimeoutCallback() {
            this.closeDestroy(false);
            this.retrycount = 0;
            setTimeout(() => {
                this.startPlayer();
            }, 1000);
        },
        startPushStream() {
            if (!this.channelId) {
                console.log('开始通道: [' + this.channelId + ']');
                return;
            }
            console.log('推流状态: [' + this.pushStream + ']');
            if (this.pushStream) {
                this.startPlayer();
            } else {
                this.closeDestroy(true);
            }
        },
        // 开启直播播放器
        startPlayer() {
            if (!this.channelId) {
                console.log('直播录像通道: [' + this.channelId + ']');
                return;
            }
            this.deviceId = this.queryParams.deviceSipId;
            if (this.playing) {
                this.closeDestroy(false);
            }
            this.$refs.player.registercallback('loadingTimeout', this.TimeoutCallback);
            this.$refs.player.registercallback('delayTimeout', this.TimeoutCallback);
            startPlay(this.deviceId, this.channelId).then((response) => {
                    console.log('开始推流: [' + this.channelId + ']');
                    const res = response.data;
                    this.streamId = res.streamId;
                    this.playurl = res.playurl;
                    this.$refs.player.play(this.playurl);
                    this.playing = true;
                    this.pushStream = true;
                });
        },
        closeStream(force) {
            if (force) {
                if (this.playing && this.streamId) {
                    console.log('强制关闭推流: [' + this.streamId + ']');
                    closeStream(this.deviceId, this.channelId, this.streamId).then((res) => {
                        this.streamId = '';
                        this.ssrc = '';
                        this.playurl = '';
                        this.pushStream = false;
                    });
                    this.playing = false;
                }
            } else {
                if (this.playing && this.streamId) {
                    console.log('关闭推流: [' + this.streamId + ']');
                    closeStream(this.deviceId, this.channelId, this.streamId).then((res) => {
                        this.streamId = '';
                        this.ssrc = '';
                        this.playurl = '';
                        this.pushStream = false;
                    });
                    this.playing = false;
                }
            }
        },
        closeDestroy(force) {
            this.closeStream(force);
            this.$refs.player.destroy();
        },
        destroy() {
            this.$refs.player.destroy();
        },
    },
};
</script>
