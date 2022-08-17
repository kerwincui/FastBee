<template>
  <ul class="user_Overview flex" v-if="pageflag">
    <li class="user_Overview-item" style="color: #00fdfa">
      <div class="user_Overview_nums allnum ">
        <dv-digital-flop :config="config" style="width:100%;height:100%;" />
      </div>
      <p>总设备数</p>
    </li>
    <li class="user_Overview-item" style="color: #07f7a8">
      <div class="user_Overview_nums online">
        <dv-digital-flop :config="onlineconfig" style="width:100%;height:100%;" />
      </div>
      <p>在线数</p>
    </li>
    <li class="user_Overview-item" style="color: #e3b337">
      <div class="user_Overview_nums offline">
        <dv-digital-flop :config="offlineconfig" style="width:100%;height:100%;" />

      </div>
      <p>掉线数</p>
    </li>
    <li class="user_Overview-item" style="color: #f5023d">
      <div class="user_Overview_nums laramnum">
        <dv-digital-flop :config="laramnumconfig" style="width:100%;height:100%;" />
      </div>
      <p>告警次数</p>
    </li>
  </ul>
  <Reacquire v-else @onclick="getData" line-height="200px">
    重新获取
  </Reacquire>
</template>

<script>
  import {
    getDeviceStatistic,
  } from "@/api/iot/device";
  import {
    listAllDeviceShort,
  } from "@/api/iot/device";
  let style = {
    fontSize: 24
  }
  export default {
    data() {
      return {
        // 设备列表
        deviceList: [],
        // 设备统计信息
        deviceStatistic: {},
        // 设备总数
        deviceCount: 0,
        options: {},
        userOverview: {
          alarmNum: 0,
          offlineNum: 0,
          onlineNum: 0,
          totalNum: 0,
        },
        pageflag: true,
        timer: null,
        config: {
          number: [],
          content: '{nt}',
          style: {
            ...style,
            // stroke: "#00fdfa",
            fill: "#00fdfa",
          },
        },
        onlineconfig: {
          number: [0],
          content: '{nt}',
          style: {
            ...style,
            // stroke: "#07f7a8",
            fill: "#07f7a8",
          },
        },
        offlineconfig: {
          number: [0],
          content: '{nt}',
          style: {
            ...style,
            // stroke: "#e3b337",
            fill: "#e3b337",
          },
        },
        laramnumconfig: {
          number: [0],
          content: '{nt}',
          style: {
            ...style,
            // stroke: "#f5023d",
            fill: "#f5023d",
          },
        }

      };
    },
    filters: {
      numsFilter(msg) {
        return msg || 0;
      },
    },
    created() {
      this.getData()
    },
    mounted() {},
    beforeDestroy() {
      this.clearData()

    },
    methods: {
      clearData() {
        if (this.timer) {
          clearInterval(this.timer)
          this.timer = null
        }
      },
      getData() {
        this.pageflag = true;
        getDeviceStatistic().then(res => {
          // this.deviceStatistic = response.data;
          if (!this.timer) {
            console.log("设备总览", res);
          }
          if (res.code == 200) {
            this.userOverview = res.data;
            this.laramnumconfig = {
              ...this.laramnumconfig,
              number: [res.data.alertCount]
            }
            this.getAllDevice();
            // 轮询
            this.switper()
          } else {
            this.pageflag = false;
            this.$Message.warning(res.msg);
          }
        });
      },
      //轮询
      switper() {
        if (this.timer) {
          return
        }
        let looper = (a) => {
        //   this.getData()
        };
        this.timer = setInterval(looper, this.$store.state.settings.echartsAutoTime);
      },
      /**查询所有设备 */
      getAllDevice() {
        listAllDeviceShort(this.queryParams).then(response => {
          this.deviceList = response.rows;
          this.deviceCount = response.total;
          let online = this.deviceList.filter(x => x.status == 3).length;
          let offline = this.deviceList.length - online;
          this.config = {
            ...this.config,
            number: [this.deviceCount]
          }
          this.onlineconfig = {
            ...this.onlineconfig,
            number: [online]
          }
          this.offlineconfig = {
            ...this.offlineconfig,
            number: [offline]
          }
        })
      },
    },
  };

</script>
<style lang='scss' scoped>
  .user_Overview {
    li {
      flex: 1;

      p {
        text-align: center;
        height: 16px;
        font-size: 16px;
      }

      .user_Overview_nums {
        width: 100px;
        height: 100px;
        text-align: center;
        line-height: 100px;
        font-size: 22px;
        margin: 50px auto 30px;
        background-size: cover;
        background-position: center center;
        position: relative;

        &::before {
          content: '';
          position: absolute;
          width: 100%;
          height: 100%;
          top: 0;
          left: 0;
        }

        &.bgdonghua::before {
          animation: rotating 14s linear infinite;
        }
      }

      .allnum {

        // background-image: url("../../assets/img/left_top_lan.png");
        &::before {
          background-image: url("../../../assets/bigScreen/img/left_top_lan.png");

        }
      }

      .online {
        &::before {
          background-image: url("../../../assets/bigScreen/img/left_top_lv.png");

        }
      }

      .offline {
        &::before {
          background-image: url("../../../assets/bigScreen/img/left_top_huang.png");

        }
      }

      .laramnum {
        &::before {
          background-image: url("../../../assets/bigScreen/img/left_top_hong.png");

        }
      }
    }
  }

</style>
