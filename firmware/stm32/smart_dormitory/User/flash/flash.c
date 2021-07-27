/****************************************Copyright (c)****************************************************
**     
** File name:               humi.c
** Created by:              Brown Lee
** Created date:            2020-10-16
** Version:                 v1.0
** Descriptions:            The original 
** Link address:            https://blog.csdn.net/weixin_45006076
**
*********************************************************************************************************/

#include "flash.h"

//从指定地址开始读取多个数据
void FLASH_ReadMoreData(uint32_t startAddress,uint16_t *readData,uint16_t countToRead)
{
  uint16_t dataIndex;
  for(dataIndex=0;dataIndex<countToRead;dataIndex++)
  {
    readData[dataIndex]=FLASH_ReadHalfWord(startAddress+dataIndex*2);
  }
}

//读取指定地址的半字(16位数据)
uint16_t FLASH_ReadHalfWord(uint32_t address)
{
  return *(__IO uint16_t*)address; 
}

//读取指定地址的全字(32位数据)
uint32_t FLASH_ReadWord(uint32_t address)
{
  uint32_t temp1,temp2;
  temp1=*(__IO uint16_t*)address; 
  temp2=*(__IO uint16_t*)(address+2); 
  return (temp2<<16)+temp1;
}

//从指定地址开始写入多个数据
void FLASH_WriteMoreData(uint32_t startAddress, uint16_t *writeData, uint16_t countToWrite)
{
	uint32_t dataIndex;
	FLASH_EraseInitTypeDef User_Flash;  //声明 FLASH_EraseInitTypeDef 结构体为 User_Flash
	
  if(startAddress < FLASH_BASE || ((startAddress+countToWrite * 2) >= (FLASH_BASE + 1024 * FLASH_SIZE)))
  {
    return;//非法地址
  }
  HAL_FLASH_Unlock();         //解锁写保护
//  offsetAddress=startAddress-FLASH_BASE;               //计算去掉0X08000000后的实际偏移地址
//  sectorPosition=offsetAddress/FLASH_SIZE;            //计算扇区地址，对于STM32F103VET6为0~255
//  
//  sectorStartAddress=sectorPosition*SECTOR_SIZE+FLASH_BASE;    //对应扇区的首地址

	HAL_FLASH_Unlock();               //解锁Flash
		
	User_Flash.TypeErase = FLASH_TYPEERASE_PAGES;  //标明Flash执行页面只做擦除操作
	User_Flash.PageAddress = startAddress;  //声明要擦除的地址
	User_Flash.NbPages = 1;                        //说明要擦除的页数，此参数必须是Min_Data = 1和Max_Data =(最大页数-初始页的值)之间的值
		
	uint32_t PageError = 0;                    //设置PageError,如果出现错误这个变量会被设置为出错的FLASH地址
	HAL_FLASHEx_Erase(&User_Flash, &PageError);  //调用擦除函数擦除

	for(dataIndex=0;dataIndex<countToWrite;dataIndex++)
  {
    HAL_FLASH_Program(FLASH_TYPEPROGRAM_HALFWORD,startAddress+dataIndex*2,writeData[dataIndex]);
  }
	
  HAL_FLASH_Lock();//上锁写保护
}

