import Vue from 'vue';
import Router from 'vue-router';
import { i18n } from '@/lang';

Vue.use(Router);

/* Layout */
import Layout from '@/layout';

/**
 * Note: 路由配置项
 *
 * hidden: true                     // 当设置 true 的时候该路由不会再侧边栏出现 如401，login等页面，或者如一些编辑页面/edit/1
 * alwaysShow: true                 // 当你一个路由下面的 children 声明的路由大于1个时，自动会变成嵌套的模式--如组件页面
 *                                  // 只有一个时，会将那个子路由当做根路由显示在侧边栏--如引导页面
 *                                  // 若你想不管路由下面的 children 声明的个数都显示你的根路由
 *                                  // 你可以设置 alwaysShow: true，这样它就会忽略之前定义的规则，一直显示根路由
 * redirect: noRedirect             // 当设置 noRedirect 的时候该路由在面包屑导航中不可被点击
 * name:'router-name'               // 设定路由的名字，一定要填写不然使用<keep-alive>时会出现各种问题
 * query: '{"id": 1, "name": "ry"}' // 访问路由的默认传递参数
 * roles: ['admin', 'common']       // 访问路由的角色权限
 * permissions: ['a:a:a', 'b:b:b']  // 访问路由的菜单权限
 * meta : {
    noCache: true                   // 如果设置为true，则不会被 <keep-alive> 缓存(默认 false)
    title: 'title'                  // 设置该路由在侧边栏和面包屑中展示的名字
    icon: 'svg-name'                // 设置该路由的图标，对应路径src/assets/icons/svg
    breadcrumb: false               // 如果设置为false，则不会在breadcrumb面包屑中显示
    activeMenu: '/system/user'      // 当路由设置了该属性，则会高亮相对应的侧边栏。
  }
 */

// 公共路由
export const constantRoutes = [
    {
        path: '/redirect',
        component: Layout,
        hidden: true,
        children: [
            {
                path: '/redirect/:path(.*)',
                component: () => import('@/views/redirect'),
            },
        ],
    },
    {
        path: '/bigScreen',
        component: () => import('@/views/bigScreen/home'),
        hidden: true,
        meta: { bigScreen: true },
    },
    {
        path: '/login',
        component: () => import('@/views/login'),
        hidden: true,
    },
    {
        path: '/register',
        component: () => import('@/views/register'),
        hidden: true,
    },
    {
        path: '/404',
        component: () => import('@/views/error/404'),
        hidden: true,
    },
    {
        path: '/401',
        component: () => import('@/views/error/401'),
        hidden: true,
    },
    {
        path: '',
        component: Layout,
        redirect: 'index',
        children: [
            {
                name: 'Index',
                path: 'index',
                component: () => import('@/views/index'),
                meta: { title: i18n.t('navbar.dashboard'), icon: 'home', affix: true },
            },
        ],
    },
    {
        path: '/user',
        component: Layout,
        hidden: true,
        redirect: 'noredirect',
        children: [
            {
                path: 'profile',
                component: () => import('@/views/system/user/profile/index'),
                name: 'Profile',
                meta: { title: i18n.t('navbar.personalCenter'), icon: 'user' },
            },
        ],
    },
];

// 动态路由，基于用户权限动态去加载
export const dynamicRoutes = [
    {
        path: '/system/user-auth',
        component: Layout,
        hidden: true,
        permissions: ['system:user:edit'],
        children: [
            {
                path: 'role/:userId(\\d+)',
                component: () => import('@/views/system/user/authRole'),
                name: 'AuthRole',
                meta: { title: i18n.t('navbar.assignRoles'), activeMenu: '/system/user' },
            },
        ],
    },
    {
        path: '/system/role-auth',
        component: Layout,
        hidden: true,
        permissions: ['system:role:edit'],
        children: [
            {
                path: 'user/:roleId(\\d+)',
                component: () => import('@/views/system/role/authUser'),
                name: 'AuthUser',
                meta: { title: i18n.t('navbar.assignUsers'), activeMenu: '/enterprise/role' },
            },
        ],
    },
    {
        path: '/system/dict-data',
        component: Layout,
        hidden: true,
        permissions: ['system:dict:list'],
        children: [
            {
                path: 'index/:dictId(\\d+)',
                component: () => import('@/views/system/dict/data'),
                name: 'Data',
                meta: { title: i18n.t('navbar.dictionaryData'), activeMenu: '/system/dict' },
            },
        ],
    },
    {
        path: '/monitor/job-log',
        component: Layout,
        hidden: true,
        permissions: ['monitor:job:list'],
        children: [
            {
                path: 'index/:jobId(\\d+)',
                component: () => import('@/views/monitor/job/log'),
                name: 'JobLog',
                meta: { title: i18n.t('navbar.dispatchingLog'), activeMenu: '/monitor/job' },
            },
        ],
    },
    {
        path: '/tool/gen-edit',
        component: Layout,
        hidden: true,
        permissions: ['tool:gen:edit'],
        children: [
            {
                path: 'index/:tableId(\\d+)',
                component: () => import('@/views/tool/gen/editTable'),
                name: 'GenEdit',
                meta: { title: i18n.t('navbar.modifyGenerationConfiguration'), activeMenu: '/tool/gen' },
            },
        ],
    },
    {
        path: '/iot',
        component: Layout,
        hidden: true,
        permissions: ['iot:device:add'],
        children: [
            {
                path: 'product-edit',
                component: () => import('@/views/iot/product/product-edit'),
                name: 'ProductEdit',
                meta: { title: i18n.t('navbar.editingProduct'), activeMenu: '/iot/product/list', noCache: true },
            },
            {
                path: 'device-edit',
                component: () => import('@/views/iot/device/device-edit'),
                name: 'DeviceEdit',
                meta: { title: i18n.t('navbar.editingEquipment'), activeMenu: '/iot/device/list', noCache: true },
            },
        ],
    },
];

// 防止连续点击多次路由报错
let routerPush = Router.prototype.push;
Router.prototype.push = function push(location) {
    return routerPush.call(this, location).catch((err) => err);
};

export default new Router({
    mode: 'history', // 去掉url中的#
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes,
});
