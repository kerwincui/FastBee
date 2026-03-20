import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
/**
 * 导出excel
 */
export const exportExcel = ([sheetNames, sheetsData], filename = '多语言包.xlsx') => {
  // 创建workbook对象
  let wb = XLSX.utils.book_new();
  sheetNames.forEach((sheetName, index) => {
    const sheeData = sheetsData[index];
    // 把json转为worksheet对象
    let ws = XLSX.utils.json_to_sheet(sheeData);
    // 计算每列最大字符数作为列宽
    const colWidths = getColumnWidths(sheeData);
    // 设置列宽
    setColumnWidths(ws, colWidths);
    // 添加worksheet 到 workbook
    XLSX.utils.book_append_sheet(wb, ws, sheetName);
  });
  // 写出 arraybuffer 数据
  let wb_out = XLSX.write(wb, { bookType: 'xlsx', type: 'array' });
  // 构建Blob对象
  let _blob = new Blob([wb_out], { type: 'application/octet-stream' });
  //下载
  saveAs(_blob, filename);
};

/**
 * 获取表格列的宽度数组。
 */
export const getColumnWidths = (data) => {
  const headers = Object.keys(data[0]);
  // 计算列宽
  const colWidths = [];
  for (let i = 0; i < headers.length; i++) {
    let maxWidth = getCellWidth(headers[i]);
    let key = headers[i];
    let cellWidth = 0;
    for (let j = 0; j < data.length; j++) {
      cellWidth = getCellWidth(data[j][key]);
      if (data[j][key] && cellWidth > maxWidth) {
        maxWidth = cellWidth;
      }
    }
    colWidths.push(maxWidth);
  }
  return colWidths;
};
/**
 * 计算单元格宽度
 */
const getCellWidth = (value) => {
  if (/.*[\u4e00-\u9fa5]+.*$/.test(value)) {
    return parseFloat(value.toString().length * 2.1);
  } else {
    return parseFloat(value.toString().length * 1.1);
  }
};

/**
 * 设置工作表的列宽
 */
export const setColumnWidths = (ws, columnWidths) => {
  ws['!cols'] = columnWidths.map((_, i) => ({
    wch: columnWidths[i] || 30,
  }));
};

/**
 * 解析文件为 JSON
 * @param file 文件
 * @returns 解析后的 JSON 数据
 */
export const parseJson = async (file) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = function (e) {
      try {
        const data = new Uint8Array(e.target.result);
        const workbook = XLSX.read(data, { type: 'array' });
        const jsonMap = new Map();
        for (let index = 0; index < workbook.SheetNames.length; index++) {
          const sheetName = workbook.SheetNames[index];
          const worksheet = workbook.Sheets[sheetName];
          const jsonData = XLSX.utils.sheet_to_json(worksheet, { header: 1 });
          jsonMap.set(sheetName, jsonData);
        }
        resolve(jsonMap);
      } catch (err) {
        reject(err);
      }
    };
    reader.onerror = () => {
      reject(new Error('文件读取失败'));
    };
    reader.readAsArrayBuffer(file);
  });
};
