
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

String randomName="wumei-device"+(String)random(1000);
const char *ap_ssid =randomName.c_str();
const char *ap_password = ""; //开放式网络

char sta_ssid[32] = {0};
char sta_password[64] = {0};
char sta_user_id[32] = {0};

IPAddress local_IP(192, 168, 4, 1);
IPAddress gateway(192, 168, 4, 1);
IPAddress subnet(255, 255, 255, 0);

void initApConfig();
void initWebServer();
void handleConfig();
void handleStatus();
void handleNotFound();

ESP8266WebServer server(80);

void setup(void)
{
  //打开串行端口：
  Serial.begin(115200);
  // AP模式
  initApConfig();
  // web服务
  initWebServer();
}

void loop(void)
{
  // Web服务端
  server.handleClient();
}

/**
 * AP模式
 */
void initApConfig()
{
  WiFi.mode(WIFI_AP_STA);
  WiFi.softAPConfig(local_IP, gateway, subnet);
  WiFi.softAP(ap_ssid, ap_password);
  printMsg("已启动AP配网，IP地址：" + WiFi.softAPIP().toString()+"， 热点名称："+(String)ap_ssid);
}

/**
 * 初始化webserver配置
 */
void initWebServer()
{
  server.on("/status", HTTP_GET, handleStatus);
  server.on("/config", HTTP_POST, handleConfig);
  server.onNotFound(handleNotFound);
  server.enableCORS(true);
  server.begin();
  printMsg("HTTP服务已启动");
}

/**
 * 连接WIFI
 */
void connectWifi()
{
  printMsg("连接WIFI");
  WiFi.begin(sta_ssid, sta_password);
  int cnt = 0;
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    cnt++;
    Serial.print(".");
    if (cnt >= 30)
    {
      printMsg("设备连接WIFI超时，请重新配网");
      return;
    }
  }
  server.close();
  WiFi.softAPdisconnect(false);
  printMsg("Http服务和热点已关闭，设备已连接WIFI");
}

/**
 * 检测设备状态
 */
 void handleStatus(){
   server.send(200, "text/plain;charset=utf-8", "AP配网已准备就绪");
 }
 
/**
 * 配网：下发配置信息
 */
void handleConfig()
{
  printMsg("进入配网......");
  // wifi名称、wifi密码、用户编号
  if (server.hasArg("SSID") && server.hasArg("password") && server.hasArg("userId"))
  {
    strcpy(sta_ssid, server.arg("SSID").c_str());
    strcpy(sta_password, server.arg("password").c_str());
    strcpy(sta_user_id, server.arg("userId").c_str());
    printMsg("收到WIFI名称：" + (String)sta_ssid);
    printMsg("收到WIFI密码：" + (String)sta_password);
    printMsg("收到用户编号：" + (String)sta_user_id);
  }
  else
  {
    printMsg("配网必须传递用户编号、WIFI名称和WIFI密码,配网失败");
    server.send(500, "text/plain;charset=utf-8", "配网必须传递用户编号、WIFI名称和WIFI密码，配网失败");
    return;
  }
  // 可选字段
  if (server.hasArg("deviceNum"))
  {
    printMsg("收到设备编号：" + server.arg("deviceNum"));
  }
  if (server.hasArg("extra"))
  {
    printMsg("收到补充信息：" + server.arg("extra"));
  }
  // TODO 可增加设备连接WIFI测试
  
  server.send(200, "text/plain;charset=utf-8", "设备已更新WIFI配置，开始连接WIFI...");
  connectWifi();
}

void handleNotFound()
{
  printMsg("进入预检请求或请求地址找不到");
  if (server.method() == HTTP_OPTIONS)
  {
    // 处理浏览器跨域问题
    server.sendHeader("Access-Control-Max-Age", "10000");
    server.sendHeader("Access-Control-Allow-Methods", "PUT,POST,GET,OPTIONS");
    server.sendHeader("Access-Control-Allow-Headers", "*");
    server.send(204);
  }
  else
  {
    server.send(404, "text/plain;charset=utf-8", "请求的地址找不到或无法访问");
  }
}

//打印提示信息
void printMsg(String msg)
{
  Serial.print("\r\n[");
  Serial.print(millis());
  Serial.print("ms]");
  Serial.print(msg);
}
