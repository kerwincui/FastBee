import request from '@/utils/request';

// 查询app语言列表
export function listLanguage(query) {
  return request({
    url: '/app/language/list',
    method: 'get',
    params: query,
  });
}

// 查询app语言详细
export function getLanguage(id) {
  return request({
    url: '/app/language/' + id,
    method: 'get',
  });
}

// 新增app语言
export function addLanguage(data) {
  return request({
    url: '/app/language',
    method: 'post',
    data: data,
  });
}

// 修改app语言
export function updateLanguage(data) {
  return request({
    url: '/app/language',
    method: 'put',
    data: data,
  });
}

// 删除app语言
export function delLanguage(id) {
  return request({
    url: '/app/language/' + id,
    method: 'delete',
  });
}

export function addOrUpdate(data) {
  return request({
    url: '/app/preferences/addOrUpdate',
    method: 'POST',
    headers: {
      repeatSubmit: false,
    },
    data: data,
  });
}

// 导出菜单翻译列表
export function exportTranslate(type, isSource, productId = null) {
  let url = `/system/translate/export?type=${type}&isSource=${isSource}`;
  if (productId) {
    url += `&productId=${productId}`;
  }
  return request({
    url,
    method: 'post',
    data: {},
    responseType: 'blob',
  });
}

// 导入菜单翻译列表
export function importTranslate(data, type, productId = '') {
  let url = `/system/translate/import?type=${type}`;
  if (productId) {
    url += `&productId=${productId}`;
  }
  return request({
    url,
    method: 'post',
    data: data,
  });
}
