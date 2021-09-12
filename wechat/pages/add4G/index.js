// miniprogram/pages/add4G/index.js
const { request } = require('../../API/request.js');
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
    selectData:[],//下拉列表的数据
    selectedIndex:0//选择的下拉列表下标
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.getCategoryList();
  },

  async getCategoryList(){
    const res = await request('system/category/list','get');
    this.setData({
      selectData:res.rows
    })
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
        let imei = res.result.substring(res.result.lastIndexOf('/')+1);
        if (imei == '') {
          wx.showToast({
            title: 'imei错误',
            icon:'error',
            mask:true
          })
          return;
        }
        that.setData({
          imei:imei
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

  async submit(){
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
      let options = {};
      options.deviceNum = imei;
      options.deviceName = deviceName;
      options.remark = remark;
      options.categoryId = selectData[selectedIndex].categoryId;
      
      const res = await request('system/device/bindDevice','post',options);
      if (res.code === 200) {
        wx.showToast({
          title: '添加成功',
          mask:true
        });
        wx.reLaunch({
          url: '/pages/index/index',
        })
      }
    }  
  }
})