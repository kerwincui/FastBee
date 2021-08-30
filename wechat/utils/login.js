const api = require("../API/request")
const appLogin =(options)=>{
  console.log("登录")
  wx.login({
    success:(res)=>{
      console.log("登录",res)
      if(res.errMsg == "login:ok"){
        api.userLogin({
          code : res.code,
          options:options
        }).then(res=>{
           wx.setStorageSync('token', res.token)
          //  wx.setStorageSync('userType', res.data.userType)
          //  wx.setStorageSync('userInfo', res.data.userInfo)
        })
      }
    }
  })
}
module.exports={
  appLogin
}