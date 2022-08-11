
/*
 * @Author: daidai
 * @Date: 2021-12-16 14:40:18
 * @LastEditors: Please set LastEditors
 * @LastEditTime: 2022-04-19 14:44:14
 * @FilePath: \web-pc\src\lib\dd-moment.js
 */


const DDmoment = function (date) {
    let time;
    if (!date) {
        time = new Date()
    }else if(date){
        time=new Date(date);
    }
    return {
        time,
        format,
        subtract,
        getTime,
    }
}
/**
 * @content 前多少天
 * @param  days  天 ||  years 年  || months 月 ||  weeks 周 
 * @returns 
 */
function subtract(num, type) {
    let time = this.time
    time.setTime(time.getTime()-getNeedTime(num, type))
    time=new Date(time)
    return {
        time,
        format,
        getTime
    }
}
/**
 * @param  Yy年  ||  M 月  || Dd 日 ||  Hh 时 || m 分 || Ss 秒
 * @returns 
 */
function format(fmt) {
    let date = this.time
    let ret;
    const opt = {
        "Y+": date.getFullYear().toString(),        // 年
        "y+": date.getFullYear().toString(),        // 年
        "M+": (date.getMonth() + 1).toString(),     // 月
        "d+": date.getDate().toString(),            // 日
        "D+": date.getDate().toString(),            // 日
        "h+": date.getHours().toString(),           // 时
        "H+": date.getHours().toString(),           // 时
        "m+": date.getMinutes().toString(),         // 分
        "S+": date.getSeconds().toString(),         // 秒
        "s+": date.getSeconds().toString()          // 秒
        // 有其他格式化字符需求可以继续添加，必须转化成字符串
    };
    for (let k in opt) {
        ret = new RegExp("(" + k + ")").exec(fmt);
        if (ret) {
            fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
        };
    };
    return fmt;
}
//时间戳转时间
function getTime() {
    return new Date(this.time)
}
//获取需要的时间
function getNeedTime(num, type) {
    let time=0
    switch (type) {
        case "days":
            time= 3600 * 1000 * 24 * num;
            break;
        case "years":
            time=3600 * 1000 * 24 *365 *num;
            break;
        case "months":
            time = 3600 * 1000 * 24 *30* num;
            break;
        case "weeks":
            time= 3600 * 1000 * 24 *7* num;
            break;
        default:
            break;
    }
    return time;
}
export default DDmoment