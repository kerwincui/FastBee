#include "stdio.h"
#include "string.h"

#include "uart.h"
#if FEATURE_CCIO_ENABLE
#include "usb_device.h"
#endif
#include DEBUG_LOG_HEADER_FILE
#include "mem_map.h"
#include "exception_process.h"
#include "hal_dumpMedia.h"
#include "exception_dump.h"
#include "plat_config.h"

#ifdef FEATURE_UART_HELP_DUMP_ENABLE
int *excepStepDump = (int *)0x404008;
uint32_t excepCfgOption = 0xff;
#define EcDumpGetUartDumpModeId(ownerId, moduleId, subId)  (ownerId##__##moduleId##__##subId)
#endif
extern int *excepStep;
int excepDumpEndFlag = DUMP_END_FLAG_INIT;

uint32_t dumpRetryReadCount = MAX_RETRY_COUNT;
uint32_t dumpHandshakeRetryCnt = MAX_RETRY_COUNT;
uint32_t dumpWaitSyncRetryCnt = DATA_DUMP_WAIT_SYNC_MAX_RETRY_COUNT;
uint32_t dumpGetCmdRetryCnt = DATA_DUMP_GET_CMD_MAX_RETRY_COUNT;

const uint8_t dump_handshake_code[]= "enter assert dump mode";
const uint8_t dump_response_code[]= "ok";
const uint8_t PreambleDumpString[PREAMBLE_STRING_LEN] = {0x44, 0x55, 0x4d, 0x50, 0x44, 0x55, 0x4d, 0x50, 0xd, 0xa};

const uint16_t wCRCTableAbs[] =
{
    0x0000, 0xCC01, 0xD801, 0x1400, 0xF001, 0x3C00, 0x2800, 0xE401, 0xA001, 0x6C00, 0x7800, 0xB401, 0x5000, 0x9C01, 0x8801, 0x4400,
};

uint32_t tDataInfoCell [][2]=
{
    {EC_EXCEPTION_AP_RAM_BASE,     EC_EXCEPTION_AP_RAM_LEN},
    {EC_EXCEPTION_CP_RAM_BASE,     EC_EXCEPTION_CP_RAM_LEN},
    {EC_EXCEPTION_APCP_RAM_BASE,   EC_EXCEPTION_APCP_RAM_LEN},
};

extern void delay_us(uint32_t us);
extern void usbc_trace_disable(void);

int excepDelay(uint32_t maxDelay)
{
    int i=0;
    int j=0;    
    
    for(i=0; i<maxDelay; i++)
    {
        if(i==0xfff)
        {
            j = maxDelay+2;    
        }
    }
    return j;
}

uint32_t EcDumpCheckIfNeedRetry(uint32_t cmdType, PtrDumpReqWrap dumpReqWrap, PtrDumpReqWrap dumpReqWrapTemp)
{
    ReadDataReqCell * ptrReadDataReqCell;
    ReadDataReqCell * ptrReadDataReqCellTemp;
    
    switch(cmdType)
    {
        case DUMP_RETRY_CMD_COUNT:
            *excepStep = (*excepStep | 0x10000000);
            ptrReadDataReqCell = (ReadDataReqCell*)(&(dumpReqWrap->Data[0]));
            ptrReadDataReqCellTemp = (ReadDataReqCell*)(&(dumpReqWrapTemp->Data[0]));
            
            if(ptrReadDataReqCell->ReadDataAddr == ptrReadDataReqCellTemp->ReadDataAddr)
            {
                dumpRetryReadCount++;
            }
            else
            {
                dumpRetryReadCount = 0;
                memcpy(dumpReqWrapTemp, dumpReqWrap, sizeof(DumpReqWrap));
            }
            break;
            
        case DUMP_RETRY_CMD_RESEND:
            *excepStep = (*excepStep | 0x20000000);
            if(dumpRetryReadCount >= DUMP_RETRY_COUNT_MAX)
            {
                ptrReadDataReqCell = (ReadDataReqCell*)(&dumpReqWrap->Data);
                memset((void *)DUMP_RETRY_ADDR, 0, ptrReadDataReqCell->ReadLen);
                memcpy((void *)DUMP_RETRY_ADDR, (void *)ptrReadDataReqCell->ReadDataAddr, ptrReadDataReqCell->ReadLen);
                ptrReadDataReqCell->ReadDataAddr = DUMP_RETRY_ADDR;
            }
            break;
    }

    return 0;
}

