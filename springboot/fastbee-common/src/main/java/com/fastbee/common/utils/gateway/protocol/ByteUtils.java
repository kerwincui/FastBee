package com.fastbee.common.utils.gateway.protocol;


import com.fastbee.common.exception.ServiceException;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.nio.ByteOrder;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;


public class ByteUtils {


	// public static Payload resolvePayload(byte[] content, short start, ModbusCode code) {
	// 	Payload payload;
	// 	switch (code) {
	// 		case Read01:
	// 		case Read02:
	// 			payload = new RealCoilPayload(start, content); break;
	// 		case Read03:
	// 		case Read04:
	// 			payload = new ReadPayload(content, start); break;
	// 		default:
	// 			payload = WritePayload.getInstance();
	// 	}
	//
	// 	return payload;
	// }

	public static Write10Build write10Build(Object... args) {
		int num = 0; List<byte[]> bytes = new ArrayList<>();
		for(Object arg : args) {
			if(arg instanceof Integer) {
				num += 2;
				bytes.add(getBytes((Integer) arg));
			} else if(arg instanceof Long) {
				num += 4;
				bytes.add(getBytes((Long) arg));
			} else if(arg instanceof Float) {
				num += 2;
				bytes.add(getBytes((Float) arg));
			} else if(arg instanceof Double) {
				num += 4;
				bytes.add(getBytes((Double) arg));
			} else if(arg instanceof Short) {
				num += 1;
				bytes.add(getBytesOfReverse((Short) arg));
			} else if(arg instanceof Byte) {
				num += 1;
				bytes.add(new byte[]{0x00, (byte) arg});
			} else if(arg instanceof String) {
				byte[] bytes1 = arg.toString().getBytes(StandardCharsets.UTF_8);
				if(bytes1.length % 2 != 0) {
					num += bytes1.length / 2 + 1;
					byte[] addMessage = new byte[bytes1.length + 1];
					addBytes(addMessage, bytes1, 0);
					bytes.add(addMessage);
				} else {
					num += bytes1.length / 2;
					bytes.add(bytes1);
				}
			} else {
				throw new ServiceException("不支持的数据类型");
			}
		}

		Integer length = bytes.stream().map(item -> item.length).reduce((a, b) -> a + b).get();
		byte[] write = new byte[length];

		int index = 0;
		for(int i=0; i<bytes.size(); i++) {
			byte[] values = bytes.get(i);
			addBytes(write, values, index);
			index += values.length;
		}

		return new Write10Build(num, write);
	}

	public static class Write10Build {
		public int num;
		public byte[] message;

		public Write10Build(int num, byte[] message) {
			this.num = num;
			this.message = message;
		}
	}

	public static byte[] create(byte b){
		return new byte[]{b};
	}

	/**
	 * 字节转成字节数组
	 * @param data
	 * @return
	 */
	public static byte[] getBytes(byte data) {
		return new byte[] {data};
	}

	/**
	 * 将short数据类型转化成Byte数组
	 * @see ByteOrder#LITTLE_ENDIAN
	 * @param data short值
	 * @return byte[]数组
	 */
	public static byte[] getBytes(short data) {
		byte[] bytes = new byte[2];
		bytes[0] = (byte) (data & 0xff);
		bytes[1] = (byte) ((data & 0xff00) >> 8);
		return bytes;
	}

	/**
	 * 将short数据类型转化成Byte数组
	 * @see ByteOrder#BIG_ENDIAN
	 * @param data short值
	 * @return byte[]数组
	 */
	public static byte[] getBytesOfReverse(short data) {
		byte[] bytes = new byte[2];
		bytes[1] = (byte) (data & 0xff);
		bytes[0] = (byte) ((data & 0xff00) >> 8);
		return bytes;
	}

	/**
	 * @see ByteOrder#LITTLE_ENDIAN
	 * @param bytes
	 * @param offset
	 * @return
	 */
	public static short bytesToShort(byte[] bytes, int offset) {
		return (short) ((0xff & bytes[0 + offset]) | (0xff00 & (bytes[1 + offset] << 8)));
	}

