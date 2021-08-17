
// const baseURL = 'http://106.38.203.210:81/prod-api';
const baseURL = 'http://106.12.9.213:80/prod-api';

const token = wx.getStorageSync('token') || '';

const requestApi = ( url, params={} ) => {
    return new Promise((resolve,reject) => {
      wx.cloud.callFunction({
        name: 'wumeiRequest',
        data: {
          url:baseURL+url,
          params:{
            ...params,   
            headers:{
              "Authorization":token
            }     
          },     
        }
      }).then(res=>{
        resolve(res)
      }).catch(err=>{
        reject(err)
      })    
    })
}

const loginApi = (url, params={})=>{
  return new Promise((resolve,reject)=>{
    wx.cloud.callFunction({
      name: 'wumeiRequest',
      data: {
        url:baseURL+url,
        params:{
          ...params        
        }
      }
    }).then(res=>{
      resolve(res)
    }).catch(err=>{
      reject(err)
    })
  })
  
}


module.exports={
  loginApi,
  requestApi
}