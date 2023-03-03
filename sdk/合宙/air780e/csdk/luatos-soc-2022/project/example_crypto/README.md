目前demo中aes和des测试需要到仓库根目录下将下面宏控代码添加进xmake.lua

add_defines("MBEDTLS_CIPHER_MODE_CBC",{public = true})
add_defines("MBEDTLS_CIPHER_MODE_CFB",{public = true})
add_defines("MBEDTLS_CIPHER_MODE_CTR",{public = true})
add_defines("MBEDTLS_CIPHER_MODE_OFB",{public = true})
add_defines("MBEDTLS_CIPHER_MODE_XTS",{public = true}) 

