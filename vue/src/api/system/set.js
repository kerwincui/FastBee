/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
import request from '@/utils/request'

// 查询设备配置列表
export function listSet(query) {
  return request({
    url: '/system/set/list',
    method: 'get',
    params: query
  })
}

// 查询设备配置详细
export function getSet(deviceSetId) {
  return request({
    url: '/system/set/' + deviceSetId,
    method: 'get'
  })
}

// 查询设备最新配置
export function getNewSet(deviceId){
  return request({
    url:'system/set/new/'+deviceId,
    method:'get'
  })
}

// 新增设备配置
export function addSet(data) {
  return request({
    url: '/system/set',
    method: 'post',
    data: data
  })
}

// 修改设备配置
export function updateSet(data) {
  return request({
    url: '/system/set',
    method: 'put',
    data: data
  })
}

// 删除设备配置
export function delSet(deviceConfigId) {
  return request({
    url: '/system/set/' + deviceConfigId,
    method: 'delete'
  })
}

// 导出设备配置
export function exportSet(query) {
  return request({
    url: '/system/set/export',
    method: 'get',
    params: query
  })
}