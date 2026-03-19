<template>
  <!-- 创建表 -->
  <el-dialog :title="$t('tool.createTable.670904-0')" :visible.sync="visible" width="800px" top="5vh" append-to-body>
    <span>{{ $t('tool.createTable.670904-1') }}</span>
    <el-input type="textarea" :rows="10" :placeholder="$t('tool.createTable.670904-2')" v-model="content"></el-input>
    <div slot="footer" class="dialog-footer">
      <el-button type="primary" @click="handleCreateTable">{{ $t('common.confirm') }}</el-button>
      <el-button @click="visible = false">{{ $t('common.cancel') }}</el-button>
    </div>
  </el-dialog>
</template>

<script>
import { createTable } from "@/api/tool/gen";
export default {
  data() {
    return {
      // 遮罩层
      visible: false,
      // 文本内容
      content: ""
    };
  },
  methods: {
    // 显示弹框
    show() {
      this.visible = true;
    },
    /** 创建按钮操作 */
    handleCreateTable() {
      if (this.content === "") {
        this.$modal.msgError(this.$i18n.t('tool.createTable.670904-3'));
        return;
      }
      createTable({ sql: this.content }).then(res => {
        this.$modal.msgSuccess(res.msg);
        if (res.code === 200) {
          this.visible = false;
          this.$emit("ok");
        }
      });
    }
  }
};
</script>
