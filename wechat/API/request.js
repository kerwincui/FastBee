
/*

  @file 微信请求封装
  @using 使用方法参考 https://bypanghu.github.io/blog/2020/10/08/Extension/

*/
import {appLogin} from '../utils/login'
const API_BASE_URL = 'http://home.xxmfl.com:9160/';
var loginKey = false

const request = (url, method, data) => {
  wx.showLoading({
    title: '请求中，请稍等',
  })
  let _url = API_BASE_URL + url
  return new Promise((resolve, reject) => {
    wx.request({
      url: _url,
      method: method,
      data: data,
      header: {
        'Content-Type': method == 'get'?'application/x-www-form-urlencoded' : 'application/json',
        'Authorization': wx.getStorageSync('token') ? 'Bearer '+ wx.getStorageSync('token') : ''
      },
      success: requestData =>{
        if(requestData.data.code == 401){
          loginKey = true
          try{
            wx.showLoading({
              title: '重新登录中……',
            })
            if(loginKey){
            wx.login({
              success:(res)=>{
                  if(res.errMsg == "login:ok"){
                    request('wxLogin','post',{
                      code : res.code
                    }).then(res=>{
                      wx.setStorageSync('token', res.data.token)
                      if(res.data.userInfo){
                        wx.setStorageSync('userInfo', res.data.userInfo)
                      }
                      var reData  =  request(url, method, data)
                      resolve(reData)
                    })
                  }
                }
              })
            }
            wx.hideLoading({
              success: (res) => {
              },
            })
          }catch (err){
            console.log("出错了")
            reject(err)
          }
          loginKey = false
        }
        else if(requestData.data.code == 500){
          wx.showToast({
            title: requestData.data.msg,
            icon:'none',
            duration:1000
          })
          resolve(requestData.data)
        }
        else{
          resolve(requestData.data)
        }
      },
      fail(error) {
        console.log("访问出错")
        reject(error)
      },
      complete(aaa) {
        wx.hideLoading()
        // 加载完成
      }
    })
  })
}


/**
 * 小程序的promise没有finally方法，自己扩展下
 */
Promise.prototype.finally = function (callback) {
  var Promise = this.constructor;
  return this.then(
    function (value) {
      Promise.resolve(callback()).then(
        function () {
          return value;
        }
      );
    },
    function (reason) {
      Promise.resolve(callback()).then(
        function () {
          throw reason;
        }
      );
    }
  );
}

module.exports = {
  API_BASE_URL ,
  request,
  userLogin:(data)=>{
    return request('wxLogin','post',data)
  },
  setUserInfo:(data)=>{
    return request('user/getUserWxInfo','post',data)
  },
  getCoinList:(data)=>{
    return request('user/coinListPage','get',data)
  },
  getToothbrushList:(data)=>{
    return request("toothbrush/getToothbrushList",'get',data)
  },
  userSign:(data)=>{
    return request("user/sign",'post',data)
  },
  addToothBrush:(data)=>{
    return request("toothbrush/save","post",data)
  },
 
  getSignData:(data)=>{
    return request("user/signList",'get',data)
  },
  getCoinListPage:(data)=>{
    return request("user/coinListPage",'get',data)
  },
  updateBrush:(data)=>{
    return request("toothbrush/update",'post',data)
  },
/**
 * 
 * 刷牙数据
 * 
 */
//保存刷牙数据
saveBrushRecord:(data)=>{
  return request("brush/save",'post',data)
},
//保存历史刷牙数据
saveHistory:(data)=>{
  return request("brush/saveHistory",'post',data)
},
//保存意见反馈
saveFeedback:(data)=>{
  return request("feedback/save",'post',data)
},

  /**
   * 
   * 首页组
   */
  getLastBrushData:(data)=>{
    return request('home/lastBrushData','get',data)
  },
  getBrushRecordById:(data)=>{
    return request('brush/getBrushRecordById','get',data)
  },
  updateToothBrushBattery:(data)=>{
    return request('toothbrush/updateToothBrushBattery','post',data)
  },
  resetBrushHead:(data)=>{
    return request("toothbrush/resetBrushHead",'post',data)
  },
  
  updateBrushScheme:(data)=>{
    return request("toothbrush/updateBrushScheme",'post',data)
  },
  
  getAdInfo:(data)=>{
    return  request("systemParam/getAdInfo",'get',data)
  },

  /**
   * 
   * 数据
   */
  getDailyBrushList:(data)=>{
    return request("data/dailyBrushList",'get',data)
  },
  getWeekBrushList:(data)=>{
    return request('data/weeklyBrushList','get',data)
  },
  dailyBrushDayList:(data)=>{
    return request("data/dailyBrushDayList",'get',data)
  },
  weeklyBrushWeekData:(data)=>{
    return request('data/weeklyBrushWeekData','get',data)
  },
  monthlyBrushList :(data)=>{
    return request("data/monthlyBrushList",'get',data)
  },
  monthlyBrushMonthData:(data)=>{
    return request("data/monthlyBrushMonthData",'get',data)
  },



  /**
   * 个人信息
   */
  changeName:(data)=>{
    return request("user/updateNickName",'post',data)
  },
  changePhone:(data)=>{
    return request("user/updatePhone",'post',data)
  },
  changeAddress:(data)=>{
    return request('user/updateAddress','post',data)
  },
  delBrush:(data)=>{
    return request('toothbrush/delete','post',data)
  },
  uploadImg:(data)=>{
    return request('upload/images','post',data)
  }
}