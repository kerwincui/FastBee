/*
 * @Author: daidai
 * @Date: 2022-01-11 15:27:31
 * @LastEditors: Please set LastEditors
 * @LastEditTime: 2022-04-21 14:32:03
 * @FilePath: \web-pc\src\directives\filters.js
 */
export function montionFilter (val) {
    // console.log(val);
    return val ? Number(val).toFixed(2) : '--'
}