	/**
	 * 将字节数组转换成short数据
	 * @see ByteOrder#BIG_ENDIAN
	 * @param bytes 字节数组
	 * @return short值
	 */
	public static short bytesToShortOfReverse(byte[] bytes) {
		return ByteUtils.bytesToShortOfReverse(bytes, 0);
	}

	/**
	 * 将字节数组转换成short数据，采用倒序的表达方式
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return short值
	 */
	public static short bytesToShortOfReverse(byte[] bytes, int offset) {
		return (short) ((0xff & bytes[1 + offset]) | (0xff00 & (bytes[0 + offset] << 8)));
	}

	/**
	 * 将int数据类型转化成Byte数组
	 * @see ByteOrder#LITTLE_ENDIAN
	 * @param data int值
	 * @return byte[]数组
	 */
	public static byte[] getBytes(int data) {
		byte[] bytes = new byte[4];
		bytes[0] = (byte) (data & 0xff);
		bytes[1] = (byte) ((data >> 8) & 0xff);
		bytes[2] = (byte) ((data >> 16) & 0xff);
		bytes[3] = (byte) ((data >> 24) & 0xff);
		return bytes;
	}

	/**
	 * 将int数据类型转化成Byte数组 倒序
	 * @see ByteOrder#BIG_ENDIAN
	 * @param data int值
	 * @return byte[]数组
	 */
	public static byte[] getBytesOfReverse(int data) {
		byte[] src = new byte[4];
		src[0] = (byte) ((data >> 24) & 0xFF);
		src[1] = (byte) ((data >> 16) & 0xFF);
		src[2] = (byte) ((data >> 8) & 0xFF);
		src[3] = (byte) (data & 0xFF);
		return src;
	}

	/**
	 * 将long数据类型转化成Byte数组
	 * @see ByteOrder#LITTLE_ENDIAN
	 * @param data long值
	 * @return byte[]数组
	 */
	public static byte[] getBytes(long data) {
		byte[] bytes = new byte[8];
		bytes[0] = (byte) (data & 0xff);
		bytes[1] = (byte) ((data >> 8) & 0xff);
		bytes[2] = (byte) ((data >> 16) & 0xff);
		bytes[3] = (byte) ((data >> 24) & 0xff);
		bytes[4] = (byte) ((data >> 32) & 0xff);
		bytes[5] = (byte) ((data >> 40) & 0xff);
		bytes[6] = (byte) ((data >> 48) & 0xff);
		bytes[7] = (byte) ((data >> 56) & 0xff);
		return bytes;
	}

	/**
	 * 将long数据类型转化成Byte数组 倒序
	 * @see ByteOrder#BIG_ENDIAN
	 * @param data long值
	 * @return byte[]数组
	 */
	public static byte[] getBytesOfReverse(long data) {
		byte[] bytes = new byte[8];
		bytes[7] = (byte) (data & 0xff);
		bytes[6] = (byte) ((data >> 8) & 0xff);
		bytes[5] = (byte) ((data >> 16) & 0xff);
		bytes[4] = (byte) ((data >> 24) & 0xff);
		bytes[3] = (byte) ((data >> 32) & 0xff);
		bytes[2] = (byte) ((data >> 40) & 0xff);
		bytes[1] = (byte) ((data >> 48) & 0xff);
		bytes[0] = (byte) ((data >> 56) & 0xff);
		return bytes;
	}

	/**
	 * 将float数据类型转化成Byte数组
	 * @see ByteOrder#LITTLE_ENDIAN
	 * @param data float值
	 * @return byte[]数组
	 */
	public static byte[] getBytes(float data) {
		int intBits = Float.floatToIntBits(data);
		return getBytes(intBits);
	}

	/**
	 * 将float数据类型转化成Byte数组 倒序
	 * @see ByteOrder#BIG_ENDIAN
	 * @param data float值
	 * @return byte[]数组
	 */
	public static byte[] getBytesOfReverse(float data) {
		int intBits = Float.floatToIntBits(data);
		return getBytesOfReverse(intBits);
	}

	/**
	 * 将double数据类型转化成Byte数组
	 * @see ByteOrder#LITTLE_ENDIAN
	 * @param data double值
	 * @return byte[]数组
	 */
	public static byte[] getBytes(double data) {
		long intBits = Double.doubleToLongBits(data);
		return getBytes(intBits);
	}

