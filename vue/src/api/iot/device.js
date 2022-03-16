import request from '@/utils/request'

// 查询设备列表
export function listDevice(query) {
  return request({
    url: '/iot/device/list',
    method: 'get',
    params: query
  })
}

// 查询设备简短列表
export function listDeviceShort(query) {
  return request({
    url: '/iot/device/shortList',
    method: 'get',
    params: query
  })
}

// 查询所有设备简短列表
export function listAllDeviceShort() {
  return request({
    url: '/iot/device/all',
    method: 'get',
  })
}

// 查询设备详细
export function getDevice(deviceId) {
  return request({
    url: '/iot/device/' + deviceId,
    method: 'get'
  })
}

// 查询设备运行状态详细
export function getDeviceRunningStatus(deviceId) {
  return request({
    url: '/iot/device/runningStatus/' + deviceId,
    method: 'get'
  })
}

// 查询设备物模型的值
export function getDeviceThingsModelValue(deviceId) {
  return request({
    url: '/iot/device/thingsModelValue/' + deviceId,
    method: 'get'
  })
}

// 新增设备
export function addDevice(data) {
  return request({
    url: '/iot/device',
    method: 'post',
    data: data
  })
}

// 修改设备
export function updateDevice(data) {
  return request({
    url: '/iot/device',
    method: 'put',
    data: data
  })
}

// 删除设备
export function delDevice(deviceId) {
  return request({
    url: '/iot/device/' + deviceId,
    method: 'delete'
  })
}

// 生成设备编号
export function generatorDeviceNum() {
  return request({
    url: '/iot/device/generator',
    method: 'get'
  })
}
