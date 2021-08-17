// miniprogram/pages/index/index.js
const { loginApi } = require('../../API/request.js');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    value:'',
    img:'',
    uuid:'',
    password:'admin123',
    username:'admin'
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.getCaptchaImage();
  },

  //获取验证码图片和uuid
  async getCaptchaImage(){
    const res = await loginApi('/captchaImage',{ method:'get' });
    const data = JSON.parse(res.result)
    this.setData({
      img:data.img,
      uuid:data.uuid
    })
  },


  //登录
  async submit(){
    wx.showLoading({
      title: '正在登录',
    })
    const res = await loginApi('/login',{      
      method:'POST',
      body:{
        code:this.data.value,
        uuid:this.data.uuid,
        password: this.data.password,
        username: this.data.username
      },
      json:true
    })
    wx.hideLoading();
    if (res.result.code !== 200) {
      wx.showToast({
        title: res.result.msg,
        icon:'error'
      });
      this.getCaptchaImage();
      return;
    }
    wx.setStorageSync('token', res.result.token);
    wx.switchTab({
      url: '/pages/index/index',
    })
  },
  

  inputUsername(e){
    this.setData({  username:e.detail });
  },
  inputPassword(e){
    this.setData({  password:e.detail });
  },
  onChange(e){
    this.setData({  value:e.detail });
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