static uint16_t EcDumpCRC16(uint16_t wCRC, uint8_t *pchMsg, uint16_t wDataLen)
{
    //uint16_t wCRC = 0xFFFF;
    uint16_t i;
    uint8_t chChar;
    for (i = 0; i < wDataLen; i++)
    {
        chChar = *pchMsg++;
        wCRC = wCRCTableAbs[(chChar^wCRC)&15]^(wCRC>>4);
        wCRC = wCRCTableAbs[((chChar >>4)^ wCRC)&15]^(wCRC>>4);
    }
    return wCRC;
}

uint32_t VerifyPreamble(uint8_t *Preamble)
{
    uint32_t idx;
    uint32_t CheckCnt = 0;
    for (idx = 0; idx < sizeof(PreambleDumpString); idx++)
    {
        if (PreambleDumpString[idx] == Preamble[idx]) {
            CheckCnt++;
        }
    }
    if (CheckCnt>1)
    {
        return TRUE;
    }
    return FALSE;
}

uint32_t EcDumpWaitSync(void)
{
    uint8_t idx = 0;
    uint8_t RecChar[DUMP_RECV_FIFO_LEN];
    uint8_t RetValue = 0;
    uint8_t  epNum = 0xff;
    uint32_t instance;
    uint32_t instanceTemp;
    
    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        instance = DUMP_UART_INSTANCE;
        instanceTemp = instance;
        eehDumpMediaFlush(UART_0_FOR_UNILOG);//flush RX FIFO is better to avoid left hdsk data, only for UART
    }
    else
    {
        instance = (uint32_t)usbDevGetLogIfIdx();
        epNum = usbDevGetEpNumFromIf(usbDevGetLogIfIdx());
        instanceTemp = (epNum&0xf);
        extern void  usbc_ctrl_full_flush_txfifo (uint32_t num );
        usbc_ctrl_full_flush_txfifo((epNum>>4)&0xf);
    }    
    
    delay_us(400000);//wait and let EPAT change its baudrate
    
    for (idx = 0; idx < PREAMBLE_CNT; idx++)
    {
        RetValue = eehDumpMediaSend(instance, (uint8_t *)&PreambleDumpString[0], PREAMBLE_STRING_LEN, 1000);
        if (RetValue != PREAMBLE_STRING_LEN)
        {
            *excepStep = (*excepStep | 0x8);

            return 1;
        }
    }
    
    //Host send Preamble twice
    RetValue = eehDumpMediaRecv(instanceTemp, &RecChar[0], PREAMBLE_CNT*PREAMBLE_STRING_LEN-2 + PREAMBLE_WITH_NULL, WaitPeriod_1s);

    if(RetValue > 0)
    {
        eehDumpMediaSend(instance, &RecChar[0], RetValue, 1000);
    }

    if (RetValue != (PREAMBLE_CNT*PREAMBLE_STRING_LEN+PREAMBLE_WITH_NULL-2))
    {
        *excepStep = (*excepStep | 0x10);

        return 1;
    }

    if (VerifyPreamble(&RecChar[0]) ||VerifyPreamble(&RecChar[4]))
    {
        *excepStep = (*excepStep | 0x20);
        return 0;
    }
    *excepStep = (*excepStep | 0x40);

    return 1;
}

