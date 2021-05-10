
#include <stdio.h>
#include "example1.h"
#include "example2.h"

/******************************************************************************
 * FunctionName : app_main
 * Description  : entry of user application, init user function here
 * Parameters   : none
 * Returns      : none
*******************************************************************************/
void app_main()
{
    printf("in app code...\n");
    example1();
    example2();
}
