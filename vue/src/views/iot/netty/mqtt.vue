<template>
  <div style="padding: 6px">
    <el-card style="margin-bottom: 6px">
      <el-row :gutter="120">
        <el-col :xs="24" :sm="24" :md="24" :lg="8" :xl="8">
          <h3 style="font-weight: bold">Mqtt 统计指标</h3>
          <el-row :gutter="20" class="panel-group">
            <el-col :span="24" class="card-panel-col" style="margin-bottom: 17px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-orange">
                  <svg-icon icon-class="guide" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div>
                    <div class="card-panel-text">发送消息</div>
                    <count-to :start-val="0" :end-val="this.static['send_total']" :duration="3000" class="card-panel-num" />
                  </div>
                </div>
              </div>
            </el-col>
            <el-col :span="24" class="card-panel-col" style="margin-bottom: 18px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-green">
                  <svg-icon icon-class="receiver" class-name="card-panel-icon" />
                </div>

                <div class="card-panel-description">
                  <div>
                    <div class="card-panel-text">接收消息</div>
                    <count-to :start-val="0" :end-val="this.static['receive_total']" :duration="3000" class="card-panel-num" />
                  </div>
                </div>
              </div>
            </el-col>
            <el-col :span="24" class="card-panel-col" style="margin-bottom: 17px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-orange">
                  <svg-icon icon-class="authenticate" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">认证次数</div>
                  <count-to :start-val="0" :end-val="this.static['auth_total']" :duration="1000" class="card-panel-num" />
                </div>
              </div>
            </el-col>
            <el-col :span="24" class="card-panel-col" style="margin-bottom: 18px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-green">
                  <svg-icon icon-class="connect" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">连接次数</div>
                  <count-to :start-val="0" :end-val="this.static['connect_total']" :duration="1000" class="card-panel-num" />
                </div>
              </div>
            </el-col>
            <el-col :span="24" class="card-panel-col" style="margin-bottom: 17px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-orange">
                  <svg-icon icon-class="subscribe1" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">订阅次数</div>
                  <count-to :start-val="0" :end-val="this.static['subscribe_total']" :duration="2000" class="card-panel-num" />
                </div>
              </div>
            </el-col>

            <el-col :span="24" class="card-panel-col" style="margin-bottom: 17px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-green">
                  <svg-icon icon-class="message" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div>
                    <div class="card-panel-text">今日接收</div>
                    <count-to :start-val="0" :end-val="this.static['today_received']" :duration="3000" class="card-panel-num" />
                  </div>
                </div>
              </div>
            </el-col>
            <el-col :span="24" class="card-panel-col" style="margin-bottom: 17px">
              <div class="card-panel">
                <div class="card-panel-icon-wrapper icon-orange">
                  <svg-icon icon-class="subscribe1" class-name="card-panel-icon" />
                </div>
                <div class="card-panel-description">
                  <div class="card-panel-text">今日发送</div>
                  <count-to :start-val="0" :end-val="this.static['today_send']" :duration="2000" class="card-panel-num" />
                </div>
              </div>
            </el-col>
          </el-row>
        </el-col>

        <el-col :xs="24" :sm="24" :md="24" :lg="15" :xl="15">
          <div style="padding: 30px 0 85px">
            <div ref="pieTotal" style="height: 230px"></div>
          </div>
          <div ref="statsChart" style="height: 275px; margin: 20px 0 40px 0"></div>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
import { getNettyMqttStats, statisticNettyMqtt } from '@/api/iot/netty';
import CountTo from 'vue-count-to';

export default {
  name: 'Mqtt',
  components: {
    CountTo,
  },
  data() {
    return {
      // mqtt状态数据
      stats: {},
      // mqtt统计信息
      static: {},
    };
  },
  created() {
    this.getMqttStats();
    this.statisticMqtt();
  },
  methods: {
    /** 查询mqtt统计*/
    statisticMqtt() {
      statisticNettyMqtt().then((response) => {
        this.static = response.data;
        this.totalMqtt();
      });
    },
    /** 查询mqtt状态数据*/
    getMqttStats() {
      getNettyMqttStats().then((response) => {
        this.stats = response.data;
        this.drawStats();
      });
    },
    // 绘制mqtt饼图
    totalMqtt() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(this.$refs.pieTotal);
      var option;
      option = {
        title: {
          text: 'Mqtt消息',
          left: 'left',
          textStyle: {
            fontSize: 16,
          },
        },
        tooltip: {
          trigger: 'item',
        },
        legend: {
          orient: 'vertical',
          left: 'right',
        },
        color: ['#E6A23C', '#F56C6C', '#DDD'],
        series: [
          {
            name: 'Mqtt消息 %',
            type: 'pie',
            radius: '55%',
            label: {
              show: true,
            },
            labelLine: {
              normal: {
                position: 'inner',
                show: false,
              },
            },
            data: [
              {
                value: this.static['send_total'],
                name: '发送消息总数',
              },
              {
                value: this.static['receive_total'],
                name: '接收消息总数',
              },
            ],
          },
        ],
      };
      option && myChart.setOption(option);
    },
    /** 绘制mqtt状态统计 */
    drawStats() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$echarts.init(this.$refs.statsChart);
      var option;

      option = {
        title: {
          text: 'Mqtt 状态数据',
          textStyle: {
            fontSize: 18,
            color: '#000',
            fontWeight: 800,
          },
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow',
          },
        },
        legend: {},
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true,
        },
        xAxis: {
          type: 'value',
          boundaryGap: [0, 0.01],
        },
        yAxis: {
          type: 'category',
          axisLabel: {
            fontSize: 14,
          },
          data: ['连接数量', '会话数量', '订阅数量', '路由数量', '保留消息'],
        },
        series: [
          {
            name: '当前数量',
            type: 'bar',
            data: [this.stats['connection_count'], this.stats['session_count'], this.stats['subscription_count'], this.stats['retain_count'], this.stats['retain_count']],
            itemStyle: {
              color: '#67C23A',
            },
          },
          {
            name: '累计总数',
            type: 'bar',
            data: [this.stats['connection_total'], this.stats['session_total'], this.stats['subscription_total'], this.stats['retain_total'], this.stats['retain_total']],
            itemStyle: {
              color: '#409EFF',
            },
          },
        ],
      };

      option && myChart.setOption(option);
    },
  },
};
</script>

<style lang="scss" scoped>
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
        background: #34bfa3;
      }

      .icon-red {
        background: #f56c6c;
      }

      .icon-orange {
        background: #e6a23c;
      }
    }

    .icon-blue {
      color: #36a3f7;
    }

    .icon-green {
      color: #34bfa3;
    }

    .icon-red {
      color: #f56c6c;
    }

    .icon-orange {
      color: #e6a23c;
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