uint32_t EcDumpWaitCmd(PtrDumpReqWrap ptrDumpReqWrap)
{
    uint32_t RetValue = 0;
    uint8_t  epNum;
    uint32_t instance;
    uint32_t instanceTemp;
    
    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        instance = DUMP_UART_INSTANCE;
        instanceTemp = instance;
    }
    else
    {
        instance = (uint32_t)usbDevGetLogIfIdx();
        epNum = usbDevGetEpNumFromIf(usbDevGetLogIfIdx());
        instanceTemp = (epNum&0xf);
    }

    RetValue = eehDumpMediaRecv(instanceTemp, (uint8_t *)ptrDumpReqWrap, CMD_FIX_LEN, WaitPeriod_1s);
    if (RetValue != CMD_FIX_LEN)
    {
        *excepStep = (*excepStep | 0x100);
        return 1;
    }

    if (ptrDumpReqWrap->Length > MAX_CMD_DATALEN)
    {
        ptrDumpReqWrap->Length = MAX_CMD_DATALEN;
    }
    #if 1
    RetValue = eehDumpMediaRecv(instanceTemp, (uint8_t *)(&ptrDumpReqWrap->Data[0]), ptrDumpReqWrap->Length, WaitPeriod_1s);
    if (RetValue != ptrDumpReqWrap->Length)
    {
        *excepStep = (*excepStep | 0x200);
        return 1;
    }

    RetValue = eehDumpMediaRecv(instanceTemp, (uint8_t *)(&ptrDumpReqWrap->FCS), CMD_FCS_LEN, WaitPeriod_1s);
    if (RetValue != CMD_FCS_LEN)
    {
        *excepStep = (*excepStep | 0x400);
        return 1;
    }
    #endif

    *excepStep = (*excepStep | 0x800);
    return 0;
}

uint32_t EcDumpCheckCmd(PtrDumpReqWrap ptrDumpReqWrap)
{
    uint32_t sum = 0;
    uint8_t * pStartAddr;

    if ((ptrDumpReqWrap->CID != DUMP_CID) ||(ptrDumpReqWrap->NCID != N_DUMP_CID))
    {
        *excepStep = (*excepStep | 0x1000);
        return 1;
    }
    pStartAddr = (uint8_t*) (&ptrDumpReqWrap->Command);

    sum  = EcDumpCRC16(0xFFFF, pStartAddr, CMD_FIX_LEN + ptrDumpReqWrap->Length);
    if (sum != ptrDumpReqWrap->FCS)
    {
        //return 0;//test now , no check sum
        *excepStep = (*excepStep | 0x2000);
        return 1;
    }

    *excepStep = (*excepStep | 0x4000);
    return 0;
}

