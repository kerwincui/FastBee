import request from '@/utils/request'
import axios from 'axios'
import { Message } from 'element-ui'
import { saveAs } from 'file-saver'
import { getToken } from '@/utils/auth'
import { blobValidate } from "@/utils/ruoyi";

const baseURL = process.env.VUE_APP_BASE_API;

// 注册方法
export function register(data) {
  return request({
    url: '/iot/tool/register',
    headers: {
      isToken: false
    },
    method: 'post',
    data: data
  })
}

// 下载文件
export function download(resource) {  
  var url = baseURL + "/iot/tool/download?fileName=" + encodeURI(resource);  
  axios({
    method: 'get',
    url: url,
    responseType: 'blob',
    headers: { 'Authorization': 'Bearer ' + getToken() }
  }).then(async (res) => {
    const isLogin = await blobValidate(res.data);
    if (isLogin) {
      const blob = new Blob([res.data])
      saveAs(blob, decodeURI(res.headers['download-filename']))
    } else {
      Message.error('无效的会话，或者会话已过期，请重新登录。');
    }
  })
}
