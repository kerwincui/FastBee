
typedef enum
{
	AM_FOTA_SETFLAG = 2,
	AM_FOTA_INPROGRESS = 1,
	AM_FOTA_SUCCEED = 0,
	AM_FOTA_FAIL = -1
}amFotaSta;
typedef enum
{
    AM_FOTA_SUCCESS=0,             //下载成功
    AM_FOTA_COMPLETED=100,         //下载完成
    AM_FOTA_DOMAIN_NOT_EXIST=1001, //下载地址不存在
    AM_FOTA_DOMAIN_TIMEOUT,        //下载地址访问超时
    AM_FOTA_DOMAIN_UNKNOWN,        //下载地址格式错误
    AM_FOTA_SERVER_CONN_FAIL,      //服务器连接失败
    AM_FOTA_AUTH_FAILED,           //授权失败
    AM_FOTA_FILE_NOT_EXIST,        //文件不存在
    AM_FOTA_FILE_SIZE_INVALID,     //文件大小不可用
    AM_FOTA_FILE_GET_ERR,          //文件获取错误
    AM_FOTA_FILE_CHECK_ERR,        //升级包校验错误
    AM_FOTA_INTERNAL_ERR,          //内部错误
    AM_FOTA_NOT_INPROGRESS,        //下载中断
    AM_FOTA_NO_MEMORY,             //内存不足
    AM_FOTA_FILE_SIZE_TOO_LARGE,   //文件太大
    AM_FOTA_PARAM_SIZE_INVALID,    //无效参数
} AM_FOTARes;
typedef void (* amFotaProgressCB_t)(amFotaSta sta, int progress, char* buff, int len);
typedef enum
{
	AM_FOTA_DWNLD_MOD_FTP,
	AM_FOTA_DWNLD_MOD_HTTP
}amFotaDwnldMod;
typedef void* amFotaImgProcCtxPtr;

#define OPENAT_OTA_HEAD 0x7e
#define OPENAT_OTA_APP_HEAD 0X7c
#define OPENAT_OTA_CORE_HEAD 0x7d
#define OPENAT_OTA_HEAD_LEN (5)
#define OPENAT_OTA_FILE_MAX (20)

typedef enum
{
	OPENAT_OTA_FILE_NULL,
	OPENAT_OTA_FILE_RFBIN,
	OPENAT_OTA_FILE_APP,
	OPENAT_OTA_FILE_CORE,
	
} E_OPENAT_OTA_FILE_TYPE;

typedef struct
{
	unsigned char head[OPENAT_OTA_HEAD_LEN];
	unsigned int readLen;
	unsigned int fileNum;
} T_OPENAT_OTA_HEAD_CTX;

typedef struct
{
	E_OPENAT_OTA_FILE_TYPE type;
	unsigned char head[OPENAT_OTA_HEAD_LEN];
	unsigned int readLen;
	unsigned int size;
} T_OPENAT_OTA_FILE_CTX;

typedef struct
{

	T_OPENAT_OTA_HEAD_CTX head;
	T_OPENAT_OTA_FILE_CTX file[OPENAT_OTA_FILE_MAX];
	unsigned int readLen;
	unsigned int fileCur;
}openat_otaCtx;

static openat_otaCtx g_s_otaCtx = {0};
