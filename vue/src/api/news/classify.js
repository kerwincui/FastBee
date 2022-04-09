import request from '@/utils/request'

// 查询新闻分类列表
export function listClassify(query) {
  return request({
    url: '/news/classify/list',
    method: 'get',
    params: query
  })
}

// 查询新闻分类详细
export function getClassify(classifyId) {
  return request({
    url: '/news/classify/' + classifyId,
    method: 'get'
  })
}

// 新增新闻分类
export function addClassify(data) {
  return request({
    url: '/news/classify',
    method: 'post',
    data: data
  })
}

// 修改新闻分类
export function updateClassify(data) {
  return request({
    url: '/news/classify',
    method: 'put',
    data: data
  })
}

// 删除新闻分类
export function delClassify(classifyId) {
  return request({
    url: '/news/classify/' + classifyId,
    method: 'delete'
  })
}


// 查询菜单下拉树结构
export function treeselect() {
  return request({
    url: '/news/classify/treeselect',
    method: 'get'
  })
}

// 根据角色ID查询菜单下拉树结构
export function classifyNewsTreeselect(newsId) {
  return request({
    url: '/news/classify/newsClassifyTreeselect/' + newsId,
    method: 'get'
  })
}