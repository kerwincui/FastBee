import request from '@/utils/request'

// 查询设备服务下发日志列表
export function listLog(query) {
  return request({
    url: '/iot/log/list',
    method: 'get',
    params: query
  })
}

// 查询设备服务下发日志详细
export function getLog(id) {
  return request({
    url: '/iot/log/' + id,
    method: 'get'
  })
}

// 新增设备服务下发日志
export function addLog(data) {
  return request({
    url: '/iot/log',
    method: 'post',
    data: data
  })
}

// 修改设备服务下发日志
export function updateLog(data) {
  return request({
    url: '/iot/log',
    method: 'put',
    data: data
  })
}

// 删除设备服务下发日志
export function delLog(id) {
  return request({
    url: '/iot/log/' + id,
    method: 'delete'
  })
}
