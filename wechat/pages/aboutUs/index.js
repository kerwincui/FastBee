// miniprogram/components/aboutUs/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    info:{}
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.getLastPageData();
  },

  getLastPageData(){
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.on('getInfo',(res)=>{
      this.setData({
        info:res
      });
      wx.setNavigationBarTitle({
        title: res.name,
      })
    })
  },
  
})