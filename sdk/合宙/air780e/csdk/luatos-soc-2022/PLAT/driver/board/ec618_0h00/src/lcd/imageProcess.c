#include "imageProcess.h"

/*  This file is used for camera preview. Since LCD will have different resolution, and decoder library need 
	a fixed resolution, so the picture from camera needs to be processed to fit different LCD resolution. */


/**
  \brief Scale the picture. Now this api can only zoom out the picture.
  \param[in]  ratio     Zoom out ratio.
  \param[in]  inPtr     Data source.
  \param[in]  width     Source data width.
  \param[in]  height    Source data height.
  \param[out] outPtr    Output data address.
  \return              
*/
void scalePic(uint8_t ratio, uint8_t* inPtr, uint16_t width, uint16_t height, uint8_t *outPtr)
{
	uint8_t *p = outPtr;
	uint16_t h, w;

	for (h = 0; h < height; h += ratio)
	{
		for (w = 0; w < width; w += ratio)
		{
			*p++ = inPtr[w + h*width];
		}
	}
}

/**
  \brief Clockwise rotate 90 degree.
  \param[in/out] mem     Data source.
  \param[in]     width   Source picture width.
  \param[in] 	 height  Source picture height.
  \return              
*/
void imageRotate(uint8_t* mem, uint32_t width, uint32_t height)
{
	uint8_t* tmpData = (uint8_t *)malloc(width * height);
	memcpy(tmpData, mem, width*height);

	for (int i= 0; i < width; i++)
	{
		for (int j = 0; j < height; j++)
		{
			mem[i*height + j] = tmpData[(height-1-j) * width + i];
		}
	}

	free(tmpData);
}

/**
  \brief Organize the bytes as horizontal or vertical.
  \param[in]  inPut       Src data.
  \param[in]  pageLen     The pageNum you want for these data, this param is set by you.
  \param[in]  width       The width you want for these data, this param is set by you.
  \param[out] outPut      Output buffer.
  \param[in]  horizotal   These data you want to array them as horizontal or vertical.
  \return              
*/
void storeByteIntoArray(uint8_t *inPut, uint8_t pageLen, uint16_t width, uint8_t *outPut, bool horizotal)
{
	uint32_t i, j;
	uint32_t index = 0;
	
	if (horizotal)
	{
		for (i = 0; i < pageLen*width; i++)
		{
			outPut[index++] = inPut[i];
		}
	}
	else
	{
		for (i = 0; i < width; i++)
		{
			for (j = 0; j < pageLen; j++)
			{
				outPut[i + j*width] = inPut[i*pageLen + j];
			}
		}
	}
}

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
uint16_t merge8Bytes2OneByte(uint8_t* p, uint8_t *outPut, uint16_t width, uint16_t height, bool horizotal, bool inByteRevert)
{
	int i;
	uint8_t data=0, data0=0, data1=0, data2=0, data3=0, data4=0, data5=0, data6=0, data7=0;
	uint16_t index = 0;

	if (horizotal)
	{
		for (i = 0 ; i < width*height; i+=8)
		{
			data0 = p[i];
			data1 = p[i+1];
			data2 = p[i+2];
			data3 = p[i+3];
			data4 = p[i+4];
			data5 = p[i+5];
			data6 = p[i+6];
			data7 = p[i+7];

			if (inByteRevert)
			{
				data =	data0 | (data1<<1) | (data2<<2) | (data3<<3) | (data4<<4) | (data5<<5) | (data6<<6) | (data7<<7);
			}
			else
			{
				data =	data7 | (data6<<1) | (data5<<2) | (data4<<3) | (data3<<4) | (data2<<5) | (data1<<6) | (data0<<7);
			}

			outPut[index++] = data;
		}
	}
	else
	{
		for (uint32_t page = 0; page < height/8; page++)
		{
			i = page*width*8;

			for (; i < page*width*8 + width; i++)
			{
				data0 = p[i];
				data1 = p[i+1*width];
				data2 = p[i+2*width];
				data3 = p[i+3*width];
				data4 = p[i+4*width];
				data5 = p[i+5*width];
				data6 = p[i+6*width];
				data7 = p[i+7*width];

				if (inByteRevert)
				{
					data =	data0 | (data1<<1) | (data2<<2) | (data3<<3) | (data4<<4) | (data5<<5) | (data6<<6) | (data7<<7);
				}
				else
				{
					data =	data7 | (data6<<1) | (data5<<2) | (data4<<3) | (data3<<4) | (data2<<5) | (data1<<6) | (data0<<7);
				}
				
				outPut[index++] = data;
			}
		}
	}

	return index;
}


