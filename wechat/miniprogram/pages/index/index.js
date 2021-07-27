// miniprogram/pages/index/index.js
const amap = require('../../libs/amap-wx.js');
const { requestApi } = require('../../API/request.js');
const app = getApp();
const project_id = 'wHJB7a';
var timer;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    weather:{}, //天气信息
    products:[],
    DeviceList:[], 
    fourGDeviceList:[],
    show: false,
    actions: [
      { name: '绑定设备' },
    ],
    
  },
  // }, 
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // this.getProducts();
    // this.query();
    // timer = setInterval(() => {
      this.getDevices();
    // }, 2000);
  },


  async getDevices(){
    const res = await requestApi('/system/device/list');
    console.log(res);  
    this.setData({ DeviceList:res.data.rows })
  },




  //获取天气
  getWeather:async function(){
    let that = this;
    var myAmapFun = new amap.AMapWX({key:'5cafa1133f593cfe005081749a46e717'});
    myAmapFun.getWeather({
      success: function(data){
        console.log(data);
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

  goToDeviceControl(e){
    if (e.currentTarget.dataset.info.categoryId !== 5) {
      return;
    }
    wx.navigateTo({
      url: '/pages/roomSystem/index',
      success:(res)=>{
        res.eventChannel.emit('getDeviceInfo',e.currentTarget.dataset.info)
      }
    })
  },

  deviceFail(){
    wx.showToast({
      title: '设备离线!',
      icon:'error'
    })
  },
  deviceNone(){
    wx.showToast({
      title: '设备未激活！',
      icon:'error'
    })
  },
  
  //底部弹起的模态面板
  isShow:function(){
    this.setData({
      show:!this.data.show
    })
  },
  onClose:function() {
    this.setData({ show: false });
  },
  onCancel:function(){
    this.setData({ show: false });
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    this.getWeather();
    if (typeof this.getTabBar === 'function' && this.getTabBar()) {
      this.getTabBar().setData({
        homeSelected:true,
        userSelected:false //这个数字是当前页面在tabBar中list数组的索引
      })
    }
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
    clearInterval(timer);
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    this.onLoad();
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