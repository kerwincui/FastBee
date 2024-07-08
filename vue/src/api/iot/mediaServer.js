import request from '@/utils/request'

// 查询流媒体服务器配置列表
export function listmediaServer(query) {
  return request({
    url: '/sip/mediaserver/list',
    method: 'get',
    params: query
  })
}

// 查询流媒体服务器配置详细
export function getmediaServer() {
  return request({
    url: '/sip/mediaserver/',
    method: 'get'
  })
}

// 新增流媒体服务器配置
export function addmediaServer(data) {
  return request({
    url: '/sip/mediaserver',
    method: 'post',
    data: data
  })
}

// 修改流媒体服务器配置
export function updatemediaServer(data) {
  return request({
    url: '/sip/mediaserver',
    method: 'put',
    data: data
  })
}

// 删除流媒体服务器配置
export function delmediaServer(id) {
  return request({
    url: '/sip/mediaserver/' + id,
    method: 'delete'
  })
}

export function checkmediaServer(query) {
  return request({
    url: '/sip/mediaserver/check' ,
    method: 'get',
    params: query
  })
}
