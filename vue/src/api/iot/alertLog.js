import request from '@/utils/request'

// 查询设备告警列表
export function listAlertLog(query) {
  return request({
    url: '/iot/alertLog/list',
    method: 'get',
    params: query
  })
}

// 查询设备告警详细
export function getAlertLog(alertLogId) {
  return request({
    url: '/iot/alertLog/' + alertLogId,
    method: 'get'
  })
}

// 新增设备告警
export function addAlertLog(data) {
  return request({
    url: '/iot/alertLog',
    method: 'post',
    data: data
  })
}

// 修改设备告警
export function updateAlertLog(data) {
  return request({
    url: '/iot/alertLog',
    method: 'put',
    data: data
  })
}

// 删除设备告警
export function delAlertLog(alertLogId) {
  return request({
    url: '/iot/alertLog/' + alertLogId,
    method: 'delete'
  })
}
