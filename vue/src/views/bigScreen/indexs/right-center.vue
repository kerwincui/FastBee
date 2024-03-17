<template>
  <div style="display: flex">
    <dv-active-ring-chart :config="config" style="width: 250px; height: 250px" />
    <div style="font-size: 14px; margin-top: 80px; line-height: 10px; margin-left: -20px">
      <div style="margin-bottom: 20px; color: #23cdd8" v-if="mqtt">
        <div style="margin-bottom: 20px; color: #23cdd8">
          发送消息总数：
          <span style="color: #fff">{{ formatter(this.static['send_total']) }}</span>
          <dv-decoration-3 style="width: 200px; height: 20px; margin-top: 5px" />
        </div>
      </div>
      <div style="margin-bottom: 20px; color: #23cdd8" v-else>
        发送字节：
        <span style="color: #fff">{{ formatter(this.static['bytes.sent']) }}</span>
        <dv-decoration-3 style="width: 200px; height: 20px; margin-top: 5px" />
      </div>
      <div style="margin-bottom: 20px; color: #23cdd8" v-if="mqtt">
        接收消息总数：
        <span style="color: #fff">{{ formatter(this.static['receive_total']) }}</span>
        <dv-decoration-3 style="width: 200px; height: 20px; margin-top: 5px" />
      </div>
      <div style="margin-bottom: 20px; color: #23cdd8" v-else>
        接收字节：
        <span style="color: #fff">{{ formatter(this.static['bytes.received']) }}</span>
        <dv-decoration-3 style="width: 200px; height: 20px; margin-top: 5px" />
      </div>
    </div>
  </div>
</template>

<script>
import { statisticNettyMqtt } from '@/api/iot/netty';

export default {
  data() {
    return {
      // emqx统计信息
      static: {},
      config: {},
      timer: null,
      mqtt: this.$store.state.user.mqtt,
    };
  },
  created() {
    this.statisticMqtt();
  },
  computed: {},
  beforeDestroy() {
    this.clearData();
  },
  methods: {
    /** 查询emqx统计*/
    statisticMqtt() {
      if (this.mqtt) {
        statisticNettyMqtt().then((response) => {
          this.static = response.data;
          // 图标配置
          this.config = {
            data: [
              {
                name: '发送',
                value: this.static['send_total'],
              },
              {
                name: '接收',
                value: this.static['receive_total'],
              },
            ],
            color: ['#ffdb5c', '#67e0e3'],
          };
          // 轮询
          this.switper();
        });
      } else {
        // 图标配置
        this.config = {
          data: [
            {
              name: '发送',
              value: 32761563,
            },
            {
              name: '接收',
              value: 31910071,
            },
          ],
          color: ['#ffdb5c', '#67e0e3'],
        };
        // 轮询
        this.switper();
      }
    },
    // 数字格式化
    formatter(number) {
      if (number) {
        const numbers = number.toString().split('').reverse();
        const segs = [];
        while (numbers.length) segs.push(numbers.splice(0, 3).join(''));
        return segs.join(',').split('').reverse().join('');
      }
      return 1024;
    },
    clearData() {
      if (this.timer) {
        clearInterval(this.timer);
        this.timer = null;
      }
    },
    //轮询
    switper() {
      if (this.timer) {
        return;
      }
      let looper = (a) => {
        this.statisticMqtt();
      };
      this.timer = setInterval(looper, 60000);
    },
  },
};
</script>
