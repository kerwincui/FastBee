// miniprogram/pages/add4G/index.js

const addOptions = {
  "categoryId": 0,
  "categoryName": "",
  "createBy": "",
  "createTime": "",
  "delFlag": "",
  "deviceId": 0,
  "deviceName": "",
  "deviceNum": "",
  "deviceTemp": 0,
  "firmwareVersion": "",
  "groupId": 0,
  "ownerId": "",
  "params": {},
  "remark": "",
  "searchValue": "",
  "updateBy": "",
  "updateTime": ""
}
Page({

  /**
   * 页面的初始数据
   */
  data: {
    imei:'',
    remark:'',
    deviceName:'',
    firmwareVersion:'1.0',
    show:false,//控制下拉列表的显示隐藏，false隐藏、true显示
    selectData:[
      { categoryId:1, categoryName:'WiFi通断器' },
      { categoryId:2, categoryName:'智能灯' },
      { categoryId:3, categoryName:'智能门锁' },
      { categoryId:4, categoryName:'智能水阀' },
      { categoryId:5, categoryName:'其它' },
    ],//下拉列表的数据
    selectedIndex:0//选择的下拉列表下标
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },
  selectTap(){
    this.setData({
      show: !this.data.show
    });
  },
  optionTap(e){
    const { index } = e.currentTarget.dataset;
    this.setData({
      selectedIndex:index,
      show:false
    })
  },
  scand(){
    const that = this;
    wx.scanCode({
      scanType:['barCode', 'qrCode'],
      success(res){
        that.setData({
          imei:res.result
        })
      }
    })
  },
  inputRemark(e){
    this.setData({
      remark:e.detail.value
    })
  },
  inputDeviceName(e){
    this.setData({
      deviceName:e.detail.value
    })
  },
  inputImei(e){
    this.setData({
      imei:e.detail.value
    })
  },

  submit(){
    let imei = this.data.imei;
    let remark = this.data.remark;
    let deviceName = this.data.deviceName;
    let firmwareVersion = this.data.firmwareVersion;
    let selectedIndex = this.data.selectedIndex;
    let selectData = this.data.selectData;
    if ((imei.trim() === '') || (deviceName.trim() === '')) {
      wx.showToast({
        title: '输入必填数据',
        icon:'error',
        mask:true
      })
      return;
    }else{
      wx.showLoading({
        title: '正在添加',
      });

      let options = addOptions;
      options.firmwareVersion = firmwareVersion;
      options.deviceNum = imei;
      options.deviceName = deviceName;
      options.remark = remark;
      options.categoryId = selectData[selectedIndex].categoryId;

      wx.request({
        url: 'http://localhost/dev-api/system/device',
        method:'POST',
        data:options,
        header:{
          "Authorization":wx.getStorageSync('token')
        },
        complete(){
          wx.hideLoading();
        },
        success(res){
          console.log(res);
        }
      })
    }

    
  }

})