/**
 * 深复制
 * @param {any} obj 需要复制的对象
 * @returns
 */
export const deepClone = (obj) => {
  if (typeof obj == 'object') {
    const objClone = Array.isArray(obj) ? [] : {};
    for (const key in obj) {
      if (Object.prototype.hasOwnProperty.call(obj, key)) {
        if (obj[key] && typeof obj[key] == 'object') {
          objClone[key] = deepClone(obj[key]);
        } else {
          objClone[key] = obj[key];
        }
      }
    }
    return objClone;
  }
  return obj;
};

/**
 * @desc 时间戳转日期毫秒
 * @param {Date} format 时间格式 Y:年，M:月，D:天 h:小时，m:分钟，s:秒 默认:'Y/M/D h:m'
 */
export function formatDate(arg, format) {
  // console.log(typeof arg.toString());
  let now;
  if (!arg) {
    return null;
  } else {
    now = new Date(arg);
  }
  format = format || 'Y.M.D h:m';

  const year = now.getFullYear();
  let month = now.getMonth() + 1;
  month = month >= 10 ? month : '0' + month;
  let date = now.getDate();
  date = date >= 10 ? date : '0' + date;
  let hour = now.getHours();
  hour = hour >= 10 ? hour : '0' + hour;
  let minute = now.getMinutes();

  minute = minute >= 10 ? minute : '0' + minute;
  let second = now.getSeconds();
  second = second >= 10 ? second : '0' + second;
  return format
    .replace('Y', year)
    .replace('M', month)
    .replace('D', date)
    .replace('h', hour)
    .replace('m', minute)
    .replace('s', second);
}
/**
 * @desc 保留多少位小数
 * @param {Number} value 数字
 * @param {Number} number 保留多少位小数
 */
export function keepDecimal(value, number) {
  let num = 1;
  for (let i = 0; i < number; i++) {
    num += '0';
  }
  num = parseInt(num);
  return parseInt(value * num) / num;
}

/**
 * 获取是什么时间
 * @param {Number} value
 * @param {String} type second minute hour day
 * @param {Number} 精确度保留多少位小数
 */
export function calcTimeText(value, type, accuracy) {
  value = parseInt(value);

  if (parseInt(type) === 0) {
    type = 'minute';
  }
  let num = 1;
  for (let i = 0; i < accuracy; i++) {
    num += '0';
  }
  num = parseInt(num);

  if (type === 'second' && value >= 60) {
    value = value / 60;
    type = 'minute';
  }
  if (type === 'minute' && value >= 60) {
    value = value / 60;
    type = 'hour';
  }

  if (type === 'hour' && value >= 24) {
    value = value / 24;
    type = 'day';
  }

  return {
    type: type,
    value: parseInt(num * value) / num,
  };
}

//将完整的base64转换为blob
export function base64toBlob(dataurl) {
  var arr = dataurl.split(','),
    mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]),
    n = bstr.length,
    u8arr = new Uint8Array(n);
  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }
  return new Blob([u8arr], { type: mime });
}

/**
 * 通过blob流下载文件
 * @param {blob} blob
 * @param {string} fileName
 */
export async function downFileByBlob(blob, fileName) {
  const isLogin = await blobValidate(blob);
  if (!isLogin) throw new Error({ code: 401 });
  const blobUrl = window.URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.download = fileName || '下载文件';
  link.style.display = 'none';
  link.href = blobUrl;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}

// 验证是否为blob格式
export async function blobValidate(data) {
  try {
    const text = await data.text();
    JSON.parse(text);
    return false;
  } catch (error) {
    return true;
  }
}

/**
 * 转义数据范围
 * @param {string} datatype
 * @param {string} specs
 * @returns
 */
