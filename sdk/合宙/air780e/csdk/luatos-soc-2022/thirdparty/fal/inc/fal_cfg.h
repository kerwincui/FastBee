#ifndef _FAL_CFG_H_
#define _FAL_CFG_H_

#define FAL_PART_HAS_TABLE_CFG

// #define NOR_FLASH_DEV_NAME             "spiflash"

/* ===================== Flash device Configuration ========================= */
extern const struct fal_flash_dev onchip_flash;
//extern struct fal_flash_dev spi_flash0;

/* flash device table */
#define FAL_FLASH_DEV_TABLE                                          \
{                                                                    \
    &onchip_flash                                                    \
}
/* ====================== Partition Configuration ========================== */
#define FAL_PART_TABLE                                                               \
{                                                                                    \
    {FAL_PART_MAGIC_WORD,    "onchip_fdb",     "onchip_flash",         0,   64*1024, 0} \
}

#endif /* _FAL_CFG_H_ */