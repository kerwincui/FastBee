import JsZip from 'jszip';
import { saveAs } from 'file-saver';
/**
 * 根据提供的JSON 数据生成 JSON 格式的 zip 文件列表。
 * @param {Object} jsonData - 包含模块和其对应多语言数据的对象。
 * @returns {Array} files - 包含每个文件信息的数组，每个文件信息包含文件夹名、文件名、文件类型和文件数据。
 */
export const generateJsonZipFiles = (jsonData) => {
  const files = [];
  // 遍历 jsonData 中的每个模块，为每个模块和语言组合生成一个文件对象
  for (const [module, objects] of jsonData.entries()) {
    for (const [lang, jsonObject] of Object.entries(objects)) {
      // 将生成的文件信息添加到 files 数组中
      files.push({
        folderName: lang, //文件夹名
        fileName: module, // 文件名
        fileType: 'json', // 文件类型
        fileData: convertToJsonBlob(jsonObject), // 文件数据
      });
    }
  }
  return files;
};

/**
 * 解析JSON Zip数据
 * @param jsonMap 包含模块名对应数据的JSON映射对象
 * @param langFileNameEnum 语言文件名枚举对象，将实际语言文件名映射到枚举值
 * @returns 返回一个Map对象，其中键为模块名，值为一个对象，该对象的键为语言文件名（根据langFileNameEnum转换），值为对应语言文件的内容（键为文件中的键，值为文件中的值）
 */
export const parseJsonZipData = (jsonMap, langFileNameEnum) => {
  const dataMap = new Map();
  for (const [module, rows] of jsonMap.entries()) {
    const fileObjects = {};
    const cellIndexMap = {};
    rows.forEach((row, rowNumber) => {
      if (rowNumber === 0) {
        row.forEach((cell, colNumber) => {
          if (colNumber !== 0) {
            fileObjects[langFileNameEnum[cell]] = {};
            cellIndexMap[colNumber] = langFileNameEnum[cell];
          }
        });
      } else {
        Object.keys(cellIndexMap)
          .map((item) => Number(item))
          .map((colNumber) => {
            const key = row[0];
            const value = row[colNumber];
            const lang = cellIndexMap[colNumber];
            fileObjects[lang][key] = value;
          });
      }
    });
    dataMap.set(module, fileObjects);
  }
  return dataMap;
};

export const convertToJsonBlob = (jsonObject) => {
  const jsonString = JSON.stringify(jsonObject, null, 2);
  return new Blob([jsonString], { type: 'application/json' });
};

/**
 * 将多个文件下载并打包成一个 zip 文件。
 * @param {Object} params 参数对象，包含待下载文件信息和 zip 文件名。
 * @param {Array} params.files 待下载的文件数组。
 * @param {string} params.zipName 打包后的 zip 文件名。
 */
export function downloadFiles2Zip(params) {
  const zip = new JsZip();
  // 待每个文件都写入完之后再生成 zip 文件
  params.files.map((file) => handleEachFile(file, zip));
  zip.generateAsync({ type: 'blob' }).then((blob) => {
    saveAs(blob, `${params.zipName}.zip`);
  });
}

/**
 * 处理每个文件，将其添加到zip文件中。
 * @param {Object} param0 包含文件相关信息的对象
 * @param {string} param0.folderName 文件所属的文件夹名称（可选）
 * @param {string} param0.fileName 文件名
 * @param {string} param0.fileType 文件类型
 * @param {Blob|Uint8Array} param0.fileData 文件数据
 * @param {JSZip} zip JSZip对象，用于构建zip文件
 */
export const handleEachFile = ({ folderName, fileName, fileType, fileData }, zip) => {
  if (folderName) {
    zip.folder(folderName)?.file(`${fileName}.${fileType}`, fileData);
  } else {
    zip.file(`${filename}.${fileType}`, blob);
  }
};
