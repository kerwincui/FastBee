import request from '@/utils/request'

// 查询文件存储配置列表
export function listOssConfig(query) {
  return request({
    url: '/oss/ossConfig/list',
    method: 'get',
    params: query
  })
}

// 查询文件存储配置详细
export function getOssConfig(id) {
  return request({
    url: '/oss/ossConfig/' + id,
    method: 'get'
  })
}

// 新增文件存储配置
export function addOssConfig(data) {
  return request({
    url: '/oss/ossConfig',
    method: 'post',
    data: data
  })
}

// 修改文件存储配置
export function updateOssConfig(data) {
  return request({
    url: '/oss/ossConfig',
    method: 'put',
    data: data
  })
}

// 删除文件存储配置
export function delOssConfig(id) {
  return request({
    url: '/oss/ossConfig/' + id,
    method: 'delete'
  })
}
