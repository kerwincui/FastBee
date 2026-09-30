import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.core.util.NumberUtil;





//系统主题
String sysTopic = '';
//系统数据格式
String sysPayload = '';

// 1. 获取主题和内容
String name = msgContext.getTopic();
Long productId = msgContext.getProductId();
String serialNumber = msgContext.getSerialNumber();
String protocolCode = msgContext.getProtocolCode();
String payload = msgContext.getPayload();
System.out.println("产品id/协议编号：" + productId + " / " + protocolCode);

// 2. 转换为系统主题 /96/D1ELV3A5TOJS/property/post
sysTopic = "/" + productId + "/" + serialNumber + "/property/post"

if("JSON".equals(protocolCode)){
    // 3. 内容格式转换
    JSONArray newArray = new JSONArray();
    JSONObject jsonObject = JSONUtil.parseObj(payload);
    jsonObject.keySet().forEach(key -> {
        JSONObject newObject =new JSONObject();
        newObject.put("id" , key);
        newObject.put("value" , jsonObject.getStr(key));
        newArray.add(newObject);
    });
    sysPayload = newArray.toString();
}else{
    //其他协议处理
}

// 4.打印
System.out.println("新主题：" + sysTopic);
System.out.println("新内容：" + sysPayload);

// 5. 返回新的数据（必要）
msgContext.setTopic(sysTopic);
msgContext.setPayload(sysPayload);