export function getDataRange(datatype, specsStr) {
  const specs = JSON.parse(specsStr) || {};
  specs.minNum = specs.min == undefined ? specs.maxNum : specs.min;
  specs.maxNum = specs.max == undefined ? specs.maxNum : specs.max;
  specs.trueName = specs.trueText == undefined ? specs.trueName : specs.trueText;
  specs.falseName = specs.falseText == undefined ? specs.falseName : specs.falseText;
  switch (datatype) {
    case 'string':
      return `最大${specs.maxLength || '--'}位字符`;
    case 'integer':
    case 'decimal':
      return `最小值为：${specs.minNum == undefined ? '--' : specs.minNum}，最大值为：${
        specs.maxNum || '--'
      }，单位为：${specs.unit || '--'}`;
    case 'bool':
      return `${specs.trueName || '--'}为true，${specs.falseName || '--'}为false`;
    case 'enum': {
      const enums = Array.isArray(specs.enums) ? specs.enums : JSON.parse(specs.enums || '[]');
      // const enums = specs.enums || []
      const enumStr = enums.map((str) => {
        return `${str.label}为${str.value || str.key}`;
      });
      return enumStr.join(',');
    }
  }
}
/**
 * 物模型数据范围
 * @param {string} datatype
 * @param {string} specs
 * @returns
 */
export function getModelRange(item) {
  // specs.minNum = specs.min == undefined ? specs.maxNum : specs.min
  // specs.maxNum = specs.max == undefined ? specs.maxNum : specs.max
  switch (item.datatype) {
    case 'string':
      return `最大${item.length || '--'}位字符`;
    case 'integer':
    case 'decimal':
      return `最小值为：${item.rangeMin || '--'}，最大值为：${item.rangeMax || '--'}，单位为：${item.unit || '--'}`;
    case 'bool':
      return `${item.trueName || '--'}为true，${item.falseName || '--'}为false`;
    case 'enum': {
      const enums = Array.isArray(item.enums) ? item.enums : JSON.parse(item.enums || '[]');
      // const enums = specs.enums || []
      const enumStr = enums.map((str) => {
        return `${str.label}为${str.value || str.key}`;
      });
      return enumStr.join(',');
    }
  }
}

/**
 * 节流
 * @param {要执行的方法} fn
 * @param {延迟的时间} delay
 * @returns
 */
export function throttle(fn, delay) {
  let timer = null;
  return function () {
    const context = this;
    const args = arguments;
    if (!timer) {
      timer = setTimeout(() => {
        fn.apply(context, args);
        clearTimeout(timer);
        timer = null;
      }, delay);
    }
  };
}

/**
 * 防抖
 * @param {要执行的方法} fn
 * @param {防抖的时间} delay
 * @returns
 */
export function debounce(fn, delay) {
  let timer = null;
  return function () {
    const context = this;
    const args = arguments;
    clearTimeout(timer);
    timer = setTimeout(function () {
      fn.apply(context, args);
    }, delay);
  };
}

/**
 * 构造树型结构数据
 * @param {*} data 数据源
 * @param {*} id id字段 默认 'id'
 * @param {*} parentId 父节点字段 默认 'parentId'
 * @param {*} children 孩子节点字段 默认 'children'
 */
export function handleTree(data, id, parentId, children) {
  const config = {
    id: id || 'id',
    parentId: parentId || 'parentId',
    childrenList: children || 'children',
  };

  var childrenListMap = {};
  var nodeIds = {};
  var tree = [];

  for (const d of data) {
    const parentId = d[config.parentId];
    if (childrenListMap[parentId] == null) {
      childrenListMap[parentId] = [];
    }
    nodeIds[d[config.id]] = d;
    childrenListMap[parentId].push(d);
  }

  for (const d of data) {
    const parentId = d[config.parentId];
    if (nodeIds[parentId] == null) {
      tree.push(d);
    }
  }

  for (const t of tree) {
    adaptToChildrenList(t);
  }

  function adaptToChildrenList(o) {
    if (childrenListMap[o[config.id]] !== null) {
      o[config.childrenList] = childrenListMap[o[config.id]];
    }
    if (o[config.childrenList]) {
      for (const c of o[config.childrenList]) {
        adaptToChildrenList(c);
      }
    }
  }
  return tree;
}

