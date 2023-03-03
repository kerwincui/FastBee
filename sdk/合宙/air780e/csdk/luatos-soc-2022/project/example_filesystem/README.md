# 文件系统API说明

## 概述

* 文件系统的主体是littlefs, 总空间288k, 可用100k左右.
* 有多套API, 各有特色, 但不应该混用

## Osa文件API

位于 `osasys.h`, 只有少量函数, 与posix API 类似. 不涉及目录操作

```c
OSAFILE OsaFopen(const char *fileName, const char* mode);
INT32 OsaFtell(OSAFILE fp);
INT32 OsaFclose(OSAFILE fp);
UINT32 OsaFread(void *buf, UINT32 size, UINT32 count, OSAFILE fp);
UINT32 OsaFwrite(void *buf, UINT32 size, UINT32 count, OSAFILE fp);
INT32 OsaFseek(OSAFILE fp, INT32 offset, UINT8 seekType);
UINT32 OsaFremove(const char *fileName);
```

通用调用逻辑:
```c
#define BUFF_SIZE (512)
char buff[BUFF_SIZE];
UINT32 rlen = 0;
OSAFILE fp = OsaFopen("fs_test", "r");
if (fp) { // 若成功, 必不为NULL
    // 读写数据
    while ((rlen = OsaFread(buff, BUFF_SIZE, 1, fp)) > 0) {
        // 处理读取到的数据
    }
    OsaFclose(fp);
}
```

## LiffteFs 文件API

在原始的lifftefs上, 封装成 `lfs_port.h`

注意: 

* 不要调用 `LFS_init` `LFS_deinit` , 底层会自行处理
* API 均以 `LFS_` 开头, 为同步阻塞且线程安全的函数. 与原生lifftefs的API基本上一一对应

通用调用逻辑:
```c
#define BUFF_SIZE (512)
char buff[BUFF_SIZE];
UINT32 rlen = 0;
int ret = 0;
lfs_file_t *file = malloc(sizeof(lfs_file_t));
if (file == NULL) {
    // 内存分配出错
    return -1;
}
ret = LFS_fileOpen(file, "fs_test", LFS_O_RDONLY);
if (ret == LFS_ERR_OK) { // 若成功, 必不为NULL
    // 读写数据
    while ((rlen = LFS_fileRead(file, buff, BUFF_SIZE)) > 0) {
        // 处理读取到的数据
    }
    LFS_fileClose(file);
}
free(file); // 注意释放内存
```
