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
#ifndef HAL_TRIM_H
#define HAL_TRIM_H

/*----------------------------------------------------------------------------*
 *                    INCLUDES                                                *
 *----------------------------------------------------------------------------*/


#ifdef __cplusplus
extern "C" {
#endif


/*----------------------------------------------------------------------------*
 *                    MACROS                                                  *
 *----------------------------------------------------------------------------*/





/*----------------------------------------------------------------------------*
 *                   DATA TYPE DEFINITION                                     *
 *----------------------------------------------------------------------------*/


/**
  \brief ADC EFUSE calibration code
 */
typedef struct 
{
    uint32_t code500 :     12;
    uint32_t code900 :     12;
    uint32_t reserved    : 8;
} AdcEfuseCalCode_t;


/**
  \brief ADC EFUSE thermal code
 */
typedef struct 
{
    uint32_t codet0 :      12;
    uint32_t t0 :          10;
    uint32_t reserved :    10;
}  AdcEfuseT0Code_t;






/*----------------------------------------------------------------------------*
 *                    GLOBAL FUNCTIONS DECLEARATION                           *
 *----------------------------------------------------------------------------*/
/**
  \fn        trimEfuseNotAon( void )
  \brief     used to read trim value from efuse, then write into none Aon reg
  \note      called in bootloader when POR/SLEEP2/HIB, in ramboot when SLEEP1
 */
void trimEfuseNotAon( void );


/**
  \fn        trimEfuseAon( void )
  \brief     used to read trim value from efuse, then write into Aon reg
  \note      called in bootloader when POR
 */
void trimEfuseAon( void );


/**
  \fn        trimFromCalNv2Aon( void )
  \brief     used to read trim value from ap nv, then write into Aon reg
  \note      called in app img after ap nv init when POR
 */
void trimFromCalNv2Aon( void );


/**
  \fn        trimAdcSetGolbalVar( void )
  \brief     read the adc cali value in efuse and set to a golbal var for ADC use
  \note      this golbal var will be used in both paging and app img, and should be set when POR/SLEEP2/HIB case
             no need for SLEEP1.
 */
void trimAdcSetGolbalVar( void );



/**
  \fn        trimAdcGetCalCode( void )
  \brief     used by ADC to get the Cali code
  \return retrun the address of Cali code golbal var
  \note      
 */
AdcEfuseCalCode_t* trimAdcGetCalCode       ( void );

/**
  \fn        trimAdcGetT0Code( void )
  \brief     used by ADC to get the T0 code
  \return retrun the address of T0 code golbal var
  \note      
 */
AdcEfuseT0Code_t* trimAdcGetT0Code(        void );
    
    






#ifdef __cplusplus
}
#endif

#endif
