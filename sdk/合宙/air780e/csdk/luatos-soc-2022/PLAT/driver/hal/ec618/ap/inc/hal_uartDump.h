/****************************************************************************
 *
 * Copy right:   2022-, Copyrigths of AirM2M Ltd.
 * File name:    hal_uartDump.h
 * Description:  header file for dumping info through UART when exception occurs
 * History:      Rev1.0   2022-1-17
 *
 ****************************************************************************/

#ifndef _HAL_UART_DUMP_H
#define _HAL_UART_DUMP_H

/**
  \brief      Initialize uart dump port
  \details
              This API will use the setting(pinmux, baudrate) if UART has already been initialized,
              otherwise custom settting should be supplied properly to make uart dump work
 */
void HAL_UartDumpPortInit(void);

/**
  \brief Check validation of uart dump port
  \return  true if current dump port is valid, otherwise false
  \note    Internal use for exception code
  */
bool HAL_UartDumpPortCheck(void);

/**
  \brief Send data to uart dump port in polling way
  \param[in]   data        Pointer to buffer with data to be sent to
  \param[in]   num         Number of data items to send
  \param[in]   timeout_us  timeout value in unit of us
  \return      num of data items sent in the internal of timeout
  \note    Internal use for exception code
  */
uint32_t HAL_UartDumpPortSend(const uint8_t *data, uint32_t num, uint32_t timeout_us);

#ifdef __cplusplus
}
#endif

#endif /* _HAL_UART_DUMP_H */
