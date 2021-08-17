#include "mqtt.h"

#define MQTT_NAME				"n87ieud/my_board2"
#define MQTT_PW					"k4e9trh5qjwjhc2q"
#define MQTT_CLIENT_ID			"my_board2"

#define MQTT_TOPIC_UPDATE 				"$baidu/iot/shadow/my_board2/update"
#define MQTT_TOPIC_DELTA				"$baidu/iot/shadow/my_board2/delta"
#define MQTT_TOPIC_SNAPSHOT				"$baidu/iot/shadow/my_board2/update/snapshot"


char str[] = "{\"deviceNum\": \"E8DB84933089\",\"relayStatus\": 0,\"lightStatus\": 0,\"isOnline\": 1,\"rssi\": -54,\"deviceTemperature\": 38}";

static int mqtt_send(uint8_t head, uint32_t vlen, uint8_t *vhead,
		uint32_t pay_len, uint8_t *payload)
{
	int32_t tmp_encode, tmp_x;
	uint32_t i = 0;
	uint8_t msg[RX_BUFF_LEN];
	msg[i++] = head;

	tmp_x = vlen + pay_len;
	do {
		tmp_encode = tmp_x % 128;
		tmp_x = tmp_x / 128;
		if (tmp_x > 0) {
			tmp_encode = tmp_encode | 128;
		}
		msg[i++] = tmp_encode;
	} while (tmp_x > 0);

	if (vlen != 0) {
		memcpy(&msg[i], vhead, vlen);
		i = i + vlen;
	}
	if (pay_len != 0) {
		memcpy(&msg[i], payload, pay_len);
		i = i + pay_len;
	}
	esp8266_send(msg, i);

	return 0;
}
static int mqtt_str_fill(uint8_t *outbuff, char *instr)
{
	uint8_t *p_tmp;
	p_tmp = &outbuff[2];
	outbuff[0] = strlen(instr) / 256;
	outbuff[1] = strlen(instr) % 256;
	strcpy((char*) p_tmp, (char*) instr);
	return 0;
}

static int mqtt_recv(uint8_t *ackbuff, uint16_t *ack_len, int timeout)
{

	do {
		if (esp8266_recv(ackbuff, &ack_len) == 0) {
			return 0;
		}
		if (timeout > 0) {
			HAL_Delay(100);
		} else {
			return -1;
		}

	} while (timeout--);
	return -1;
}

static int mqtt_ack_check(uint8_t head, int timeout, uint16_t msg_id)
{
	uint8_t recv_head;
	uint8_t recv_buff[RX_BUFF_LEN];
	uint16_t recv_len;

	if (mqtt_recv(recv_buff, &recv_len, timeout) != 0) {
		return -1;
	}
	recv_head = recv_buff[0];

	if ((head & recv_head) != head) {
		return -1;
	}
	switch (recv_head & 0xF0) {
	case MQTT_CONNACK:
		return 0;
	case MQTT_PUBACK:
		return 0;
	case MQTT_SUBACK:
		return 0;
	case MQTT_PINGRESP:
		return 0;
	default:
		return -1;
	}
	return -1;
}

static int mqtt_connect(char *name, char *pwd, char *client_id)
{
	uint32_t i, j;
	uint8_t vhead[512];
	uint8_t payload[512];
	uint8_t connec_flag = 0;
	uint8_t head;
	uint16_t keep_alive = 60;

	i = 0;
	vhead[i++] = 0;
	vhead[i++] = 4;
	vhead[i++] = 'M';
	vhead[i++] = 'Q';
	vhead[i++] = 'T';
	vhead[i++] = 'T';
	vhead[i++] = 4;

	if (name != NULL) {
		connec_flag = connec_flag | CONNECT_FLAG_NAME;
	}
	if (pwd != NULL) {
		connec_flag = connec_flag | CONNECT_FLAG_PWD;
	}
	vhead[i++] = connec_flag;
	vhead[i++] = keep_alive / 256;
	vhead[i++] = keep_alive % 256;

	j = 0;
	mqtt_str_fill(&payload[j], client_id);
	j = j + strlen(client_id) + 2;
	mqtt_str_fill(&payload[j], name);
	j = j + strlen(name) + 2;
	mqtt_str_fill(&payload[j], pwd);
	j = j + strlen(pwd) + 2;

	head = MQTT_CONNECT;

	mqtt_send(head, i, vhead, j, payload);
	if (mqtt_ack_check(MQTT_CONNACK, 100, 0) != 0) {
		return -1;
	}
	return 0;
}

