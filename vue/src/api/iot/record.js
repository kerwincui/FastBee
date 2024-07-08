import request from '@/utils/request'

export function getDevRecord(deviceId,channelId,query) {
  return request({
    url: '/sip/record/devquery/' + deviceId + "/" + channelId,
    method: 'get',
    params: query
  })
}

export function getRecord(channelId,sn) {
  return request({
    url: '/sip/record/query/' + channelId + "/" + sn,
    method: 'get',
  })
}

export function getServerRecord(query) {
  return request({
    url: '/sip/record/serverRecord/list',
    method: 'get',
    params: query
  })
}

export function getServerRecordByDate(query) {
  return request({
    url: '/sip/record/serverRecord/date/list',
    method: 'get',
    params: query
  })
}

export function getServerRecordByStream(query) {
  return request({
    url: '/sip/record/serverRecord/stream/list',
    method: 'get',
    params: query
  })
}

export function getServerRecordByApp(query) {
  return request({
    url: '/sip/record/serverRecord/app/list',
    method: 'get',
    params: query
  })
}

export function getServerRecordByFile(query) {
  return request({
    url: '/sip/record/serverRecord/file/list',
    method: 'get',
    params: query
  })
}

export function getServerRecordByDevice(query) {
  return request({
    url: '/sip/record/serverRecord/device/list',
    method: 'get',
    params: query
  })
}

export function startPlayRecord(deviceId, channelId) {
  return request({
    url: '/sip/record/play/' + deviceId + "/" + channelId,
    method: 'get'
  })
}

export function startDownloadRecord(deviceId, channelId, query) {
  return request({
    url: '/sip/record/download/' + deviceId + "/" + channelId,
    method: 'get',
    params: query
  })
}


export function uploadRecord(query) {
  return request({
    url: '/sip/record/upload',
    method: 'get',
    params: query
  })
}
