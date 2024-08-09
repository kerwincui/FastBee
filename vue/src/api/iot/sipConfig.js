import request from '@/utils/request'

// 查询sip系统配置详细
export function getSipconfig(productId,isDefault) {
  return request({
    url: '/sip/sipconfig/' + productId+'/'+isDefault,
    method: 'get'
  })
}

// 新增sip系统配置
export function addSipconfig(data) {
  return request({
    url: '/sip/sipconfig',
    method: 'post',
    data: data
  })
}

// 修改sip系统配置
export function updateSipconfig(data) {
  return request({
    url: '/sip/sipconfig',
    method: 'put',
    data: data
  })
}

export function delSipconfigByProductId(productId) {
  return request({
    url: '/sip/sipconfig/product/' + productId,
    method: 'delete'
  })
}
