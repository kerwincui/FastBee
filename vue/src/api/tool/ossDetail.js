import request from '@/utils/request'

// 查询文件记录列表
export function listOssDetail(query) {
  return request({
    url: '/oss/OssDetail/list',
    method: 'get',
    params: query
  })
}

// 查询文件记录详细
export function getOssDetail(id) {
  return request({
    url: '/oss/OssDetail/' + id,
    method: 'get'
  })
}

// 新增文件记录
export function addOssDetail(data) {
  return request({
    url: '/oss/OssDetail',
    method: 'post',
    data: data
  })
}

// 修改文件记录
export function updateOssDetail(data) {
  return request({
    url: '/oss/OssDetail',
    method: 'put',
    data: data
  })
}

// 删除文件记录
export function delOssDetail(id) {
  return request({
    url: '/oss/OssDetail/' + id,
    method: 'delete'
  })
}
