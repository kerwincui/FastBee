/*
 * @Author: daidai
 * @Date: 2021-12-06 15:53:24
 * @LastEditors: Please set LastEditors
 * @LastEditTime: 2022-04-22 09:31:24
 * @FilePath: \web-pc\src\lib\currency.js
 */
import router from '@/router'
import { isString, isHtmlElement } from './types'
export const returnWeek = () => {
  var week = new Date().getDay();
  switch (week) {
    case 1:
      return '周一'
    case 2:
      return '周二'
    case 3:
      return '周三'
    case 4:
      return '周四'
    case 5:
      return '周五'
    case 6:
      return '周六'
    case 0:
      return '周日'
  }
}

/**
 * 获取uuid
 */
export function getUUID() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, c => {
    return (c === 'x' ? (Math.random() * 16 | 0) : ('r&0x3' | '0x8')).toString(16)
  })
}

/**
 * 是否有权限
 * @param {*} key
 */
export function isAuth(key) {
  // console.log("key",key,sessionStorage.getItem('permissions'))
  // if(process.env.VUE_APP_CONFIG=="dev"){
  //   return true
  // }
  return JSON.parse(sessionStorage.getItem('permissions') || '[]').indexOf(key) !== -1 || false
}
export const rowClassName = ({ row, rowIndex }) => {
  if (rowIndex % 2 == 0) {
    return 'lightColour';
  } else {
    return 'DarkColor';
  }
}

export const getToken = () => {
  return localStorage.getItem("token");
}
//跳转当前页面并传参
export const currentQuery = (param) => {
  let newParam = { ...param }
  for (let i in newParam) {
    if (newParam[i] === "") {
      delete newParam[i]
    }
  }
  // console.log(newParam)
  router.push({
    path: router.currentRoute.path,
    query: newParam
  })
}
/**
 * 树形数据转换
 * @param {*} data
 * @param {*} id
 * @param {*} pid
 * @param {*} order
 */
export function treeDataTranslate(data, id, pid, order) {
  // console.log(Array.isArray(data))
  if (data == null || !Array.isArray(data)) {
    return [];
  }
  if (order) {
    data.sort(function (a, b) {
      return a[order] - b[order];
    })
  }
  // console.log(data)
  var res = []
  var temp = {}
  for (var i = 0; i < data.length; i++) {
    temp[data[i][id]] = data[i]
  }
  for (var k = 0; k < data.length; k++) {

    if (temp[data[k][pid]] && data[k][id] !== data[k][pid]) {
      if (!temp[data[k][pid]]['subs']) {
        temp[data[k][pid]]['subs'] = []
      }
      if (!temp[data[k][pid]]['_level']) {
        temp[data[k][pid]]['_level'] = 1
      }
      data[k]['_level'] = temp[data[k][pid]]._level + 1
      temp[data[k][pid]]['subs'].push(data[k])


    } else {
      res.push(data[k])
    }
  }
  // console.log(outurls)
  // console.log(res)
  return res
}

//带了一个 margin-left  
export const dragss = (e, marginleft) => {

  let odiv = e.currentTarget.parentElement;
  let disX = e.clientX - odiv.offsetLeft;
  let disY = e.clientY - odiv.offsetTop;
  document.onmousemove = (e) => {
    odiv.style.left = e.clientX - disX + marginleft + 'px';
    odiv.style.top = e.clientY - disY + 'px';
    return false;
  };
  document.onmouseup = (e) => {
    document.onmousemove = null;
    document.onmouseup = null;
  };
  return false;
}

//转base64

export const turnStr = (data) => {
  return window.btoa(window.encodeURI(JSON.stringify(data)));
}
// 验证只能输入数字和小数，小数且只能输入2位，第一位不能输入小数点
//   .replace(/[^\d.]/g, '')
//   .replace(/\.{2,}/g, '.')
//   .replace('.', '$#$')
//   .replace(/\./g, '')
//   .replace('$#$', '.')
//   .replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3')
//   .replace(/^\./g, '')
/**
 * 清除登录信息
 */
export function clearLoginInfo() {
  router.options.isAddDynamicMenuRoutes = false;
  localStorage.removeItem('token')
  sessionStorage.removeItem("menuList")
  sessionStorage.removeItem("permissions")
}


//对象拼成路径传参
export const convertObj = (data) => {
  var _result = [];
  for (var key in data) {
    var value = data[key];
    if (value.constructor == Array) {
      value.forEach(function (_value) {
        _result.push(key + "=" + _value);
      });
    } else {
      _result.push(key + '=' + value);
    }
  }
  return _result.join('&');
}
//判断浏览器
function getExplorer() {
  var explorer = window.navigator.userAgent;
  if (explorer.indexOf('MSIE') >= 0) {
    return 'ie';        // ie
  } else if (explorer.indexOf('Firefox') >= 0) {
    return 'Firefox';   // firefox
  } else if (explorer.indexOf('Chrome') >= 0) {
    return 'Chrome';    // Chrome
  } else if (explorer.indexOf('Opera') >= 0) {
    return 'Opera';     // Opera
  } else if (explorer.indexOf('Safari') >= 0) {
    return 'Safari';    // Safari
  } else if (!!explorer.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)) {
    return 'IOS';
  } else if (u.indexOf('Android') > -1 || u.indexOf('Adr') > -1) {
    return 'Android';
  } else {
    return explorer
  }
};