	/**
	 * 将double数据类型转化成Byte数组 倒序
	 * @see ByteOrder#BIG_ENDIAN
	 * @param data double值
	 * @return byte[]数组
	 */
	public static byte[] getBytesOfReverse(double data) {
		long intBits = Double.doubleToLongBits(data);
		return getBytesOfReverse(intBits);
	}

	/**
	 * 字符串转字节数组(UTF-8)
	 * @param data
	 * @return
	 */
	public static byte[] getBytes(String data) {
		return data.getBytes(StandardCharsets.UTF_8);
	}

	/**
	 * 将字符串转换成byte[]数组
	 * @param data 字符串值
	 * @param charsetName 编码方式
	 * @return 字节数组
	 */
	public static byte[] getBytes(String data, String charsetName) {
		Charset charset = Charset.forName(charsetName);
		return data.getBytes(charset);
	}

	/*
	 * 把16进制字符串转换成字节数组
	 * @param hex
	 * @return
	 */
	public static byte[] hexToByte(String hexStr) {
		if(StringUtils.isBlank(hexStr)) {
			return null;
		}
		if(hexStr.length()%2 != 0) {//长度为单数
			hexStr = "0" + hexStr;//前面补0
		}

		char[] chars = hexStr.toCharArray();
		int len = chars.length/2;
		byte[] bytes = new byte[len];
		for (int i = 0; i < len; i++) {
			int x = i*2;
			bytes[i] = (byte)Integer.parseInt(String.valueOf(new char[]{chars[x], chars[x+1]}), 16);
		}
		return bytes;

	}

	public static byte getByte(byte[] src, int offset) {
		return src[offset];
	}

	/**
	 * 字节数组转16进制
	 * @param bArray
	 * @return
	 */
	public static final String bytesToHex(byte[] bArray) {
		StringBuffer sb = new StringBuffer(bArray.length);
		String sTemp;
		for (int i = 0; i < bArray.length; i++) {
			sTemp = Integer.toHexString(0xFF & bArray[i]);
			if (sTemp.length() < 2) sb.append(0);
			sb.append(sTemp.toUpperCase());
		}
		return sb.toString();
	}

	/**
	 * 字节数组转16进制且格式化十六进制
	 * @param bArray
	 * @return
	 */
	public static final String bytesToHexByFormat(byte[] bArray) {
		StringBuffer sb = new StringBuffer(bArray.length);
		String sTemp;
		for (int i = 0; i < bArray.length; i++) {
			sTemp = Integer.toHexString(0xFF & bArray[i]);
			if (sTemp.length() < 2) sb.append(0);
			sb.append(sTemp.toUpperCase()).append(' ');
		}
		return sb.toString();
	}

	/**
	 * 字节数组转16进制
	 * @param src
	 * @return
	 */
	public static final String bytesToHex(byte[] src, int offset, int length) {
		byte[] bArray = ArrayUtils.subarray(src, offset, offset + length);
		return bytesToHex(bArray);
	}

	public static final String byteToHex(byte value) {
		String s = Integer.toHexString(0xff & value);
		if(s.length() == 1) return "0"+s;
		return s;
	}

	public static final String shortToHex(short value) {
		String s = Integer.toHexString(value);
		switch (s.length()) {
			case 1: return "000" + s;
			case 2: return "00" + s;
			case 3: return "0" + s;
			default: return s;
		}
	}

	public static final String intToHex(int value) {
		StringBuilder s = new StringBuilder(Integer.toHexString(value));
		String v1 = s.toString().replace("f","");
		if (v1.length() <4){
			for (int i = 0; i < 4 - v1.length(); i++) {
			  s.insert(0, "0");
			}
			return s.toString().replace("f","");
		}
		else return s.toString().replace("f","");
	}

	public static final String hexTo8Bit(int value,int index){
		String s = Integer.toBinaryString(value);
		StringBuilder result = new StringBuilder(s);
		if (s.length() < index){
			for (int i = 0; i < index - s.length(); i++) {
				result.insert(0,"0");
			}
		}
		return result.toString();
	}

