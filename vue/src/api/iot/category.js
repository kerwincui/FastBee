import request from '@/utils/request'

// 查询产品分类列表
export function listCategory(query) {
  return request({
    url: '/iot/category/list',
    method: 'get',
    params: query
  })
}

// 查询产品简短分类列表
export function listShortCategory() {
  return request({
    url: '/iot/category/shortlist',
    method: 'get',
  })
}

// 查询产品分类详细
export function getCategory(categoryId) {
  return request({
    url: '/iot/category/' + categoryId,
    method: 'get'
  })
}

// 新增产品分类
export function addCategory(data) {
  return request({
    url: '/iot/category',
    method: 'post',
    data: data
  })
}

// 修改产品分类
export function updateCategory(data) {
  return request({
    url: '/iot/category',
    method: 'put',
    data: data
  })
}

// 删除产品分类
export function delCategory(categoryId) {
  return request({
    url: '/iot/category/' + categoryId,
    method: 'delete'
  })
}
