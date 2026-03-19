<template>
  <el-form ref="basicInfoForm" :model="info" :rules="rules" label-width="150px">
    <el-row>
      <el-col :span="12">
        <el-form-item :label="$t('tool.basicInfo.670905-0')" prop="tableName">
          <el-input :placeholder="$t('tool.basicInfo.670905-1')" v-model="info.tableName" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item :label="$t('tool.basicInfo.670905-2')" prop="tableComment">
          <el-input :placeholder="$t('tool.basicInfo.670905-3')" v-model="info.tableComment" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item :label="$t('tool.basicInfo.670905-4')" prop="className">
          <el-input :placeholder="$t('tool.basicInfo.670905-3')" v-model="info.className" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item :label="$t('tool.basicInfo.670905-5')" prop="functionAuthor">
          <el-input :placeholder="$t('tool.basicInfo.670905-3')" v-model="info.functionAuthor" />
        </el-form-item>
      </el-col>
      <el-col :span="24">
        <el-form-item :label="$t('tool.basicInfo.670905-6')" prop="remark">
          <el-input type="textarea" :rows="3" v-model="info.remark"></el-input>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>

<script>
export default {
  props: {
    info: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      rules: {
        tableName: [
          { required: true, message: this.$i18n.t('tool.basicInfo.670905-7'), trigger: "blur" }
        ],
        tableComment: [
          { required: true, message: this.$i18n.t('tool.basicInfo.670905-8'), trigger: "blur" }
        ],
        className: [
          { required: true, message: this.$i18n.t('tool.basicInfo.670905-9'), trigger: "blur" }
        ],
        functionAuthor: [
          { required: true, message: this.$i18n.t('tool.basicInfo.670905-10'), trigger: "blur" }
        ]
      }
    };
  }
};
</script>
