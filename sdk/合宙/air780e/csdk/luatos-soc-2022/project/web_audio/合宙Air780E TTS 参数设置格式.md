# 合宙Air780E TTS 参数设置格式（可以变声的TTS）

1.原始格式（选择默认参数）

```c
char str[] = "大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

2.设置发音人

​      设置代码参考，发音人同时只能设置一个

```c
 格式： [m*] (*=51~55)
 51 – 许久
 52 – 许多
 53 – 晓萍
 54 – 唐老鸭
 55 – 许宝宝 
 选择许多(52)作为发音人
 char str[] = "[m52]大家好，我是小宙";
 luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

3.设置发音风格

```c
格式： [f*] (*=0/1/2)
参数： 0 – 一字一顿
      1 – 平铺直叙
      2 – 有声有色
说明： 默认为平铺直叙风格。
 char str[] = "[f1]大家好，我是小宙";
 luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
 
```

4.选择语种

```c
格式： [g*] (*=0/1/2)
参数： 0 – 自动判断
	  1 – 汉语普通话
	  2 – 英语语种
      3 – 法语
说明：默认语种为自动判断。
char str[] = "[g0]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口

```

5.设置数字处理策略

```c
格式： [n*] (*=0/1/2)
参数： 0 – 自动判断
      1 – 数字作号码处理
      2 – 数字作数值处理
说明： 默认为自动判断。
char str[] = "[n1]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

6.英文数字 0 的朗读设置

```c
格式： [o*] (*=0/1)
参数： 0 – 英文数字 0 读做“O”
	  1 – 英文数字 0 读做“zero”
说明： 默认为英文数字 0 读做“zero”。
注意：0 只有作为号码朗读时，标记才会生效，0 处理为数值时，一律读作 zero。
char str[] = "[o1]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

7.静音一段时间

```c
格式： [p*] (*=无符号整数)
参数： * – 静音的时间长度，单位：毫秒(ms)
char str[] = "[p2000]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

8.设置语速

```c
格式： [s*] (*=0~10)
参数： * – 0-10
说明： 默认语速值为 5，语速的调节范围为默认语速的一半到两倍，即 0 的值比默认语速慢一半，10 的值比默认语速快一倍。
char str[] = "[s5]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

9.设置语调

```c
格式： [t*] (*=0~10)
参数： * – 语调值对应到参数设置的值为 6553*（值-5），即 0 对应到-32765，5 对应到 0，10 对应到+32765
说明： 默认语调值为 5，语调的调节范围为默认语调基频下 64Hz 到上 128Hz。
char str[] = "[t5]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

10.设置音量

```c
格式： [v*] (*=0~10)
参数： * – 音量值对应到参数设置的值为 6553*（值-5），即 0 对应到-32765，5 对应到 0，10 对应到+32765。
说明： 音量的调节范围为静音到音频设备支持的最大值，默认值 5 为中间音量。
char str[] = "[v1]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

11.设置汉语号码中“1”的读法

```c
格式： [y*] (*=0/1)
参数： 0 – 合成号码时“1”读成“yāo”
      1 – 合成号码时“1”读成“yī”
说明： 默认合成号码时“1”读成“yāo”。
char str[] = "[y1]大家好，我是小宙";
luat_audio_play_tts_text(0, str, sizeof(str));//audio 播报TTS 的接口
```

