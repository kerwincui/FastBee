
const baseURL = 'http://106.12.9.213:80/prod-api';
const token = wx.getStorageSync('token') || '';

const loginApi = (url, params = {} ) => {
  return new Promise((resolve,reject) => {
      wx.request({
        url:baseURL+url,
        ...params,
        success:(res)=>{
          resolve(res);
        },
        fail:(err) => {
          reject(err)
        }
      })
    })
  }

const requestApi = ( url, params={} ) => {
    return new Promise((resolve,reject) => {
      wx.request({
        url:baseURL+url,
        ...params,
        header:{
          "Authorization":token
        },
        success:(res)=>{
          resolve(res);
        },
        fail:(err) => {
          reject(err)
        }
      })
    })
}



module.exports={
  loginApi,
  requestApi
}