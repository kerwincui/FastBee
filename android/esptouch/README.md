# EspTouch
[example](../app/src/main/java/com/espressif/esptouch/android/v1)

- Create task instance
  ```java
  Context context; // Set Applicatioin context
  byte[] apSsid = {}; // Set AP's SSID
  byte[] apBssid = {}; // Set AP's BSSID
  byte[] apPassword = {}; // Set AP's password

  EsptouchTask task = new EsptouchTask(apSsid, apBssid, apPassword, context);
  task.setPackageBroadcast(true); // if true send broadcast packets, else send multicast packets
  ```

- Set result callback
  ```java
  task.setEsptouchListener(new IEsptouchListener() {
      @Override
      public void onEsptouchResultAdded(IEsptouchResult result) {
          // Result callback
      }
  });
  ```

- Execute task
  ```java
  int expectResultCount = 1;
  List<IEsptouchResult> results = task.executeForResults(expectResultCount);
  IEsptouchResult first = results.get(0);
  if (first.isCancelled()) {
    // User cancel the task
    return;
  }
  if (first.isSuc()) {
    // EspTouch successfully
  }
  ```

- Cancel task
  ```java
  task.interrupt();
  ```
