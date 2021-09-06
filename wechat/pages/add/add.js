// pages/add/add.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    activeKey: 0,
    elementId:0,
    list:[
      {
        name: '4G设备', id: 0, devices: [
          { id: 0, name: "窗帘", des: '一键远程开机', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1568613757827.png" }
          , { id: 1, name: "灯", des: '一键远程开机', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585738057372.png" }
          , { id: 2, name: "插座", des: '一键远程开机', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585737911180.png" }
          , { id: 3, name: "开关", des: '一键远程开机', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585737869517.png" }
          , { id: 4, name: "灭蚊器", des: '一键远程开机', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1568972293729.png" }]
      }
      , {
        name: 'WiFi设备', id: 1, devices: [
          { id: 0, name: "空气净化器", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585735911905.png" }
          , { id: 1, name: "断路器", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1559631642708.png" }
          , { id: 2, name: "电饭煲", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585737625713.png" }
          , { id: 3, name: "冰箱", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585736782834.png" }
          , { id: 4, name: "油烟机", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585737687733.png" }
          , { id: 5, name: "地暖", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585735982904.png" }
          , { id: 6, name: "净水器", des: '智能，便捷', url: "http://iotx-paas-admin.oss-cn-shanghai.aliyuncs.com/publish/image/1585735954567.png" }
          ]
      }
    ],
    load:true,
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },

  changeTab:function(e){
    const { index } = e.currentTarget.dataset;
    this.setData({ 
      activeKey:index,
      elementId:index
    });
  },
  
  scroll:function(e){
    let that = this;
    let list = this.data.list;
    let tabHeight = 0;
    if (this.data.load) {
      for (let i = 0; i < list.length; i++) {
        let view = wx.createSelectorQuery().select("#main-" + list[i].id);
        view.fields({
          size: true
        }, data => {
          list[i].top = tabHeight;
          tabHeight = tabHeight + data.height;
          list[i].bottom = tabHeight;
        }).exec();
      }
      that.setData({
        load: false,
        list: list
      })
    }
    let scrollTop = e.detail.scrollTop - 25 ;
    for (let i = 0; i < list.length; i++) {
      if (scrollTop > list[i].top && scrollTop < list[i].bottom) {
        that.setData({
          activeKey: list[i].id
        })
        return false
      }
    }
  },


  goToBindDevice(e){
    if(e.currentTarget.dataset.type === 0){
      this.addFourG();
    }else if(e.currentTarget.dataset.type === 1){
      this.addWifi();
    };
  },
  addFourG(){
    wx.navigateTo({
      url: '/pages/add4G/index',
    })
  },
  addWifi(){
    // wx.showToast({
    //   title: '暂不支持',
    //   icon:'error'
    // })
    wx.navigateTo({
      url: '/pages/addWiFi/index',
    })
  },
})