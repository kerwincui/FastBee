# 量产说明
aliyun 在使用一机一密的情况下，需要在每个设备上烧写与设备对应的 ProductKey、ProductSecret、DeviceName、DeviceSecret。

为了使烧录和软件读取流程尽量简化，我们将使用 IDF 的 NVS 分区功能，将 ProductKey、ProductSecret、DeviceName、DeviceSecret 信息通过 NVS 分区生成工具或量产工具生成对应的 NVS 分区，该分区中利用 NVS 结构保存了 ProductKey、ProductSecret、DeviceName、DeviceSecret 的键值对。生成后的 NVS 分区 bin 可以通过 esptool 或其他烧写工具直接烧录到 NVS 分区对应的起始扇区，partition 分区表中指明了该 NVS 分区的起始地址。软件可以通过 NVS 相关接口读取到 ProductKey、ProductSecret、DeviceName、DeviceSecret 的具体值。

请参照 partitions_esp32.csv 和 partitions_esp8266.csv 中 fctry 的起始地址进行烧录，也可根据实际项目对 partitions 进行调整，但一定要保证 partitons 中 fctry 的实际地址与烧录地址保持吻合。

关于 NVS、NVS 分区生成工具、量产工具，请参考：
- [NVS](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/storage/nvs_flash.html)
- [NVS 分区生成工具](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/storage/nvs_partition_gen.html)
- [量产工具](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/storage/mass_mfg.html)

## 单个 bin 生成
在调试过程中，建议使用该方式。

mass_mfg 目录中有一参考配置：single_mfg_config.csv，请拷贝成自己的配置文件，如 my_single_mfg_config.csv。
```
cp single_mfg_config.csv my_single_mfg_config.csv
```

使用自己的 ProductKey、ProductSecret、DeviceName、DeviceSecret 对 my_single_mfg_config.csv 进行修改：
```
key,type,encoding,value
aliyun-key,namespace,,
DeviceName,data,string,config
DeviceSecret,data,string,dsj3RuY74pgCBJ3zczKz1LaLK7RGApqh
ProductKey,data,string,a10BnLLzGv4
ProductSecret,data,string,pVfLpS1u3A9JM0go
```

将 config，dsj3RuY74pgCBJ3zczKz1LaLK7RGApqh，a10BnLLzGv4，pVfLpS1u3A9JM0go 修改为你对应的值。

修改完成后，使用如下命令生成对应的 NVS 分区：
```
$IDF_PATH/components/nvs_flash/nvs_partition_generator/nvs_partition_gen.py --input single_mfg_config.csv --output single_mfg.bin --size 0x4000
python nvs_partition_gen.py generate single_mfg_config.csv single_mfg.bin 0x4000
```
如针对 esp8266 平台，请使用如下命令：
```
$IDF_PATH/components/nvs_flash/nvs_partition_generator/nvs_partition_gen.py --input my_single_mfg_config.csv --output my_single_mfg.bin --size 0x4000
```
> 说明：esp8266 的 NVS 格式当前为 v1, 默认已设置。

可以使用 esptool 工具将生成的包含秘钥的 NVS 分区烧入对应的 sector，针对 example 中默认提供的 partitions，esp32 和 esp8266 将烧写到不同的分区，其中 esp32 的默认烧录地址为 0x210000，esp8266 的默认烧录地址为 0x100000。

针对 esp32：
```
$IDF_PATH/components/esptool_py/esptool/esptool.py write_flash 0x210000 my_single_mfg.bin
```

针对 esp8266：
```
$IDF_PATH/components/esptool_py/esptool/esptool.py --port /dev/ttyUSB0 write_flash 0x100000 my_single_mfg.bin
```

> 注，当前 esp32 默认使用 4MB 的模组，esp8266 默认使用 2MB 的模组，如使用其他大小的 Flash，请适当调整 partitions 分区表，并确认烧写地址。

## 多个 bin 批量生成
量产过程中如采用以上方法单个生成对应的 NVS 分区会很繁琐，因此采用 IDF 中的量产工具，该量产工具也是基于 NVS 分区生成工具的扩充。

mass_mfg 目录中提供了一套参考的配置，其中 multipule_mfg_config.csv 为参数区配置文件，已做好针对 aliyun 的配置，用户无需修改，multipule_mfg_values.csv 中可以包含所有需要生成 NVS 分区的 ProductKey、ProductSecret、DeviceName、DeviceSecret 信息，请将 multipule_mfg_values.csv 复制为 my_multipule_mfg_values.csv 并对该文件进行修改，包含所有希望用于量产的 ProductKey、ProductSecret、DeviceName、DeviceSecret 信息。

my_multipule_mfg_values.csv 中内容如下：
```
id,DeviceName,DeviceSecret,ProductKey,ProductSecret
1,config,dsj3RuY74pgCBJ3zczKz1LaLK7RGApqh,a10BnLLzGv4,pVfLpS1u3A9JM0go
2,config,dsj3RuY74pgCBJ3zczKz1LaLK7RGApqh,a10BnLLzGv4,pVfLpS1u3A9JM0go
3,config,dsj3RuY74pgCBJ3zczKz1LaLK7RGApqh,a10BnLLzGv4,pVfLpS1u3A9JM0go
```

每一行代表了一组秘钥信息，第一列的为 id 信息，不会生成到对应的 NVS 分区中，仅用作标号。

采用如下命令批量生成 NVS 分区。

针对 esp32：
```
$IDF_PATH/tools/mass_mfg/mfg_gen.py --conf multipule_mfg_config.csv --values my_multipule_mfg_values.csv --prefix Fan --size 0x4000
```

针对 esp8266：
```
$IDF_PATH/tools/mass_mfg/mfg_gen.py --conf multipule_mfg_config.csv --values my_multipule_mfg_values.csv --prefix Fan --size 0x4000 --version v1
```

其中 --prefix 为生成的批量文件的前缀名称，可以修改为所需要的产品名称。执行完成后，会在当前目录下生成一 bin 目录，里面保持了所有可用于量产的 NVS 分区 bin。

> 注，当前不知道 aliyun 能否批量导出 ProductKey、ProductSecret、DeviceName、DeviceSecret，如有需要，可以编写特定脚本来生成 my_multipule_mfg_values.csv。