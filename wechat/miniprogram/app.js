//app.js
import { request } from "./utils/request.js";

App({
  onLaunch:async function () {

  // const res =await request('ag-api.ctwing.cn/aep_product_management/products','GET',20190507004824,
  // {
  //   'searchValue':'',
  //   'pageSize':'',
  //   'pageNow':''
  // });
  // const res = await request('ag-api.ctwing.cn/aep_device_management/device','PUT',20181031202122,
  // {'MasterKey':'f9ceed06f3374bb28cfc0083e2899bac',
  //  'deviceId':'15058943ssdhhsnfvvf23'
  // },
  // {
  //   "deviceName": "ssd",
  //   "operator": "qll",
  //   "productId": 15058943
  // })

    if (!wx.cloud) {
      console.error('请使用 2.2.3 或以上的基础库以使用云能力')
    } else {
      wx.cloud.init({
        // env 参数说明：
        //   env 参数决定接下来小程序发起的云开发调用（wx.cloud.xxx）会默认请求到哪个云环境的资源
        //   此处请填入环境 ID, 环境 ID 可打开云控制台查看
        //   如不填则使用默认环境（第一个创建的环境）
        env: 'mmydev-1ge33h7a9c3abf3fy-env-id',
        traceUser: true,
      })
    }

    this.globalData = {}
  }
})
