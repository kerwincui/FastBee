// pages/my/my.js
Page({
  data: {
    userInfo:{},
    isLogin:false,
    items:[
      { flag:'info',name:'公司简介',icon:'/icons/jianjie.png' },
      { flag:'join',name:'加入我们',icon:'/icons/join.png' },
      { flag:'address',name:'联系方式',icon:'/icons/about.png' }  
    ]
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

  lookMore(e){
    console.log(e);
    wx.navigateTo({
      url: '/pages/aboutUs/index',
      success(res){
        res.eventChannel.emit('getInfo',e.currentTarget.dataset.info)
      }
    })
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