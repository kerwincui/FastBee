var app = getApp();

Page({
  data: {
    userInfo: {},
    mode: ['信息反馈', '联系客服', '关于我们']
  },
  onLoad: function () {
  },
  getOut(){
    wx.clearStorage({
      success: (res) => {
        wx.reLaunch({
          url: '/pages/login/index',
        })
      },
    })
  }
})