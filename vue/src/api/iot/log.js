import request from '@/utils/request'

// 查询设备日志列表
export function listLog(query) {
  return request({
    url: '/iot/log/list',
    method: 'get',
    params: query
  })
}

// 查询设备日志详细
export function getLog(deviceLogId) {
  return request({
    url: '/iot/log/' + deviceLogId,
    method: 'get'
  })
}

// 新增设备日志
export function addLog(data) {
  return request({
    url: '/iot/log',
    method: 'post',
    data: data
  })
}

// 修改设备日志
export function updateLog(data) {
  return request({
    url: '/iot/log',
    method: 'put',
    data: data
  })
}

// 删除设备日志
export function delLog(deviceLogId) {
  return request({
    url: '/iot/log/' + deviceLogId,
    method: 'delete'
  })
}
