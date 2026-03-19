import Vue from 'vue';
import Element from 'element-ui';
import VueI18n from 'vue-i18n';
import locale from 'element-ui/lib/locale';
import enLocale from 'element-ui/lib/locale/lang/en';
import zhLocale from 'element-ui/lib/locale/lang/zh-CN';
import defaultSettings from '@/settings';

import { listLanguage } from '@/api/system/language';

Vue.use(VueI18n);

const zh = getJson(require.context('./zh-CN', true, /.\.json$/));
const en = getJson(require.context('./en-US', true, /.\.json$/));

const langs = {
  'zh-CN': Object.assign(zhLocale, zh, { language: '简体中文' }),
  'en-US': Object.assign(enLocale, en, { language: 'English' }),
};
const i18n = new VueI18n({
  locale: defaultSettings.language, // set locale
  messages: langs, // set locale langs
});

locale.use(Element, {
  i18n: (key, value) => i18n.t(key, value),
});
listLanguage({ pageNum: 1, pageSize: 1000 }).then((res) => {
  res.rows.forEach((row) => {
    if (langs[row.language]) langs[row.language].language = row.langName;
  });
});

function getJson(contexts) {
  let json = {};
  contexts.keys().forEach((name) => {
    json = Object.assign(json, contexts(name));
  });
  return json;
}

// 导出langs 给切换语言的时候用
export { i18n, langs };
