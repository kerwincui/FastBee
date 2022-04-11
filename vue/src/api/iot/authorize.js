import request from '@/utils/request'

// 查询产品授权码列表
export function listAuthorize(query) {
  return request({
    url: '/iot/authorize/list',
    method: 'get',
    params: query
  })
}

// 查询产品授权码详细
export function getAuthorize(authorizeId) {
  return request({
    url: '/iot/authorize/' + authorizeId,
    method: 'get'
  })
}

// 新增产品授权码
export function addAuthorize(data) {
  return request({
    url: '/iot/authorize',
    method: 'post',
    data: data
  })
}

//根据数量批量新增产品授权码
export function addProductAuthorizeByNum(data) {
  return request({
    url: '/iot/authorize/addProductAuthorizeByNum',
    method: 'post',
    data: data
  })
}
// 修改产品授权码
export function updateAuthorize(data) {
  return request({
    url: '/iot/authorize',
    method: 'put',
    data: data
  })
}

// 删除产品授权码
export function delAuthorize(authorizeId) {
  return request({
    url: '/iot/authorize/' + authorizeId,
    method: 'delete'
  })
}
