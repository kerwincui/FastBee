// pages/my/my.js
Page({
  data: {
    userInfo:{},
    isLogin:false
  },

  getUserInfo(){
    const that = this;
    wx.showLoading({
      title: '正在登录'
    });
    wx.getUserProfile({
      desc:'用以展示您的头像和昵称等信息',
      success(res){
        console.log(res);
        wx.setStorageSync('userInfo',JSON.parse(res.rawData));
        wx.setStorageSync('isLogin',true);
        that.setData({
          userInfo:JSON.parse(res.rawData),
          isLogin:true
        })
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
  },

  getPhoneNumber(e){
    console.log('===========');
    console.log(e);
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      userInfo:wx.getStorageSync('userInfo'),
      isLogin:wx.getStorageSync('isLogin') || false
    })
  },

  
})