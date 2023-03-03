/****************************************************************************
 *
 * Copy right:   2020-, Copyrigths of AirM2M Ltd.
 * File name:    eepRom.c
 * Description:  EC618 eepRom ds2431 driver source file
 * History:      Rev1.0   2020-12-17
 *
 ****************************************************************************/
#include "ec618.h"
#include "bsp.h"
#include "eepRom.h"
#include "oneWire.h"
#include "string.h"
#include "stdio.h"

extern void delay_us(uint32_t us);

static uint16_t crc16Maxim(uint8_t *data, uint16_t len)
{
    uint8_t i;
    uint16_t crc = 0;
    while (len--)
    {
        crc ^= *data++;
        for (i=0; i<8; ++i)
        {
            if (crc&1)
            {
                crc = (crc>>1) ^ 0xA001;
            }
            else
            {
                crc = crc>>1;
            }
        }
    }
    return ~crc;
}


int32_t writeScratchpad(uint8_t addr, uint8_t data[8])
{
    uint8_t crcSrcData[11];
    uint16_t crcCalResult;
    uint8_t crcReadData[2];

    if ((data == NULL) || (addr > 0x8F))
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    if (owResetPd() != 0)
    {
        return EEPROMDRV_RESET_ERR;
    }

    delay_us(140); // delay 200us

    owWriteByte(ROM_SKIP_CMD);
    owWriteByte(SCRATCHPAD_WRITE_CMD);
    owWriteByte(addr);
    owWriteByte(0x00);

    crcSrcData[0] = SCRATCHPAD_WRITE_CMD; // before are right
    crcSrcData[1] = addr;
    crcSrcData[2] = 0x00;
    for (int i=0; i<8; i++)
    {
        owWriteByte(data[i]);
        crcSrcData[i+3] = data[i];
    }

    crcCalResult = crc16Maxim(crcSrcData, 11); // before are right

    owReadByte(crcReadData);
    owReadByte(crcReadData+1);

    if (((crcReadData[1]<<8) | crcReadData[0]) != crcCalResult)
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    return EEPROMDRV_OK;
}

void readScratchpad(uint8_t dataBack[13])
{
    if (owResetPd() != 0)
    {
        return;
    }

    delay_us(140); // delay 200us

    owWriteByte(ROM_SKIP_CMD);
    owWriteByte(SCRATCHPAD_READ_CMD);

    // first 3 bytes are: TA1, TA2, ES; Then 8 bytes data; Last are 2 bytes crc
    for (int i=0; i<13; i++)
    {
        owReadByte(dataBack+i);
    }
}

int32_t copyScratchpad2Mem(uint16_t addr)
{
    uint8_t readData;

    if (owResetPd() != 0)
    {
        return EEPROMDRV_RESET_ERR;
    }

    delay_us(140); // delay 200us

    owWriteByte(ROM_SKIP_CMD);
    owWriteByte(SCRATCHPAD_COPY_CMD);
    owWriteByte(addr);
    owWriteByte(0x00);
    owWriteByte(0x07);

    delay_us(140); // delay 200us

    owReadByte(&readData);
    if (readData != 0xAA)
    {
        return EEPROMDRV_SCRATCHPADCOPY_ERR;
    }

    return EEPROMDRV_OK;
}

uint8_t dataBack[13]={0};
int32_t dataCmp(uint8_t targetAddr, uint8_t* buffer, uint8_t len)
{
    // compare the data read from scratchpad
    if (dataBack[0] != targetAddr)
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    if (dataBack[1] != 0)
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    if (dataBack[2] != 0x7)
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    for (int j=0; j<len; j++)
    {
        if (dataBack[j+3] != buffer[j])
        {
            return EEPROMDRV_SCRATCHPADWRITE_ERR;
        }
    }

    return EEPROMDRV_OK;
}

int32_t eePromReadRom(uint8_t* romCode)
{
    if (owResetPd() !=0)
    {
        return EEPROMDRV_RESET_ERR;
    }

    delay_us(140); // delay 200us

#if 0
    uint8_t data = ROM_READ_CMD;
    int i;
    for (i=0; i<8; i++)
    {
        owWriteBit(data&0x01);
        data >>=1;
    }

    uint8_t dataRead;
    for (i=0; i<8; i++)
    {
        owReadBit(&dataRead);
        dataRead <<=1;
    }
#endif

#if 1
    int32_t result = owWriteByte(ROM_READ_CMD);
    if (result < 0)
    {
        return EEPROMDRV_ROMREAD_ERR;
    }

    for (int32_t i=0; i<8; i++)
    {
        owReadByte(romCode+i);
    }
#endif

    return EEPROMDRV_OK;
}

int32_t eePromReadMem(uint8_t targetAddr, uint8_t len, uint8_t* buffer)
{
    delay_us(3000); // wait unitl former write operations finish

    if (owResetPd() != 0)
    {
        return EEPROMDRV_RESET_ERR;
    }

    delay_us(140); // delay 200us

    if (owWriteByte(ROM_SKIP_CMD) < 0)
    {
        return EEPROMDRV_ROMREAD_ERR;
    }

    if (owWriteByte(MEM_READ_CMD) < 0)
    {
        return EEPROMDRV_ROMREAD_ERR;
    }

    // write addr low byte
    if (owWriteByte(targetAddr) < 0)
    {
        return EEPROMDRV_ROMREAD_ERR;
    }

    // write addr high byte
    if (owWriteByte(0) < 0)
    {
        return EEPROMDRV_ROMREAD_ERR;
    }

    for (int i=0; i<len; i++)
    {
        owReadByte(buffer+i);
    }

    return owResetPd();
}

int32_t writeSctStats;
int32_t eePromWriteMem(uint8_t targetAddr, uint8_t len, uint8_t* buffer)
{
    uint8_t tmp[8];
    int i, index=0;

    if (owResetPd() != 0)
    {
        return EEPROMDRV_RESET_ERR;
    }

    if (targetAddr > 0x88)
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    while (len > 8)
    {
        for (i=0; i<8; i++)
        {
            tmp[i] = buffer[i+index];
        }

        len -= 8;
        writeSctStats = writeScratchpad(targetAddr+index, tmp);
        delay_us(3000);
        readScratchpad(dataBack);
        if (dataCmp(targetAddr+index, buffer+index, 8) != 0)
        {
            return EEPROMDRV_SCRATCHPADWRITE_ERR;
        }

        copyScratchpad2Mem(targetAddr+index);
			delay_us(3000);
        memset(dataBack, 0, 13);

        index += 8;
    }

    for (i=0; i<len; i++)
    {
        tmp[i] = buffer[i+index];
    }

    memset(tmp+i, 1, 8-len);
    delay_us(3000); // wait until eeprom store data finish
    writeSctStats = writeScratchpad(targetAddr+index, tmp);
    delay_us(3000);
    readScratchpad(dataBack);
    if (dataCmp(targetAddr+index, buffer+index, len) != 0)
    {
        return EEPROMDRV_SCRATCHPADWRITE_ERR;
    }

    copyScratchpad2Mem(targetAddr+index);
    delay_us(30000); // wait until eeprom store data finish

    if (owResetPd() != 0)
    {
        return EEPROMDRV_RESET_ERR;
    }

    return EEPROMDRV_OK;
}

void eepRomInit(OwModeSel_e mode)
{
    owInit();
    owSetMode(mode);
}
