// miniprogram/pages/deviceControl/PM2.5/index.js
import * as echarts from '../../ec-canvas/echarts';

 function initChart(canvas, width, height, dpr) {
  const chart = echarts.init(canvas, null, {
    width: width,
    height: height,
    devicePixelRatio: dpr // 像素
  });
  canvas.setChart(chart);

  var option = {
    title:{ text:'污染物浓度趋势',bottom:15,left:'33%' },
    xAxis:{ maxInterval: 3600 * 1000, data:['8:00','9:00','10:00','11:00','12:00','13:00'],nameTextStyle:{
      color:'#fff'
    } },
    yAxis:{ type:'value',name:'μg/m³',max:50, min:0 ,show:true ,splitNumber:5 },
    legend:{
      data:['PM2.5','PM10','PM1.0'],
      z:100
    },
    legend:{ textStyle:{ color:'#fff' } },
    textStyle:{ color:'#fff' },
    series:[
      { type:'bar',name:'PM2.5', smooth:true, data: [27, 22, 25, 31, 32, 26] },
      { type:'line',name:'PM10', smooth:true, data: [28, 27, 28, 30, 28, 28] },
      { type:'line',name:'PM1.0', smooth:true, data: [22, 24, 22, 23, 22, 24] }
    ],
    axisPointer:{ show:true,type:'line',snap:true }
  };
  chart.setOption(option);
  return chart;
};


Page({

  /**
   * 页面的初始数据
   */
  data: {
    deviceInfo:{},
    deviceData:[],
    ec: {
      onInit:initChart
    }

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // this.getServerData();
    // this.getLastPageData();
    // this.getDeviceAttribute();
    wx.setNavigationBarTitle({
      title: 'PM2.5监测',
    })
  },

  //获取上一页的数据
  getLastPageData(){
    const that = this;
    const eventChannel = this.getOpenerEventChannel();
    eventChannel.on('getDeviceInfo',(data)=>{
      wx.setNavigationBarTitle({
        title: data.product_name
      });
      that.setData({ deviceInfo:data })
    })
  },

  //获取设备属性数据

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