/**
  \brief Binary the source picture.
  \param[in]   inPut       Src data.
  \param[in]   width       Source picture width.
  \param[in]   height      Source picture height.
  \param[out]  outPut      Output buffer.
  \return              
*/
void calBinary(uint8_t* inPut, uint16_t width, uint16_t height, uint8_t* outPut)
{
	uint32_t sum = 0, avg = 0, i;

	for (i = 0; i < width*height; i++)
	{
		sum += *(inPut + i);
	}

	avg = sum / (width*height);

	for (uint32_t j = 0; j < width*height; j++)
	{
		if (*(inPut + j) < avg)
		{
			*(outPut + j) = 1;
		}
		else
		{
			*(outPut + j) = 0;
		}
	}
}


/**
  \brief Reverse the high 4bits and low 4bits.
  \param[in/out]   p       source/output memory.
  \param[in]       num     source data num.
  \return              
*/
void reverseByte(uint8_t* p, int num)
{
	uint8_t data = 0;
	
	for (int i = 0; i< num; i++)
	{
		data = *(p+i);
		data = ((data&0x0f)<<4) | ((data&0xf0)>>4);
		*(p+i) = data;
	}
}

/**
  \brief Clear low 7bits.
  \param[in/out]   p       Src/output mem.
  \param[in]       num     source data num.
  \return              
*/
void clearLow7bits(uint8_t* p, int num)
{
	for (int i = 0; i < num; i++)
	{
		*(p+i) = *(p+i) & 0x80;
	}
}


/**
  \brief Convert yuv422 to rgb565, used in color screen.
  \param[in]   inbuf       source memory.
  \param[out]  outbuf      output memory.
  \param[in]   width       source picture width.
  \param[in]   height      source picture height.
  \return              
*/
#define RANGE_LIMIT(x) (x > 255 ? 255 : (x < 0 ? 0 : x))
void yuv422ToRgb565(const void* inbuf, void* outbuf, int width, int height)
{
	int rows, cols;
	int y, u, v, r, g, b;
	unsigned char *yuv_buf;
	unsigned short *rgb_buf;
	int y_pos,u_pos,v_pos;

	yuv_buf = (unsigned char *)inbuf;
	rgb_buf = (unsigned short *)outbuf;

	y_pos = 0;
	u_pos = 1;
	v_pos = 3;

	for (rows = 0; rows < height; rows++)
	{
		for (cols = 0; cols < width; cols++) 
		{
			y = yuv_buf[y_pos];
			u = yuv_buf[u_pos] - 128;
			v = yuv_buf[v_pos] - 128;

			// R = Y + 1.402*(V-128)
			// G = Y - 0.34414*(U-128)
			// B = Y + 1.772*(U-128)
			r = RANGE_LIMIT(y + v + ((v * 103) >> 8));
			g = RANGE_LIMIT(y - ((u * 88) >> 8) - ((v * 183) >> 8));
			b = RANGE_LIMIT(y + u + ((u * 198) >> 8));

			*rgb_buf++ = (((r & 0xf8) << 8) | ((g & 0xfc) << 3) | ((b & 0xf8) >> 3));

			y_pos += 2;

			if (cols & 0x01) 
			{
				u_pos += 4;
				v_pos += 4;
			}
		}
	}
}



