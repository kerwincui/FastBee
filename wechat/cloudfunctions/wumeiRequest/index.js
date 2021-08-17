// 云函数入口文件
const cloud = require('wx-server-sdk')
const resPro = require('request-promise')
cloud.init({
  env: cloud.DYNAMIC_CURRENT_ENV
})

// 云函数入口函数
exports.main = async (event, context) => {
  const url = event.url;
  const params = event.params;
  return await resPro({ 
    ...params,
    url:url
  }).then(res=>{
    return res
  }).catch(err=>{
    return err
  });
}