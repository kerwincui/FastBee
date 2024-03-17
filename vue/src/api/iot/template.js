import request from '@/utils/request'

// 查询通用物模型列表
export function listTemplate(query) {
  return request({
    url: '/iot/template/list',
    method: 'get',
    params: query
  })
}

// 查询通用物模型详细
export function getTemplate(templateId) {
  return request({
    url: '/iot/template/' + templateId,
    method: 'get'
  })
}

// 新增通用物模型
export function addTemplate(data) {
  return request({
    url: '/iot/template',
    method: 'post',
    data: data
  })
}

// 修改通用物模型
export function updateTemplate(data) {
  return request({
    url: '/iot/template',
    method: 'put',
    data: data
  })
}

// 删除通用物模型
export function delTemplate(templateId) {
  return request({
    url: '/iot/template/' + templateId,
    method: 'delete'
  })
}

// 查询通用物模型详细
export function getAllPoints(params) {
  return request({
    url: '/iot/template/getPoints',
    method: 'get',
    params: params,
  })
}
