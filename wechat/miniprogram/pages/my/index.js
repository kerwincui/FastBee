var app = getApp();

Page({
  data: {
    userInfo: {},
    mode: [
      { flag:'info',name:'关于我们' }, 
      { flag:'join',name:'加入我们' }, 
      { flag:'address',name:'联系方式' }
    ]
  },
  onLoad: function () {
  },
  getOut(){
    wx.showModal({
      cancelColor: '#ff0000',
      cancelText: '取消',
  
      confirmText: '确定',
      content: '您确定要退出吗？',
      showCancel: true,
      success: (res) => {
        if(res.confirm){
          wx.clearStorage({
            success: (res) => {
              wx.reLaunch({
                url: '/pages/login/index',
              })
            },
          })
        }
      },
    })
    
  },

  aboutus(e){
    wx.navigateTo({
      url: '/pages/aboutUs/index',
      success(res){
        res.eventChannel.emit('getInfo',e.currentTarget.dataset.data)
      }
    })
  },
})