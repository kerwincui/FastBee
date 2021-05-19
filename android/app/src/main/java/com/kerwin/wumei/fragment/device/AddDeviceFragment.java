package com.kerwin.wumei.fragment.device;

import android.Manifest;
import android.os.Build;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.MyApp;
import com.kerwin.wumei.R;
import com.kerwin.wumei.activity.AddDeviceActivity;
import com.kerwin.wumei.activity.MainActivity;
import com.kerwin.wumei.adapter.entity.EspTouchViewModel;
import com.kerwin.wumei.core.BaseFragment;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.core.PageOption;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.widget.spinner.materialspinner.MaterialSpinner;

import java.util.List;

import butterknife.BindView;


@Page(name = "WIFI网络配置")
public class AddDeviceFragment extends BaseFragment {
    @BindView(R.id.advance_frame_layout)
    FrameLayout advanceFrameLayout;
    @BindView(R.id.advance_linear_layout)
    LinearLayout advanceLinearLayout;
    @BindView(R.id.advance_icon)
    AppCompatImageView advanceIcon;
    @BindView(R.id.wifi_password_icon)
    AppCompatImageView wifiPasswordIcon;

    private static final String TAG = AddDeviceFragment.class.getSimpleName();
    private static final int REQUEST_PERMISSION = 0x01;
    private EspTouchViewModel mViewModel;

    /**
     * 布局的资源id
     *
     * @return
     */
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_add_device;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {

        //智能配网
        mViewModel = ((AddDeviceActivity)this.getActivity()).GetMViewModel();
        mViewModel.ssidSpinner = findViewById(R.id.ssid_spinner);
        mViewModel.apPasswordEdit = findViewById(R.id.wifi_password_txt);
        mViewModel.packageModeGroup = findViewById(R.id.packageModeGroup);
        mViewModel.messageView = findViewById(R.id.messageView);
        mViewModel.confirmBtn = findViewById(R.id.add_device_next_btn);
        mViewModel.confirmBtn.setOnClickListener(v ->
        {
            // ((AddDeviceActivity)this.getActivity()).executeEsptouch();
            PageOption.to(AddDeviceTwoFragment.class) //跳转的fragment
                    .setAnim(CoreAnim.slide) //页面转场动画
                    .setRequestCode(100) //请求码，用于返回结果
                    .setAddToBackStack(true) //是否加入堆栈
                    .putString("device_mac","0908070605040306")
                    .open(this); //打开页面进行跳转
        });

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            String[] permissions = {Manifest.permission.ACCESS_FINE_LOCATION,Manifest.permission.ACCESS_COARSE_LOCATION};
            requestPermissions(permissions, REQUEST_PERMISSION);
        }

        MyApp.getInstance().observeBroadcast(this, broadcast -> {
            Log.d(TAG, "onCreate: Broadcast=" + broadcast);
            ((AddDeviceActivity)this.getActivity()).onWifiChanged();

            List<String> ssids=((AddDeviceActivity)this.getActivity()).GetSsids();
            if(ssids!=null && ssids.size()>0){
                Log.e(TAG, "进入数据绑定 " );
                mViewModel.ssidSpinner.setItems(ssids);
                // ssidSpinner.setOnItemSelectedListener((spinner, position, id, item) -> SnackbarUtils.Long(spinner, "Clicked " + item).show());
                // ssidSpinner.setOnNothingSelectedListener(spinner -> SnackbarUtils.Long(spinner, "Nothing selected").show());
                String ssid=((AddDeviceActivity)this.getActivity()).GetSelectedSSID();
                if(ssid!=null && ssid.length()>0 && ssids.contains(ssid)) {
                    mViewModel.ssidSpinner.setSelectedItem(ssid);
                }
            }
        });


    }

    @Override
    protected void initListeners() {
        //单击高级设置项
        advanceFrameLayout.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view) {
                int visible=advanceLinearLayout.getVisibility();
                if(visible!=0) {
                    advanceLinearLayout.setVisibility(View.VISIBLE);
                    advanceIcon.setImageDrawable(getResources().getDrawable((R.drawable.up)));
                }else{
                    advanceLinearLayout.setVisibility(View.GONE);
                    advanceIcon.setImageDrawable(getResources().getDrawable((R.drawable.down)));
                }
            }
        });

        //显示和隐藏密码
        wifiPasswordIcon.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                if(wifiPasswordIcon.getTag()==null) return;
                if(wifiPasswordIcon.getTag().toString().equals("show")){
                    wifiPasswordIcon.setImageDrawable(getResources().getDrawable((R.drawable.hide)));
                    wifiPasswordIcon.setTag("hide");
                    mViewModel.apPasswordEdit.setTransformationMethod(PasswordTransformationMethod.getInstance());
                }else{
                    wifiPasswordIcon.setImageDrawable(getResources().getDrawable((R.drawable.show)));
                    wifiPasswordIcon.setTag("show");
                    mViewModel.apPasswordEdit.setTransformationMethod(HideReturnsTransformationMethod.getInstance());
                }
            }
        });



    }

}
