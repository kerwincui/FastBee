set(COMPONENT_ADD_INCLUDEDIRS "./include")

set(COMPONENT_SRCS "fastbee.c" "Config.c" "Mqtt.c")

set(COMPONENT_REQUIRES "esp-aliyun" "mqtt" "json")

register_component()
