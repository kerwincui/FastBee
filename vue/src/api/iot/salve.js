import request from '@/utils/request'

// 查询变量模板设备从机列表
export function listSalve(query) {
  return request({
    url: '/iot/salve/list',
    method: 'get',
    params: query
  })
}

// 查询变量模板设备从机详细
export function getSalve(id) {
  return request({
    url: '/iot/salve/' + id,
    method: 'get'
  })
}

// 新增变量模板设备从机
export function addSalve(data) {
  return request({
    url: '/iot/salve',
    method: 'post',
    data: data
  })
}

// 修改变量模板设备从机
export function updateSalve(data) {
  return request({
    url: '/iot/salve',
    method: 'put',
    data: data
  })
}

// 删除变量模板设备从机
export function delSalve(id) {
  return request({
    url: '/iot/salve/' + id,
    method: 'delete'
  })
}

//根据产品id查询从机列表
export function listByPid(params){
  return request({
    url: "/iot/salve/listByPId",
    method: 'get',
    params: params,
  })
}
