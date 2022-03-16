import request from '@/utils/request'

// 查询云云对接列表
export function listClientDetails(query) {
  return request({
    url: '/iot/clientDetails/list',
    method: 'get',
    params: query
  })
}

// 查询云云对接详细
export function getClientDetails(clientId) {
  return request({
    url: '/iot/clientDetails/' + clientId,
    method: 'get'
  })
}

// 新增云云对接
export function addClientDetails(data) {
  return request({
    url: '/iot/clientDetails',
    method: 'post',
    data: data
  })
}

// 修改云云对接
export function updateClientDetails(data) {
  return request({
    url: '/iot/clientDetails',
    method: 'put',
    data: data
  })
}

// 删除云云对接
export function delClientDetails(clientId) {
  return request({
    url: '/iot/clientDetails/' + clientId,
    method: 'delete'
  })
}
