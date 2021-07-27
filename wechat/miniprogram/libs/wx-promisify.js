module.exports = api => (object, ...params) => new Promise((resolve, reject) => {
  if (api) {
    api.call(wx, { ...object, success: resolve, fail: reject }, ...params);
  } else {
    console.error('调用不支持的 API');
    reject({ errCode: 'WXAPI_NOT_SUPPORTED' });
  }
});