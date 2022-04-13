import request from '@/utils/request'

// 查询新闻分类列表
export function listNewsCategory(query) {
  return request({
    url: '/iot/newsCategory/list',
    method: 'get',
    params: query
  })
}

// 查询产品简短分类列表
export function listShortNewsCategory() {
  return request({
    url: '/iot/newsCategory/newsCategoryShortList',
    method: 'get',
  })
}

// 查询新闻分类详细
export function getNewsCategory(categoryId) {
  return request({
    url: '/iot/newsCategory/' + categoryId,
    method: 'get'
  })
}

// 新增新闻分类
export function addNewsCategory(data) {
  return request({
    url: '/iot/newsCategory',
    method: 'post',
    data: data
  })
}

// 修改新闻分类
export function updateNewsCategory(data) {
  return request({
    url: '/iot/newsCategory',
    method: 'put',
    data: data
  })
}

// 删除新闻分类
export function delNewsCategory(categoryId) {
  return request({
    url: '/iot/newsCategory/' + categoryId,
    method: 'delete'
  })
}