//导出文档流
export const exportFile = (data, name) => {
  return new Promise((resolve, reject) => {
    let types = getExplorer()
    if (types == 'IOS') {
      resolve({
        success: false,
        msg: "请使用设备自带浏览器导出！"
      })
      return
    }
    if (data.type && data.type.indexOf('application/vnd.ms-excel') >= 0) {
      // console.log(data)
      try {
        let blob = new Blob([data], {
          type:data.type|| 'application/vnd.ms-excel;charset=UTF-8'
        })
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
          window.navigator.msSaveOrOpenBlob(blob, name);
        } else {
          const link = document.createElement('a')
          link.style.display = 'none';
          link.href = URL.createObjectURL(blob);
          if (types == 'Safari') {
            link.download = `${name || "未命名"}`;
          } else {
            link.download = `${name || "未命名"}.xlsx`;
          }
          // Safari thinks _blank anchor are pop ups. We only want to set _blank
          // target if the browser does not support the HTML5 download attribute.
          // This allows you to download files in desktop safari if pop up blocking
          // is enabled.
          if (typeof link.download === 'unde fined') {
            tempLink.setAttribute('target', '_blank');
          }
          document.body.appendChild(link)
          link.click()
          // Fixes "webkit blob resource error 1"
          let timer = setTimeout(function () {
            document.body.removeChild(link)
            window.URL.revokeObjectURL(link.href);
            clearTimeout(timer)
          }, 200)
        }
        resolve({
          success: true,
          msg: "导出成功"
        })
      } catch (error) {
        resolve({
          success: false,
          msg: "未知异常，请联系管理员！"
        })
      }
    } else {
      // console.log(data)
       readFile(data).then(res => {
        resolve(res)
      }).catch(err => {
        resolve({
          success: false,
          msg: "未知异常，请联系管理员！"
        })
      })
    }
  })

}
//阅读 blod
export const readFile = (data) => {
  return new Promise((resole, reject) => {
    if (Object.prototype.toString.call(data)==='[object Blob]') {
      let reader = new FileReader()
      reader.readAsText(data, 'utf-8')
      reader.onload = (e) => {
        console.log('--导出--', JSON.parse(reader.result))
        let result = JSON.parse(reader.result)
        if (result.code == 401) {
          router.push("/login")
        }
        resole(result)
      }
    } else {
      resole(data)
    }

    // reader.readAsText(data)
  })

}

//element 时间选择



export const shortcuts = [{
  text: '最近一周',
  onClick(picker) {
    const end = new Date();
    const start = new Date();
    start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
    picker.$emit('pick', [start, end]);
  }
}, {
  text: '最近一个月',
  onClick(picker) {
    const end = new Date();
    const start = new Date();
    start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
    picker.$emit('pick', [start, end]);
  }
}, {
  text: '最近三个月',
  onClick(picker) {
    const end = new Date();
    const start = new Date();
    start.setTime(start.getTime() - 3600 * 1000 * 24 * 89);
    picker.$emit('pick', [start, end]);
  }
}]
export const pickerOptions = {
  shortcuts: shortcuts
}
/**
 * 清除相同
 * @param {*} origin
 * @param {*} target
 */
export const ArrayCleanRepeat = (origin, target) => {
  if (target) origin = origin.concat(target);
  const result = []
  const tagObj = {}
  for (const i of origin) {
    if (!tagObj[i]) {
      result.push(i)
      tagObj[i] = 1
    }
  }
  return result
}
/**
 * @description: 
 * @param {file:Object} 文件
 * @return {*}
 */
export const beforeUpoads = (file) => {
  // console.log(file)
  var testmsg = file.name.substring(file.name.lastIndexOf('.') + 1)
  if (
    testmsg != 'png' &&
    testmsg != 'jpg' &&
    testmsg != 'jpeg' &&
    testmsg != 'webp'
  ) {
    // testmsg != 'gif' &&
    return {
      success: false,
      msg: "上传图片格式不正确！"
    }
  }
  const if10M = file.size / 1024 / 1024 < 20
  if (!if10M) {
    return {
      success: false,
      msg: "上传图片大小不能超过20M!"
    }
  }
  // console.log("上传前",file, this.filelist)
  return {
    success: true
  }
}
//复制文字
export const copy = (value) => {
  let transfer = document.createElement('input')

  document.body.appendChild(transfer)
  transfer.value = value // 这里表示想要复制的内容
  transfer.focus()
  transfer.select()
  if (document.execCommand('copy')) {
    document.execCommand('copy')
  }
  transfer.blur()
  document.body.removeChild(transfer)
  //选中文字
  //   let range = document.createRange()
  //   let referenceNode = this.$refs.xy
  //   range.selectNodeContents(referenceNode)
  //   var selection = window.getSelection()
  //   selection.removeAllRanges()
  //   selection.addRange(range)
}
// 取出两个数组的不同元素
export const getArrDifference = (arr1, arr2) => {
  return arr1.concat(arr2).filter(function (v, i, arr) {
    return arr.indexOf(v) === arr.lastIndexOf(v);
  });
}

/**
 * 表格最大高度
 * @param {ElementDom} dom 
 * @param {Boolean} isPaging 是否拥有分页 false 没有 ||  true 有 默认有
 * @returns 
 */
export const tableHeight = (dom,isPaging=true) => {
  //定位父级到文档高度
  if (isString(dom)) {
    dom = document.querySelector(dom)
    // if (dom) {
    //   return window.innerHeight - top
    // }
  }
  if (isHtmlElement(dom)) {
    var parent = dom.offsetParent;
    var top = dom.offsetTop
    if(isPaging){
      top= top+ 63 + 4
    }else{
      top= top+ 16
    }
    while (parent != null) {
      top += parent.offsetTop;
      parent = parent.offsetParent;
    };
    return window.innerHeight - top
  }

  return null
}

//