uint32_t EcDumpHandleGetData(PtrDumpReqWrap ptrDumpReqWrap)
{
    uint32_t RetValue = 0;
    DumpRspWrap tDumpRspWrap;
    ReadDataReqCell * ptrReadDataReqCell;
    uint32_t Sum = 0xFFFF;
    uint32_t Idx;
    uint32_t *DataBuff;
    uint32_t instance;
    uint32_t sendDataLenLeft;
    uint32_t sendDataLen;
    uint32_t sendDataLastFlag = 0;
    uint8_t dataAndCrcBuf[READ_ONECE_DATA_LEN+CMD_FCS_LEN] = {0};
    
    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        instance = DUMP_UART_INSTANCE;
        EcDumpCheckIfNeedRetry(DUMP_RETRY_CMD_RESEND, ptrDumpReqWrap, NULL);
    }
    else
    {
        instance = (uint32_t)usbDevGetLogIfIdx();
        EcDumpCheckIfNeedRetry(DUMP_RETRY_CMD_RESEND, ptrDumpReqWrap, NULL);
    }
    
    ptrReadDataReqCell = (ReadDataReqCell*)(&ptrDumpReqWrap->Data[0]);
    tDumpRspWrap.Command = ptrDumpReqWrap->Command;
    tDumpRspWrap.Sequence = ptrDumpReqWrap->Sequence;
    tDumpRspWrap.CID = ptrDumpReqWrap->CID;
    tDumpRspWrap.NCID = ptrDumpReqWrap->NCID;
    if ((ptrReadDataReqCell->ReadLen > MAX_READ_DATALEN) || ((ptrReadDataReqCell->ReadDataAddr%4)!=0))
    {
        tDumpRspWrap.Length = 0;
        tDumpRspWrap.Status = NACK;
        Sum = EcDumpCRC16(0xFFFF, &tDumpRspWrap.Command, PROTOCOL_RSP_FIX_LEN+tDumpRspWrap.Length);
        tDumpRspWrap.FCS = Sum;
        RetValue = eehDumpMediaSend(instance, &tDumpRspWrap.Command, PROTOCOL_RSP_FIX_LEN+tDumpRspWrap.Length + CMD_FCS_LEN, 1000);
        *excepStep = (*excepStep | 0x10000);
        return RetValue;
    }

    tDumpRspWrap.Status = ACK;
    tDumpRspWrap.Length = ptrReadDataReqCell->ReadLen;

    RetValue = eehDumpMediaSend(instance, &tDumpRspWrap.Command, PROTOCOL_RSP_FIX_LEN, 1000);
    if (RetValue != PROTOCOL_RSP_FIX_LEN)
    {
        *excepStep = (*excepStep | 0x20000);
        return 1;
    }
    Sum = EcDumpCRC16(Sum, &tDumpRspWrap.Command,PROTOCOL_RSP_FIX_LEN);
    
    for (Idx = 0; Idx < ptrReadDataReqCell->ReadLen;)
    {
        (DataBuff) =  (uint32_t *)(ptrReadDataReqCell->ReadDataAddr + Idx);

        sendDataLenLeft = ptrReadDataReqCell->ReadLen - Idx;
        if(sendDataLenLeft < READ_ONECE_DATA_LEN)
        {
            sendDataLen = sendDataLenLeft;
        }
        else
        {
            sendDataLen = READ_ONECE_DATA_LEN;
        }

        Sum = EcDumpCRC16(Sum, (uint8_t*)(DataBuff), sendDataLen);
        
        Idx = Idx + sendDataLen;
    }
    tDumpRspWrap.FCS = Sum;

    for (Idx = 0; Idx < ptrReadDataReqCell->ReadLen;)
    {
        (DataBuff) =  (uint32_t *)(ptrReadDataReqCell->ReadDataAddr + Idx);

        sendDataLenLeft = ptrReadDataReqCell->ReadLen - Idx;
        if(sendDataLenLeft < READ_ONECE_DATA_LEN)
        {
            sendDataLen = sendDataLenLeft;
            sendDataLastFlag = 1;
        }
        else
        {
            sendDataLen = READ_ONECE_DATA_LEN;
            if((READ_ONECE_DATA_LEN+Idx)==ptrReadDataReqCell->ReadLen)
            {
                sendDataLastFlag = 1;
            }
        }
        if(sendDataLastFlag != 1)
        {
            RetValue = eehDumpMediaSend(instance, (uint8_t*)(DataBuff), sendDataLen, 5000);
        }
        else
        {
            memcpy(dataAndCrcBuf, (uint8_t*)(DataBuff), READ_ONECE_DATA_LEN);
            memcpy(&dataAndCrcBuf[READ_ONECE_DATA_LEN], (uint8_t *)(&tDumpRspWrap.FCS), CMD_FCS_LEN);
            
            RetValue = eehDumpMediaSend(instance, (uint8_t*)(dataAndCrcBuf), (READ_ONECE_DATA_LEN+CMD_FCS_LEN), 5000);
        }
        //excepDelay(1000);

        if (RetValue != READ_ONECE_DATA_LEN)
        {
            *excepStep = (*excepStep | 0x40000);
            return 1;
        }
        
        Idx = Idx + sendDataLen;
    }

    *excepStep = (*excepStep | 0x100000);
    return RetValue;
}

uint32_t EcDumpHandleGetInfo(PtrDumpReqWrap ptrDumpReqWrap)
{
    uint32_t RetValue = 0;
    DumpRspWrap tDumpRspWrap;
    uint32_t Sum = 0xFFFF;
    uint32_t instance;
    char infoCmdBuf[96] = {0};
    uint32_t infoCellLen = sizeof(tDataInfoCell);

    
    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        instance = DUMP_UART_INSTANCE;
    }
    else
    {
        instance = (uint32_t)usbDevGetLogIfIdx();
    }

    tDumpRspWrap.Command = ptrDumpReqWrap->Command;
    tDumpRspWrap.Sequence = ptrDumpReqWrap->Sequence;
    tDumpRspWrap.CID = ptrDumpReqWrap->CID;
    tDumpRspWrap.NCID = ptrDumpReqWrap->NCID;

    tDumpRspWrap.Status = ACK;
    tDumpRspWrap.Length = sizeof(tDataInfoCell);

    memcpy(infoCmdBuf, &tDumpRspWrap.Command, PROTOCOL_RSP_FIX_LEN);
    
    Sum = EcDumpCRC16(Sum, &tDumpRspWrap.Command,PROTOCOL_RSP_FIX_LEN);
    memcpy(&infoCmdBuf[PROTOCOL_RSP_FIX_LEN], (uint8_t *)&tDataInfoCell, sizeof(tDataInfoCell));

    Sum = EcDumpCRC16(Sum, (uint8_t *)&tDataInfoCell, sizeof(tDataInfoCell));
    tDumpRspWrap.FCS = Sum;
    memcpy(&infoCmdBuf[PROTOCOL_RSP_FIX_LEN+infoCellLen], (uint8_t *)(&tDumpRspWrap.FCS), CMD_FCS_LEN);
    RetValue = eehDumpMediaSend(instance, (uint8_t *)infoCmdBuf, PROTOCOL_RSP_FIX_LEN+infoCellLen+CMD_FCS_LEN, 1000);
    if (RetValue != CMD_FCS_LEN)
    {
        *excepStep = (*excepStep | 0x1000000);
        return 1;
    }

    *excepStep = (*excepStep | 0x2000000);
    return 0;
}

