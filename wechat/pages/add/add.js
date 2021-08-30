// pages/add/add.js
Page({

  /**
   * 页面的初始数据
   */
  data: {

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },
  addFourG(){
    wx.navigateTo({
      url: '/pages/add4G/index',
    })
  },
  addWifi(){
    wx.showToast({
      title: '暂不支持',
      icon:'error'
    })
  },
})