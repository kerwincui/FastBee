import defaultSettings from '@/settings';
import Cookies from 'js-cookie';

const { sideTheme, showSettings, topNav, tagsView, fixedHeader, sidebarLogo, dynamicTitle, language } = defaultSettings;

const storageSetting = JSON.parse(localStorage.getItem('layout-setting')) || '';
const state = {
    title: '',
    theme: storageSetting.theme || '#409EFF',
    sideTheme: storageSetting.sideTheme || sideTheme,
    showSettings: showSettings,
    topNav: storageSetting.topNav === undefined ? topNav : storageSetting.topNav,
    tagsView: storageSetting.tagsView === undefined ? tagsView : storageSetting.tagsView,
    fixedHeader: storageSetting.fixedHeader === undefined ? fixedHeader : storageSetting.fixedHeader,
    sidebarLogo: storageSetting.sidebarLogo === undefined ? sidebarLogo : storageSetting.sidebarLogo,
    dynamicTitle: storageSetting.dynamicTitle === undefined ? dynamicTitle : storageSetting.dynamicTitle,
    language: language,
};
const mutations = {
    CHANGE_SETTING: (state, { key, value }) => {
        if (state.hasOwnProperty(key)) {
            state[key] = value;
        }
    },
    SET_LANG: (state, lang) => {
        state.language = lang;
        Cookies.set('language', lang);
    },
};

const actions = {
    // 修改布局设置
    changeSetting({ commit }, data) {
        commit('CHANGE_SETTING', data);
    },
    // 设置网页标题
    setTitle({ commit }, title) {
        state.title = title;
    },
    setLang({ commit }, lang) {
        commit('SET_LANG', lang);
    },
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
};
