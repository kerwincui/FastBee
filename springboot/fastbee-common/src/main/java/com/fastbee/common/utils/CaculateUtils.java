package com.fastbee.common.utils;

import com.fastbee.common.exception.ServiceException;
import io.netty.buffer.ByteBufUtil;
import org.apache.commons.codec.binary.Hex;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串公式计算工具
 */
public class CaculateUtils {

    /**
     * /*
     * 暂时只支持加减乘除及括号的应用
     */
    private static final String symbol = "+-,*/,()";


    /**
     * 公式计算 字符串
     *
     * @param exeStr
     */
    public static BigDecimal execute(String exeStr, Map<String, String> replaceMap) {
        //替换掉占位符
        exeStr = caculateReplace(exeStr, replaceMap);
        exeStr = exeStr.replaceAll("\\s*", "");
        List<String> suffixList = suffixHandle(exeStr);
        return caculateAnalyse(suffixList);

    }

    /**
     * 公式计算 后序list
     *
     * @param suffixList
     * @return
     */
    public static BigDecimal caculateAnalyse(List<String> suffixList) {

        BigDecimal a = BigDecimal.ZERO;
        BigDecimal b = BigDecimal.ZERO;
        // 构建一个操作数栈  每当获得操作符号时取出最上面两个数进行计算。
        Stack<BigDecimal> caculateStack = new Stack<BigDecimal>();
        if (suffixList.size() > 1) {

            for (int i = 0; i < suffixList.size(); i++) {
                String temp = suffixList.get(i);
                if (symbol.contains(temp)) {
                    b = caculateStack.pop();
                    a = caculateStack.pop();
                    a = caculate(a, b, temp.toCharArray()[0]);
                    caculateStack.push(a);
                } else {
                    if (isNumber(suffixList.get(i))) {
                        caculateStack.push(BigDecimal.valueOf(Double.parseDouble(suffixList.get(i))));
                    } else {
                        throw new RuntimeException("公式异常！");
                    }
                }
            }
        } else if (suffixList.size() == 1) {
            String temp = suffixList.get(0);
            if (isNumber(temp)) {
                a = BigDecimal.valueOf(Double.parseDouble(temp));
            } else {
                throw new RuntimeException("公式异常！");
            }
        }
        return a;
    }


    /**
     * 计算 使用double 进行计算  如果需要可以在这里使用bigdecimal 进行计算
     *
     * @param a
     * @param b
     * @param symbol
     * @return
     */
    public static BigDecimal caculate(BigDecimal a, BigDecimal b, char symbol) {

        switch (symbol) {
            case '+': {
                return a.add(b).stripTrailingZeros();
            }
            case '-':
                return a.subtract(b).stripTrailingZeros();
            case '*':
                return a.multiply(b);
            case '/':
                return a.divide(b).stripTrailingZeros();
            default:
                throw new RuntimeException("操作符号异常！");
        }

    }

    /**
     * 字符串直接 转 后序
     */
    public static List<String> suffixHandle(String exeStr) {
        StringBuilder buf = new StringBuilder();
        Stack stack = new Stack();
        char[] exeChars = exeStr.toCharArray();
        List<String> res = new ArrayList<String>();
        for (char x : exeChars) {
            // 判断是不是操作符号
            if (symbol.indexOf(x) > -1) {
                // 不管怎样先将数据添加进列表
                if (buf.length() > 0) {
                    // 添加数据到res
                    String temp = buf.toString();
                    // 验证是否为数
                    if (!isNumber(temp)) throw new RuntimeException(buf.append("  格式不对").toString());

                    // 添加到结果列表中
                    res.add(temp);
                    // 清空临时buf
                    buf.delete(0, buf.length());
                }
                if (stack.size() > 0) {

                    //2.判断是不是开是括号
                    if (x == '(') {
                        stack.push(x);
                        continue;
                    }
                    //3.判断是不是闭合括号
                    if (x == ')') {
                        while (stack.size() > 0) {
                            char con = (char) stack.peek();
                            if (con == '(') {
                                stack.pop();
                                continue;
                            } else {
                                res.add(String.valueOf(stack.pop()));
                            }
                        }
                        continue;
                    }
                    // 取出最后最近的一个操作符
                    char last = (char) stack.peek();
                    if (compare(x, last) > 0) {
                        stack.push(x);
                    } else if (compare(x, last) <= 0) {
                        if (last != '(') {
                            res.add(String.valueOf(stack.pop()));
                        }
                        stack.push(x);
                    }
                } else {
                    stack.push(x);
                }
            } else {
                buf.append(x);
            }
        }
        if (buf.length() > 0) res.add(buf.toString());
        while (stack.size() > 0) {
            res.add(String.valueOf(stack.pop()));
        }
        return res;

    }


    /**
     * 比较两个操作符号的优先级
     *
     * @param a
     * @param b
     * @return
     */
    public static int compare(char a, char b) {
        if (symbol.indexOf(a) - symbol.indexOf(b) > 1) {
            return 1;
        } else if (symbol.indexOf(a) - symbol.indexOf(b) < -1) {
            return -1;
        } else {
            return 0;
        }
    }


    /**
     * 判断是否为数 字符串
     *
     * @param str
     * @return
     */
    public static boolean isNumber(String str) {
        Pattern pattern = Pattern.compile("[0-9]+\\.{0,1}[0-9]*");
        Matcher isNum = pattern.matcher(str);
        return isNum.matches();
    }

