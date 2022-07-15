
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

#define DEBUG

#ifdef DEBUG
  //以下三个定义为调试定义
  #define DebugBegin(baud_rate)    Serial.begin(baud_rate)
  #define DebugPrintln(message)    Serial.println(message)
  #define DebugPrint(message)    Serial.print(message)
#else
  //以下三个定义为调试定义
  #define DebugBegin(baud_rate)
  #define DebugPrintln(message)
  #define DebugPrint(message)
#endif  

const char* ap_ssid = "esp_webconfig";
const char* ap_password = "";//开放式网络

char sta_ssid[32] = {0};
char sta_password[64] = {0};

const char* webpage_html = "\
<!DOCTYPE html>\r\n\
<html lang='en'>\r\n\
<head>\r\n\
  <meta charset='UTF-8'>\r\n\
  <title>Document</title>\r\n\
</head>\r\n\
<body>\r\n\
  <form name='input' action='/' method='POST'>\r\n\
        wifi名称: <br>\r\n\
        <input type='text' name='ssid'><br>\r\n\
        wifi密码:<br>\r\n\
        <input type='text' name='password'><br>\r\n\
        <input type='submit' value='保存'>\r\n\
    </form>\r\n\
</body>\r\n\
</html>\r\n\
";

IPAddress local_IP(192,168,4,1);
IPAddress gateway(192,168,4,1);
IPAddress subnet(255,255,255,0);

void initApConfig();
void initWebServer();
void connectToWifi();
void handleRootPost();
void handleRoot();
void handleNotFound();

ESP8266WebServer server(80);

void setup(void) {
  DebugBegin(115200);
  DebugPrintln("");
  DebugPrint("connect ap: ");
  DebugPrintln(ap_ssid);

  initApConfig();

  DebugPrint("IP address: ");
  DebugPrintln(WiFi.softAPIP());

  initWebServer();

  DebugPrintln("HTTP server started");

  Serial.printf("Ready! Open http://%s in your browser\n",
  WiFi.softAPIP().toString().c_str());
}

void loop(void) {
  server.handleClient();
}

/**
 * 初始化AP配置
 */
void initApConfig(){
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(local_IP, gateway, subnet);
  WiFi.softAP(ap_ssid, ap_password);
}

/**
 * 初始化webserver配置
 */
void initWebServer(){
  server.on("/", HTTP_GET, handleRoot);
  server.on("/", HTTP_POST, handleRootPost);
  server.onNotFound(handleNotFound);
  server.enableCORS(true);
  server.begin();  
}

/**
 * 连接到WiFi
 */
void connectToWifi(){
  DebugPrintln("connectToWifi");
  WiFi.disconnect();
  WiFi.mode(WIFI_STA);
  WiFi.begin(sta_ssid, sta_password);

  int cnt = 0;
  while (WiFi.status() != WL_CONNECTED) {
          delay(500);
          cnt++;
          Serial.print(".");
          if(cnt>=40){
            cnt = 0;
            //重启系统
            DebugPrintln("\r\nRestart now!");
            ESP.restart();
          }
  }
  DebugPrintln("connectToWifi Success!");
}

/**
 * 处理web post请求
 */
void handleRootPost() {
  DebugPrintln("handleRootPost");
  if (server.hasArg("ssid")) {
    DebugPrint("got ssid:");
    strcpy(sta_ssid, server.arg("ssid").c_str());
    DebugPrintln(sta_ssid);
  } else {
    DebugPrintln("error, not found ssid");
    server.send(200, "text/plain", "error, not found ssid");
    return;
  }

  if (server.hasArg("password")) {
    DebugPrint("got password:");
    strcpy(sta_password, server.arg("password").c_str());
    DebugPrintln(sta_password);
  } else {
    DebugPrintln("error, not found password");
    server.send(200, "text/plain", "error, not found password");
    return;
  }

  server.send(200, "text/plain", "保存成功");
  delay(2000);
  //连接wifi
  connectToWifi();
}

/**
 * 处理web get请求
 */
void handleRoot() {
  DebugPrintln("handleRoot");
  server.send(200, "text/html", webpage_html);
}

void handleNotFound() {
  if (server.method() == HTTP_OPTIONS)
    {
        server.sendHeader("Access-Control-Max-Age", "10000");
        server.sendHeader("Access-Control-Allow-Methods", "PUT,POST,GET,OPTIONS");
        server.sendHeader("Access-Control-Allow-Headers", "*");
        server.send(204);
    }
    else
    {
        server.send(404, "text/plain", "");
    }
  String message = "File Not Found\n\n";
  server.send(404, "text/plain", message);
}
