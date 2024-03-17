import request from '@/utils/request'


// 查询事件日志列表
export function listEventLog(query) {
  return request({
    url: '/iot/event/list',
    method: 'get',
    params: query
  })
}

// 查询事件日志详细
export function getEventLog(logId) {
  return request({
    url: '/iot/event/' + logId,
    method: 'get'
  })
}

// 新增事件日志
export function addEventLog(data) {
  return request({
    url: '/iot/event',
    method: 'post',
    data: data
  })
}

// 修改事件日志
export function updateEventLog(data) {
  return request({
    url: '/iot/event',
    method: 'put',
    data: data
  })
}

// 删除事件日志
export function delLog(logId) {
  return request({
    url: '/iot/event/' + logId,
    method: 'delete'
  })
}
