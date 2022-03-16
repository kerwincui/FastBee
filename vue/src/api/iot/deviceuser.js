import request from '@/utils/request'

// 查询设备用户列表
export function listDeviceUser(query) {
  return request({
    url: '/iot/deviceUser/list',
    method: 'get',
    params: query
  })
}

// 查询设备用户详细
export function getDeviceUser(deviceId) {
  return request({
    url: '/iot/deviceUser/' + deviceId,
    method: 'get'
  })
}

// 新增设备用户
export function addDeviceUser(data) {
  return request({
    url: '/iot/deviceUser',
    method: 'post',
    data: data
  })
}

// 修改设备用户
export function updateDeviceUser(data) {
  return request({
    url: '/iot/deviceUser',
    method: 'put',
    data: data
  })
}

// 删除设备用户
export function delDeviceUser(deviceId) {
  return request({
    url: '/iot/deviceUser/' + deviceId,
    method: 'delete'
  })
}
