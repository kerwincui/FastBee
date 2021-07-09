#ifndef ESP_MQTT_CLIENT_H
#define ESP_MQTT_CLIENT_H

#include <PubSubClient.h>
#include <vector>

#ifdef ESP8266

  #include <ESP8266WiFi.h>
  #include <ESP8266WebServer.h>
  #include <ESP8266mDNS.h>
  #include <ESP8266HTTPUpdateServer.h>

  #define WebServer ESP8266WebServer
  #define ESPmDNS ESP8266mDNS
  #define ESPHTTPUpdateServer ESP8266HTTPUpdateServer

#else // for ESP32

  #include <WiFiClient.h>
  #include <WebServer.h>
  #include <ESPmDNS.h>
  #include "ESP32HTTPUpdateServer.h"

  #define ESPHTTPUpdateServer ESP32HTTPUpdateServer

#endif

void onConnectionEstablished(); // MUST be implemented in your sketch. Called once everythings is connected (Wifi, mqtt).

typedef std::function<void()> ConnectionEstablishedCallback;
typedef std::function<void(const String &message)> MessageReceivedCallback;
typedef std::function<void(const String &topicStr, const String &message)> MessageReceivedCallbackWithTopic;
typedef std::function<void()> DelayedExecutionCallback;

class EspMQTTClient
{
private:
  // Wifi related
  bool _handleWiFi;
  bool _wifiConnected;
  bool _connectingToWifi;
  unsigned long _lastWifiConnectiomAttemptMillis;
  unsigned long _nextWifiConnectionAttemptMillis;
  unsigned int _wifiReconnectionAttemptDelay;
  const char* _wifiSsid;
  const char* _wifiPassword;
  WiFiClient _wifiClient;

  // MQTT related
  bool _mqttConnected;
  unsigned long _nextMqttConnectionAttemptMillis;
  unsigned int _mqttReconnectionAttemptDelay;
  const char* _mqttServerIp;
  const char* _mqttUsername;
  const char* _mqttPassword;
  const char* _mqttClientName;
  const short _mqttServerPort;
  bool _mqttCleanSession;
  char* _mqttLastWillTopic;
  char* _mqttLastWillMessage;
  bool _mqttLastWillRetain;
  unsigned int _failedMQTTConnectionAttemptCount;

  PubSubClient _mqttClient;

  struct TopicSubscriptionRecord {
    String topic;
    MessageReceivedCallback callback;
    MessageReceivedCallbackWithTopic callbackWithTopic;
  };
  std::vector<TopicSubscriptionRecord> _topicSubscriptionList;

  // HTTP update server related
  char* _updateServerAddress;
  char* _updateServerUsername;
  char* _updateServerPassword;
  WebServer* _httpServer;
  ESPHTTPUpdateServer* _httpUpdater;

  // Delayed execution related
  struct DelayedExecutionRecord {
    unsigned long targetMillis;
    DelayedExecutionCallback callback;
  };
  std::vector<DelayedExecutionRecord> _delayedExecutionList;

  // General behaviour related
  ConnectionEstablishedCallback _connectionEstablishedCallback;
  bool _enableSerialLogs;
  bool _drasticResetOnConnectionFailures;
  unsigned int _connectionEstablishedCount; // Incremented before each _connectionEstablishedCallback call

public:
  // Wifi + MQTT with no MQTT authentification
  EspMQTTClient(
    const char* wifiSsid,
    const char* wifiPassword,
    const char* mqttServerIp,
    const char* mqttClientName = "ESP8266",
    const short mqttServerPort = 1883);

  // Wifi + MQTT with MQTT authentification
  EspMQTTClient(
    const char* wifiSsid,
    const char* wifiPassword,
    const char* mqttServerIp,
    const char* mqttUsername,
    const char* mqttPassword,
    const char* mqttClientName = "ESP8266",
    const short mqttServerPort = 1883);

  // Only MQTT handling (no wifi), with MQTT authentification
  EspMQTTClient(
    const char* mqttServerIp,
    const short mqttServerPort,
    const char* mqttUsername,
    const char* mqttPassword,
    const char* mqttClientName = "ESP8266");

