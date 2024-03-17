import request from '@/utils/request'

// 集群下所有客户端列表
export function listNettyMqttClient(query) {
  return request({
    url: '/iot/mqtt/clients',
    method: 'get',
    params: query
  })
}

export function clientOut(query) {
  return request({
    url: '/iot/mqtt/client/out',
    method: 'get',
    params: query
  })
}


export function getNettyMqttStats() {
  return request({
    url: '/bashBoard/stats',
    method: 'get',
  })
}


export function statisticNettyMqtt(query) {
  return request({
    url: '/bashBoard/metrics',
    method: 'get',
    params: query
  })
}

