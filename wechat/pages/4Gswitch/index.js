// miniprogram/pages/4Gswitch/index.js

const { request } = require('../../API/request')
Page({

  /**
   * 页面的初始数据
   */
  data: {
    deviceInfo:{},
    deviceId:'',
    lightStatus:false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setNavigate();    
    if (getCurrentPages().length > 1) {
      this.getLastPageData();
    }
    this.isShared(options);
  },

  checkLogin(){
    const isLogin = wx.getStorageSync('isLogin') || false;
    const that = this;
    if (!isLogin) {
      wx.showModal({
        cancelColor: '#ff0000',
        cancelText: '取消',
        confirmColor: '#6149f6',
        confirmText: '登录',
        content: '检测到您还未登录，是否授权登录？',
        showCancel: true,
        title: '登录授权',
        success: (result) => {
          if (result.confirm) {       
              wx.showLoading({
                title: '正在登录'
              });
              wx.getUserProfile({
                desc:'用以展示您的头像和昵称等信息',
                success(res){
                  console.log(res);
                  wx.setStorageSync('userInfo',JSON.parse(res.rawData));
                  wx.setStorageSync('isLogin',true);
                },
                complete(){
                  wx.hideLoading();
                },
                fail(err){
                  if (err.errMsg == 'getUserProfile:fail auth deny') {
                    wx.showToast({
                      title: '授权取消',
                      icon:'error'
                    })
                  }
                }
              })
          }else if(result.cancel){
            wx.switchTab({
              url: '/pages/my/my',
            })
          }
        }
      })
    }
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
    eventChannel.on('getDeviceInfo',(data)=>{
      that.setData({
        deviceId:data
      })
    })
  },


  async getDeviceDetail(){
    let deviceId = this.data.deviceId;
    console.log(deviceId);
    const res = await request(`system/device/getDeviceInfoByDeviceId?deviceId=${deviceId}`,'get');
    console.log(res);
    if (res.code === 200) {
      this.setData({
        deviceInfo:res.data,
        lightStatus:res.data.relayStatus
      })
    }
  },

  async lightPower(){
    let lightStatus = this.data.lightStatus;
    let deviceInfo = this.data.deviceInfo;
    if (!deviceInfo.isOnline) {
      wx.showToast({
        title: '设备离线',
        icon:'error',
        mask:true
      });
      return;
    }
    if(lightStatus){
      var res = await request('system/device/control','post',{
        deviceNum:deviceInfo.deviceNum,
        cmd:'off'
      })
    }else if(!lightStatus){
      var res = await request('system/device/control','post',{
        deviceNum:deviceInfo.deviceNum,
        cmd:'on'
      })
    }
    if (res.code === 200) {
      this.setData({ lightStatus:!lightStatus })
    }
  },

  //打开分享的页面
  async isShared(options){
    if (options.hasOwnProperty('deviceInfo')) {
      this.checkLogin();
      const deviceInfo = JSON.parse(options.deviceInfo);
      this.setData({
        deviceInfo
      })
      const res = await request('system/device/bindDevice','post',{
        deviceNum:deviceInfo.deviceNum,
        deviceName:deviceInfo.deviceName,
        categoryId:deviceInfo.categoryId,
        remark:deviceInfo.remark
      });
      const result = await request(`system/status/new/${deviceInfo.deviceId}`,'GET');
      this.setData({
        power:result.data.relayStatus,
        isOnline:result.data.isOnline
      });
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
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    setTimeout(()=>{
      this.getDeviceDetail();
    },100)
    
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function (e) {
    return {
      title:"我分享了一个设备。",
      path:`/pages/4Gswitch/index?deviceInfo=${JSON.stringify(e.target.dataset.info)}&&isShare=1`,
      imageUrl:'/icons/light.png'
    }
  }
})