	/**
	 * @函数功能: BCD码转为10进制串(阿拉伯数据)
	 * @输入参数: BCD码
	 * @输出结果: 10进制串
	 */
	public static String bcdToStr(byte[] bytes){
		StringBuffer temp=new StringBuffer(bytes.length*2);

		for(int i=0;i<bytes.length;i++){
			temp.append((byte)((bytes[i] & 0xf0)>>>4));
			temp.append((byte)(bytes[i] & 0x0f));
		}

		return temp.toString();
	}

	/**
	 *
	 * @param src 原报文
	 * @param offset 起始位置
	 * @param length 长度
	 * @return
	 */
	public static String bcdToStr(byte[] src, int offset, int length){
		byte[] bArray = ArrayUtils.subarray(src, offset, offset + length);
		return bcdToStr(bArray);
	}

	public static byte[] str2Bcd(String asc) {
		int len = asc.length();
		int mod = len % 2;

		if (mod != 0) {
			asc = "0" + asc;
			len = asc.length();
		}

		byte abt[];
		if (len >= 2) {
			len = len / 2;
		}

		byte bbt[] = new byte[len];
		abt = asc.getBytes();
		int j, k;

		for (int p = 0; p < asc.length()/2; p++) {
			if ( (abt[2 * p] >= '0') && (abt[2 * p] <= '9')) {
				j = abt[2 * p] - '0';
			} else if ( (abt[2 * p] >= 'a') && (abt[2 * p] <= 'z')) {
				j = abt[2 * p] - 'a' + 0x0a;
			} else {
				j = abt[2 * p] - 'A' + 0x0a;
			}

			if ( (abt[2 * p + 1] >= '0') && (abt[2 * p + 1] <= '9')) {
				k = abt[2 * p + 1] - '0';
			} else if ( (abt[2 * p + 1] >= 'a') && (abt[2 * p + 1] <= 'z')) {
				k = abt[2 * p + 1] - 'a' + 0x0a;
			}else {
				k = abt[2 * p + 1] - 'A' + 0x0a;
			}

			int a = (j << 4) + k;
			byte b = (byte) a;
			bbt[p] = b;
		}
		return bbt;
	}

	private static byte toByte(char c) {
		return (byte) c;
	}

	/**
	 * 将字节数组转换成 ushort 数据
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return short值
	 */
	public static int bytesToUShort(byte[] bytes, int offset) {
		return ((0xff & bytes[0 + offset]) | (0xff00 & (bytes[1 + offset] << 8)));
	}

	/**
	 * 将字节数组转换成 ushort 数据，采用倒序的方式
	 * @param bytes 字节数组
	 * @return short值
	 */
	public static int bytesToUShortOfReverse(byte[] bytes) {
		return ByteUtils.bytesToShortOfReverse(bytes, 0);
	}

	/**
	 * 将字节数组转换成 ushort 数据，采用倒序的方式
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return short值
	 */
	public static int bytesToUShortOfReverse(byte[] bytes, int offset) {
		return ((0xff & bytes[1 + offset]) | (0xff00 & (bytes[0 + offset] << 8)));
	}

	/**
	 * byte数组中取int数值，本方法适用于(低位在前，高位在后)的顺序，和intToBytes配套使用
	 *
	 * @param src
	 *            byte数组
	 * @param offset
	 *            从数组的第offset位开始
	 * @return int数值
	 */
	public static int bytesToInt(byte[] src, int offset) {
		return ((src[offset] & 0xFF) | ((src[offset + 1] & 0xFF) << 8)
				| ((src[offset + 2] & 0xFF) << 16) | ((src[offset + 3] & 0xFF) << 24));
	}

	/**
	 * byte数组中取int数值，本方法适用于(低位在前，高位在后)的顺序，和intToBytes配套使用
	 * @param src byte数组
	 * @return int数值
	 */
	public static int bytesToInt(byte[] src) {
		return ByteUtils.bytesToInt(src, 0);
	}

