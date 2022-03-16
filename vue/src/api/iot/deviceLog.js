import request from '@/utils/request'

// 查询设备日志列表
export function listDeviceLog(query) {
  return request({
    url: '/iot/deviceLog/list',
    method: 'get',
    params: query
  })
}

// 查询设备监测数据
export function listMonitor(query) {
  return request({
    url: '/iot/deviceLog/monitor',
    method: 'get',
    params: query
  })
}

// 查询设备日志详细
export function getDeviceLog(logId) {
  return request({
    url: '/iot/deviceLog/' + logId,
    method: 'get'
  })
}

// 新增设备日志
export function addDeviceLog(data) {
  return request({
    url: '/iot/deviceLog',
    method: 'post',
    data: data
  })
}

// 修改设备日志
export function updateDeviceLog(data) {
  return request({
    url: '/iot/deviceLog',
    method: 'put',
    data: data
  })
}

// 删除设备日志
export function delDeviceLog(logId) {
  return request({
    url: '/iot/deviceLog/' + logId,
    method: 'delete'
  })
}
