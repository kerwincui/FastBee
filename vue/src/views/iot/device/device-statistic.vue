<template>
  <div style="padding-left: 20px">
    <el-row>
      <el-col :span="24">
        <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="75px">
          <el-form-item label="请选择设备从机:" label-width="120px" v-if="isSubDev">
            <el-select v-model="queryParams.slaveId" placeholder="请选择设备从机" @change="selectSlave">
              <el-option v-for="slave in slaveList" :key="slave.slaveId" :label="`${slave.deviceName} (${slave.slaveId})`"
                :value="slave.slaveId"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="时间范围">
            <el-date-picker v-model="daterangeTime" size="small" style="width: 240px" value-format="yyyy-MM-dd"
              type="daterange" range-separator="-" start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="getListHistory">查询</el-button>
          </el-form-item>
        </el-form>
      </el-col>
      <el-col :span="23">
        <div v-for="(item, index) in staticList" :key="index" style="margin-bottom: 30px">
          <el-card shadow="hover" :body-style="{ padding: '10px 0px', overflow: 'auto' }" v-loading="loading">
            <div ref="statisticMap" style="height: 300px; width: 1080px"></div>
          </el-card>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { listHistory } from '@/api/iot/deviceLog';

export default {
  name: 'device-statistic',
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
      if (this.deviceInfo && this.deviceInfo.deviceId != 0) {
        this.isSubDev = this.deviceInfo.subDeviceList && this.deviceInfo.subDeviceList.length > 0;
        this.queryParams.slaveId = this.deviceInfo.slaveId;
        this.queryParams.serialNumber = this.deviceInfo.serialNumber;
        this.slaveList = newVal.subDeviceList;
        // 监测数据
        if (this.isSubDev) {
          this.staticList = this.deviceInfo.cacheThingsModel['properties'].filter((item) => {
            return item.tempSlaveId == this.queryParams.slaveId;
          });
        } else {
          this.staticList = this.deviceInfo.staticList;
        }
        // 加载图表
        this.$nextTick(function () {
          // 绘制图表
          this.getStatistic();
        });
      }
    },
  },
  data() {
    return {
      loading: true,
      // 设备信息
      deviceInfo: {},
      // 统计物模型
      staticList: [],
      // 图表集合
      chart: [],
      // 激活时间范围
      daterangeTime: [this.getTime(), this.getTime()],
      // 查询参数
      queryParams: {
        serialNumber: null,
        identity: '',
        slaveId: undefined,
      },
      // 对象数组类型物模型暂存数据
      arrayData: [],
      // 子设备列表
      slaveList: [],
      isSubDev: false,
    };
  },
  mounted() {
    // 获取统计数据
    // this.getListHistory();
  },
  methods: {
    /** 获取当前日期 **/
    getTime() {
      let date = new Date();
      let y = date.getFullYear();
      let m = date.getMonth() + 1;
      let d = date.getDate();
      m = m < 10 ? '0' + m : m;
      d = d < 10 ? '0' + d : d;
      return y + '-' + m + '-' + d;
    },
    /* 获取监测历史数据*/
    getListHistory() {
      this.loading = true;
      this.queryParams.serialNumber = this.queryParams.slaveId ? this.deviceInfo.serialNumber + '_' + this.queryParams.slaveId : this.deviceInfo.serialNumber;
      if (null != this.daterangeTime && '' != this.daterangeTime) {
        this.queryParams.beginTime = this.daterangeTime[0];
        this.queryParams.endTime = this.daterangeTime[1] + ' 23:59';
      }
      listHistory(this.queryParams).then((res) => {
        for (let key in res.data) {
          for (let i = 0; i < this.staticList.length; i++) {
            if (key == this.staticList[i].id) {
              // 对象转数组
              let dataList = [];
              for (let j = 0; j < res.data[key].length; j++) {
                let item = [];
                item[0] = res.data[key][j].time;
                item[1] = res.data[key][j].value;
                dataList.push(item);
              }
              // 图表显示数据
              this.chart[i].setOption({
                series: [
                  {
                    data: dataList,
                  },
                ],
              });
            }
          }
        }
        this.loading = false;
      });
    },

    /**监测统计数据 */
    getStatistic() {
      let color = ['#1890FF', '#91CB74', '#FAC858', '#EE6666', '#73C0DE', '#3CA272', '#FC8452', '#9A60B4', '#ea7ccc'];
      for (let i = 0; i < this.staticList.length; i++) {
        // 设置宽度
        this.$refs.statisticMap[i].style.width = document.documentElement.clientWidth - 510 + 'px';
        this.chart[i] = this.$echarts.init(this.$refs.statisticMap[i]);
        var option;
        option = {
          animationDurationUpdate: 3000,
          tooltip: {
            trigger: 'axis',
          },
          title: {
            left: 'center',
            text: this.staticList[i].name + '统计 （单位 ' + (this.staticList[i].datatype && this.staticList[i].datatype.unit != undefined ? this.staticList[i].datatype.unit : '无') + '）',
          },
          grid: {
            top: '80px',
            left: '50px',
            right: '20px',
            bottom: '80px',
            // containLabel: true,
          },
          toolbox: {
            feature: {
              dataZoom: {
                yAxisIndex: 'none',
              },
              restore: {},
              saveAsImage: {},
            },
          },
          xAxis: {
            type: 'time',
          },
          yAxis: {
            type: 'value',
          },
          dataZoom: [
            {
              type: 'inside',
              start: 0,
              end: 100,
            },
            {
              start: 0,
              end: 100,
            },
          ],
          series: [
            {
              name: this.staticList[i].name,
              type: 'line',
              symbol: 'none',
              sampling: 'lttb',
              itemStyle: {
                color: i > 9 ? color[0] : color[i],
              },
              areaStyle: {},
              data: [],
            },
          ],
        };
        option && this.chart[i].setOption(option);
      }
    },

    /*选择从机*/
    selectSlave() {
      this.staticList = this.deviceInfo.cacheThingsModel['properties'].filter((item) => {
        return item.tempSlaveId == this.queryParams.slaveId;
      });
      // 加载图表
      this.$nextTick(function () {
        // 绘制图表
        this.getStatistic();
        // 获取统计数据
        this.getListHistory();
      });
    },
  },
};
</script>
