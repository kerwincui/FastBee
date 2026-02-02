export function loadBMap() {
    return new Promise(function(resolve, reject) {
        if (typeof BMap !== 'undefined') {
            resolve(BMap)
            return true
        }
        window.onBMapCallback = function() {
            resolve(BMap)
        }
        // 使用https协议需要添加一下meta标签
        var protocolStr = document.location.protocol;  
        if(protocolStr == "https:")  
        {  
            let meta = document.createElement('meta')
            meta.httpEquiv = 'Content-Security-Policy'
            meta.content ='upgrade-insecure-requests'
            meta.onerror = reject
            document.head.appendChild(meta)
        }       
        // 引入百度地图
        const script = document.createElement('script');
        const ak = process.env.VUE_APP_BAI_DU_AK
        script.type = 'text/javascript';
        script.src = `https://api.map.baidu.com/api?v=3.0&ak=${ak}&callback=onBMapCallback`;
        script.onerror = reject;
        document.head.appendChild(script);
        
    })
}