// 根据id找到树节点
export function getNodeById(tree, id, idName) {
  idName = idName || 'id';
  const arr = Array.isArray(tree) ? deepClone(tree) : [tree];
  let result = null;
  while (arr.length) {
    const item = arr.pop();
    if (item && item[idName] === id) {
      result = item;
      break;
    } else if (item && item.children && item.children.length) {
      arr.push(...item.children);
    }
  }
  return result;
}

// 利用递归，需要注意区分子节点是对象还是数组
export function findNodeFromTreeById(root, id, idName) {
  idName = idName || 'id';
  let result = null; // 报错最终结果
  if (root) {
    const type = Object.prototype.toString.call(root).slice(8, -1);
    if (type === 'Object') {
      if (root[idName] && root[idName] === id) {
        result = root;
      } else {
        const node = root.children || null;
        result = findNodeFromTreeById(node, id, idName);
      }
    } else if (type === 'Array') {
      const needNode = root.find((x) => !!x === true && x[idName] === id);
      if (needNode) {
        result = needNode;
      } else {
        root.some((item) => {
          if (item && item.children && item.children.length) {
            result = findNodeFromTreeById(item.children, id, idName);
            if (result) return true;
          }
        });
      }
    }
  }
  return result;
}

// 利用递归，将tree转化成数组结构来操作
export function getPathById(tree, id, idName, path) {
  idName = idName || 'id';
  tree = Array.isArray(tree) ? tree : [tree];
  if (!path) {
    path = [];
  }
  for (let i = 0, len = tree.length; i < len; i++) {
    const tempPath = [...path];
    tempPath.push(tree[i].name);
    if (tree[i][idName] === id) {
      return tempPath;
    }
    if (tree[i].children) {
      return getPathById(tree[i].children, id, idName, tempPath);
    }
  }
}
// 复制文本
export function copyText(copytext) {
  const text = document.createElement('input'); // 创建节点
  text.setAttribute('readonly', 'readonly');
  text.value = copytext; // 赋值
  document.body.appendChild(text); // 插入节点
  text.setSelectionRange(0, text.value.length);
  text.select(); // 选中节点
  document.execCommand('copy'); // 执行浏览器复制方法
  if (document.body.removeChild(text)) {
    return { type: 'success', message: '复制成功' };
  } else {
    return { type: 'error', message: '复制失败' };
  }
}
// 导出excel
export function exportToExcel(data, fileName) {
  const csv = convertToCSV(data); // 将数据转换为CSV格式
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' }); // 创建Blob对象
  const url = URL.createObjectURL(blob); // 转换为URL
  const link = document.createElement('a'); // 创建<a>元素
  link.setAttribute('href', url);
  link.setAttribute('download', `${fileName}.csv`);
  link.style.visibility = 'hidden';
  document.body.appendChild(link);
  link.click(); // 触发下载
  document.body.removeChild(link); // 清理
}
// 生成csv格式
export function convertToCSV(data) {
  const rows = [];
  for (let i = 0; i < data.length; i++) {
    const row = [];
    for (let j = 0; j < data[i].length; j++) {
      row.push(`"${data[i][j]}"`); // 将每个单元格格式化为带引号的字符串
    }
    rows.push(row.join(',')); // 将每行数据连接为一个字符串
  }
  return rows.join('\n'); // 将所有行数据连接为一个字符串
}

/*
 * 找到对应的经销商和审核的选择路径
 * options传选项组，ids传需要对应的id数组
 * 有三种情况，如options为[userId:0,children:[userId:1,children:[userId:2]]]
 * 第一种情况，options的路径跟ids的路径一样
 *  如ids为[0,1,2]
 * 第二种情况，options的路径大于ids的路径
 *  如ids为[1,2]
 * 第三种情况，options的路径小于ids的路径
 *  如ids为[3,0,1,2]
 * 这三种情况都需要返回[0,1,2]，才能让选择组件识别对应的值
 */
