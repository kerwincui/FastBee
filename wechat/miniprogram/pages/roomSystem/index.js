// miniprogram/pages/roomSystem/index.js
const { requestApi } = require('../../API/request.js');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    light_power:false,
    gradientColor: {
      '0%': '#ffd01e',
      '100%': '#ee0a24',
    },
    curtainShow:false,
    curtainAutoChecked:true,
    curtainManvalChecked:false,
    curtainPowerChecked:false,
    fanAutoChecked:true,
    fanManvalChecked:false,
    fanPowerChecked:false,
    fanShow:false,
    tempShow:false,
    realMaxTempValue:'',
    maxTempValue:0,
    currentValue:0,
    deviceInfo:{},
    nowDeviceData:{}
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.setNavigationBarTitle({
      title: '智能宿舍系统',
    })
    this.getLastPageData();
    this.query();
  },


  //查询设备最新数据
  async query(){
    const res = await requestApi(`/system/status/newByNum/${this.data.deviceInfo.deviceNum}`,{ method:'GET' });
    let light_power;
    let relayStatus;
    if (res.data.data.lightStatus === 0) {
      light_power = false;
    }else if (res.data.data.lightStatus === 1) {
      light_power =true;
    }
    if (res.data.data.relayStatus === 0) {
      relayStatus = false;
    }else if (res.data.data.relayStatus === 1) {
      relayStatus = true;
    }
    this.setData({ 
      nowDeviceData:res.data.data,
      light_power,
      curtainPowerChecked:relayStatus,
      currentValue:res.data.data.airTemperature,
      maxTempValue:res.data.data.airTemperature,
      realMaxTempValue: res.data.data.airTemperature
    })
  },




  getLastPageData(){
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.on('getDeviceInfo',(data)=>{
      this.setData({ deviceInfo:data })
    })
  },


  initParams(){
    const params = this.data.nowDeviceData;
    return params;
  },

  //灯开关
  async lightPower(){
    let light_power = this.data.light_power;
    let lightStatus;
    if (light_power === false) {
      lightStatus = 1;
    }else if (light_power === true) {
      lightStatus = 0;
    }
    let params = this.initParams();
    params.lightStatus = lightStatus;
    const res = await requestApi(`/system/status`,{
      method:'PUT',
      data:params
    });
    console.log('lightres:',res);
    if (res.data.code !== 200) {
      wx.showToast({
        title: '操作失败',
        icon:'error'
      })
      return;
    }
    this.setData({ light_power:!light_power });
  },

  showCurtain(){
    this.setData({
      curtainShow:true
    })
  },

  onAutoCurtainMode(){
    let curtainAutoChecked = !this.data.curtainAutoChecked;
    this.setData({
      curtainAutoChecked:curtainAutoChecked,
      curtainManvalChecked:!curtainAutoChecked
    })
  },
  onManvalCurtainMode(){
    let curtainManvalChecked = !this.data.curtainManvalChecked;
    this.setData({
      curtainAutoChecked:!curtainManvalChecked,
      curtainManvalChecked:curtainManvalChecked
    })
  },

  //窗帘开关
  async onChangeCurtainPower(){
    // let curtainPowerChecked = this.data.curtainPowerChecked;
    // let relayStatus;
    // if (curtainPowerChecked === false) {
    //   relayStatus = 1;
    // }else if (curtainPowerChecked === true) {
    //   relayStatus = 0;
    // }
    // if (this.data.curtainManvalChecked) {
    //   let params = this.initParams();
    //   params.relayStatus = relayStatus;
    //   const res = await requestApi(`/system/status`,{
    //     method:'PUT',
    //     data:params
    //   });
    //   console.log('窗帘:',res);
    //   if (res.data.code !== 200) {
    //     wx.showToast({
    //       title: '操作失败',
    //       icon:'error'
    //     })
    //     return;
    //   }
    //   this.setData({ curtainPowerChecked:!curtainPowerChecked })
    // }
  },



  onAutoFanMode(){
    let fanAutoChecked = !this.data.fanAutoChecked;
    this.setData({
      fanAutoChecked:fanAutoChecked,
      fanManvalChecked:!fanAutoChecked
    })
  },
  onManvalFanMode(){
    let fanManvalChecked = !this.data.fanManvalChecked;
    this.setData({
      fanAutoChecked:!fanManvalChecked,
      fanManvalChecked:fanManvalChecked
    })
  },

  //风扇开关
  async onChangeFanPower(){
    let fanPowerChecked = this.data.fanPowerChecked;
    let relayStatus;
    if (fanPowerChecked === false) {
      relayStatus = 1;
    }else if (fanPowerChecked === true) {
      relayStatus = 0;
    }
    if (this.data.fanManvalChecked) {
      let params = this.initParams();
      params.relayStatus = relayStatus;
      const res = await requestApi(`/system/status`,{
        method:'PUT',
        data:params
      });
      console.log('窗帘:',res);
      if (res.data.code !== 200) {
        wx.showToast({
          title: '操作失败',
          icon:'error'
        })
        return;
      }
      this.setData({ fanPowerChecked:!fanPowerChecked })
    }
  },
  
  showFan(){ 
    this.setData({
      fanShow:true
    })
  },
  showTemp(){ 
    this.setData({
      tempShow:true
    })
  },
  onChangeValue(e){

    this.setData({ maxTempValue:e.detail,currentValue:e.detail })
  },
  onDrag(e){
    this.setData({ currentValue:e.detail.value })
  },
  onCancel(){
    this.setData({
      maxTempValue:this.data.realMaxTempValue,
      currentValue:this.data.realMaxTempValue,
      tempShow:false
    })
  },
  async onMakeSure(){
    const params = this.initParams();
    params.airTemperature = this.data.maxTempValue;
    const res = await requestApi('/system/status',{
      method:'PUT',
      data:params
    });
    if (res.data.code !== 200) {
      wx.showToast({
        title: '操作失败',
        icon:'error'
      })
      return;
    }
    this.setData({ 
      realMaxTempValue:this.data.maxTempValue,
      tempShow:false
     })
  },
  onClose(){
    this.setData({
      curtainShow:false,
      fanShow:false
    })
    this.onCancel();
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