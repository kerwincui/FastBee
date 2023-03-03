#include "psdial_ps_ctrl.h"
#include "cms_comm.h"
#include "common_api.h"

ALIGNED_4BYTE CAT_PSPHY_SHAREDATA   UINT8   psUpMem[PS_DIAL_PS_UP_MEM_SIZE];

void *psDialGetUpMemAndSize(UINT32 *pUpMemSize)
{
    if (pUpMemSize != PNULL)
    {
        *pUpMemSize     = sizeof(psUpMem);
    }

    return (void *)psUpMem;
}
