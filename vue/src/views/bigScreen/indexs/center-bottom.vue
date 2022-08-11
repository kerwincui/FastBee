<template>
  <div class="center_bottom">
    <Echart :options="options" id="bottomLeftChart" class="echarts_bottom"></Echart>
  </div>
</template>

<script>
import {currentGET} from '@/api/bigScreen/modules'
export default {
  data() {
    return {
      options: {},
    };
  },
  props: {

  },
  mounted() {
    this.getData()
  },
  methods: {
    getData() {
      this.pageflag = true
      currentGET('big6', { companyName: this.companyName }).then(res => {
        console.log('安装计划', res);
        if (res.success) {
          this.init(res.data)
        } else {
          this.pageflag = false
          this.$Message({
            text: res.msg,
            type: 'warning'
          })
        }
      })
    },
    init(newData) {
      this.options = {
        tooltip: {
          trigger: "axis",
          backgroundColor: "rgba(0,0,0,.6)",
          borderColor: "rgba(147, 235, 248, .8)",
          textStyle: {
            color: "#FFF",
          },
          formatter: function (params) {
              // 添加单位
                var result = params[0].name + "<br>";
                params.forEach(function (item) {
                    if (item.value) {
                      if(item.seriesName=="安装率"){
                        result += item.marker + " " + item.seriesName + " : " + item.value + "%</br>";
                      }else{
                        result += item.marker + " " + item.seriesName + " : " + item.value + "个</br>";
                      }
                    } else {
                        result += item.marker + " " + item.seriesName + " :  - </br>";
                    }
                });
                return result;
              }
        },
        legend: {
          data: ["已安装", "计划安装", "安装率"],
          textStyle: {
            color: "#B4B4B4"
          },
          top: "0"
        },
        grid: {
          left: "50px",
          right: "40px",
          bottom: "30px",
          top: "20px",
        },
        xAxis: {
          data: newData.category,
          axisLine: {
            lineStyle: {
              color: "#B4B4B4"
            }
          },
          axisTick: {
            show: false
          }
        },
        yAxis: [
          {
            splitLine: { show: false },
            axisLine: {
              lineStyle: {
                color: "#B4B4B4"
              }
            },

            axisLabel: {
              formatter: "{value}"
            }
          },
          {
            splitLine: { show: false },
            axisLine: {
              lineStyle: {
                color: "#B4B4B4"
              }
            },
            axisLabel: {
              formatter: "{value}% "
            }
          }
        ],
        series: [
          
          {
            name: "已安装",
            type: "bar",
            barWidth: 10,
            itemStyle: {
              normal: {
                barBorderRadius: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: "#956FD4" },
                  { offset: 1, color: "#3EACE5" }
                ])
              }
            },
            data: newData.barData
          },
          {
            name: "计划安装",
            type: "bar",
            barGap: "-100%",
            barWidth: 10,
            itemStyle: {
              normal: {
                barBorderRadius: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: "rgba(156,107,211,0.8)" },
                  { offset: 0.2, color: "rgba(156,107,211,0.5)" },
                  { offset: 1, color: "rgba(156,107,211,0.2)" }
                ])
              }
            },
            z: -12,
            data: newData.lineData
          },
          {
            name: "安装率",
            type: "line",
            smooth: true,
            showAllSymbol: true,
            symbol: "emptyCircle",
            symbolSize: 8,
            yAxisIndex: 1,
            itemStyle: {
              normal: {
                color: "#F02FC2"
              }
            },
            data: newData.rateData
          },
        ]
      }
    }
  },

}
</script>
<style lang="scss" scoped>
.center_bottom {
  width: 100%;
  height: 100%;

  .echarts_bottom {
    width: 100%;
    height: 100%;
  }
}
</style>