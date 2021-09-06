// pages/index/index.js
const amap = require('../../libs/amap-wx.js');
const { request } = require('../../API/request.js');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    weather:{}, //天气信息
    products:[],
    DeviceList:[],
    onlineList:[],
    unlineList:[]
  },


  async getDevices(){
    wx.showLoading({
      title: '获取设备',
      mask: true
    })
    const res = await request('system/device/listDevice','GET');
    wx.hideLoading();
    const result = res.rows;
    if (res.code !== 200) {
      wx.showToast({
        title: '请求失败',
        icon:'error'
      });
      return;
    }
    wx.showToast({
      title: '请求成功',
    });
    let onlineList = [];
    let unlineList = [];
    result.forEach(v=>{
      if (v.isOnline == 1) {
        onlineList.push(v)
      } else if (v.isOnline == 0) {
        unlineList.push(v);
      }
    })
    this.setData({
      onlineList,
      unlineList,
      DeviceList:result
    })
  },

  goToDeviceControl(e){
    switch (e.currentTarget.dataset.info.categoryId) {
      case 1:
        wx.navigateTo({
          url: '/pages/4Gswitch/index',
          success:(res)=>{
            res.eventChannel.emit('getDeviceInfo',e.currentTarget.dataset.info.deviceId)
          }
        })
        break;
      case 4:
        wx.navigateTo({
          url: '/pages/4Gswitch/index',
          success:(res)=>{
            res.eventChannel.emit('getDeviceInfo',e.currentTarget.dataset.info.deviceId)
          }
        })
        break;
      // case 4:
      //     wx.navigateTo({
      //       url: '/pages/someData/index',
      //       success:(res)=>{
      //         res.eventChannel.emit('getDeviceInfo',e.currentTarget.dataset.deviceId)
      //       }
      //     })     
      //   break;
    
      case 5:
        wx.navigateTo({
          url: '/pages/roomSystem/index',
          success:(res)=>{
            res.eventChannel.emit('getDeviceInfo',e.currentTarget.dataset.deviceId)
          }
        })
        break;
    }  
  },

  getWeather:async function(){
    let that = this;
    var myAmapFun = new amap.AMapWX({key:'5cafa1133f593cfe005081749a46e717'});
    myAmapFun.getWeather({
      success: function(data){
        that.setData({
          weather:data
        })
      },
      fail: function(info){
        //失败回调
        console.log(info)
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    setTimeout(()=>{
       this.getDevices();
    },1000)
   
  },


  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.getWeather();
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    this.getDevices();
    this.getWeather();
    wx.stopPullDownRefresh();
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})