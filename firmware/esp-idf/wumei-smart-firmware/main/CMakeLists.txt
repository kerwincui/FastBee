
set(COMPONENT_SRCS "main.c"  
"button.c" 
"common.c" 
"device_temp.c" 
"i2c_temp.c" 
"led.c" 
"lwip_sntp.c" 
"mqtt.c" 
"nvs_storage.c" 
"smart_config.c" 
"wifi.c" 
"http_server.c" 
# "mqtt_ssl.c" 
"native_ota.c" 
# "https_ota.c" 
# "statistic_free_rtos.c" 
# "statistic_perfmon.c" 
# "flash_encrypt.c" 
)
set(COMPONENT_ADD_INCLUDEDIRS ". include")
set(COMPONENT_EMBED_TXTFILES ${project_dir}/server_certs/ca_cert.pem)
set(COMPONENT_EMBED_FILES "www/home.html.gz" "www/prompt.html.gz" "favicon.ico" "www/upload_script.html" "spiffs/test.pem" "main/spiffs/test.pem")
register_component()