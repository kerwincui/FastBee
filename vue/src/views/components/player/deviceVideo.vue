<template>
  <div style="display: block; width: 1000px">
    <div style="display: flex">
      <el-row>
        <span style="margin-left: 10px" prop="channelName">通道：</span>
        <el-select v-model="channelId" placeholder="请选择" @change="changeChannel" style="width: 200px; margin-right: 10px" size="small">
          <el-option v-for="option in channelList" :key="option.value" :label="option.label" :value="option.value"></el-option>
        </el-select>
        <span style="overflow: auto; margin-left: 10px">日期：</span>
        <el-date-picker v-model="queryDate" type="date" size="small" value-format="yyyy-MM-dd" clearable placeholder="选择日期" style="width: 180px; margin-right: 10px" />
        <el-button-group style="margin: 0">
          <el-button size="mini" type="success" title="查看录像" @click="loadDevRecord()" :disabled="channelId === '' || !queryDate">
            <i class="el-icon-video-camera" />
            查看
          </el-button>
        </el-button-group>

        <span style="margin-left: 82px; overflow: auto">时间：</span>
        <el-button-group>
          <el-time-picker
            size="small"
            is-range
            align="left"
            v-model="timeRange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            placeholder="选择时间范围"
            @change="timePickerChange"
            style="width: 200px"
            :disabled="channelId === '' || !queryDate"
          ></el-time-picker>
        </el-button-group>
        <el-button-group style="margin: 0 0 0 10px">
          <el-button size="mini" type="primary" title="下载选定录像" @click="downloadRecord()" :disabled="channelId === '' || !timeRange">
            <i class="el-icon-download" />
            转存
          </el-button>
        </el-button-group>
      </el-row>
    </div>
    <player ref="playbacker" :playerinfo="playinfo" class="components-container"></player>
  </div>
</template>
<script>
import player from '@/views/components/player/player.vue';
import { listChannel, playback, closeStream, playbackSeek } from '@/api/iot/channel';
import { getDevRecord, startDownloadRecord } from '@/api/iot/record';

