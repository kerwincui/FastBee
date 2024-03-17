<template>
  <div style="padding-top: 10px">
    <dv-capsule-chart :config="config" style="width: 430px; height: 230px" />
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

  mounted() {},
  beforeDestroy() {
    this.clearData();
  },
  methods: {
    /** 查询mqtt统计*/
    statisticMqtt() {
      if (this.mqtt) {
        statisticNettyMqtt().then((response) => {
          this.static = response.data;
          this.config = {
            data: [
              {
                name: '今日接收',
                value: this.static['today_received'],
              },
              {
                name: '今日发送',
                value: this.static['today_send'],
              },
              {
                name: '订阅总数',
                value: this.static['subscribe_total'],
              },
              {
                name: '发布消息',
                value: this.static['send_total'],
              },
              {
                name: '接收消息',
                value: this.static['receive_total'],
              },
              {
                name: '认证次数',
                value: this.static['auth_total'],
              },
              {
                name: '认证成功',
                value: this.static['auth_total'],
              },
            ],
            unit: '次数',
            showValue: true,
          };
          this.switper();
        });
      } else {
        this.config = {
          data: [
            {
              name: '今日接收',
              value: 6000,
            },
            {
              name: '今日发送',
              value: 5000,
            },
            {
              name: '订阅总数',
              value: 4000,
            },
            {
              name: '发布消息',
              value: 3000,
            },
            {
              name: '接收消息',
              value: 2000,
            },
            {
              name: '认证次数',
              value: 1000,
            },
            {
              name: '认证成功',
              value: 1000,
            },
          ],
          unit: '次数',
          showValue: true,
        };
        this.switper();
      }
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
