import request from '@/utils/request'

// 查询监控设备列表
export function listSipDevice(query) {
  return request({
    url: '/sip/device/list',
    method: 'get',
    params: query
  })
}

export function listSipDeviceChannel(deviceId) {
  return request({
    url: '/sip/device/listchannel/'+ deviceId,
    method: 'get'
  })
}

// 查询监控设备详细
export function getSipDevice(deviceId) {
  return request({
    url: '/sip/device/' + deviceId,
    method: 'get'
  })
}

// 新增监控设备
export function addSipDevice(data) {
  return request({
    url: '/sip/device',
    method: 'post',
    data: data
  })
}

// 修改监控设备
export function updateSipDevice(data) {
  return request({
    url: '/sip/device',
    method: 'put',
    data: data
  })
}

// 删除监控设备
export function delSipDevice(deviceId) {
  return request({
    url: '/sip/device/' + deviceId,
    method: 'delete'
  })
}

export function delSipDeviceBySipId(sipId) {
  return request({
    url: '/sip/device/sipid/' + sipId,
    method: 'delete'
  })
}

export function ptzdirection(deviceId,channelId,data) {
  return request({
    url: '/sip/ptz/direction/'+ deviceId + "/" + channelId,
    method: 'post',
    data: data
  })
}

export function ptzscale(deviceId,channelId,data) {
  return request({
    url: '/sip/ptz/scale/'+ deviceId + "/" + channelId,
    method: 'post',
    data: data
  })
}