uint32_t EcDumpDataFlow(void)
{
    uint32_t retryCount = dumpWaitSyncRetryCnt;
    uint32_t RetValue = 1;
    DumpReqWrap tDumpReqWrap;
    DumpReqWrap tDumpReqWrapTmep;

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        //UART_init(DUMP_UART_INSTANCE, 921600, false);
        eehDumpMediaInit();
    }

    while(retryCount)
    {
        RetValue = EcDumpWaitSync();
        if(RetValue == 0)
        {
            break;
        }
        else
        {
            retryCount--;
        }
    }
    if(retryCount == 0)//sync failed
    {
        return 1;
    }

    retryCount = dumpGetCmdRetryCnt;

    while(retryCount)
    {
        memset(&tDumpReqWrap, 0, sizeof(tDumpReqWrap));
        *excepStep = (*excepStep | 0x80);
        RetValue = EcDumpWaitCmd(&tDumpReqWrap);
        if (RetValue != 0)
        {
            retryCount--;
            continue;
        }

        if(tDumpReqWrap.Command != 0x00)
        {
            EcDumpCheckIfNeedRetry(DUMP_RETRY_CMD_COUNT, &tDumpReqWrap, &tDumpReqWrapTmep);
        }

        *excepStep = (*excepStep | 0x10);
        RetValue = EcDumpCheckCmd(&tDumpReqWrap);
        if (RetValue != 0)
        {
            continue;
        }

        retryCount = dumpGetCmdRetryCnt;

        switch(tDumpReqWrap.Command)
        {
            case GetDataCmd:
                *excepStep = (*excepStep | 0x8000);
                EcDumpHandleGetData(&tDumpReqWrap);
                break;
                
            case GetInfoCmd:
                *excepStep = (*excepStep | 0x200000);
                EcDumpHandleGetInfo(&tDumpReqWrap);
                break;
                
            case FinishCmd:
                excepDumpEndFlag = DUMP_END_FLAG_SUCC;
                return 0;
                
            default:
                break;

        }
    }
    return RetValue;
}

uint32_t EcDumpHandshakeProc(uint32_t SyncPeriod)
{
    uint8_t recv_buffer[DUMP_SYNC_RSP_LEN];
    uint32_t SyncCnt = 0;
    uint32_t RetValue = 0;
    uint32_t idx;
    uint8_t  epNum;
    uint32_t instance;
    uint32_t retryCnt = 0;
    uint32_t instanceTemp;
        
    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        instance = DUMP_UART_INSTANCE;
        retryCnt = dumpHandshakeRetryCnt;
        instanceTemp = instance;
    }
    else
    {    
        retryCnt = dumpHandshakeRetryCnt;
        instance = (uint32_t)usbDevGetLogIfIdx();
        epNum = usbDevGetEpNumFromIf(usbDevGetLogIfIdx());
        instanceTemp = (epNum&0xf);
    }

    //eehDumpMediaPurgeRx(instance); only valid for UART and no need to reset RX FIFO again

    memset(recv_buffer, 0, sizeof(recv_buffer));

    while(SyncCnt++ < retryCnt)
    {
        uniLogFlushOut();
        if(uniLogGetPherType() == UART_0_FOR_UNILOG)
        {   
            ECPLAT_PRINTF(UNILOG_PLA_INTERNAL_CMD, ecDumpHandshakeProc, P_ERROR, "enter dump handshake mode");
            
            uniLogFlushOut();
        }
        else
        {
            ECPLAT_PRINTF(UNILOG_PLA_INTERNAL_CMD, ecDumpUsbHandshakeProc, P_ERROR, "enter USB dump handshake mode");
            uniLogFlushOut();
        }
        RetValue = eehDumpMediaRecv(instanceTemp, recv_buffer, DUMP_SYNC_RSP_LEN, WaitPeriod_1s/2);
        
        if (RetValue >= 2)
        {
            if(RetValue < (DUMP_SYNC_RSP_LEN - 2))
            {
                delay_us(WaitPeriod_1s/2);
            }
            else
            {
                for (idx = 0; idx < DUMP_SYNC_RSP_LEN - 2; idx++)
                {
                    if ((recv_buffer[idx] == dump_response_code[0]) && (recv_buffer[idx+1] == dump_response_code[1]))
                    {
                        *excepStep = (*excepStep | 0x2);
                        return 0;
                    }
                }				
            }
        }
        else
        {
            delay_us(WaitPeriod_1s/2);
        }
    }

    *excepStep = (*excepStep | 0x4);
    return 1;
}

