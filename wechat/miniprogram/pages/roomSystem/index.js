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
    fanShow:false,
    tempShow:false,
    realMaxTempValue:50,
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
    this.setData({ 
      currentValue:this.data.realMaxTempValue,
      maxTempValue:this.data.realMaxTempValue
    });  

    this.getLastPageData();
    this.query();
  },


  //查询设备最新数据
  async query(){
    const res = await requestApi(`/system/status/newByNum/${this.data.deviceInfo.deviceNum}`,{ method:'GET' });
    let light_power;
    if (res.data.data.lightStatus === 0) {
      light_power = false;
    }else if (res.data.data.lightStatus === 1) {
      light_power =true;
    }
    this.setData({ 
      nowDeviceData:res.data.data,
      light_power
    })
  },




  getLastPageData(){
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.on('getDeviceInfo',(data)=>{
      this.setData({ deviceInfo:data })
    })
  },


  initParams(){
    // const params = {
    //   deviceNum: this.data.deviceInfo.deviceNum,
    //   relayStatus: this.data.nowDeviceData.relayStatus,
    //   lightStatus: this.data.nowDeviceData.lightStatus,
    //   isOnline: this.data.nowDeviceData.isOnline,
    //   rssi: this.data.nowDeviceData.rssi,
    //   deviceTemperature: this.data.nowDeviceData.deviceTemperature,
    //   airTemperature: this.data.nowDeviceData.airTemperature,
    //   airHumidity: this.data.nowDeviceData.airHumidity,
    //   triggerSource: this.data.nowDeviceData.triggerSource,
    //   brightness: this.data.nowDeviceData.brightness,
    //   lightInterval: this.data.nowDeviceData.lightInterval,
    //   lightMode: this.data.nowDeviceData.lightMode,
    //   fadeTime: this.data.nowDeviceData.fadeTime,
    //   red: this.data.nowDeviceData.red,
    //   green: this.data.nowDeviceData.green,
    //   blue: this.data.nowDeviceData.blue,
    //   other:this.data.nowDeviceData.other
    //  };
    const params = this.data.nowDeviceData;
    return params;
  },

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
  onChangeCurtainPower(){
    let curtainPowerChecked = this.data.curtainPowerChecked;
    if (this.data.curtainManvalChecked) {
      this.setData({ curtainPowerChecked:!curtainPowerChecked })
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
  onMakeSure(){
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