export default {
  name: 'DeviceVideo',
  components: {
    player,
  },
  data() {
    return {
      deviceId: '',
      channelId: '',
      streamId: '',
      ssrc: '',
      playurl: '',
      queryDate: '',
      playing: false,
      vodData: {},
      hisData: [],
      playinfo: {},
      channelList: [],
      playbackinfo: {},
      timeRange: null,
      startTime: null,
      endTime: null,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceSipId: null,
        channelSipId: null,
      },
    };
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
      if (this.deviceInfo && this.deviceInfo.deviceId !== 0) {
        this.queryParams.deviceSipId = this.deviceInfo.serialNumber;
        this.deviceId = this.device.serialNumber;
      }
    },
  },
  created() {
    this.queryParams.deviceSipId = this.device.serialNumber;
    this.deviceId = this.device.serialNumber;
    this.getList();
    this.playinfo = {
      playtype: 'playback',
      deviceId: this.device.serialNumber,
    };
  },
  beforeDestroy() {},
  destroyed() {
    this.closeStream();
  },
  methods: {
    /** 查询监控设备通道信息列表 */
    getList() {
      this.loading = true;
      listChannel(this.queryParams).then((response) => {
        this.channelList = response.rows.map((item) => {
          return { value: item.channelSipId, label: item.channelName };
        });
      });
    },
    // 改变通道
    changeChannel() {
      this.playinfo.channelId = this.channelId;
    },
    initUrl(data) {
      if (data) {
        this.streamId = data.ssrc;
        this.ssrc = data.ssrc;
        this.playurl = data.playurl;
      } else {
        this.streamId = '';
        this.ssrc = '';
        this.playurl = '';
      }
    },
    getBeijingTime(queryDate) {
      // 计算与UTC的时区差，对于北京时间来说是8小时
      let offset = 8 * 60 * 60 * 1000;
      // 加上时区差，得到北京时间
      let beijingTime = new Date(new Date(queryDate).getTime() - offset);
      return beijingTime.getTime();
    },
    // 录像控制
    loadDevRecord() {
      this.$refs.playbacker.registercallback('playbackSeek', this.seekPlay);
      if (this.queryDate === '' || this.queryDate === null){
        this.$message.error('请选择日期');
        return;
      }
      if (this.deviceId && this.channelId) {
        const date = this.getBeijingTime(this.queryDate);
        const start = date / 1000;
        const end = Math.floor((date + 24 * 60 * 60 * 1000 - 1) / 1000);
        const query = {
          start: start,
          end: end,
        };
        this.vodData = {
          start: start,
          end: end,
          base: start,
        };
        this.setTime(this.queryDate + ' 00:00:00', this.queryDate + ' 23:59:59');
        getDevRecord(this.deviceId, this.channelId, query).then((res) => {
          this.hisData = res.data.recordItems;
          if (res.data.recordItems) {
            const len = this.hisData.length;
            if (len > 0) {
              if (this.hisData[0].start < start) {
                this.hisData[0].start = start;
                this.vodData.start = start;
              } else {
                this.vodData.start = this.hisData[0].start;
              }
              if (this.hisData[0].end !== 0 &&this.hisData[0].end < end) {
                this.vodData.end = this.hisData[0].end;
              }
              this.playback();
            } else {
              this.$message({
                type: 'warning',
                message: '请确认设备是否支持录像，或者设备SD卡是否正确插入！',
              });
            }
          } else {
            this.$message({
              type: 'warning',
              message: '请确认设备是否支持录像，或者设备SD卡是否正确插入！',
            });
          }
        });
      }
    },
    /**录像播放*/
    playback() {
      const query = {
        start: this.vodData.start,
        end: this.vodData.end,
      };
      if (this.ssrc) {
        closeStream(this.deviceId, this.channelId, this.ssrc).then((res) => {
          playback(this.deviceId, this.channelId, query)
            .then((res) => {
              this.initUrl(res.data);
            })
            .finally(() => {
              this.triggerPlay(this.hisData);
            });
        });
      } else {
        playback(this.deviceId, this.channelId, query)
          .then((res) => {
            this.initUrl(res.data);
          })
          .finally(() => {
            this.triggerPlay(this.hisData);
          });
      }
    },
    /**触发播放*/
    triggerPlay(playTimes) {
      this.$refs.playbacker.playback(this.playurl, playTimes);
      this.playing = true;
    },
    /**录像播放*/
    seekPlay(s) {
      const curTime = this.vodData.base + s.hour * 3600 + s.min * 60 + s.second;
      const seekRange = curTime - this.vodData.start;
      if (this.ssrc) {
        const query = {
          seek: seekRange,
        };
        const _this = this;
        playbackSeek(this.deviceId, this.channelId, this.streamId, query).then((res) => {
          _this.$refs.playbacker.setPlaybackStartTime(curTime);
        });
      }
    },
    /**关闭播放流*/
    closeStream() {
      if (this.playing && this.streamId) {
        closeStream(this.deviceId, this.channelId, this.streamId).then((res) => {
          this.streamId = '';
          this.ssrc = '';
          this.playurl = '';
          this.playing = false;
        });
        // this.$refs.playbacker.destroy();
      }
    },
    /**销毁录像播放器*/
    destroy() {
      if (this.playing && this.streamId) {
        this.$refs.playbacker.destroy();
      }
    },
    closeDestroy() {
      this.closeStream();
      this.destroy();
    },
    /**设置时间*/
    timePickerChange: function (val) {
      this.setTime(val[0], val[1]);
    },
    setTime: function (startTime, endTime) {
      this.startTime = startTime;
      this.endTime = endTime;
      this.timeRange = [startTime, endTime];
    },
    /**下载录像*/
    downloadRecord: function () {
      const start = new Date(this.startTime).getTime() / 1000;
      const end = new Date(this.endTime).getTime() / 1000;
      const query = {
        startTime: start,
        endTime: end,
        speed: '4',
      };
      startDownloadRecord(this.deviceId, this.channelId, query).then((res) => {
        console.log('开始转存到流服务器：' + this.deviceId + ' : ' + this.channelId);
        if (res.code === 200 ) {
          this.$message({
            type: 'success',
            message: '转存到流服务器,请前往视频中心->录像管理查看！',
          });
        }
      });
    },
  },
};
</script>
