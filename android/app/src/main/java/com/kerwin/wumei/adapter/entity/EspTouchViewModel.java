package com.kerwin.wumei.adapter.entity;

import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.xuexiang.xui.widget.picker.XSeekBar;
import com.xuexiang.xui.widget.spinner.materialspinner.MaterialSpinner;

public class EspTouchViewModel {
    public MaterialSpinner ssidSpinner;
    public EditText apPasswordEdit;
    public XSeekBar xsbDeviceCount;
    public RadioGroup packageModeGroup;
    public TextView messageView;
    public Button confirmBtn;

    public String ssid;
    public byte[] ssidBytes;
    public String bssid;

    public CharSequence message;

    public boolean confirmEnable;

    public void invalidateAll() {
        ssidSpinner.setText(ssid);
        messageView.setText(message);
        confirmBtn.setEnabled(confirmEnable);
    }
}