	/**
	 * 将字节数组转换成int数据，采用倒序的方式
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return int值
	 */
		public static int bytesToIntOfReverse(byte[] bytes, int offset) {
		return (0xff &         bytes[3 + offset]) |
				(0xff00 &     (bytes[2 + offset] << 8)) |
				(0xff0000 &   (bytes[1 + offset] << 16)) |
				(0xff000000 & (bytes[0 + offset] << 24));
	}

	/**
	 * 将字节数组转换成int数据，采用倒序的方式
	 * @param bytes 字节数组
	 * @return int值
	 */
	public static int bytesToIntOfReverse(byte[] bytes) {
		return ByteUtils.bytesToIntOfReverse(bytes, 0);
	}

	/**
	 * 将字节数组转换成uint数据
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return int值
	 */
	public static long bytesToUInt(byte[] bytes, int offset) {
		int value = bytesToInt(bytes, offset);
		if (value >= 0) return value;
		return 65536L * 65536L + value;
	}

	/**
	 * 将字节数组转换成uint数据
	 * @param bytes 字节数组
	 * @return int值
	 */
	public static long bytesToUInt(byte[] bytes) {
		return ByteUtils.bytesToUInt(bytes, 0);
	}

	/**
	 * 将字节数组转换成uint数据
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return int值
	 */
	public static long bytesToUIntOfReverse(byte[] bytes, int offset) {
		int value = bytesToIntOfReverse(bytes, offset);
		if (value >= 0) return value;
		return 65536L * 65536L + value;
	}

	/**
	 * 将字节数组转换成uint数据 倒序
	 * @param bytes 字节数组
	 * @return int值
	 */
	public static long bytesToUIntOfReverse(byte[] bytes) {
		return ByteUtils.bytesToUIntOfReverse(bytes, 0);
	}

	/**
	 * 将字节数组转换成float数据
	 * @param bytes 字节数组
	 * @return float值
	 */
	public static float bytesToFloat(byte[] bytes) {
		return Float.intBitsToFloat(bytesToInt(bytes, 0));
	}

	/**
	 * 将字节数组转换成float数据
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return float值
	 */
	public static float bytesToFloat(byte[] bytes, int offset) {
		return Float.intBitsToFloat(bytesToInt(bytes,offset));
	}

	/**
	 * 将字节数组转换成float数据
	 * @param bytes 字节数组
	 * @return float值
	 */
	public static float bytesToFloatOfReverse(byte[] bytes) {
		return bytesToFloatOfReverse(bytes, 0);
	}

	/**
	 * 将字节数组转换成float数据
	 * @param bytes 字节数组
	 * @param offset 偏移量
	 * @return float值
	 */
	public static float bytesToFloatOfReverse(byte[] bytes, int offset) {
		return Float.intBitsToFloat(bytesToIntOfReverse(bytes, offset));
	}


	/**
	 * byte数组中取double数值
	 * @param src byte数组
	 * @return double数值
	 */
	public static double bytesToDouble(byte[] src) {
		return Double.longBitsToDouble(bytesToLong(src));
	}

	/**
	 * byte数组中取double数值
	 * @param src byte数组
	 * @param offset 从数组的第offset位开始
	 * @return double数值
	 */
	public static double bytesToDouble(byte[] src, int offset) {
		return Double.longBitsToDouble(bytesToLong(src, offset));
	}

	/**
	 * byte数组中取double数值
	 * @param src byte数组
	 * @return double数值
	 */
	public static double bytesToDoubleOfReverse(byte[] src) {
		return bytesToDoubleOfReverse(src, 0);
	}

    /**
     * byte数组中取double数值
     * @param src byte数组
     * @param offset 从数组的第offset位开始
     * @return double数值
     */
    public static double bytesToDoubleOfReverse(byte[] src, int offset) {
        return Double.longBitsToDouble(bytesToLongOfReverse(src, offset));
    }

	/**
	 * 去掉字节数组尾数为零的字节,并将其转成字符串
	 * @param src
	 * @param charset
	 * @return
	 */
	public static String bytesToString(byte[] src, Charset charset){
		int search = Arrays.binarySearch(src, (byte) 0);
		return new String(Arrays.copyOf(src, search), charset);
	}

