// miniprogram/pages/deviceDetail/index.js
const { requestApi } = require('../../API/request')

Page({

  /**
   * 页面的初始数据
   */
  data: {
    newRemark:{},
    newName:'',
    info:{},
    show:false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.getLastPageData();
  },

  getLastPageData(){
    const that = this;
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.on('getDeviceInfo', async(res)=>{
      const data = await requestApi(`/system/device/getByNum/${res.deviceNum}`,{ method:'GET' });
      that.setData({
        info:JSON.parse(data.result).data
      })
    })
  },

  changeName(e){
    this.setData({ newName:e.detail })
  },
  changeRemark(e){
    this.setData({ newRemark:e.detail })
  },

  showDialog(){
    this.setData({ show:true })
  },
  async onConfirm(){
    wx.showLoading({
      title: '正在提交',
    });
    let info = this.data.info;
    info.deviceName = this.data.newName;
    info.newRemark = this.data.newRemark;
    const res = await requestApi('/system/device',{
      method:'PUT',
      body:info,
      json:true
    });
    wx.hideLoading();
    wx.showToast({
      title: res.result.msg,
    })
    this.onClose();
  },
  onCancel(){
    this.onClose();
  },

  onClose(){
    this.setData({ show:false });
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
  onShareAppMessage: function () {

  }
})