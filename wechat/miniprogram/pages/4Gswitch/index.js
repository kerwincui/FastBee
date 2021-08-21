// miniprogram/pages/4Gswitch/index.js

const { requestApi } = require('../../API/request')
Page({

  /**
   * 页面的初始数据
   */
  data: {
    deviceInfo:{},
    power:0,
    info:{
      name:"客厅1号",
      imei:123478098765432345,
      remark:"这是客厅1号的开关"
    }
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setNavigate();
    this.getLastPageData();
    console.log('options',options);
  },

  setNavigate(){
    wx.setNavigationBarTitle({
      title: '4G开关',
    });
    wx.setNavigationBarColor({
      backgroundColor: '#4271f1',
      frontColor: '#ffffff',
    });
  },

  getLastPageData(){
    const eventChannel = this.getOpenerEventChannel();
    const that = this;
    eventChannel.on('getDeviceInfo',async (data)=>{
      const res = await requestApi(`/system/status/newByNum/${data.deviceNum}`,{ method:'GET' });
      that.setData({
        deviceInfo:JSON.parse(res.result).data,
        power:JSON.parse(res.result).data.lightStatus
      });
      
    })
  },


  async lightPower(){
    let deviceInfo = this.data.deviceInfo;
    if(deviceInfo.lightStatus === 1){
      deviceInfo.lightStatus = 0;
    }else if(deviceInfo.lightStatus === 0){
      deviceInfo.lightStatus = 1;
    }
    const res = await requestApi('/system/status',{
      method:'PUT',
      body:deviceInfo,
      json:true
    })
    if (res.result.code === 200) {
      this.setData({ power:deviceInfo.lightStatus })
    }
  },

  //打开分享的页面
  isShared(options){
    if (options.hasOwnProperty('deviceInfo')) {
      const deviceInfo = JSON.parse(options.deviceInfo);
      this.setData({
        info:deviceInfo
      })
    }
  },


  lookDetail(e){
    wx.navigateTo({
      url: '/pages/deviceDetail/index',
      success: (result) => {
        result.eventChannel.emit('getDeviceInfo',e.currentTarget.dataset.info);
      }
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
  onShareAppMessage: function (e) {
    console.log(e);
    return {
      title:"我分享了一个设备。",
      path:`/pages/4Gswitch/index?deviceInfo=${JSON.stringify(e.target.dataset.info)}`,
      imageUrl:'/icons/smart.jpg'
    }
  }
})