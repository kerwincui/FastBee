<template>
  <div style="padding-left: 20px">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-refresh" size="mini" @click="getList">{{ $t('refresh') }}</el-button>
      </el-col>
    </el-row>
    <el-table v-loading="loading" :data="channelList" size="mini">
      <el-table-column :label="$t('sip.channel.998532-0')" align="center" prop="deviceSipId" />
      <el-table-column :label="$t('sip.channel.998532-1')" align="center" prop="channelSipId" />
      <el-table-column :label="$t('sip.channel.998532-2')" min-width="120">
        <template v-slot:default="scope">
          <el-image v-if="isVideoChannel(scope.row)" :src="getSnap(scope.row)" :preview-src-list="getBigSnap(scope.row)" :fit="'contain'" style="width: 60px">
            <div slot="error" class="image-slot">
              <i class="el-icon-picture-outline"></i>
            </div>
          </el-image>
        </template>
      </el-table-column>
      <el-table-column :label="$t('sip.channel.998532-3')" align="center" prop="channelName" />
      <el-table-column :label="$t('sip.channel.998532-4')" align="center" prop="model" />
      <el-table-column :label="$t('sip.channel.998532-9')" align="center" prop="streamPush" >
        <template slot-scope="scope">
          <el-tag type="warning" v-if="scope.row.streamPush === 0">{{ $t('sip.channel.998532-10') }}</el-tag>
          <el-tag type="success" v-if="scope.row.streamPush === 1">{{ $t('sip.channel.998532-11') }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column :label="$t('sip.channel.998532-12')" align="center" prop="streamRecord" >
        <template slot-scope="scope">
          <el-tag type="warning" v-if="scope.row.streamRecord === 0">{{ $t('sip.channel.998532-10') }}</el-tag>
          <el-tag type="success" v-if="scope.row.streamRecord === 1">{{ $t('sip.channel.998532-14') }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column :label="$t('sip.channel.998532-15')" align="center" prop="videoRecord" >
        <template slot-scope="scope">
          <el-tag type="warning" v-if="scope.row.videoRecord === 0">{{ $t('sip.channel.998532-10') }}</el-tag>
          <el-tag type="success" v-if="scope.row.videoRecord === 1">{{ $t('sip.channel.998532-17') }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column :label="$t('sip.channel.998532-5')" align="center" prop="status" width="80">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sip_gen_status" :value="scope.row.status" size="mini" />
        </template>
      </el-table-column>
      <el-table-column :label="$t('opation')" align="center" width="120" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button size="small" type="success" icon="el-icon-video-play" style="padding: 5px" :disabled="scope.row.status !== 2" @click="sendDevicePush(scope.row)">{{ $t('sip.channel.998532-6') }}</el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listChannel, getChannel, delChannel } from '@/api/iot/channel';
export default {
  name: 'Channel',
  dicts: ['sip_gen_status', 'video_type', 'channel_type'],
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
        this.queryParams.deviceSipId = this.deviceInfo.serialNumber;
      }
    },
  },
  data() {
    return {
      loadSnap: {},
      // 设备信息
      deviceInfo: {},
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 监控设备通道信息表格数据
      channelList: [],
      // 弹出层标题
      title: '',
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        deviceSipId: null,
      },
      // 表单参数
      form: {},
    };
  },
  created() {
    this.queryParams.deviceSipId = this.device.serialNumber;
    this.getList();
  },
  methods: {
    //通知设备上传媒体流
    sendDevicePush: function (itemData) {
      var data = { tabName: 'videoLive', channelId: itemData.channelSipId };
      this.$emit('playerEvent', data);
      console.log('通知设备推流：' + itemData.deviceSipId + ' : ' + itemData.channelSipId);
    },
    /** 查询监控设备通道信息列表 */
    getList() {
      this.loading = true;
      listChannel(this.queryParams).then((response) => {
        console.log(response);
        this.channelList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        channelId: null,
        channelSipId: null,
        deviceSipId: null,
        channelName: null,
        manufacture: null,
        model: null,
        owner: null,
        civilcode: null,
        block: null,
        address: null,
        parentid: null,
        ipaddress: null,
        port: null,
        password: null,
        ptztype: null,
        ptztypetext: null,
        status: 0,
        longitude: null,
        latitude: null,
        streamid: null,
        subcount: null,
        parental: 1,
        hasaudio: 1,
      };
      this.resetForm('form');
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
        /** 修改按钮操作 */
        handleUpdate(row) {
            this.reset();
            const channelId = row.channelId || this.ids;
            getChannel(channelId).then((response) => {
                this.form = response.data;
                this.open = true;
                this.title = this.$t('sip.channel.998532-7');
            });
        },
        /** 删除按钮操作 */
        handleDelete(row) {
            const channelIds = row.channelId || this.ids;
            this.$modal
                .confirm(this.$t('sip.channel.998532-8', [channelIds]))
                .then(function () {
                    return delChannel(channelIds);
                })
                .then(() => {
                    this.getList();
                    this.$modal.msgSuccess(this.$t('sip.channel.998532-18'));
                })
                .catch(() => {});
        },
    getSnap: function (row) {
      console.log('getSnap:' + process.env.VUE_APP_BASE_API + '/profile/snap/' + row.deviceSipId + '_' + row.channelSipId + '.jpg');
      return process.env.VUE_APP_BASE_API + '/profile/snap/' + row.deviceSipId + '_' + row.channelSipId + '.jpg';
    },
    getBigSnap: function (row) {
      return [this.getSnap(row)];
    },
    isVideoChannel: function (row) {
      let channelType = row.channelSipId.substring(10, 13);
      // 111-DVR编码;112-视频服务器编码;118-网络视频录像机(NVR)编码;131-摄像机编码;132-网络摄像机(IPC)编码
      return !(channelType !== '111' && channelType !== '112' && channelType !== '118' && channelType !== '131' && channelType !== '132');
    },
  },
};
</script>
