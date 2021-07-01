/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
import request from '@/utils/request'

// 查询分组列表
export function listGroup(query) {
  return request({
    url: '/system/group/list',
    method: 'get',
    params: query
  })
}

// 查询分组详细
export function getGroup(groupId) {
  return request({
    url: '/system/group/' + groupId,
    method: 'get'
  })
}

// 新增分组
export function addGroup(data) {
  return request({
    url: '/system/group',
    method: 'post',
    data: data
  })
}

// 修改分组
export function updateGroup(data) {
  return request({
    url: '/system/group',
    method: 'put',
    data: data
  })
}

// 删除分组
export function delGroup(groupId) {
  return request({
    url: '/system/group/' + groupId,
    method: 'delete'
  })
}

// 导出分组
export function exportGroup(query) {
  return request({
    url: '/system/group/export',
    method: 'get',
    params: query
  })
}