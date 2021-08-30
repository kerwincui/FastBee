// pages/feedBack/feedBack.js

const { request } = require('../../API/request');

Page({

  /**
   * 页面的初始数据
   */
  data: {
    selectData:[
      { id:1,text:'程序bug' },
      { id:2,text:'内容意见' },
      { id:3,text:'网络问题' },
      { id:4,text:'功能建议' },
      { id:5,text:'其他' }
    ],
    maxlength:200,
    radio: 1,
    value:'',
    tempFilePaths:[],
    phoneNum:'',
    lengthErr:false
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    wx.setNavigationBarTitle({
      title: '意见反馈'
    });
    wx.setNavigationBarColor({
      backgroundColor: '#58bcff',
      frontColor: '#ffffff',
    })
  },

  checkOne(e){
    this.setData({
      radio:e.detail
    })
  },
  
  inputDetail(e){
    if (e.detail.value.trim().length >= 15) {
      this.setData({
        lengthErr:false
      })
    }
    this.setData({
      value:e.detail.value
    })
  },

  chooseImage(){
    const that = this;
    let tempFilePaths = this.data.tempFilePaths;
    wx.chooseImage({
      count: 3,
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: (result) => {
        that.setData({
          tempFilePaths:tempFilePaths.concat(result.tempFilePaths)
        })
      }
    })
  },

  previewImage(e){
    console.log(e);
    wx.previewImage({
      urls: this.data.tempFilePaths,
      current:this.data.tempFilePaths[e.currentTarget.dataset.index]
    })
  },

  deleteImage(e){
    let tempFilePaths = this.data.tempFilePaths;
    tempFilePaths.splice(e.currentTarget.dataset.index,1);
    this.setData({
      tempFilePaths
    })
  },
  inputNum(e){
    this.setData({
      phoneNum:e.detail.value
    })
  },

  async submit(){
    const tempFilePaths = this.data.tempFilePaths;
    const describe = this.data.value;
    const phone = this.data.phoneNum;
    const radio = this.data.radio;
    if(describe.trim().length < 15){
      this.setData({
        lengthErr:true
      })
      return;
    }
    const res = await request('','post',{
      phone,
      tempFilePaths,
      describe,
      type:this.data.selectData[radio-1]
    });
    if (res.code === 200) {
      wx.switchTab({
        url: '/pages/my/my',
      })
    }
  }
})