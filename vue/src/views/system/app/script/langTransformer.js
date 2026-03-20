// 获取语言包数据, new Map({fileName,{key:{ [lang]:value}}})
export const getLangJson = () => {
  const all = require.context('@/lang', true, /^((?!index).)*\.json$/);
  const modules = new Map();
  all.keys().forEach((key) => {
    const lang = key.match(/(?<=\/)[^\/]+(?=\/|$)/)[0];
    const fileName = key.match(/(?<=\.\/[^\/]+\/)[^\.]+(?=\.\w+$)/)[0];
    const obj = modules.get(fileName) || {};
    Object.entries(all(key)).forEach(([key, value]) => {
      const item = obj[key] || {};
      item[lang] = value;
      obj[key] = item;
    });
    modules.set(fileName, obj);
  });
  return modules;
};

// 转换为excel数据: [sheeNames:表,sheeData:单表数据]
export const transoformToExcel = (array2, langs) => {
  const sheetNames = [];
  const sheetData = [];
  for (const [sheetName, arr] of array2.entries()) {
    sheetNames.push(sheetName);
    sheetData.push(transformToExcelSheet(arr, langs));
  }
  return [sheetNames, sheetData];
};

// 转换为excel单表数据：[{'键值':'key','中文':'中文','英文':'English'}]
export const transformToExcelSheet = (jsonData, langs) => {
  let data = [];
  for (const [key, obj] of Object.entries(jsonData)) {
    let item = { 键值: key };
    for (const [lang, label] of Object.entries(langs)) {
      item[label] = obj[lang] || '';
    }
    data.push(item);
  }
  return data;
};