    public static String caculateReplace(String str, Map<String, String> map) {
        for (Map.Entry<String, String> entry : map.entrySet()) {
            str = str.replaceAll(entry.getKey(), entry.getValue()==null ? "1" : entry.getValue());
        }
        return str;
    }

    public static String toFloat(byte[] bytes) throws IOException {
        ByteArrayInputStream mByteArrayInputStream = new ByteArrayInputStream(bytes);
        DataInputStream mDataInputStream = new DataInputStream(mByteArrayInputStream);
        try {
            float v = mDataInputStream.readFloat();
            return String.format("%.6f",v);
        }catch (Exception e){
            throw new ServiceException("modbus16转浮点数错误");
        }
        finally {
            mDataInputStream.close();
            mByteArrayInputStream.close();
        }
    }

    /**
     * 转16位无符号整形
     * @param value
     * @return
     */
    public static String toUnSign16(long value) {
        long unSigned = value & 0xFFFF;
        return unSigned +""; // 将字节数组转换为十六进制字符串
    }

    /**
     * 32位有符号CDAB数据类型
     * @param value
     * @return
     */
    public static String toSign32_CDAB(long value) {
        byte[] bytes = intToBytes2((int) value);
        return bytesToInt2(bytes)+"";
    }

    /**
     * 32位无符号ABCD数据类型
     * @param value
     * @return
     */
    public static String toUnSign32_ABCD(long value) {
       return Integer.toUnsignedString((int) value);
    }

    /**
     * 32位无符号CDAB数据类型
     * @param value
     * @return
     */
    public static String toUnSign32_CDAB(long value) {
        byte[] bytes = intToBytes2((int) value);
        int val = bytesToInt2(bytes);
        return Integer.toUnsignedString(val);
    }

    /**
     * 转32位浮点数 ABCD
     * @param bytes
     * @return
     */
    public static float toFloat32_ABCD(byte[] bytes) {
        int intValue = (bytes[0] << 24) | ((bytes[1] & 0xFF) << 16) | ((bytes[2] & 0xFF) << 8) | (bytes[3] & 0xFF);
        return Float.intBitsToFloat(intValue);
    }

    /**
     * 转32位浮点数 CDAB
     * @param bytes
     * @return
     */
    public static Float toFloat32_CDAB(byte[] bytes) {
        int intValue = ((bytes[2] & 0xFF) << 24) | ((bytes[3] & 0xFF) << 16) |  ((bytes[0] & 0xFF) << 8) | ((bytes[1] & 0xFF)) ;
        return Float.intBitsToFloat(intValue);
    }

    /**
     * byte数组中取int数值，本方法适用于(低位在后，高位在前)的顺序。和intToBytes2（）配套使用
     */
    public static int bytesToInt2(byte[] src) {
        return (((src[2] & 0xFF) << 24) | ((src[3] & 0xFF) << 16) | ((src[0] & 0xFF) << 8) | (src[1] & 0xFF));
    }

    /**
     * 将int数值转换为占四个字节的byte数组，本方法适用于(高位在前，低位在后)的顺序。  和bytesToInt2（）配套使用
     */
    public static byte[] intToBytes2(int value) {
        byte[] src = new byte[4];
        src[0] = (byte) ((value >> 24) & 0xFF);
        src[1] = (byte) ((value >> 16) & 0xFF);
        src[2] = (byte) ((value >> 8) & 0xFF);
        src[3] = (byte) (value & 0xFF);
        return src;
    }


    public static void main(String[] args) throws IOException {
        Map<String, String> map = new HashMap<>();
        map.put("%s", "180");
        String caculate = caculateReplace("%s*2", map);
        System.out.println(caculate);
        System.out.println(execute("%s*10",map));

        String s4 = toUnSign16(-1);
        System.out.println("转16位无符号："+s4);

        String s1 = toSign32_CDAB(40100);
        System.out.println("转32位有符号-CDAB序"+s1);

        String s2 = toUnSign32_ABCD(-10);
        System.out.println("转32位无符号-ABCD序："+s2);

        String s3 = toUnSign32_CDAB(123456789);
        System.out.println("转32位无符号-CDAB序："+s3);

        String hexToBytes = "41EE8000";
        byte[] bytes = ByteBufUtil.decodeHexDump(hexToBytes);

        float v1 = toFloat32_ABCD(bytes);
        System.out.println("转32位浮点型-ABCD序："+v1);

        String hexToBytes1= "800041EE";
        long i = Long.parseLong(hexToBytes1, 16);
        System.out.println(i);
        byte[] bytes1 = ByteBufUtil.decodeHexDump(hexToBytes1);

        float v2 = toFloat32_CDAB(bytes1);
        System.out.println("转32位浮点型-CDAB序："+v2);

        int signedShort = -32627; // 16位有符号整形
         // 将有符号短整型转换为无符号短整型
        int unSignedInt = signedShort & 0xFFFF;
        // 输出结果
        System.out.println(unSignedInt); // 输出: 0

        long l = Long.parseLong("00501F40", 16);
        System.out.println(l);

        int val1 = -6553510;
        byte[] bytes2 = intToBytes2(val1);
        int i1 = bytesToInt2(bytes2);
        System.out.println(i1);
    }

}
