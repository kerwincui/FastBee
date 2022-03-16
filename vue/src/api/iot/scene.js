import request from '@/utils/request'

// 查询场景联动列表
export function listScene(query) {
  return request({
    url: '/iot/scene/list',
    method: 'get',
    params: query
  })
}

// 查询场景联动详细
export function getScene(sceneId) {
  return request({
    url: '/iot/scene/' + sceneId,
    method: 'get'
  })
}

// 新增场景联动
export function addScene(data) {
  return request({
    url: '/iot/scene',
    method: 'post',
    data: data
  })
}

// 修改场景联动
export function updateScene(data) {
  return request({
    url: '/iot/scene',
    method: 'put',
    data: data
  })
}

// 删除场景联动
export function delScene(sceneId) {
  return request({
    url: '/iot/scene/' + sceneId,
    method: 'delete'
  })
}
