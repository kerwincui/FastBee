import request from '@/utils/request';

// 查询物模型列表
export function listModel(query) {
  return request({
    url: '/iot/model/list',
    method: 'get',
    params: query,
  });
}

// 查询物模型详细
export function getModel(modelId) {
  return request({
    url: '/iot/model/' + modelId,
    method: 'get',
  });
}

// 查询物模型对应分享设备用户权限列表
export function permListModel(productId) {
  return request({
    url: '/iot/model/permList/' + productId,
    method: 'get',
  });
}

// 新增物模型
export function addModel(data) {
  return request({
    url: '/iot/model',
    method: 'post',
    data: data,
  });
}

// 导入通用物模型
export function importModel(data) {
  return request({
    url: '/iot/model/import',
    method: 'post',
    data: data,
  });
}

// 修改物模型
export function updateModel(data) {
  return request({
    url: '/iot/model',
    method: 'put',
    data: data,
  });
}

// 删除物模型
export function delModel(modelId) {
  return request({
    url: '/iot/model/' + modelId,
    method: 'delete',
  });
}

// 根据产品ID获取缓存的物模型
export function cacheJsonThingsModel(productId) {
  return request({
    url: '/iot/model/cache/' + productId,
    method: 'get',
  });
}

// 同步采集点模板到产品物模型
export function synchron(data) {
  return request({
    url: '/iot/model/synchron',
    method: 'post',
    data: data,
  });
}
