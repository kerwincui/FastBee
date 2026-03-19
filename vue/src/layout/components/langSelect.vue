<template>
  <div class="lang-select">
    <el-dropdown @command="chooseLang">
      <div class="title-wrap">
        <svg-icon icon-class="globe" />
        <span class="lang">{{ language }}</span>
      </div>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item v-for="(item, key, i) in langs" :key="i" :command="key">
          <span style="font-size: 14px">{{ item.language }}</span>
        </el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>

<script>
import { langs } from '@/lang';
import { addOrUpdate } from '@/api/system/language';
import { getToken } from '@/utils/auth';
import defaultSettings from '@/settings';

export default {
  name: 'langSelect',
  data() {
    return {
      langs: langs,
      language: '',
    };
  },
  methods: {
    setLanguage() {
      console.log(defaultSettings.language);
      const lang = this.$i18n.locale || defaultSettings.language;
      console.log('🚀 ~ setLanguage ~ lang:', lang);
      this.language = this.langs[lang].language || '';
      if (getToken()) addOrUpdate({ language: lang });
      this.$store.dispatch('settings/setLang', lang);
    },
    chooseLang(lang) {
      this.$i18n.locale = lang;
      this.setLanguage();
      window.location.reload();
    },
  },
  created() {
    this.setLanguage();
  },
};
</script>

<style lang="scss" scoped>
.lang-select {
  .title-wrap {
    font-size: 14px;

    .lang {
      margin-left: 6px;
    }
  }
}
</style>
