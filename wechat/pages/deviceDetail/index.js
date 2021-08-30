// miniprogram/pages/deviceDetail/index.js
const { request } = require('../../API/request')

Page({

  /**
   * 页面的初始数据
   */
  data: {
    newRemark:{},
    newName:'',
    info:{},
    show:false,
    deleteShow:false
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
      const data = await request(`system/device/getByUserAndNum/${res.deviceNum}`,'GET');
      that.setData({
        info:data.data
      })
    })
  },

  changeName(e){
    let info = this.data.info;
    info.deviceName = e.detail;
    this.setData({ info });
  },
  changeRemark(e){
    let info = this.data.info;
    info.remark = e.detail;
    this.setData({ info });
  },

  showDialog(){
    this.setData({ show:true })
  },

  async onConfirm(){
    let info = this.data.info;
    const { deviceName, remark } = info;
    if (deviceName.trim() === '') {
      wx.showToast({
        title: '名称不能为空!',
        icon:'error',
        mask:true
      });
      return;
    }
    const res = await request('system/device/updateDeviceInfo','post',{
      deviceId:info.deviceId,
      deviceName,
      remark,
    });
    wx.showToast({
      title: res.msg,
    })
    this.onClose();
  },
  onCancel(){
    this.onClose();
  },

  onClose(){
    this.setData({ show:false });
  },

  showDeleteDialog(){
    this.setData({
      deleteShow:true
    })
  },
  
  onCancelDelete(){
    this.setData({
      deleteShow:false
    })
  },

  onCloseDelete(){
    this.onCancelDelete();
  },
 
  async onConfirmDelete(){
    let deviceId = this.data.info.deviceId;
    const res = await request('system/device/unBindDevice','post',{
      deviceId
    });
    if (res.code === 200) {
      wx.showToast({
        title: '解除成功',
        icon:'success',
        mask:true,
        duration:1000
      });
      wx.reLaunch({
        url: '/pages/index/index',
      });
    }
  }

})