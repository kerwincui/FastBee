import router from './router'
import store from './store'
import { Message } from 'element-ui'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { getToken } from '@/utils/auth'
import { isRelogin } from '@/utils/request'
import { PASSWORD_CHANGE_ROUTE } from '@/utils/passwordChange'
import { loadLanguageNames } from '@/lang'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login', '/auth-redirect', '/bind', '/register']

router.beforeEach((to, from, next) => {
  NProgress.start()
  if (getToken()) {
    to.meta.title && store.dispatch('settings/setTitle', to.meta.title)
    /* has token*/
    if (to.path === '/login') {
      next({ path: '/' })
      NProgress.done()
    } else {
      if (store.getters.roles.length === 0) {
        isRelogin.show = true
        // 判断当前用户是否已拉取完user_info信息
        store.dispatch('GetInfo').then(() => {
          isRelogin.show = false
          // Resolve the server-owned password state before mounting any business page.
          if (store.state.user.needChangePwd) {
            if (to.path === PASSWORD_CHANGE_ROUTE) next()
            else next({ path: PASSWORD_CHANGE_ROUTE, replace: true })
            return
          }
          store.dispatch('GenerateRoutes').then(accessRoutes => {
            // 根据roles权限生成可访问的路由表
            router.addRoutes(accessRoutes) // 动态添加可访问路由表
            next(to.path === PASSWORD_CHANGE_ROUTE
              ? { path: '/index', replace: true }
              : { ...to, replace: true }) // hack方法 确保addRoutes已完成
          })
        }).catch(err => {
            store.dispatch('LogOut').then(() => {
              Message.error(err)
              next({ path: '/' })
            })
          })
      } else if (store.state.user.needChangePwd) {
        if (to.path === PASSWORD_CHANGE_ROUTE) next()
        else next({ path: PASSWORD_CHANGE_ROUTE, replace: true })
      } else if (to.path === PASSWORD_CHANGE_ROUTE) {
        next({ path: '/index', replace: true })
      } else {
        next()
      }
    }
  } else {
    // 没有token
    if (whiteList.indexOf(to.path) !== -1) {
      // 在免登录白名单，直接进入
      next()
    } else {
      next(`/login?redirect=${to.fullPath}`) // 否则全部重定向到登录页
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  NProgress.done()
  // Avoid the eager language-list request before GetInfo has resolved the login state.
  if (!getToken() || !store.state.user.needChangePwd) loadLanguageNames()
})
