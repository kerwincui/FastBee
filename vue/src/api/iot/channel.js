import request from '@/utils/request'

// 查询监控设备通道信息列表
export function listChannel(query) {
  return request({
    url: '/sip/channel/list',
    method: 'get',
    params: query
  })
}

// 查询监控设备通道信息详细
export function getChannel(channelId) {
  return request({
    url: '/sip/channel/' + channelId,
    method: 'get'
  })
}

// 新增监控设备通道信息
export function addChannel(createNum, data) {
  return request({
    url: '/sip/channel/' + createNum,
    method: 'post',
    data: data
  })
}

// 修改监控设备通道信息
export function updateChannel(data) {
  return request({
    url: '/sip/channel',
    method: 'put',
    data: data
  })
}

// 删除监控设备通道信息
export function delChannel(channelId) {
  return request({
    url: '/sip/channel/' + channelId,
    method: 'delete'
  })
}

// 开始播放
export function startPlay(deviceId, channelId) {
  return request({
    url: '/sip/player/play/' + deviceId + "/" + channelId,
    method: 'get'
  })
}

// 获取流信息
export function getStreaminfo(deviceId, channelId) {
  return request({
    url: '/sip/player/playstream/' + deviceId + "/" + channelId,
    method: 'get'
  })
}


export function closeStream(deviceId, channelId, streamId){
  return request({
    url: '/sip/player/closeStream/' + deviceId  + "/" + channelId + "/" + streamId,
    method: 'get'
  })
}

