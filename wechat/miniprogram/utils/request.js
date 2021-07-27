const CryptoJs = require('crypto-js');
const HmacSHA1 = require('crypto-js').HmacSHA1;
const { Base64,Utf8 } = require('crypto-js').enc;
const application = 'YoWrZ2mYoZc'; //app_key
const appSecret = 'qGJEtGEyfj';  //app_secret

//获取服务器返回的时间戳
const getTimestamp=()=>{
  return new Promise((resolve,reject)=>{
    wx.request({
      url: 'https://ag-api.ctwing.cn/echo',
      timeout: 0,
      success: (result) => {
        resolve(result.header['x-ag-timestamp'])
      },
      fail: (err)=>{
        reject(err)
      }
    })
  })
};
//计算时间偏移量offset
const getOffset = async ()=>{
  const start = (new Date()).valueOf(); //获取当前系统时间戳
  const time = await getTimestamp();
  const end = (new Date()).valueOf();
  const offset = Math.round(time - (start + end)/2);
  return offset;
};

//对象按名称ASCII码排序
function sort_ASCII(obj){
  var arr = new Array();
  var num = 0;
  for (var i in obj) {
    arr[num] = i;
    num++;
  }
  //sort方法让数组元素按ASCII码排序
  var sortArr = arr.sort();
  var sortObj = {};
  for (var i in sortArr) {
    sortObj[sortArr[i]] = obj[sortArr[i]];
  }
  return sortObj;
}

//将公共参数封装到请求中
//url 请求地址 + 路径
//method 请求方式
//version API版本号
//data 对象格式 非公共请求参数,如果不是必选参数，可以给其赋予空值，例如 { "pageSize":"" }
//body 请求体参数
export const request = async (url,method,version,data,body)=>{
  data = (sort_ASCII(data)) || null;
  const offset = await getOffset();
  const timestamp = (new Date()).valueOf() + offset;
  let params = data;
  let Data = {
    'application':application,
    'timestamp':timestamp,
    ...data
  };
  //生成要签名的字符串
  let dataStr = JSON.stringify(Data).replace(/[\"|\{]/g,'').replace(/[\,|\}]/g,'\n'); 
  if(body && body!== {}){
    dataStr += (JSON.stringify(body).concat('\n'));
    params = body;
    if (data && Object.keys(data).length>1) {
      let query = '';
      for(let k in data){
        if (k === 'MasterKey') {
          continue;
        } 
        query += `${ k }=${ data[k] }&`;
      }
      url = `${ url }?${ query }`
    }
  }

  //生成签名
  const signature = Base64.stringify(HmacSHA1(dataStr.toString(Utf8),appSecret));
  let header = {
        'application':application,
        'signature':signature,
        'timestamp':timestamp,
        'version':version
  };
  if (data.MasterKey) {
    header.MasterKey = data.MasterKey;
  }
  return new Promise((resolve,reject)=>{
    wx.request({
      url: `https://${ url }`,
      method:method,
      data: params,
      //公共参数封装到请求头
      header:header,
      success: (result) => {
        resolve(result);
      },
      fail: (res) => {
        reject(res);
      },
    })
  })
}
