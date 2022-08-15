import request from '@/utils/request'

// 大屏 map
export function map(data) {
  return request({
    url: '/iot/big/screen/map',
    method: 'post',
    data: data
  })
}
