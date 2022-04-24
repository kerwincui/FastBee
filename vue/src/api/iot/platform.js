import request from '@/utils/request'

// 查询第三方登录平台控制列表
export function listPlatform(query) {
  return request({
    url: '/iot/platform/list',
    method: 'get',
    params: query
  })
}

// 查询第三方登录平台控制详细
export function getPlatform(socialPlatformId) {
  return request({
    url: '/iot/platform/' + socialPlatformId,
    method: 'get'
  })
}

// 新增第三方登录平台控制
export function addPlatform(data) {
  return request({
    url: '/iot/platform',
    method: 'post',
    data: data
  })
}

// 修改第三方登录平台控制
export function updatePlatform(data) {
  return request({
    url: '/iot/platform',
    method: 'put',
    data: data
  })
}

// 删除第三方登录平台控制
export function delPlatform(socialPlatformId) {
  return request({
    url: '/iot/platform/' + socialPlatformId,
    method: 'delete'
  })
}

//解除绑定
export function unbind(socialUserId){
  return request({
    url: '/iot/social/unbind/' + socialUserId,
    method: 'get'
  })
}

//绑定跳转
export function bind(platform){
  return request({
    url: '/iot/social/bind/' + platform,
    method: 'get'
  })
}

//绑定
export function bindUser(bindId){
  return request({
    url: '/iot/social/bindId/' + bindId,
    method: 'get'
  })
}
