# Makefile
COMPONENT_ADD_LDFLAGS += -u ota_pubn_buf
COMPONENT_PRIV_INCLUDEDIRS := \
iotkit-embedded/coap_server/CoAPPacket \
iotkit-embedded/coap_server/server \
iotkit-embedded/dev_bind/impl \
iotkit-embedded/dev_bind/impl/os \
iotkit-embedded/dev_bind/impl/awss_reset \
iotkit-embedded/wifi_provision/dev_ap \
iotkit-embedded/wifi_provision/frameworks \
iotkit-embedded/wifi_provision/frameworks/aplist \
iotkit-embedded/wifi_provision/frameworks/ieee80211 \
iotkit-embedded/wifi_provision/frameworks/statics \
iotkit-embedded/wifi_provision/frameworks/utils \
iotkit-embedded/wifi_provision/p2p \
iotkit-embedded/wifi_provision/phone_ap \
iotkit-embedded/wifi_provision/router_ap \
iotkit-embedded/wifi_provision/smartconfig \
iotkit-embedded/wifi_provision/zero_config

COMPONENT_ADD_INCLUDEDIRS := \
conn_mgr \
iotkit-embedded/atm \
iotkit-embedded/coap_server \
iotkit-embedded/dev_bind \
iotkit-embedded/dev_model \
iotkit-embedded/dev_sign \
iotkit-embedded/dynamic_register \
iotkit-embedded/mqtt \
iotkit-embedded/ota \
iotkit-embedded/infra \
iotkit-embedded/wifi_provision \
iotkit-embedded \
wrappers

COMPONENT_SRCDIRS := \
conn_mgr \
iotkit-embedded/atm \
iotkit-embedded/certs \
iotkit-embedded/dev_bind/impl \
iotkit-embedded/dev_bind/impl/os \
iotkit-embedded/dev_bind/impl/awss_reset \
iotkit-embedded/dev_model \
iotkit-embedded/dev_reset \
iotkit-embedded/dev_sign \
iotkit-embedded/dynamic_register \
iotkit-embedded/infra \
iotkit-embedded/mqtt \
iotkit-embedded/ota \
iotkit-embedded/wifi_provision/dev_ap \
iotkit-embedded/wifi_provision/frameworks \
iotkit-embedded/wifi_provision/frameworks/aplist \
iotkit-embedded/wifi_provision/frameworks/ieee80211 \
iotkit-embedded/wifi_provision/frameworks/statics \
iotkit-embedded/wifi_provision/frameworks/utils \
iotkit-embedded/wifi_provision/p2p \
iotkit-embedded/wifi_provision/phone_ap \
iotkit-embedded/wifi_provision/router_ap \
iotkit-embedded/wifi_provision/smartconfig \
iotkit-embedded/wifi_provision/zero_config \
iotkit-embedded/coap_server/CoAPPacket \
iotkit-embedded/coap_server/server \
wrappers

CFLAGS += -Wno-char-subscripts
