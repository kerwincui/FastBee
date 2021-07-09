/*
  twoMQTTClientHandling.ino
  The purpose of this exemple is to illustrate how to handle more than one MQTT connection a the same time in the same sketch.
  Getting into "SimpleMQTTClient.ino" before this one is recommended (there is more comments)
*/

#include "EspMQTTClient.h"

void onConnectionEstablishedClient2();

// The client #1 will handle wifi connection (connecting, retrying, etc) and MQTT connection to 192.168.1.100
EspMQTTClient client1(
  "WifiSSID",
  "WifiPassword",
  "192.168.1.100",
  "MQTTUsername",
  "MQTTPassword",
  "TestClient1"
);

// The client #2 will handle MQTT connection to 192.168.1.101.
EspMQTTClient client2(
  "192.168.1.101",
  1883,
  "MQTTUsername", 
  "MQTTPassword",
  "TestClient2"
);

void setup()
{
  Serial.begin(115200);

  // We redirect the connection established callback of client2 to onConnectionEstablishedClient2.
  // This will prevent the two client from calling the same callback (default to onConnectionEstablished)
  client2.setOnConnectionEstablishedCallback(onConnectionEstablishedClient2); 
}

// For client1
void onConnectionEstablished()
{
  client1.subscribe("mytopic/test", [](const String & payload) {
    Serial.println(payload);
  });
  client1.publish("mytopic/test", "This is a message from client1");
}

// For client2
void onConnectionEstablishedClient2()
{
  client2.subscribe("mytopic/test", [](const String & payload) {
    Serial.println(payload);
  });
  client2.publish("mytopic/test", "This is a message from client2");
}

void loop()
{
  client1.loop();
  client2.loop();
}