static int mqtt_disconnect(void)
{
	uint8_t head;
	head = MQTT_DISCONNECT;
	mqtt_send(head, 0, NULL, 0, NULL);
}
static int mqtt_publish(char *topic, uint8_t *msg, uint16_t msg_len,
		uint16_t msg_id)
{
	uint32_t i, j;
	uint8_t vhead[512];
	uint8_t head;
	uint8_t payload[512];

	head = 0;
	head = head | MQTT_PUBLISH;
	head = head | PUBLISH_FLAG_RETN;
	head = head | PUBLISH_FLAG_QOS1;

	i = 0;
	mqtt_str_fill(&vhead[i], topic);
	i = i + strlen(topic) + 2;
	vhead[i++] = msg_id >> 8;
	vhead[i++] = msg_id;

	j = 0;
	memcpy(payload, msg, msg_len);
	j = j + msg_len;

	mqtt_send(head, i, vhead, j, payload);

	if (mqtt_ack_check(MQTT_PUBACK, 100, msg_id) != 0) {
		return -1;
	}
	return 0;
}

static int mqtt_publish_ack(uint16_t msg_id)
{
	uint32_t i, j;
	uint8_t vhead[512];
	uint8_t head;
	uint8_t payload[512];
	head = MQTT_PUBACK;
	i = 0;
	vhead[i++] = msg_id >> 8;
	vhead[i++] = msg_id;
	j = 0;
	mqtt_send(head, i, vhead, j, payload);
	return 0;
}

static int mqtt_subscriber(char *topic, uint16_t msg_id)
{
	uint32_t i, j;
	uint8_t vhead[512];
	uint8_t payload[512];
	uint8_t head;
	head = MQTT_SUBSCRIBE;
	head = head | 0x02;
	i = 0;
	vhead[i++] = msg_id >> 8;
	vhead[i++] = msg_id;

	j = 0;
	mqtt_str_fill(&payload[j], topic);
	j = j + strlen(topic) + 2;
	payload[j++] = 1;
	mqtt_send(head, i, vhead, j, payload);
	if (mqtt_ack_check(MQTT_SUBACK, 100, msg_id) != 0) {
		return -1;
	}
	return 0;
}

static int mqtt_publish_from_cloud(uint8_t *ackbuff, uint16_t ack_len)
{
	uint32_t i = 0;
	uint16_t multiplier = 1;
	uint32_t remain_len = 0;
	uint32_t vhead_len;
	uint32_t payload_len;
	uint8_t byte;
	uint8_t payload[512];
	uint16_t msg_id;
	uint8_t topic[256];
	i = 1;

	memset(topic, 0, 256);
	memset(payload, 0, 256);
	do {
		byte = ackbuff[i++];
		remain_len += (byte & 0x7F) * multiplier;
		multiplier *= 128;
		if (multiplier > 128 * 128 * 128) {
			return -1;
		}
	} while ((byte & 0x80) != 0);
	vhead_len = ackbuff[i++];
	vhead_len = (vhead_len * 256) + ackbuff[i++];
	memcpy(topic, &ackbuff[i], vhead_len);

	i = i + vhead_len;
	msg_id = ackbuff[i++];
	msg_id = (msg_id * 256) + ackbuff[i++];

	payload_len = remain_len - vhead_len - 4;

	memcpy(payload, &ackbuff[i], payload_len);
	if (strcmp((char*) topic, MQTT_TOPIC_DELTA) == 0) {
		sensor_data_set(payload);
	}
	mqtt_publish_ack(msg_id);
	return 0;
}

uint16_t msg_id = 1;

int mqtt_beat(void)
{
	uint8_t head = MQTT_PINGREQ;
	uint8_t vhead[5];
	uint8_t payload[5];
	uint32_t i = 0, j = 0;
	mqtt_send(head, i, vhead, j, payload);
	if (mqtt_ack_check(MQTT_PINGRESP, 100, 0) != 0) {
		if (mqtt_connect(MQTT_NAME, MQTT_PW, MQTT_CLIENT_ID) != 0) {
			return -1;
		}else{
			return 0;
		}
	}
	return 0;
}

int mqtt_handle(void)
{
	uint8_t recv_head;
	uint8_t recv_buff[RX_BUFF_LEN];
	uint16_t recv_len;

	if (mqtt_recv(recv_buff, &recv_len, 0) != 0) {
		return -1;
	}
	recv_head = recv_buff[0];

	switch (recv_head & 0xF0) {
	case MQTT_PUBLISH:
		return mqtt_publish_from_cloud(recv_buff, recv_len);
	default:
		return -1;
	}
	return -1;
}

int mqtt_publish_update(uint8_t *msg, uint16_t msg_len)
{
	if (mqtt_publish(MQTT_TOPIC_UPDATE, msg, msg_len, msg_id++) != 0) {
		return -1;
	}
	return 0;
}

int mqtt_init(void)
{
	if (mqtt_connect(MQTT_NAME, MQTT_PW, MQTT_CLIENT_ID) != 0) {
		mqtt_disconnect();
		esp8266_init();
		HAL_Delay(100);
		if (mqtt_connect(MQTT_NAME, MQTT_PW, MQTT_CLIENT_ID) != 0) {
			return -1;
		}
	}

	if (mqtt_subscriber(MQTT_TOPIC_DELTA, msg_id++) != 0) {
		return -1;
	}
	return 0;
}

