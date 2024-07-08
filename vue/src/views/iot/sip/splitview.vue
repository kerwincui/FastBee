<template>
  <div style="padding: 6px">
    <el-card id="devicePosition" style="width: 100vw; height: 91vh" :body-style="{ padding: '0px' }">
      <el-container v-loading="loading" style="height: 91vh; " element-loading-text="拼命加载中">
        <el-aside width="250px" style="background-color: #ffffff;">
          <DeviceTree :clickEvent="clickEvent"></DeviceTree>
        </el-aside>
        <el-main style="padding: 0">
          <div height="5vh" style="text-align: left; font-size: 17px; line-height: 5vh;margin-bottom: 10px;">
            分屏:
            <el-button type="success" style="margin-left: 10px;" :class="{ active: spilt == 1 }" @click="spilt = 1"
              plain icon='el-icon-full-screen' size="mini">单屏 </el-button>
            <el-button type="info" style="margin-left: 10px;" :class="{ active: spilt == 4 }" @click="spilt = 4"
              icon="el-icon-menu" plain size="mini">四屏</el-button>
            <el-button type="warning" style="margin-left: 10px;" :class="{ active: spilt == 9 }" @click="spilt = 9"
              plain icon="el-icon-s-grid" size="mini">九屏</el-button>
          </div>
          <div style="height: 85vh; display: flex; flex-wrap: wrap">
            <div v-for="i in spilt" :key="i" class="play-box" :style="liveStyle"
              :class="{ redborder: playerIdx == i - 1 }" @click="playerIdx = i - 1">
              <div v-if="!videoUrl[i - 1]" style="color: #ffffff; font-size: 30px; font-weight: bold">{{ i }}</div>
              <player ref="player" v-else :videoUrl="videoUrl[i - 1]" fluent autoplay @screenshot="shot"
                @destroy="destroy" class="player-wrap" />
            </div>
          </div>
        </el-main>
      </el-container>
    </el-card>


  </div>
</template>

<script>
import player from '@/views/components/player/jessibuca.vue';
import DeviceTree from '@/views/components/player/DeviceTree.vue';
import { startPlay } from '@/api/iot/channel';

export default {
  name: 'SplitView',
  components: {
    player,
    DeviceTree,
  },
  data() {
    return {
      videoUrl: [''],
      spilt: 1, //分屏
      playerIdx: 0, //激活播放器
      updateLooper: 0, //数据刷新轮训标志
      count: 15,
      total: 0,
      loading: false,
    };
  },
  mounted() { },
  created() {
    this.checkPlayByParam();
  },

  computed: {
    liveStyle() {
      let style = { width: '81%', height: '99%' };
      switch (this.spilt) {
        case 4:
          style = { width: '40%', height: '49%' };
          break;
        case 9:
          style = { width: '27%', height: '32%' };
          break;
      }
      this.$nextTick(() => {
        for (let i = 0; i < this.spilt; i++) {
          const player = this.$refs.player;
          player && player[i] && player[i].updatePlayerDomSize();
        }
      });
      return style;
    },
  },
  watch: {
    spilt(newValue) {
      console.log('切换画幅;' + newValue);
      let that = this;
      for (let i = 1; i <= newValue; i++) {
        if (!that.$refs['player' + i]) {
          continue;
        }
        this.$nextTick(() => {
          if (that.$refs['player' + i] instanceof Array) {
            that.$refs['player' + i][0].resize();
          } else {
            that.$refs['player' + i].resize();
          }
        });
      }
      window.localStorage.setItem('split', newValue);
    },
    '$route.fullPath': 'checkPlayByParam',
  },
  destroyed() {
    clearTimeout(this.updateLooper);
  },
  methods: {
    destroy(idx) {
      console.log(idx);
      this.clear(idx.substring(idx.length - 1));
    },
    clickEvent: function (data) {
      if (data.channelSipId) {
        this.sendDevicePush(data);
      }
    },
    //通知设备上传媒体流
    sendDevicePush: function (itemData) {
      this.save(itemData);
      let deviceId = itemData.deviceSipId;
      let channelId = itemData.channelSipId;
      console.log('通知设备推流1：' + deviceId + ' : ' + channelId);
      let idxTmp = this.playerIdx;
      let that = this;
      this.loading = true;
      startPlay(deviceId, channelId)
        .then((response) => {
          console.log('开始播放：' + this.deviceId + ' : ' + this.channelId);
          console.log('流媒体信息：' + response.data);
          let res = response.data;
          console.log('playurl：' + res.playurl);
          itemData.playUrl = res.playurl;
          itemData.streamId = res.streamId;
          that.setPlayUrl(itemData.playUrl, idxTmp);
        })
        .finally(() => {
          that.loading = false;
        });
    },
    setPlayUrl(url, idx) {
      this.$set(this.videoUrl, idx, url);
      let _this = this;
      setTimeout(() => {
        window.localStorage.setItem('videoUrl', JSON.stringify(_this.videoUrl));
      }, 100);
    },
    checkPlayByParam() {
      let { deviceId, channelId } = this.$route.query;
      if (deviceId && channelId) {
        this.sendDevicePush({ deviceId, channelId });
      }
    },
    shot(e) {
      var base64ToBlob = function (code) {
        let parts = code.split(';base64,');
        let contentType = parts[0].split(':')[1];
        let raw = window.atob(parts[1]);
        let rawLength = raw.length;
        let uInt8Array = new Uint8Array(rawLength);
        for (let i = 0; i < rawLength; ++i) {
          uInt8Array[i] = raw.charCodeAt(i);
        }
        return new Blob([uInt8Array], {
          type: contentType,
        });
      };
      let aLink = document.createElement('a');
      let blob = base64ToBlob(e); //new Blob([content]);
      let evt = document.createEvent('HTMLEvents');
      evt.initEvent('click', true, true); //initEvent 不加后两个参数在FF下会报错  事件类型，是否冒泡，是否阻止浏览器的默认行为
      aLink.download = '截图';
      aLink.href = URL.createObjectURL(blob);
      aLink.click();
    },
    save(item) {
      let dataStr = window.localStorage.getItem('playData') || '[]';
      let data = JSON.parse(dataStr);
      data[this.playerIdx] = item;
      window.localStorage.setItem('playData', JSON.stringify(data));
    },
    clear(idx) {
      let dataStr = window.localStorage.getItem('playData') || '[]';
      let data = JSON.parse(dataStr);
      data[idx - 1] = null;
      console.log(data);
      window.localStorage.setItem('playData', JSON.stringify(data));
    },
  },
};
</script>
<style>
.btn {
  margin: 0 10px;
}

.btn:hover {
  color: #409eff;
}

.btn.active {
  color: #409eff;
}

.redborder {
  border: 2px solid red !important;
}

.play-box {
  background-color: #000000;
  border: 1px solid #505050;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 10px;
  position: relative;
  border-radius: 5px;
}

.player-wrap {
  position: absolute;
  top: 0px;
  height: 100% !important;
}
</style>
