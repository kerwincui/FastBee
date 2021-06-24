
package com.kerwin.wumei.activity;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.LocationManager;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.util.Log;
import android.view.KeyEvent;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.core.location.LocationManagerCompat;

import com.espressif.iot.esptouch.EsptouchTask;
import com.espressif.iot.esptouch.IEsptouchResult;
import com.espressif.iot.esptouch.IEsptouchTask;
import com.espressif.iot.esptouch.util.ByteUtil;
import com.espressif.iot.esptouch.util.TouchNetUtil;
import com.kerwin.wumei.R;
import com.kerwin.wumei.adapter.entity.EspTouchViewModel;
import com.kerwin.wumei.core.BaseActivity;
import com.kerwin.wumei.fragment.device.AddDeviceFragment;
import com.kerwin.wumei.utils.NetUtils;
import com.xuexiang.xui.utils.KeyboardUtils;
import com.xuexiang.xui.utils.StatusBarUtils;
import com.xuexiang.xutil.display.Colors;

import java.lang.ref.WeakReference;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class AddDeviceActivity extends BaseActivity {

    // begin esptouch -------------------------------------
    private static final String TAG = AddDeviceActivity.class.getSimpleName();
    private static final int REQUEST_PERMISSION = 0x01;
    private EspTouchViewModel mViewModel;
    private EsptouchAsyncTask4 mTask;
    private WifiManager mWifiManager;
    private List<String> ssids;
    private String selectedSSID;

    public String GetSelectedSSID(){
        return selectedSSID;
    }
    public List<String> GetSsids(){
        return ssids;
    }
    public EspTouchViewModel GetMViewModel(){
        return mViewModel;
    }

    private AddDeviceFragment addDeviceFragment;
    private IEsptouchTask mEsptouchTask;


    public void executeEsptouch() {
        EspTouchViewModel viewModel = mViewModel;
        // byte[] ssid = viewModel.ssidBytes == null ? ByteUtil.getBytesByString(viewModel.ssid): viewModel.ssidBytes;
        CharSequence ssidStr=mViewModel.ssidSpinner.getText();
        byte[] ssid= ByteUtil.getBytesByString(ssidStr.toString());
        CharSequence pwdStr = mViewModel.apPasswordEdit.getText();
        byte[] password = pwdStr == null ? null : ByteUtil.getBytesByString(pwdStr.toString());
        byte[] bssid = TouchNetUtil.parseBssid2bytes(viewModel.bssid);
        byte[] broadcast = {(byte) (mViewModel.packageModeGroup.getCheckedRadioButtonId() == R.id.packageBroadcast? 1 : 0)};
        int count = mViewModel.xsbDeviceCount.getSelectedNumber();
        byte[] deviceCount = String.valueOf(count).getBytes();
        if (mTask != null) {
            mTask.cancelEsptouch();
        }
        mTask = new EsptouchAsyncTask4(this);
        mTask.execute(ssid, bssid, password, deviceCount, broadcast);
    }

    public void onWifiChanged() {
        StateResult stateResult = check();
        mViewModel.message = stateResult.message;
        mViewModel.ssid = stateResult.ssid;
        mViewModel.ssidBytes = stateResult.ssidBytes;
        mViewModel.bssid = stateResult.bssid;
        mViewModel.confirmEnable = false;
        if (stateResult.wifiConnected) {
            mViewModel.confirmEnable = true;
            if (stateResult.is5G) {
                mViewModel.message = getString(R.string.esptouch1_wifi_5g_message);
            }
        } else {
            if (mTask != null) {
                mTask.cancelEsptouch();
                mTask = null;
                new AlertDialog.Builder(AddDeviceActivity.this)
                        .setMessage(R.string.esptouch1_configure_wifi_change_message)
                        .setNegativeButton(android.R.string.cancel, null)
                        .show();
            }
        }
        mViewModel.invalidateAll();
    }

    protected static class StateResult {
        public CharSequence message = null;
        public boolean permissionGranted = false;
        public boolean locationRequirement = false;
        public boolean wifiConnected = false;
        public boolean is5G = false;
        public InetAddress address = null;
        public String ssid = null;
        public byte[] ssidBytes = null;
        public String bssid = null;
    }

    private StateResult check() {
        StateResult result = checkPermission();
        if (!result.permissionGranted) {
            return result;
        }
        result = checkLocation();
        result.permissionGranted = true;
        if (result.locationRequirement) {
            return result;
        }
        result = checkWifi();
        result.permissionGranted = true;
        result.locationRequirement = false;
        return result;
    }

    protected StateResult checkWifi() {
        StateResult result = new StateResult();
        result.wifiConnected = false;
        WifiInfo wifiInfo = mWifiManager.getConnectionInfo();

        // 获取wifi列表
        mWifiManager.startScan();
        List<ScanResult> scanWifiList = mWifiManager.getScanResults();
        List<ScanResult> wifiList = new ArrayList<>();
        ssids=new ArrayList<>();
        if (scanWifiList != null && scanWifiList.size() > 0) {
            HashMap<String, Integer> signalStrength = new HashMap<String, Integer>();
            for (int i = 0; i < scanWifiList.size(); i++) {
                ScanResult scanResult = scanWifiList.get(i);
                Log.e(TAG, "搜索的wifi-ssid:" + scanResult.SSID);
                if (!scanResult.SSID.isEmpty()) {
                    String key = scanResult.SSID + " " + scanResult.capabilities;
                    if (!signalStrength.containsKey(key)) {
                        signalStrength.put(key, i);
                        wifiList.add(scanResult);
                        ssids.add(scanResult.SSID);
                    }
                }
            }
        }

        boolean connected = NetUtils.isWifiConnected(mWifiManager);
        if (!connected) {
            result.message = getString(R.string.esptouch_message_wifi_connection);
            return result;
        }

        String ssid = NetUtils.getSsidString(wifiInfo);
        selectedSSID=ssid;
        int ipValue = wifiInfo.getIpAddress();
        if (ipValue != 0) {
            result.address = NetUtils.getAddress(wifiInfo.getIpAddress());
        } else {
            result.address = NetUtils.getIPv4Address();
            if (result.address == null) {
                result.address = NetUtils.getIPv6Address();
            }
        }

        result.wifiConnected = true;
        result.message = "";

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            result.is5G = NetUtils.is5G(wifiInfo.getFrequency());
        }
        if (result.is5G) {
            result.message = getString(R.string.esptouch_message_wifi_frequency);
        }
        result.ssid = ssid;
        result.ssidBytes = NetUtils.getRawSsidBytesOrElse(wifiInfo, ssid.getBytes());
        result.bssid = wifiInfo.getBSSID();
        return result;
    }

    protected StateResult checkLocation() {
        StateResult result = new StateResult();
        result.locationRequirement = true;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            LocationManager manager = getSystemService(LocationManager.class);
            boolean enable = manager != null && LocationManagerCompat.isLocationEnabled(manager);
            if (!enable) {
                result.message = getString(R.string.esptouch_message_location);
                return result;
            }
        }

        result.locationRequirement = false;
        return result;
    }

    protected StateResult checkPermission() {
        StateResult result = new StateResult();
        result.permissionGranted = false;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            boolean locationGranted = checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION)
                    == PackageManager.PERMISSION_GRANTED;
            if (!locationGranted) {
                String[] splits = getString(R.string.esptouch_message_permission).split("\n");
                if (splits.length != 2) {
                    throw new IllegalArgumentException("Invalid String @RES esptouch_message_permission");
                }
                SpannableStringBuilder ssb = new SpannableStringBuilder(splits[0]);
                ssb.append('\n');
                SpannableString clickMsg = new SpannableString(splits[1]);
                ForegroundColorSpan clickSpan = new ForegroundColorSpan(0xFF0022FF);
                clickMsg.setSpan(clickSpan, 0, clickMsg.length(), Spannable.SPAN_INCLUSIVE_INCLUSIVE);
                ssb.append(clickMsg);
                result.message = ssb;
                return result;
            }
        }

        result.permissionGranted = true;
        return result;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == REQUEST_PERMISSION) {
            if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                onWifiChanged();
            } else {
                new AlertDialog.Builder(this)
                        .setTitle(R.string.esptouch1_location_permission_title)
                        .setMessage(R.string.esptouch1_location_permission_message)
                        .setCancelable(false)
                        .setPositiveButton(android.R.string.ok, (dialog, which) -> finish())
                        .show();
            }

            return;
        }

        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    /**
     * 中断配网任务
     */
    public void interruptEspTouchTask(){
        if (mEsptouchTask != null) {
            mEsptouchTask.interrupt();
        }
    }

    public class EsptouchAsyncTask4 extends AsyncTask<byte[], IEsptouchResult, List<IEsptouchResult>> {
        private WeakReference<AddDeviceActivity> mActivity;
        private final Object mLock = new Object();


        EsptouchAsyncTask4(AddDeviceActivity activity) {
            mActivity = new WeakReference<>(activity);
        }

        public void cancelEsptouch() {
            cancel(true);
            if (mEsptouchTask != null) {
                mEsptouchTask.interrupt();
            }
        }

        @Override
        protected void onPreExecute() {
            addDeviceFragment = (AddDeviceFragment) getSupportFragmentManager().getFragments().get(0);
            addDeviceFragment.beginCounter();
        }

        @Override
        protected void onProgressUpdate(IEsptouchResult... values) {
            Context context = mActivity.get();
            if (context != null) {
                IEsptouchResult result = values[0];
                Log.i(TAG, "EspTouchResult: " + result);
                String text = result.getBssid() + " is connected to the wifi";
                Toast.makeText(context, text, Toast.LENGTH_SHORT).show();
            }
        }

        @Override
        protected List<IEsptouchResult> doInBackground(byte[]... params) {
            AddDeviceActivity activity = mActivity.get();
            int taskResultCount;
            synchronized (mLock) {
                byte[] apSsid = params[0];
                byte[] apBssid = params[1];
                byte[] apPassword = params[2];
                byte[] deviceCountData = params[3];
                byte[] broadcastData = params[4];
                taskResultCount = deviceCountData.length == 0 ? -1 : Integer.parseInt(new String(deviceCountData));
                Context context = activity.getApplicationContext();
                mEsptouchTask = new EsptouchTask(apSsid, apBssid, apPassword, context);
                mEsptouchTask.setPackageBroadcast(broadcastData[0] == 1);
                mEsptouchTask.setEsptouchListener(this::publishProgress);
            }
            return mEsptouchTask.executeForResults(taskResultCount);
        }

        @Override
        protected void onPostExecute(List<IEsptouchResult> result) {
            AddDeviceActivity activity = mActivity.get();
            activity.mTask = null;
            if (result == null) {
                addDeviceFragment.showMessage("建立 EspTouch 任务失败, 端口可能被其他程序占用",false);
                addDeviceFragment.cancleCounter();
                return;
            }

            // check whether the task is cancelled and no results received
            IEsptouchResult firstResult = result.get(0);
            if (firstResult.isCancelled()) {
                return;
            }

            if (!firstResult.isSuc()) {
                addDeviceFragment.showMessage("配网失败",false);
                addDeviceFragment.cancleCounter();
                return;
            }

            String message="";
            for (IEsptouchResult touchResult : result) {
                message += "BSSID: "+touchResult.getBssid()+"\n 地址: "+touchResult.getInetAddress().getHostAddress()+"\n";
            }

            addDeviceFragment.completeCounter();
            addDeviceFragment.showMessage("完成配网\n"+message,true);
        }
    }

    // end esptouch ----------------------------------------

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mWifiManager = (WifiManager) getApplicationContext().getSystemService(WIFI_SERVICE);
        mViewModel = new EspTouchViewModel();


    }

    @Override
    protected boolean isSupportSlideBack() {
        return true;
    }

    @Override
    protected void initStatusBarStyle() {
        StatusBarUtils.initStatusBarStyle(this, false, Colors.WHITE);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return KeyboardUtils.onDisableBackKeyDown(keyCode) && super.onKeyDown(keyCode, event);
    }


}
