import request from '@/utils/request'

// 查询产品固件列表
export function listFirmware(query) {
  return request({
    url: '/iot/firmware/list',
    method: 'get',
    params: query
  })
}

// 查询设备最新固件
export function getLatestFirmware(deviceId) {
  return request({
    url: '/iot/firmware/getLatest/' + deviceId,
    method: 'get'
  })
}

// 查询产品固件详细
export function getFirmware(firmwareId) {
  return request({
    url: '/iot/firmware/' + firmwareId,
    method: 'get'
  })
}

// 新增产品固件
export function addFirmware(data) {
  return request({
    url: '/iot/firmware',
    method: 'post',
    data: data
  })
}

// 修改产品固件
export function updateFirmware(data) {
  return request({
    url: '/iot/firmware',
    method: 'put',
    data: data
  })
}

// 删除产品固件
export function delFirmware(firmwareId) {
  return request({
    url: '/iot/firmware/' + firmwareId,
    method: 'delete'
  })
}