	/**
	 * 去掉字节数组尾数为零的字节,并将其转成字符串
	 * @param src
	 * @return
	 */
	public static String bytesToString(byte[] src){
		return new String(wipeLastZero(src));
	}

	/**
	 * 去掉字节数组尾数为零的字节,并将其转成字符串
	 * @param src
	 * @return
	 */
	public static String bytesToString(byte[] src, int startIndex, int endIndex){
		return new String(wipeLastZero(subBytes(src, startIndex, endIndex)));
	}

	/**
	 * 去掉字节数组尾数为零的字节,并将其转成字符串
	 * @param src
	 * @return
	 */
	public static String bytesToString(byte[] src, int startIndex, int endIndex, Charset charset){
		return new String(wipeLastZero(subBytes(src, startIndex, endIndex)), charset);
	}

	/**
	 * 将byte[]数组的数据进行翻转
	 * @param reverse 等待反转的字符串
	 */
	public static void bytesReverse(byte[] reverse) {
		if (reverse != null) {
			byte tmp = 0;
			for (int i = 0; i < reverse.length / 2; i++) {
				tmp = reverse[i];
				reverse[i] = reverse[reverse.length - 1 - i];
				reverse[reverse.length - 1 - i] = tmp;
			}
		}
	}

	/**
	 * 去除包含0的字节
	 * @param src
	 * @return
	 */
	private static byte[] wipeLastZero(byte[] src){
		int index = 0;
		for(int i=0; i<src.length; i++){
			if(src[i] == 0) {
				break;
			}

			index++;
		}

		return subBytes(src, 0, index);
	}

	/**
	 * 字节转为long, 偏移位从0开始
	 * @param bytes
	 * @return
	 */
	public static long bytesToLong(byte[] bytes) {
		return ByteUtils.bytesToLong(bytes, 0);
	}

	/**
	 * 字节转为long
	 * @param bytes
	 * @param offset 偏移位置
	 * @return
	 */
	public static long bytesToLong(byte[] bytes, int offset) {
		return (0xffL & (long) bytes[0 + offset]) |
				(0xff00L & ((long) bytes[1 + offset] << 8)) |
				(0xff0000L & ((long) bytes[2 + offset] << 16)) |
				(0xff000000L & ((long) bytes[3 + offset] << 24)) |
				(0xff00000000L & ((long) bytes[4 + offset] << 32)) |
				(0xff0000000000L & ((long) bytes[5 + offset] << 40)) |
				(0xff000000000000L & ((long) bytes[6 + offset] << 48)) |
				(0xff00000000000000L & ((long) bytes[7 + offset] << 56));
	}

	/**
	 * 将字节数组转换成long数据 倒序
	 * @param bytes 字节数组
	 * @return long值
	 */
	public static long bytesToLongOfReverse(byte[] bytes) {
		return ByteUtils.bytesToLongOfReverse(bytes, 0);
	}

	/**
	 * 将字节数组转换成long数据 倒序
	 * @param bytes 字节数组
	 * @param offset 起始位置
	 * @return long值
	 */
	public static long bytesToLongOfReverse(byte[] bytes, int offset) {
		return (0xffL & (long) bytes[7 + offset]) |
				(0xff00L & ((long) bytes[6 + offset] << 8)) |
				(0xff0000L & ((long) bytes[5 + offset] << 16)) |
				(0xff000000L & ((long) bytes[4 + offset] << 24)) |
				(0xff00000000L & ((long) bytes[3 + offset] << 32)) |
				(0xff0000000000L & ((long) bytes[2 + offset] << 40)) |
				(0xff000000000000L & ((long) bytes[1 + offset] << 48)) |
				(0xff00000000000000L & ((long) bytes[0 + offset] << 56));
	}

	/**
	 * 字符数组 切割
	 * @param bytes 字节数组
	 * @param beginIndex 开始索引
	 * @param endIndex 结束索引
	 * @return
	 */
	public static byte[] subBytes(byte[] bytes, int beginIndex, int endIndex) {
		byte[] result = new byte[endIndex - beginIndex];
		System.arraycopy(bytes, beginIndex, result, 0, result.length);
		return result;
	}