export function getUserPath(options, ids) {
  let res = [];
  // 遍历传进来的选项，找到对应的节点
  const isOpt = options.some((opt) => {
    // 用于判断这个选项是不是对应ids的值
    let hasId = false;
    // 用于存需要返回的id
    const resIds = [];
    // 遍历传进来的id路径，判断是不是在这个选项
    ids.forEach((id) => {
      // 判断这个id有没有对应这个选项，有的话就让hasId为true，返回值也要加上这个
      if (id == opt.userId) {
        resIds.push(parseInt(id));
        hasId = true;
        // 如果没有，判断之前是否已经对应了，之前对应的话，返回值也要加上现在这个，做成完整路径
      } else if (hasId) resIds.push(parseInt(id));
    });
    // 判断这个选项是否有对应id，是的话就返回之前存的返回值
    if (hasId) {
      res = resIds;
      return true;
    } else if (opt.children) {
      // 没有对应id但还有children节点，就继续往下走
      const hasChild = getUserPath(opt.children, ids);
      // 如果children有返回值，说明该选项也在节点上，返回值要在数组最前头加上该选项
      if (hasChild) {
        res = [opt.userId].concat(hasChild);
        return true;
      }
    }
    // 没有对应id也没有children节点，就返回false，开始遍历别的选项
    return false;
  });
  // 判断该节点是否在路径上，是的话，就返回返回值，不是的就返回false，继续遍历别的选项组
  if (isOpt) {
    return res;
  } else {
    return false;
  }
}

/**
 * hex转10进制
 * @param hex
 */
export function hex2int(hexStr) {
  let twoStr = parseInt(hexStr, 16).toString(2); // 将十六转十进制，再转2进制
  let bitNum = hexStr.length * 4; // 1个字节 = 8bit ，0xff 一个 "f"就是4位
  if (twoStr.length < bitNum) {
    while (twoStr.length < bitNum) {
      twoStr = '0' + twoStr;
    }
  }
  if (twoStr.substring(0, 1) == '0') {
    // 正数
    const two = parseInt(twoStr, 2); // 二进制转十进制
    return two;
  } else {
    // 负数
    let twoStr_unsign = '';
    let two = parseInt(twoStr, 2) - 1; // 补码：(负数)反码+1，符号位不变；相对十进制来说也是 +1，但这里是负数，+1就是绝对值数据-1
    twoStr = two.toString(2);
    twoStr_unsign = twoStr.substring(1, bitNum); // 舍弃首位(符号位)
    // 去除首字符，将0转为1，将1转为0   反码
    twoStr_unsign = twoStr_unsign.replace(/0/g, 'z');
    twoStr_unsign = twoStr_unsign.replace(/1/g, '0');
    twoStr_unsign = twoStr_unsign.replace(/z/g, '1');
    two = -parseInt(twoStr_unsign, 2);
    return two;
  }
}
/**
 * 10进制转16进制
 * @param hex
 */
export function int2hex(hexStr) {
  let hexInt = typeof hexStr == 'string' ? parseInt(hexStr, 10) : hexStr;
  let hex = '';
  const LENGTH_04 = 4;
  const LENGTH_15 = 15;
  if (hexInt >= 0) {
    hex = hexInt.toString(16).toLocaleLowerCase();
  } else {
    let twoStr = (-hexInt - 1).toString(2);
    let sb = '000000000000000';
    twoStr = sb.slice(0, LENGTH_15 - twoStr.length) + twoStr;
    // 将0转为1，将1转为0   反码
    twoStr = twoStr.replace(/0/g, 'z');
    twoStr = twoStr.replace(/1/g, '0');
    twoStr = twoStr.replace(/z/g, '1');
    hex = parseInt('1' + twoStr, 2)
      .toString(16)
      .toLocaleLowerCase();
  }
  //长度不等于4 补全
  if (hex.length != LENGTH_04) {
    let sb = '0000';
    hex = sb.slice(0, LENGTH_04 - hex.length) + hex;
  }
  return hex.toUpperCase();
}
