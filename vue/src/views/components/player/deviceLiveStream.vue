<template>
  <div>
    <el-row>
      <span style="margin-left: 10px" prop="channelName">通道名称：</span>
      <el-select v-model="channelId" placeholder="请选择" @change="changeChannel()" size="small">
        <el-option v-for="option in channelList" :key="option.value" :label="option.label" :value="option.value"></el-option>
      </el-select>
      <span style="margin: 10px 10px 10px 30px">开启拉流:</span>
      <el-switch v-model="pushStream" active-color="#13ce66" inactive-color="#c4c6c9" style="border-radius: 10px" :disabled="channelId === ''" @change="startPushStream"></el-switch>
      <span style="margin: 10px 10px 10px 30px">开启直播录像:</span>
      <el-switch v-model="playrecord" active-color="#13ce66" inactive-color="#c4c6c9" style="border-radius: 10px" :disabled="channelId === ''" @change="startPlayRecord"></el-switch>
    </el-row>
    <player ref="player" :playerinfo="playinfo" class="components-container"></player>
  </div>
</template>
<script>
import player from '@/views/components/player/player.vue';
import { startPlay, closeStream, listChannel } from '@/api/iot/channel';
import { startPlayRecord } from '@/api/iot/record';

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
      playinfo: {},
      playrecord: false,
      playrecording: false,
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
  destroyed() {
    console.log("destroyed");
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
      console.log('开始通道: [' + this.channelId + ']');
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
    startPlayRecord() {
      console.log('推流状态: [' + this.pushStream + ']');
      this.closeDestroy(true);
      setTimeout(() => {
        this.startPlayer();
      }, 500);
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
      if (!this.$refs.player.isInit) {
        this.$refs.player.init();
      }
      // this.$refs.player.registercallback('loadingTimeout', this.TimeoutCallback);
      // this.$refs.player.registercallback('delayTimeout', this.TimeoutCallback);
      // this.$refs.player.play("https://sample-videos.com/video321/flv/480/big_buck_bunny_480p_1mb.flv");
      if (this.playrecord) {

      } else {
        startPlay(this.deviceId, this.channelId).then((response) => {
          const res = response.data;
          this.streamId = res.streamId;
          this.playurl = res.playurl;
          console.log('开始推流: [' + this.streamId + ']');
          this.$refs.player.play(res.playurl);
          this.playing = true;
          this.playrecording = false;
          this.pushStream = true;
        });;
      }
    },
    closeStream(force) {
      if (force) {
        if (this.playing && this.streamId) {
          console.log('关闭推流3: [' + this.streamId + ']');
          closeStream(this.deviceId, this.channelId, this.streamId).then((res) => {
            this.streamId = '';
            this.ssrc = '';
            this.playurl = '';
            this.pushStream = false;
          });
          this.playing = false;
          this.playrecording = false;
        }
      } else {
        if (this.playrecording === true) {
          return;
        }
        if (this.playing && this.streamId) {
          console.log('关闭推流3: [' + this.streamId + ']');
          closeStream(this.deviceId, this.channelId, this.streamId).then((res) => {
            this.streamId = '';
            this.ssrc = '';
            this.playurl = '';
            this.pushStream = false;
          });
          this.playing = false;
          this.playrecording = false;
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