uint32_t EcDumpTopFlow(void)
{
    uint32_t RetValue = 1;
    uint32_t instance = 0;

    *excepStep = 0x0;

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        instance = DUMP_UART_INSTANCE;
    }
    else
    {
        usbc_trace_disable();
        eehDumpMediaInit();
        instance = (uint32_t)usbDevGetLogIfIdx();
    }

    *excepStep = (*excepStep | 0x1);
    eehDumpMediaFlush(instance);
    RetValue = EcDumpHandshakeProc(WaitPeriod_1s>>1);

    if (RetValue == 0)
    {
        RetValue = EcDumpDataFlow();
        *excepStep = (*excepStep | 0x4000000);
    }
    *excepStep = (*excepStep | 0x8000000);

    #ifdef FEATURE_UART_HELP_DUMP_ENABLE
    excepCfgOption = BSP_GetPlatConfigItemValue(PLAT_CONFIG_ITEM_FAULT_ACTION);

    if ((RetValue == 1)&&((excepCfgOption == EXCEP_OPTION_DUMP_FLASH_EPAT_LOOP_AND_UART_HELP_DUMP)||(excepCfgOption == EXCEP_OPTION_DUMP_FLASH_EPAT_RESET_AND_UART_HELP_DUMP)))
    {
        RetValue = EcDumpHandshakeProcUart(WaitPeriod_1s>>1);
        
        if (RetValue == 0)
        {
            RetValue = EcDumpDataFlowUart();
            *excepStepDump = (*excepStepDump | 0x4000000);
        }
        *excepStepDump = (*excepStepDump | 0x8000000);
    }
    #endif
    return RetValue;
}

