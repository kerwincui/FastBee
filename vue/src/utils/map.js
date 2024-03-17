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
        let script = document.createElement('script')
        script.type = 'text/javascript'
        script.src =
            'http://api.map.baidu.com/api?v=2.0&ak='+ process.env.VUE_APP_BAI_DU_AK +'&s=1&__ec_v__=20190126&callback=onBMapCallback'
        script.onerror = reject
        document.head.appendChild(script)
    })
}