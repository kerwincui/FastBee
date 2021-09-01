#ifndef _cJSON_H_
#define _cJSON_H_

#ifdef __cplusplus
extern "C"
{
#endif

/* cJSON Types: */
#define cJSON_False     0
#define cJSON_True      1
#define cJSON_NULL      2
#define cJSON_Number    3
#define cJSON_String    4
#define cJSON_Array     5
#define cJSON_Object    6
	
#define cJSON_IsReference   256
#define cJSON_StringIsConst 512

/* The cJSON structure: */
typedef struct cJSON {
	struct cJSON *next,*prev;	/* next/prev allow you to walk array/object chains. Alternatively, use GetArraySize/GetArrayItem/GetObjectItem */
	struct cJSON *child;		/* An array or object item will have a child pointer pointing to a chain of the items in the array/object. */

	int    type;				/* The type of the item, as above. */

	char  *valuestring;			/* The item's string, if type==cJSON_String */
	int    valueint;			/* The item's number, if type==cJSON_Number */
	double valuedouble;			/* The item's number, if type==cJSON_Number */

	char  *string;				/* The item's name string, if this item is the child of, or is in the list of subitems of an object. */
} cJSON;

typedef struct cJSON_Hooks {
      void *(*malloc_fn)(size_t sz);
      void (*free_fn)(void *ptr);
} cJSON_Hooks;

/* 向cJSON提供malloc、realloc和free函数 */
extern void cJSON_InitHooks(cJSON_Hooks* hooks);

/* 提供一个JSON块，然后返回一个可以查询的cJSON对象。完成后调用cJSON_Delete */
extern cJSON *cJSON_Parse(const char *value);
/* 将cJSON实体呈现为用于传输/存储的文本。完成后释放char* */
extern char  *cJSON_Print(cJSON *item);
/* 将cJSON实体呈现为用于传输/存储的文本，而不进行任何格式化。完成后释放char* */
extern char  *cJSON_PrintUnformatted(cJSON *item);
/* 使用缓冲策略将cJSON实体呈现为文本。预缓冲是对最终大小的猜测。猜测减少了重新分配。fmt=0表示无格式,=1表示有格式 */
extern char  *cJSON_PrintBuffered(cJSON *item,int prebuffer,int fmt);
/* 删除一个cJSON实体和所有子实体 */
extern void   cJSON_Delete(cJSON *c);

/* 返回数组(或对象)中的项数 */
extern int	  cJSON_GetArraySize(cJSON *array);
/* 从数组“数组”中检索项目编号“项目”。如果不成功，返回NULL */
extern cJSON *cJSON_GetArrayItem(cJSON *array,int item);
/* 从对象中获取项目“string”。不区分大小写 */
extern cJSON *cJSON_GetObjectItem(cJSON *object,const char *string);

/* 用于分析失败的语法。这将返回一个指向解析错误的指针。你可能需要回头看几个字才能理解它。当cJSON_Parse()返回0时定义。当cJSON_Parse()成功时为0 */
extern const char *cJSON_GetErrorPtr(void);
	
/* 这些调用创建适当类型的cJSON项 */
extern cJSON *cJSON_CreateNull(void);
extern cJSON *cJSON_CreateTrue(void);
extern cJSON *cJSON_CreateFalse(void);
extern cJSON *cJSON_CreateBool(int b);
extern cJSON *cJSON_CreateNumber(double num);
extern cJSON *cJSON_CreateString(const char *string);
extern cJSON *cJSON_CreateArray(void);
extern cJSON *cJSON_CreateObject(void);

/* 这些实用程序创建一个计数项数组 */
extern cJSON *cJSON_CreateIntArray(const int *numbers,int count);
extern cJSON *cJSON_CreateFloatArray(const float *numbers,int count);
extern cJSON *cJSON_CreateDoubleArray(const double *numbers,int count);
extern cJSON *cJSON_CreateStringArray(const char **strings,int count);

/* 向指定的数组/对象追加项 */
extern void cJSON_AddItemToArray(cJSON *array, cJSON *item);
extern void	cJSON_AddItemToObject(cJSON *object,const char *string,cJSON *item);
extern void	cJSON_AddItemToObjectCS(cJSON *object,const char *string,cJSON *item);	/* Use this when string is definitely const (i.e. a literal, or as good as), and will definitely survive the cJSON object */
/* Append reference to item to the specified array/object. Use this when you want to add an existing cJSON to a new cJSON, but don't want to corrupt your existing cJSON. */
extern void cJSON_AddItemReferenceToArray(cJSON *array, cJSON *item);
extern void	cJSON_AddItemReferenceToObject(cJSON *object,const char *string,cJSON *item);

/* 从数组/对象中删除/分离项 */
extern cJSON *cJSON_DetachItemFromArray(cJSON *array,int which);
extern void   cJSON_DeleteItemFromArray(cJSON *array,int which);
extern cJSON *cJSON_DetachItemFromObject(cJSON *object,const char *string);
extern void   cJSON_DeleteItemFromObject(cJSON *object,const char *string);
	
/* Update array items. */
extern void cJSON_InsertItemInArray(cJSON *array,int which,cJSON *newitem);	/* Shifts pre-existing items to the right. */
extern void cJSON_ReplaceItemInArray(cJSON *array,int which,cJSON *newitem);
extern void cJSON_ReplaceItemInObject(cJSON *object,const char *string,cJSON *newitem);

/* 复制一个cJSON项目 */
extern cJSON *cJSON_Duplicate(cJSON *item,int recurse);
/* Duplicate will create a new, identical cJSON item to the one you pass, in new memory that will
need to be released. With recurse!=0, it will duplicate any children connected to the item.
The item->next and ->prev pointers are always zero on return from Duplicate. */

/* ParseWithOpts允许您要求(并检查)JSON是否以null结尾，并检索指向解析后的最终字节的指针 */
extern cJSON *cJSON_ParseWithOpts(const char *value,const char **return_parse_end,int require_null_terminated);

extern void cJSON_Minify(char *json);

/* 用于快速创建内容的宏 */
#define cJSON_AddNullToObject(object,name)		cJSON_AddItemToObject(object, name, cJSON_CreateNull())
#define cJSON_AddTrueToObject(object,name)		cJSON_AddItemToObject(object, name, cJSON_CreateTrue())
#define cJSON_AddFalseToObject(object,name)		cJSON_AddItemToObject(object, name, cJSON_CreateFalse())
#define cJSON_AddBoolToObject(object,name,b)	cJSON_AddItemToObject(object, name, cJSON_CreateBool(b))
#define cJSON_AddNumberToObject(object,name,n)	cJSON_AddItemToObject(object, name, cJSON_CreateNumber(n))
#define cJSON_AddStringToObject(object,name,s)	cJSON_AddItemToObject(object, name, cJSON_CreateString(s))

/* 在分配整数值时，也需要将其传播到valuedouble */
#define cJSON_SetIntValue(object,val)			((object)?(object)->valueint=(object)->valuedouble=(val):(val))
#define cJSON_SetNumberValue(object,val)		((object)?(object)->valueint=(object)->valuedouble=(val):(val))

#ifdef __cplusplus
}
#endif

#endif
