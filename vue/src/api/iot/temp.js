import request from '@/utils/request'

// 查询设备采集变量模板列表
export function listTemp(query) {
  return request({
    url: '/iot/temp/list',
    method: 'get',
    params: query
  })
}

// 查询设备采集变量模板详细
export function getTemp(templateId) {
  return request({
    url: '/iot/temp/' + templateId,
    method: 'get'
  })
}

// 新增设备采集变量模板
export function addTemp(data) {
  return request({
    url: '/iot/temp',
    method: 'post',
    data: data
  })
}

// 修改设备采集变量模板
export function updateTemp(data) {
  return request({
    url: '/iot/temp',
    method: 'put',
    data: data
  })
}

// 删除设备采集变量模板
export function delTemp(templateId) {
  return request({
    url: '/iot/temp/' + templateId,
    method: 'delete'
  })
}


//根据产品查询采集点关联
export function getDeviceTemp(params){
  return request({
    url: '/iot/temp/getTemp' ,
    method: 'get',
    params: params,
  })
}

export function getTempByPId(params){
  return request({
    url: '/iot/temp/getTempByPid',
    method: 'get',
    params: params,
  })
}