#ifdef FEATURE_UART_HELP_DUMP_ENABLE
uint32_t EcDumpHandshakeProcUart(uint32_t SyncPeriod)
{
    uint8_t recv_buffer[DUMP_SYNC_RSP_LEN];
    uint32_t SyncCnt = 0;
    uint32_t RetValue = 0;
    uint32_t idx;
    uint32_t retryCnt = 0;
    uint32_t instanceTemp;
    uint32_t uartDumpModeId = 0;
    uint32_t atPortBaudRate = 0xff;
    uint8_t uartDumpModeBuff[EC_UART_HELP_DUMP_BUFF_LEN] = {0};
    int i;

    *excepStepDump = 0;   

    uniLogSetPherType(UART_0_FOR_UNILOG);

    atPortBaudRate = BSP_GetPlatConfigItemValue(PLAT_CONFIG_ITEM_LOG_BAUDRATE);
    UART_init(DUMP_UART_INSTANCE, atPortBaudRate & 0x7FFFFFFFUL, false);
    retryCnt = 32;
    instanceTemp = DUMP_UART_INSTANCE;

    memset(recv_buffer, 0, sizeof(recv_buffer));
    for(i=0; i<EC_UART_HELP_DUMP_BUFF_LEN; i++)
    {
        uartDumpModeBuff[i] = 0xff;
        if(((i%16) == 3)||((i%16) == 11))
        {
            uartDumpModeBuff[i] = 0xfe;
        }
    }
    uartDumpModeBuff[28] = 0x6e;
    uartDumpModeBuff[29] = 0x27;
    uartDumpModeBuff[30] = 0xc9;
    uartDumpModeBuff[31] = 0x70;
    uartDumpModeId = EcDumpGetUartDumpModeId(UNILOG_PLAT_AP, UNILOG_PLA_INTERNAL_CMD, ecDumpHandshakeProc);
    uartDumpModeId = uartDumpModeId & ~0x7FF;

    uartDumpModeBuff[32] = ((uartDumpModeId >> 28)&0xff)|0x20;
    uartDumpModeBuff[33] = (uartDumpModeId >> 20)&0xff;
    uartDumpModeBuff[34] = (uartDumpModeId >> 12)&0xff;
    uartDumpModeBuff[35] = (uartDumpModeId >> 4)&0xf0;
    uartDumpModeBuff[36] = 0xf;

    while(SyncCnt++ < retryCnt)
    {
        if(uniLogGetPherType() == UART_0_FOR_UNILOG)
        {   
            //ECPLAT_PRINTF(UNILOG_EXCEP_PRINT, ecDumpHandshakeProc, P_ERROR, "enter dump handshake mode");
            UART_send(DUMP_UART_INSTANCE, (const uint8_t *)uartDumpModeBuff, EC_UART_HELP_DUMP_BUFF_LEN, 10000);            
        }

        RetValue = eehDumpMediaRecv(instanceTemp, recv_buffer, DUMP_SYNC_RSP_LEN, WaitPeriod_1s);
        
        if (RetValue >= 2)
        {
            for (idx = 0; idx < DUMP_SYNC_RSP_LEN - 2; idx++)
            {
                if ((recv_buffer[idx] == dump_response_code[0]) && (recv_buffer[idx+1] == dump_response_code[1]))
                {
                    *excepStepDump = (*excepStepDump | 0x2);
                    return 0;
                }
            }
        }
    }

    *excepStepDump = (*excepStepDump | 0x4);
    return 1;
}

uint32_t EcDumpDataFlowUart(void)
{
    uint32_t retryCount = dumpWaitSyncRetryCnt;
    uint32_t RetValue = 1;
    DumpReqWrap tDumpReqWrap;
    DumpReqWrap tDumpReqWrapTmep;

    if(uniLogGetPherType() == UART_0_FOR_UNILOG)
    {
        //UART_init(DUMP_UART_INSTANCE, 921600, false);
        eehDumpMediaInit();
    }

    while(retryCount)
    {
        RetValue = EcDumpWaitSync();
        if(RetValue == 0)
        {
            break;
        }
        else
        {
            retryCount--;
        }
    }
    if(retryCount == 0)//sync failed
    {
        return 1;
    }

    retryCount = dumpGetCmdRetryCnt;

    while(retryCount)
    {
        memset(&tDumpReqWrap, 0, sizeof(tDumpReqWrap));
        *excepStepDump = (*excepStepDump | 0x80);
        RetValue = EcDumpWaitCmd(&tDumpReqWrap);
        if (RetValue != 0)
        {
            retryCount--;
            continue;
        }

        if(tDumpReqWrap.Command != 0x00)
        {
            EcDumpCheckIfNeedRetry(DUMP_RETRY_CMD_COUNT, &tDumpReqWrap, &tDumpReqWrapTmep);
        }

        *excepStepDump = (*excepStepDump | 0x10);
        RetValue = EcDumpCheckCmd(&tDumpReqWrap);
        if (RetValue != 0)
        {
            continue;
        }

        retryCount = dumpGetCmdRetryCnt;

        switch(tDumpReqWrap.Command)
        {
            case GetDataCmd:
                *excepStepDump = (*excepStepDump | 0x8000);
                EcDumpHandleGetData(&tDumpReqWrap);
                break;
                
            case GetInfoCmd:
                *excepStepDump = (*excepStepDump | 0x200000);
                EcDumpHandleGetInfo(&tDumpReqWrap);
                break;
                
            case FinishCmd:
                excepDumpEndFlag = DUMP_END_FLAG_SUCC;
                return 0;
                
            default:
                break;
        }
    }
    return RetValue;
}
#endif
