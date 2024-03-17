<template>
  <div>
    <div ref="statsChart" style="height: 240px; margin: 20px 0 40px 0"></div>
  </div>
</template>

<script>
import { getNettyMqttStats } from '@/api/iot/netty';
export default {
  data() {
    return {
      timer: null,
      // emqx状态数据
      stats: {},
      mqtt: this.$store.state.user.mqtt,
    };
  },
  created() {
    this.getMqttStats();
  },
  beforeDestroy() {
    this.clearData();
  },
  methods: {
    /** 查询mqtt状态数据*/
    getMqttStats() {
      if (this.mqtt) {
        getNettyMqttStats().then((response) => {
          this.stats = response.data;
          this.drawStats();
          // 轮询
          this.switper();
        });
      } else {
        this.$nextTick(() => {
          // 初始值
          this.stats = {
            'connections.count': 800,
            'connections.max': 8000,
            'sessions.count': 700,
            'sessions.max': 7000,
            'topics.count': 600,
            'topics.max': 6000,
            'subscribers.count': 500,
            'subscribers.max': 5000,
            'routes.count': 400,
            'routes.max': 4000,
            'retained.count': 300,
            'retained.max': 3000,
          };
          this.drawStats();
          // 轮询
          this.switper();
        });
      }
    },
    /** EMQX状态统计 */
    drawStats() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(this.$refs.statsChart);
      var option;
      option = {
        animationDuration: 3000,
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow',
          },
          backgroundColor: 'rgba(58,73,116,0.7)',
          textStyle: {
            color: 'rgba(65,235,246,1)',
          },
        },
        legend: {
          textStyle: {
            color: 'rgba(65,235,246,1)',
          },
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true,
        },
        xAxis: {
          type: 'value',
          boundaryGap: [0, 0.01],
          axisLabel: {
            fontSize: 12,
            color: '#fff',
          },
          splitLine: {
            //网格线
            lineStyle: {
              type: 'dashed', //设置网格线类型 dotted：虚线   solid:实线
              color: 'rgba(65,235,246,1)', //网格线颜色
              width: 0.5,
            },
          },
        },
        yAxis: {
          type: 'category',
          axisLabel: {
            fontSize: 12,
            color: '#fff',
          },
          data: this.mqtt ? ['连接数量', '会话数量', '订阅数量', '路由数量', '保留消息'] : ['连接数量', '会话数量', '主题数量', '订阅数量', '路由数量', '保留消息'],
        },
        series: [
          {
            name: '当前数量',
            type: 'bar',
            data: this.mqtt
              ? [this.stats['connection_count'], this.stats['session_count'], this.stats['subscription_count'], this.stats['retain_count'], this.stats['retain_count']]
              : [this.stats['connections.count'], this.stats['sessions.count'], this.stats['topics.count'], this.stats['subscribers.count'], this.stats['routes.count'], this.stats['retained.count']],
            itemStyle: {
              color: '#67e0e3',
            },
          },
          {
            name: this.mqtt ? '累计总数' : '历史最大数',
            type: 'bar',
            data: this.mqtt
              ? [this.stats['connection_total'], this.stats['session_total'], this.stats['subscription_total'], this.stats['retain_total'], this.stats['retain_total']]
              : [this.stats['connections.max'], this.stats['sessions.max'], this.stats['topics.max'], this.stats['subscribers.max'], this.stats['routes.max'], this.stats['retained.max']],
            itemStyle: {
              color: '#ffdb5c',
            },
          },
        ],
      };
      option && myChart.setOption(option);
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
        this.getMqttStats();
      };
      this.timer = setInterval(looper, 60000);
    },
  },
};
</script>
