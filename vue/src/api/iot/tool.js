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

// 查询用户列表
export function listUser(query) {
  return request({
    url: '/iot/tool/userList',
    method: 'get',
    params: query
  })
}
