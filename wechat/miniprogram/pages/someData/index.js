// miniprogram/pages/someData/index.js
const { requestApi } = require('../../API/request.js');
let timer = null;
Page({

  /**
   * 页面的初始数据
   */
  data: {
    deviceInfo:{},
    deviceData:{}
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.setNavigationBarTitle({
      title: '环境监测'
    })
    this.getLastPageData();
    this.getData();
    timer = setInterval(() => {
      this.getData();
    }, 1000);
  },


  async getData(){
    let that = this;
    const res = await requestApi(`/system/status/newByNum/${this.data.deviceInfo.deviceNum}`,{ method:'GET' });
    const data = JSON.parse(res.result);
    data.data.remark = JSON.parse(data.data.remark)
    this.setData({ deviceData:data.data })
  },

  getLastPageData(){
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.on('getDeviceInfo',(data)=>{
      this.setData({ deviceInfo:data })
    })
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