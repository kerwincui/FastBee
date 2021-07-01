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

// 查询设备状态列表
export function listStatus(query) {
  return request({
    url: '/system/status/list',
    method: 'get',
    params: query
  })
}

// 查询设备状态详细
export function getStatus(deviceStatusId) {
  return request({
    url: '/system/status/' + deviceStatusId,
    method: 'get'
  })
}

// 查询设备最新状态
export function getNewStatus(deviceId){
  return request({
    url:'/system/status/new/'+deviceId,
    method:'get'
  })
}

// 新增设备状态
export function addStatus(data) {
  return request({
    url: '/system/status',
    method: 'post',
    data: data
  })
}

// 修改设备状态
export function updateStatus(data) {
  return request({
    url: '/system/status',
    method: 'put',
    data: data
  })
}

// 删除设备状态
export function delStatus(deviceStatusId) {
  return request({
    url: '/system/status/' + deviceStatusId,
    method: 'delete'
  })
}

// 导出设备状态
export function exportStatus(query) {
  return request({
    url: '/system/status/export',
    method: 'get',
    params: query
  })
}