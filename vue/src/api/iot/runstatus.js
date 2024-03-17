import request from '@/utils/request'

//查询设备实时数据
export function runStatus(params) {
  return request({
    url: '/iot/runtime/runState',
    method: 'get',
    params: params,
  })
}


//查询设备实时数据
export function serviceInvoke(data) {
  return request({
    url: '/iot/runtime/service/invoke',
    method: 'post',
    data: data,
  })
}

//查询设备服务下发日志
export function funcLog(params) {
  return request({
    url: '/iot/runtime/funcLog',
    method: 'get',
    params: params,
  })
}
