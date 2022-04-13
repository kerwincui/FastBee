import request from '@/utils/request'

// 查询新闻资讯列表
export function listNews(query) {
  return request({
    url: '/iot/news/list',
    method: 'get',
    params: query
  })
}

// 查询新闻资讯详细
export function getNews(newsId) {
  return request({
    url: '/iot/news/' + newsId,
    method: 'get'
  })
}

// 新增新闻资讯
export function addNews(data) {
  return request({
    url: '/iot/news',
    method: 'post',
    data: data
  })
}

// 修改新闻资讯
export function updateNews(data) {
  return request({
    url: '/iot/news',
    method: 'put',
    data: data
  })
}

// 删除新闻资讯
export function delNews(newsId) {
  return request({
    url: '/iot/news/' + newsId,
    method: 'delete'
  })
}
