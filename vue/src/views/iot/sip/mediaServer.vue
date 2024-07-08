<template>
  <div id="mediaServer" style="padding: 6px">
    <el-card style="margin-bottom: 6px">
      <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="75px" style="margin-bottom: -20px">
        <el-form-item>
          <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="add"
            v-hasPermi="['iot:video:add']">新增节点</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="warning" plain icon="el-icon-refresh" size="mini" @click="getServerList">刷新</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card style="padding-bottom: 100px" v-loading="loading">
      <el-row :gutter="30">
        <el-col :xs="24" :sm="12" :md="12" :lg="8" :xl="6" v-for="(item, index) in mediaServerList" :key="index"
          style="margin-bottom: 30px; text-align: center">
          <el-card shadow="always" class="card-item">
            <el-row :gutter="10">
              <el-col :span="15">
                <el-descriptions :column="1" size="mini" style="white-space: nowrap">
                  <el-descriptions-item label="配置名称">
                    {{ item.serverId }}
                  </el-descriptions-item>
                  <el-descriptions-item label="服务器IP">
                    {{ item.ip }}
                  </el-descriptions-item>
                  <el-descriptions-item label="播放协议">
                    {{ item.protocol }}
                  </el-descriptions-item>
                  <el-descriptions-item label="创建时间">
                    {{ parseTime(item.createTime, '{y}-{m}-{d}') }}
                  </el-descriptions-item>
                </el-descriptions>
              </el-col>
              <el-col :span="8">
                <div style="margin-top: 10px">
                  <el-image :src="require('@/assets/images/zlm-logo.png')" fit="fit"></el-image>
                </div>
              </el-col>
            </el-row>
            <el-button-group style="margin-top: 10px">
              <el-button type="danger" size="mini" style="padding: 5px 10px" icon="el-icon-delete"
                v-hasPermi="['iot:video:remove']" @click="del(item)">删除</el-button>
              <el-button type="primary" size="mini" style="padding: 5px 15px" icon="el-icon-view" @click="view(item)"
                v-hasPermi="['iot:video:query']">查看</el-button>
              <el-button v-if="!istrue" type="success" size="mini" style="padding: 5px 15px" icon="el-icon-odometer"
                @click.native.prevent="edit(item)" v-hasPermi="['iot:video:edit']">编辑
              </el-button>
              <el-button v-else type="success" size="mini" style="padding: 5px 15px" icon="el-icon-odometer"
                :loading="true" disabled>重启中...
              </el-button>
            </el-button-group>
          </el-card>
        </el-col>
      </el-row>
      <el-empty description="暂无数据，请添加流媒体服务器节点" v-if="total == 0"></el-empty>
      <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize"
        :pageSizes="[12, 24, 36, 60]" @pagination="getServerList" />
    </el-card>

    <mediaServerEdit ref="mediaServerEdit" :edit-flag="editFlag"> </mediaServerEdit>
  </div>
</template>

<script>
import mediaServerEdit from '@/views/iot/sip/mediaServer-edit.vue';
import { delmediaServer, listmediaServer } from '@/api/iot/mediaServer';
export default {
  name: 'MediaServer',
  components: {
    mediaServerEdit,
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      editFlag: false,
      istrue: false,
      mediaServerList: [], //设备列表
      winHeight: window.innerHeight - 200,
      updateLooper: false,
      currentPage: 1,
      count: 15,
      num: this.getNumberByWidth(),
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
      },
    };
  },
  computed: {},
  mounted() {
    this.initData();
    //this.updateLooper = setInterval(this.initData, 2000);
  },
  destroyed() {
    clearTimeout(this.updateLooper);
  },
  methods: {
    initData: function () {
      this.getServerList();
    },
    pageNumChange: function (val) {
      this.queryParams.pageNum = val;
      this.getServerList();
    },
    pageSizeChange: function (val) {
      this.queryParams.pageSize = val;
      this.getServerList();
    },
    getServerList: function () {
      this.loading = true;
      listmediaServer(this.queryParams).then((response) => {
        this.mediaServerList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    add: function () {
      this.$refs.mediaServerEdit.openDialog(null, this.initData, this.editFlag);
      this.editFlag = true;
    },
    view: function (row) {
      this.$refs.mediaServerEdit.openDialog(row, this.initData, this.editFlag);
      this.editFlag = false;
    },
    edit: function (row) {
      this.$refs.mediaServerEdit.openDialog(row, this.initData, this.editFlag);
      this.editFlag = true;
    },
    delay: function () {
      let n = 5;
      // 定义定时器time
      const time = setInterval(() => {
        this.istrue = true;
        n--;
        // 如果n<0，清除定时器，禁用状态取消，文字提示为空（不显示）
        if (n < 0) {
          this.istrue = false;
          clearInterval(time);
        }
      }, 1000);
    },
    del: function (row) {
      const ids = row.id || this.ids;
      this.$modal
        .confirm('是否确认删除流媒体服务器配置编号为"' + ids + '"的数据项？')
        .then(function () {
          delmediaServer(ids);
        })
        .then(() => {
          this.getServerList();
          this.$modal.msgSuccess('删除成功');
        })
        .catch(() => { });
    },
    getNumberByWidth() {
      let candidateNums = [1, 2, 3, 4, 6, 8, 12, 24];
      let clientWidth = window.innerWidth - 30;
      let interval = 20;
      let itemWidth = 360;
      let num = (clientWidth + interval) / (itemWidth + interval);
      let result = Math.ceil(24 / num);
      let resultVal = 24;
      for (let i = 0; i < candidateNums.length; i++) {
        let value = candidateNums[i];
        if (i + 1 >= candidateNums.length) {
          return 24;
        }
        if (value <= result && candidateNums[i + 1] > result) {
          return value;
        }
      }
      return resultVal;
    },
  },
};
</script>

<style scoped>
.card-item {
  border-radius: 10px;
  padding: 15px 0px;
}
</style>
