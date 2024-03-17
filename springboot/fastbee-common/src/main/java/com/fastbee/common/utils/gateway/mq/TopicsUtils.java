package com.fastbee.common.utils.gateway.mq;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.message.DeviceDownMessage;
import com.fastbee.common.enums.ThingsModelType;
import com.fastbee.common.enums.TopicType;
import com.fastbee.common.utils.collection.CollectionUtils;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;


import java.util.*;

/**
 * topic工具类
 *
 * @author gsb
 * @date 2022/9/15 16:49
 */
@Slf4j
@Component
public class TopicsUtils {

    @Value("${server.broker.enabled}")
    private Boolean enabled;

    /**
     * 拼接topic
     *
     * @param productId    产品id
     * @param serialNumber 设备编号
     * @param type         主题类型
     * @return topic
     */
    public String buildTopic(Long productId, String serialNumber, TopicType type) {
        /*
         * 订阅属性:
         * 如果启动emq  则为  /+/+/property/post
         * 如果启动netty的mqttBroker 则为   /{productId}/{serialNumber}/property/post
         *
         * 发布都为：/{productId}/{serialNumber}/property/get
         */
        String product = String.valueOf(productId);
        if (null == productId || productId == -1L || productId == 0L) {
            product = "+";
        }
        if (com.fastbee.common.utils.StringUtils.isEmpty(serialNumber)) {
            serialNumber = "+";
        }
        if (type.getType() == 0) {
            return enabled ? "/" + product + "/" + serialNumber + type.getTopicSuffix() : FastBeeConstant.MQTT.PREDIX + type.getTopicSuffix();
        } else {
            return "/" + product + "/" + serialNumber + type.getTopicSuffix();
        }
    }


    /**
     * 获取所有可订阅的主题
     *
     * @return 订阅主题列表
     */
    public TopicsPost getAllPost() {
        List<Integer> qos = new ArrayList<>();
        List<String> topics = new ArrayList<>();
        TopicsPost post = new TopicsPost();
        for (TopicType topicType : TopicType.values()) {
            if (topicType.getType() == 0) {
                String topic = this.buildTopic(0L, null, topicType);
                topics.add(topic);
                qos.add(1);
            }
        }
        post.setTopics(topics.toArray(new String[0]));
        int[] ints = Arrays.stream(qos.toArray(new Integer[0])).mapToInt(Integer::valueOf).toArray();
        post.setQos(ints);
        return post;
    }

    /**
     * 获取所有get topic
     *
     * @param isSimulate 是否是设备模拟
     * @return list
     */
    public static List<Topics> getAllGet(boolean isSimulate) {
        List<Topics> result = new ArrayList<>();
        for (TopicType type : TopicType.values()) {
            if (type.getType() == 4) {
                Topics topics = new Topics();
                topics.setTopicName(type.getTopicSuffix());
                topics.setDesc(type.getMsg());
                topics.setQos(1);
                result.add(topics);
                if (isSimulate && type == TopicType.PROPERTY_GET) {
                    result.remove(topics);
                }
            }
        }
        return result;
    }


    /**
     * 替换topic中的产品编码和设备编码,唯一作用是在系统收到来自网关设备上报子设备消息时将topic进行替换
     *
     * @param orgTopic     String 原始topic
     * @param productId    String 目标产品编码
     * @param serialNumber String 目标设备编码
     * @return 替换产品编码和设备编码后的新topic
     */
    public String topicSubDevice(String orgTopic, Long productId, String serialNumber) {
        if (com.fastbee.common.utils.StringUtils.isEmpty(orgTopic)) {
            return orgTopic;
        }
        String[] splits = orgTopic.split("/");
        StringBuilder sb = new StringBuilder(splits[0])
                .append("/")
                .append(productId)
                .append("/")
                .append(serialNumber);
        for (int index = 3; index < splits.length; index++) {
            sb.append("/").append(splits[index]);
        }
        return sb.toString();
    }

    /**
     * 从topic中获取IMEI号 IMEI即是设备编号
     *
     * @param topic /{productId}/{serialNumber}/property/post
     * @return serialNumber
     */
    @SneakyThrows
    public Long parseProductId(String topic) {
        String[] values = topic.split("/");
        return Long.parseLong(values[1]);
    }


    /**
     * 从topic中获取IMEI号 IMEI即是设备编号
     *
     * @param topic /{productId}/{serialNumber}/property/post
     * @return serialNumber
     */
    @SneakyThrows
    public String parseSerialNumber(String topic) {
        String[] values = topic.split("/");
        return values[2];
    }

