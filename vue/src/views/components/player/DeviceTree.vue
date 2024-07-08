<template>
  <div id="DeviceTree" style="width: 100%; height: 100%; background-color: #ffffff; overflow: auto">
    <div style="line-height: 3vh;margin-bottom: 10px;font-size: 17px;">设备列表</div>
    <el-tree ref="tree" :props="defaultProps" :current-node-key="selectchannelId" :default-expanded-keys="expandIds"
      :highlight-current="true" @node-click="handleNodeClick" :load="loadNode" lazy node-key="id"
      style="min-width: 100%; display: inline-block !important">
      <span class="custom-tree-node" slot-scope="{ node, data }" style="width: 100%">
        <span v-if="node.data.type === 0 && node.data.online" title="在线设备"
          class="device-online iconfont icon-jiedianleizhukongzhongxin2"></span>
        <span v-if="node.data.type === 0 && !node.data.online" title="离线设备"
          class="device-offline iconfont icon-jiedianleizhukongzhongxin2"></span>
        <span v-if="node.data.type === 3 && node.data.online" title="在线通道"
          class="device-online iconfont icon-shebeileijiankongdian"></span>
        <span v-if="node.data.type === 3 && !node.data.online" title="离线通道"
          class="device-offline iconfont icon-shebeileijiankongdian"></span>
        <span v-if="node.data.type === 4 && node.data.online" title="在线通道-球机"
          class="device-online iconfont icon-shebeileiqiuji"></span>
        <span v-if="node.data.type === 4 && !node.data.online" title="离线通道-球机"
          class="device-offline iconfont icon-shebeileiqiuji"></span>
        <span v-if="node.data.type === 5 && node.data.online" title="在线通道-半球"
          class="device-online iconfont icon-shebeileibanqiu"></span>
        <span v-if="node.data.type === 5 && !node.data.online" title="离线通道-半球"
          class="device-offline iconfont icon-shebeileibanqiu"></span>
        <span v-if="node.data.type === 6 && node.data.online" title="在线通道-枪机"
          class="device-online iconfont icon-shebeileiqiangjitongdao"></span>
        <span v-if="node.data.type === 6 && !node.data.online" title="离线通道-枪机"
          class="device-offline iconfont icon-shebeileiqiangjitongdao"></span>
        <span v-if="node.data.online" style="padding-left: 1px" class="device-online">{{ node.label }}</span>
        <span v-if="!node.data.online" style="padding-left: 1px" class="device-offline">{{ node.label }}</span>
      </span>
    </el-tree>
  </div>
</template>

<script>
import { listSipDeviceChannel } from '@/api/iot/sipdevice';
import { listDeviceShort } from '@/api/iot/device';

export default {
  name: 'DeviceTree',
  data() {
    return {
      // 总条数
      total: 0,
      // 监控设备通道信息表格数据
      channelList: [],
      DeviceData: [],
      expandIds: [],
      selectData: {},
      selectchannelId: '',
      defaultProps: {
        children: 'children',
        label: 'name',
        isLeaf: 'isLeaf',
      },
      queryParams: {
        pageNum: 1,
        pageSize: 100,
        status: 3,
        deviceType: 3,
      },
    };
  },
  props: ['onlyCatalog', 'clickEvent'],
  mounted() {
    this.selectchannelId = '';
    this.expandIds = ['0'];
  },
  methods: {
    handleNodeClick(data, node, element) {
      this.selectData = node.data;
      this.selectchannelId = node.data.value;
      if (node.level !== 0) {
        let deviceNode = this.$refs.tree.getNode(data.userData.channelSipId);
        if (typeof this.clickEvent == 'function' && node.level > 1) {
          this.clickEvent(deviceNode.data.userData);
        }
      }
    },
    loadNode: function (node, resolve) {
      if (node.level === 0) {
        listDeviceShort(this.queryParams).then((response) => {
          const data = response.rows;
          if (data.length > 0) {
            let nodeList = [];
            for (let i = 0; i < data.length; i++) {
              let node = {
                name: data[i].deviceName,
                isLeaf: false,
                id: data[i].serialNumber,
                type: 0,
                online: data[i].status === 3,
                userData: data[i],
              };
              nodeList.push(node);
            }
            resolve(nodeList);
          } else {
            resolve([]);
          }
        });
      } else {
        let channelArray = [];
        listSipDeviceChannel(node.data.userData.serialNumber).then((res) => {
          if (res.data != null) {
            channelArray = channelArray.concat(res.data);
            this.channelDataHandler(channelArray, resolve);
          } else {
            resolve([]);
          }
        });
      }
    },
    channelDataHandler: function (data, resolve) {
      if (data.length > 0) {
        let nodeList = [];
        for (let i = 0; i < data.length; i++) {
          let item = data[i];
          let channelType = item.id.substring(10, 13);
          console.log('channelType: ' + channelType);
          let type = 3;
          if (item.id.length <= 10) {
            type = 2;
          } else {
            if (item.id.length > 14) {
              let channelType = item.id.substring(10, 13);
              // 111-DVR编码;112-视频服务器编码;118-网络视频录像机(NVR)编码;131-摄像机编码;132-网络摄像机(IPC)编码
              if (channelType !== '111' && channelType !== '112' && channelType !== '118' && channelType !== '131' && channelType !== '132') {
                type = -1;
                // 1-球机;2-半球;3-固定枪机;4-遥控枪机
              } else if (item.basicData.ptztype === 1) {
                type = 4;
              } else if (item.basicData.ptztype === 2) {
                type = 5;
              } else if (item.basicData.ptztype === 3 || item.basicData.ptztype === 4) {
                type = 6;
              }
            } else {
              if (item.basicData.subCount > 0 || item.basicData.parental === 1) {
                type = 2;
              }
            }
          }
          let node = {
            name: item.name || item.id,
            isLeaf: true,
            id: item.id,
            deviceId: item.deviceId,
            type: type,
            online: item.status === 2,
            userData: item.basicData,
          };

          if (channelType === '111' || channelType === '112' || channelType === '118' || channelType === '131' || channelType === '132') {
            nodeList.push(node);
          }
        }
        resolve(nodeList);
      } else {
        resolve([]);
      }
    },
    reset: function () {
      this.$forceUpdate();
    },
  },
  destroyed() { },
};
</script>

<style>
.device-tree-main-box {
  text-align: left;
}

.device-online {
  color: #252525;
}

.device-offline {
  color: #727272;
}
</style>
