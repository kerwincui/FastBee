/******************************************************************************

*(C) Copyright 2018 AirM2M International Ltd.

* All Rights Reserved

******************************************************************************
*  Filename:
*
*  Description:
*
*  History:
*
*  Notes:
*
******************************************************************************/
#ifndef EC_STRING_H
#define EC_STRING_H

/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
#if defined(__cplusplus)
extern "C" {
#endif

int32_t strlen_fast(const char *str);
char* ec_strnstr(const char *s, const char *find, size_t slen);

#ifdef __cplusplus
}
#endif

#endif // EC_STRING_H

