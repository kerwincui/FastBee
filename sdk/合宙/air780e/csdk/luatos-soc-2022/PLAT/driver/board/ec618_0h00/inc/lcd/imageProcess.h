#ifndef  IMAGE_PROCESS_H
#define  IMAGE_PROCESS_H

#ifdef __cplusplus
extern "C" {
#endif
#include "stdio.h"
#include "string.h"
#include "ec618.h"
#include "bsp.h"
#include <stdlib.h>


/**
  \brief Convert yuv422 to rgb565, used in color screen.
  \param[in]   inbuf       source memory.
  \param[out]  outbuf      output memory.
  \param[in]   width       source picture width.
  \param[in]   height      source picture height.
  \return              
*/
void yuv422ToRgb565(const void* inbuf, void* outbuf, int width, int height);

/**
  \brief Scale the picture. Now this api can only zoom out the picture.
  \param[in]  ratio     Zoom out ratio.
  \param[in]  inPtr     Data source.
  \param[in]  width     Source data width.
  \param[in]  height    Source data height.
  \param[out] outPtr    Output data address.
  \return              
*/
void scalePic(uint8_t ratio, uint8_t* inPtr, uint16_t width, uint16_t height, uint8_t *outPtr);

/**
  \brief Clockwise rotate 90 degree.
  \param[in,out] mem     Data source.
  \param[in]     width   Source picture width.
  \param[in] 	 height  Source picture height.
  \return              
*/
void imageRotate(uint8_t* mem, uint32_t width, uint32_t height);

/**
  \brief Organize the bytes as horizontal or vertical.
  \param[in]  inPut       Src data.
  \param[in]  pageLen     The pageNum you want for these data, this param is set by you.
  \param[in]  width       The width you want for these data, this param is set by you.
  \param[out] outPut      Output buffer.
  \param[in]  horizotal   These data you want to array them as horizontal or vertical.
  \return              
*/
void storeByteIntoArray(uint8_t *inPut, uint8_t pageLen, uint16_t width, uint8_t *outPut, bool horizotal);

/**
  \brief Merge 8bytes into one byte, used in 1-bit LCD.
  \param[in]   p       		  Src data.
  \param[out]  outPut     	  Output buffer.
  \param[in]   width       	  Source data width.
  \param[out]  height         Source data height.
  \param[in]   horizotal      Fetch the data by row or by column.
  \param[in]   inByteRevert   Within the byte, positive or reverse the bit sequence.
  \return      index   		  How many bytes has been returned, for debug use         
*/
uint16_t merge8Bytes2OneByte(uint8_t* p, uint8_t *outPut, uint16_t width, uint16_t height, bool horizotal, bool inByteRevert);

/**
  \brief Binary the source picture.
  \param[in]   inPut       Src data.
  \param[in]   width       Source picture width.
  \param[in]   height      Source picture height.
  \param[out]  outPut      Output buffer.
  \return              
*/
void calBinary(uint8_t* inPut, uint16_t width, uint16_t height, uint8_t* outPut);




#ifdef __cplusplus
}
#endif
#endif /* IMAGE_PROCESS_H */