	/**
	 * 子字节 从开始位置{beginIndex} 到结束
	 * @param bytes
	 * @param beginIndex
	 * @return
	 */
	public static byte[] subBytes(byte[] bytes, int beginIndex) {
		return ByteUtils.subBytes(bytes, beginIndex, bytes.length);
	}

	/**
	 * 将截取数组指定数据,并将其转为字符串
	 * @param bytes
	 * @param beginIndex
	 * @param endIndex
	 * @return
	 */
	public static String subBytesToString(byte[] bytes, int beginIndex, int endIndex){
		byte[] subBytes = subBytes(bytes, beginIndex, endIndex);
		return bytesToString(subBytes);
	}

	/**
	 * byte数组添加整个target数组
	 *
	 *            源字节数组
	 * @param targetBytes
	 *            添加对象数组
	 * @param beginIndex
	 *            开始下标
	 * @return
	 */
	public static byte[] addBytes(byte[] sourceBytes, byte[] targetBytes, int beginIndex) {
		if (targetBytes == null) {
			return sourceBytes;
		}
		int targetSize = targetBytes.length;
		if (sourceBytes == null) {
			beginIndex = 0;
			sourceBytes = new byte[targetSize];
		}
		int sourceSize = sourceBytes.length;
		if (sourceSize - beginIndex < targetSize) {
			return sourceBytes;
		} else {
			for (int i = 0; i < targetSize; i++) {
				sourceBytes[beginIndex + i] = targetBytes[i];
			}
		}
		return sourceBytes;

	}

	/**
	 * 将一个uuid对象转化成byte[]
	 * @param uuid uuid对象
	 * @return 字节数组
	 */
	public static byte[] UUID2Byte(UUID uuid) {
		ByteArrayOutputStream ba = new ByteArrayOutputStream(16);
		DataOutputStream da = new DataOutputStream(ba);
		try {
			da.writeLong(uuid.getMostSignificantBits());
			da.writeLong(uuid.getLeastSignificantBits());
			ba.close();
			da.close();
		}
		catch (IOException e) {
			e.printStackTrace();
		}

		byte[] buffer = ba.toByteArray();
		// 进行错位
		byte temp=buffer[0];
		buffer[0] = buffer[3];
		buffer[3] =temp;
		temp=buffer[1];
		buffer[1]=buffer[2];
		buffer[2]=temp;

		temp = buffer[4];
		buffer[4]=buffer[5];
		buffer[5] =temp;

		temp = buffer[6];
		buffer[6]=buffer[7];
		buffer[7] =temp;

		return buffer;
	}

	/**
	 * 获取字节的指定位值 0 or 1
	 * @param value
	 * @param index
	 * @return
	 */
	public static byte bitAtByte(byte value, int index) {
		return (byte) ((value & (1 << index)) > 0 ? 1 : 0);
	}

	/**
	 *将bool数组转换到byte数组<br />
	 * @param array bool数组
	 * @return 字节数组
	 */
	public static byte[] boolArrayToByte(boolean[] array) {
		if (array == null) return null;

		int length = array.length % 8 == 0 ? array.length / 8 : array.length / 8 + 1;
		byte[] buffer = new byte[length];

		for (int i = 0; i < array.length; i++) {
			if (array[i]) {
				buffer[i / 8] += (1 << i % 8);
			}
		}

		return buffer;
	}

	public static Integer cutMessageHexTo(byte[] source, int startIndex, int endIndex){
		byte[] subarray = ArrayUtils.subarray(source, startIndex, endIndex);
		String s = bytesToHexString(subarray);
		return Integer.parseInt(s,16);
	}

	/**
	 * byte数组转换炒年糕十六进制字符串
	 *
	 * @param bArray byte数组
	 * @return hex字符串
	 */
	public static String bytesToHexString(byte[] bArray) {
		StringBuilder sb = new StringBuilder(bArray.length);
		for (int i = 0; i < bArray.length; i++) {
			String hexStr = Integer.toHexString(0xFF & bArray[i]);
			if (hexStr.length() < 2) {
				sb.append(0);
			}
			sb.append(hexStr.toUpperCase());
		}
		return sb.toString();
	}


}