  // Only MQTT handling without MQTT authentification
  EspMQTTClient(
    const char* mqttServerIp,
    const short mqttServerPort,
    const char* mqttClientName = "ESP8266");

  ~EspMQTTClient();

  // Optional functionality
  void enableDebuggingMessages(const bool enabled = true); // Allow to display useful debugging messages. Can be set to false to disable them during program execution
  void enableHTTPWebUpdater(const char* username, const char* password, const char* address = "/"); // Activate the web updater, must be set before the first loop() call.
  void enableHTTPWebUpdater(const char* address = "/"); // Will set user and password equal to _mqttUsername and _mqttPassword
  void enableMQTTPersistence(); // Tell the broker to establish a persistent connection. Disabled by default. Must be called before the first loop() execution
  void enableLastWillMessage(const char* topic, const char* message, const bool retain = false); // Must be set before the first loop() call.
  void enableDrasticResetOnConnectionFailures() {_drasticResetOnConnectionFailures = true;} // Can be usefull in special cases where the ESP board hang and need resetting (#59)

  // Main loop, to call at each sketch loop()
  void loop();

  // MQTT related
  bool setMaxPacketSize(const uint16_t size); // Pubsubclient >= 2.8; override the default value of MQTT_MAX_PACKET_SIZE
  bool publish(const String &topic, const String &payload, bool retain = false);
  bool subscribe(const String &topic, MessageReceivedCallback messageReceivedCallback, uint8_t qos = 0);
  bool subscribe(const String &topic, MessageReceivedCallbackWithTopic messageReceivedCallback, uint8_t qos = 0);
  bool unsubscribe(const String &topic);   //Unsubscribes from the topic, if it exists, and removes it from the CallbackList.
  void setKeepAlive(uint16_t keepAliveSeconds); // Change the keepalive interval (15 seconds by default)
  inline void setMqttClientName(const char* name) { _mqttClientName = name; }; // Allow to set client name manually (must be done in setup(), else it will not work.)

  // Other
  void executeDelayed(const unsigned long delay, DelayedExecutionCallback callback);

  inline bool isConnected() const { return isWifiConnected() && isMqttConnected(); }; // Return true if everything is connected
  inline bool isWifiConnected() const { return _wifiConnected; }; // Return true if wifi is connected
  inline bool isMqttConnected() const { return _mqttConnected; }; // Return true if mqtt is connected
  inline bool getConnectionEstablishedCount() const { return _connectionEstablishedCount; }; // Return the number of time onConnectionEstablished has been called since the beginning.

  inline const char* getMqttClientName() { return _mqttClientName; };
  inline const char* getMqttServerIp() { return _mqttServerIp; };
  inline const short getMqttServerPort() { return _mqttServerPort; };

  // Default to onConnectionEstablished, you might want to override this for special cases like two MQTT connections in the same sketch
  inline void setOnConnectionEstablishedCallback(ConnectionEstablishedCallback callback) { _connectionEstablishedCallback = callback; };

  // Allow to set the minimum delay between each MQTT reconnection attempt. 15 seconds by default.
  inline void setMqttReconnectionAttemptDelay(const unsigned int milliseconds) { _mqttReconnectionAttemptDelay = milliseconds; };

  // Allow to set the minimum delay between each WiFi reconnection attempt. 60 seconds by default.
  inline void setWifiReconnectionAttemptDelay(const unsigned int milliseconds) { _wifiReconnectionAttemptDelay = milliseconds; };

private:
  bool handleWiFi();
  bool handleMQTT();
  void onWiFiConnectionEstablished();
  void onWiFiConnectionLost();
  void onMQTTConnectionEstablished();
  void onMQTTConnectionLost();

  void connectToWifi();
  bool connectToMqttBroker();
  void processDelayedExecutionRequests();
  bool mqttTopicMatch(const String &topic1, const String &topic2);
  void mqttMessageReceivedCallback(char* topic, byte* payload, unsigned int length);
};

#endif
