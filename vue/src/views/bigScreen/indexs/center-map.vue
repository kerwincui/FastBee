<template>
  <div class="centermap">
    <div class="maptitle">
      <div class="zuo"></div>
      <span class="titletext">{{ maptitle }}</span>
      <div class="you"></div>
    </div>
    <div class="mapwrap">
       <dv-border-box-13 >
      <div class="quanguo" @click="getData(-1)" v-if="code !== 'china' && userCode == -1">
        中国
      </div>

      <Echart id="CenterMap" :options="options" ref="CenterMap" />
      </dv-border-box-13>
    </div>
  </div>
</template>

<script>
import xzqCode from "../../../utils/bigScreen/map/xzqCode";
import { currentGET } from '@/api/bigScreen/modules'

import { GETNOBASE } from '@/api/bigScreen/api'
export default {
  data() {
    return {
      maptitle: "设备分布图",
      options: {},
      code: "china",
      userCode: -1,//-1 代表中国 用户权限的行政区code
      echartBindClick: false
    };
  },
  created() { },

  mounted() {
    // console.log(xzqCode);
    this.getData()


  },
  methods: {
    getData(code) {
      currentGET('big8',{regionCode:code}).then(res => {
        console.log('设备分布', res);
        if (res.success) {
          if (!code) {
            this.userCode = res.data.regionCode;
          }
          this.getGeojson(res.data.regionCode, res.data.dataList);
          this.mapclick();

        } else {
          this.$Message.warning(res.msg)
        }
      })
    },
    getGeojson(name, mydata) {

      if (name == -1) {
        name = 'china'
      }
      this.code = name;
      GETNOBASE("./map-geojson/" + name + ".json").then((res) => {
        // console.log('地图行政区划', name, res);
        let cityCenter = {};
        let arr = res.features;
        arr.map((item) => {
          cityCenter[item.properties.name] =
            item.properties.centroid || item.properties.center;
        });
        let newData = [];
        // console.log('中心点',cityCenter);
        mydata.map((item) => {
          if (cityCenter[item.name]) {
            let color = this.getColor(item.value);
            newData.push({
              name: item.name,
              value: cityCenter[item.name].concat(item.value),
              // itemStyle: {
              //   color: color,
              //   borderColor: color,
              //   // borderWidth: 4,
              // },
            });
          }
        });
        let mapjson = echarts.getMap(name);
        if (!mapjson) {
          echarts.registerMap(name, res);
        }
        this.init(name, mydata, newData);
      });
    },
    getColor(num) {
      if (num > 0 && num < 9) {
        return "#035cf5";
      } else if (num > 10 && num < 49) {
        return "#3375e4";
      } else if (num > 50 && num < 199) {
        return "#6797ef";
      } else if (num > 200 && num < 499) {
        return "#96b5ef";
      } else if (num > 500 && num < 9999) {
        return "#bacae8";
      } else if (num > 1000) {
        return "#3FF4FF";
      } else {
        return "";
      }
    },
    init(name, data, data2) {
      let top = 45;
      let zoom = 1.05;
      if (name == "china") {
        top = 140;
        zoom = 1.42;
      }

      let option = {
        backgroundColor: "rgba(0,0,0,0)",
        tooltip: {
          show: false,
        },
        legend: {
          show: false,
        },
        visualMap: {
          left: 20,
          bottom: 20,
          pieces: [
            { gte: 1000, label: "1000个以上" }, // 不指定 max，表示 max 为无限大（Infinity）。
            { gte: 600, lte: 999, label: "600-999个" },
            { gte: 200, lte: 599, label: "200-599个" },
            { gte: 50, lte: 199, label: "49-199个" },
            { gte: 10, lte: 49, label: "10-49个" },
            { lte: 9, label: "1-9个" }, // 不指定 min，表示 min 为无限大（-Infinity）。
          ],
          inRange: {
            // 渐变颜色，从小到大
            color: [
              "#c3d7df",
              "#5cb3cc",
              "#8abcd1",
              "#66a9c9",
              "#2f90b9",
              "#1781b5",
            ],
          },
          textStyle: {
            color: "#fff",
          },
        },
        geo: {
          map: name,
          roam: false,
          selectedMode: false, //是否允许选中多个区域
          zoom: zoom,
          top: top,
          aspectScale: 0.78,
          tooltip: {
            show: false,
          },
          label: {
            show: false,
          }, //地图中文字内容及样式控制
          itemStyle: {
            areaColor: "rgba(0,0,0,0)",
            borderColor: "rgba(0,0,0,0)",
          },
          emphasis: {
            disabled: true,
          },
        },
        series: [
          {
            name: "MAP",
            type: "map",
            mapType: name,
            aspectScale: 0.78,
            data: data,
            // data: [1,100],

            selectedMode: false, //是否允许选中多个区域
            zoom: zoom,
            geoIndex: 1,
            top: top,
            tooltip: {
              show: true,
              formatter: function (params) {
                if (params.data) {
                  return params.name + "：" + params.data["value"];
                } else {
                  return params.name;
                }
              },
              backgroundColor: "rgba(0,0,0,.6)",
              borderColor: "rgba(147, 235, 248, .8)",
              textStyle: {
                color: "#FFF",
              },
            },
            label: {
              show: false,
              color: "#000",
              // position: [-10, 0],
              formatter: function (val) {
                // console.log(val)
                if (val.data !== undefined) {
                  return val.name.slice(0, 2);
                } else {
                  return "";
                }
              },
              rich: {},
              emphasis: { show: false },
            },
            itemStyle: {
              borderColor: "rgba(147, 235, 248, .8)",
              borderWidth: 1,
              areaColor: {
                type: "radial",
                x: 0.5,
                y: 0.5,
                r: 0.8,
                colorStops: [
                  {
                    offset: 0,
                    color: "rgba(147, 235, 248, 0)", // 0% 处的颜色
                  },
                  {
                    offset: 1,
                    color: "rgba(147, 235, 248, .2)", // 100% 处的颜色
                  },
                ],
                globalCoord: false, // 缺为 false
              },
              shadowColor: "rgba(128, 217, 248, .3)",
              shadowOffsetX: -2,
              shadowOffsetY: 2,
              shadowBlur: 10,
              emphasis: {
                areaColor: "#389BB7",
                borderWidth: 1,
              },
            },
          },
          {
            data: data2,
            type: "effectScatter",
            coordinateSystem: "geo",
            symbolSize: function (val) {
              return 4;
              // return val[2] / 50;
            },
            legendHoverLink: true,
            showEffectOn: "render",
            rippleEffect: {
              // period: 4,
              scale: 6,
              color: "rgba(255,255,255, 1)",
              brushType: "fill",
            },
            tooltip: {
              show: true,
              formatter: function (params) {
                if (params.data) {
                  return params.name + "：" + params.data["value"][2];
                } else {
                  return params.name;
                }
              },
              backgroundColor: "rgba(0,0,0,.6)",
              borderColor: "rgba(147, 235, 248, .8)",
              textStyle: {
                color: "#FFF",
              },
            },
            label: {
              formatter: (param) => {
                return param.name.slice(0, 2);
              },

              fontSize: 11,
              offset: [0, 2],
              position: "bottom",
              textBorderColor: "#fff",
              textShadowColor: "#000",
              textShadowBlur: 10,
              textBorderWidth: 0,
              color: "#FFF",
              show: true,
            },
            // colorBy: "data",
            itemStyle: {
              color: "rgba(255,255,255,1)",
              borderColor: "rgba(2255,255,255,2)",
              borderWidth: 4,
              shadowColor: "#000",
              shadowBlur: 10,
            },
          },
        ],
      };
      this.options = option;
    },
    message(text) {
      this.$Message({
        text: text,
        type: 'warning'
      })
    },
    mapclick() {
      if (this.echartBindClick || this.userCode !== -1) return
      //单击切换到级地图，当mapCode有值,说明可以切换到下级地图
      this.$refs.CenterMap.chart.on("click", (params) => {
        // console.log(params);
        let xzqData = xzqCode[params.name];
        if (xzqData) {
          this.getData(xzqData.adcode);
        } else {
          this.message("暂无下级地市!");
        }
      });
      this.echartBindClick = true
    },
  },
};
</script>
<style lang='scss' scoped>
.centermap {
  margin-bottom: 30px;

  .maptitle {
    height: 60px;
    display: flex;
    justify-content: center;
    padding-top: 10px;
    box-sizing: border-box;

    .titletext {
      font-size: 28px;
      font-weight: 900;
      letter-spacing: 6px;
      background: linear-gradient(92deg,
          #0072ff 0%,
          #00eaff 48.8525390625%,
          #01aaff 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin: 0 10px;
    }

    .zuo,
    .you {
      background-size: 100% 100%;
      width: 29px;
      height: 20px;
      margin-top: 8px;
    }

    .zuo {
      background: url("../../../assets/bigScreen/img/xiezuo.png") no-repeat;
    }

    .you {
      background: url("../../../assets/bigScreen/img/xieyou.png") no-repeat;
    }
  }

  .mapwrap {
   
    height: 548px;
    width: 100%;
    // padding: 0 0 10px 0;
    box-sizing: border-box;
    position: relative;

    .quanguo {
      position: absolute;
      right: 20px;
      top: -46px;
      width: 80px;
      height: 28px;
      border: 1px solid #00eded;
      border-radius: 10px;
      color: #00f7f6;
      text-align: center;
      line-height: 26px;
      letter-spacing: 6px;
      cursor: pointer;
      box-shadow: 0 2px 4px rgba(0, 237, 237, 0.5),
        0 0 6px rgba(0, 237, 237, 0.4);
    }
  }
}
</style>