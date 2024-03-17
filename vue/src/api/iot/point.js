import request from '@/utils/request'

// 查询变量模板从机采集点列表
export function listPoint(query) {
  return request({
    url: '/iot/point/list',
    method: 'get',
    params: query
  })
}

// 查询变量模板从机采集点详细
export function getPoint(id) {
  return request({
    url: '/iot/point/' + id,
    method: 'get'
  })
}

// 新增变量模板从机采集点
export function addPoint(data) {
  return request({
    url: '/iot/point',
    method: 'post',
    data: data
  })
}

// 修改变量模板从机采集点
export function updatePoint(data) {
  return request({
    url: '/iot/point',
    method: 'put',
    data: data
  })
}

// 删除变量模板从机采集点
export function delPoint(id) {
  return request({
    url: '/iot/point/' + id,
    method: 'delete'
  })
}

//根据从机id删除采集点数据
export function delBySlaveId(data){
  return request({
    url: '/iot/point/delBySlaveId',
    method: 'delete',
    data: data,

  })
}
//..
export function selectByTemp(query){
  return request({
    url: '/iot/point/getPoints',
    method: 'get',
    params: query
  })
}