    /**
     * 获取topic 判断字段 name
     **/
    public String parseTopicName(String topic) {
        String[] values = topic.split("/");
        return values[3];
    }

    /**
     * 获取topic 判断字段 name
     **/
    public String parseTopicName4(String topic) {
        String[] values = topic.split("/");
        return values[4];
    }

    /**
     * 从topic解析物模型类型
     *
     * @param topic /{productId}/{serialNumber}/property/post
     * @return 物模型类型
     */
    @SneakyThrows
    public String getThingsModel(String topic) {
        String[] split = topic.split("/");
        return split[2].toUpperCase();
    }

    /**
     * 检查topic的合法性
     *
     * @param topicNameList 主题list
     * @return 验证结果
     */
    public static boolean validTopicFilter(List<String> topicNameList) {
        for (String topicName : topicNameList) {
            if (com.fastbee.common.utils.StringUtils.isEmpty(topicName)) {
                return false;
            }
            /*以#或+符号开头的、以/符号结尾的及不存在/符号的订阅按非法订阅处理*/
            if (StringUtils.startsWithIgnoreCase(topicName, "#") || StringUtils.startsWithIgnoreCase(topicName, "+") || StringUtils.endsWithIgnoreCase(topicName, "/") || !topicName.contains("/")) {
                return false;
            }
            if (topicName.contains("#")) {
                /*不是以/#字符串结尾的订阅按非法订阅处理*/
                if (!StringUtils.endsWithIgnoreCase(topicName, "/#")) {
                    return false;
                }
                /*如果出现多个#符号的订阅按非法订阅处理*/
                if (StringUtils.countOccurrencesOf(topicName, "#") > 1) {
                    return false;
                }
            }
            if (topicName.contains("+")) {
                /*如果+符号和/+字符串出现的次数不等的情况按非法订阅处理*/
                if (StringUtils.countOccurrencesOf(topicName, "+") != StringUtils.countOccurrencesOf(topicName, "/+")) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 判断topic与topicFilter是否匹配，topic与topicFilter需要符合协议规范
     *
     * @param topic:       主题
     * @param topicFilter: 主题过滤器
     * @return boolean
     * @author ZhangJun
     * @date 23:57 2021/2/27
     */
    public static boolean matchTopic(String topic, String topicFilter) {
        if (topic.contains("+") || topic.contains("#")) {

            String[] topicSpilts = topic.split("/");
            String[] filterSpilts = topicFilter.split("/");

            if (!topic.contains("#") && topicSpilts.length < filterSpilts.length) {
                return false;
            }

            String level;
            for (int i = 0; i < topicSpilts.length; i++) {
                level = topicSpilts[i];
                if (!level.equals(filterSpilts[i]) && !level.equals("+") && !level.equals("#")) {
                    return false;
                }
            }
        } else {
            return topic.equals(topicFilter);
        }
        return true;
    }

    /**
     * 根据指定topic搜索所有订阅的topic
     * 指定的topic没有通配符，但是订阅的时候可能会存在通配符，所以有个查找的过程
     *
     * @param topic 主题
     * @return 返回的所有主题
     */
    public static List<String> searchTopic(String topic) {
        try {
            List<String> topicList = new ArrayList<>();
            topicList.add(topic);
            /*先处理#通配符*/
            String[] filterDup = topic.split("/");
            int[] source = new int[filterDup.length];
            String itemTopic = "";
            for (int i = 0; i < filterDup.length; i++) {
                String item = itemTopic.concat("#");
                topicList.add(item);
                itemTopic = itemTopic.concat(filterDup[i]).concat("/");
                source[i] = i;
                continue;
            }
            /*处理+通配符*/
            Map<List<Integer>, Boolean> map = TopicsUtils.handle(source);
            for (List<Integer> key : map.keySet()) {
                String[] arr = CollectionUtils.copy(filterDup);
                for (Integer index : key) {
                    arr[index] = "+";
                }
                String newTopic = CollectionUtils.concat(arr, "/");
                topicList.add(newTopic);
            }
            return topicList;
        } catch (Exception e) {
            log.error("=>查询topic异常", e);
            return null;
        }
    }


    public static Map<List<Integer>, Boolean> handle(int[] src) {
        int nCnt = src.length;
        int nBit = (0xFFFFFFFF >>> (32 - nCnt));
        Map<List<Integer>, Boolean> map = new HashMap<>();
        for (int i = 1; i <= nBit; i++) {
            List<Integer> list = new ArrayList<>();
            for (int j = 0; j < nCnt; j++) {
                if ((i << (31 - j)) >> 31 == -1) {
                    list.add(j);
                }
            }
            map.put(list, true);
        }
        return map;
    }
}
