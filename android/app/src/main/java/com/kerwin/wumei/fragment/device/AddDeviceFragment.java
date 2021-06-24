/*****************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 *****************************************************************************/
package com.kerwin.wumei.fragment.device;

import android.Manifest;
import android.graphics.Color;
import android.os.Build;
import android.os.Handler;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.util.Log;
import android.view.View;
import android.widget.CheckBox;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.MyApp;
import com.kerwin.wumei.R;
import com.kerwin.wumei.activity.AddDeviceActivity;
import com.kerwin.wumei.adapter.entity.EspTouchViewModel;
import com.kerwin.wumei.core.BaseFragment;
import com.xuexiang.xpage.annotation.Page;
import com.king.view.circleprogressview.CircleProgressView;

import com.xuexiang.xui.widget.textview.supertextview.SuperButton;


import java.util.List;

import butterknife.BindView;

import static com.kerwin.wumei.utils.SettingUtils.getWifiPassword;
import static com.kerwin.wumei.utils.SettingUtils.setWifiPassword;


@Page(name = "智能配网")
public class AddDeviceFragment extends BaseFragment {
    @BindView(R.id.advance_frame_layout)
    FrameLayout advanceFrameLayout;
    @BindView(R.id.advance_linear_layout)
    LinearLayout advanceLinearLayout;
    @BindView(R.id.advance_icon)
    AppCompatImageView advanceIcon;
    @BindView(R.id.wifi_password_icon)
    AppCompatImageView wifiPasswordIcon;
//    @BindView(R.id.progressView_circle_main)
//    CircleProgressView progressViewCircleMain;
    @BindView(R.id.progress_text_main)
    TextView progressTextMain;
    @BindView(R.id.btn_config_cancle)
    SuperButton btnConfigCancle;
    @BindView(R.id.btn_return)
    SuperButton btnReturn;
    @BindView(R.id.chk_remeber)
    CheckBox chk_remeber;
    @BindView(R.id.circleProgressView)
    CircleProgressView circleProgressView;

    private static final String TAG = AddDeviceFragment.class.getSimpleName();
    private static final int REQUEST_PERMISSION = 0x01;
    private EspTouchViewModel mViewModel;

    private boolean bStart=false;

    private Handler mHander=new Handler();
    private int mCount=0;

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

        mViewModel.apPasswordEdit = findViewById(R.id.wifi_password_txt);
        mViewModel.apPasswordEdit.setText(getWifiPassword());

        mViewModel.ssidSpinner = findViewById(R.id.ssid_spinner);
        mViewModel.packageModeGroup = findViewById(R.id.packageModeGroup);
        mViewModel.messageView = findViewById(R.id.txt_config_message);
        mViewModel.messageView.setText("");

        mViewModel.xsbDeviceCount = findViewById(R.id.xsb_device_count);
        mViewModel.xsbDeviceCount.setDefaultValue(1);

        mViewModel.confirmBtn = findViewById(R.id.btn_begin);
        mViewModel.confirmBtn.setOnClickListener(v ->
        {

             ((AddDeviceActivity)this.getActivity()).executeEsptouch();

             //存储wifi密码
            if(chk_remeber.isChecked()){
                setWifiPassword(mViewModel.apPasswordEdit.getText().toString());
            }else{
                setWifiPassword("");
            }

//            PageOption.to(AddDeviceTwoFragment.class) //跳转的fragment
//                    .setAnim(CoreAnim.slide) //页面转场动画
//                    .setRequestCode(100) //请求码，用于返回结果
//                    .setAddToBackStack(true) //是否加入堆栈
//                    .putString("device_mac","0908070605040306")
//                    .open(this); //打开页面进行跳转
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

        btnConfigCancle.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                ((AddDeviceActivity)getActivity()).interruptEspTouchTask();
                cancleCounter();
            }
        });

        btnReturn.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                popToBack();
                cancleCounter();
            }
        });

    }

    @Override
    public void onDestroyView() {
        cancleCounter();
        super.onDestroyView();
    }

    /**
     * 打开计时器
     */
    public void beginCounter(){
        mViewModel.confirmBtn.setEnabled(false);
        btnConfigCancle.setEnabled(true);
        showMessage("配网中...",true);
        mHander.post(mCounter);

        //显示进度动画，进度，动画时长
        circleProgressView.showAnimation(100,3000);
        //设置进度改变监听
        circleProgressView.setOnChangeListener(new CircleProgressView.OnChangeListener() {
            @Override
            public void onProgressChanged(float progress, float max) {
                if(progress==100){
                    circleProgressView.setProgress(0);
                    circleProgressView.showAnimation(100);

                }
            }
        });
    }

    /**
     * 计时器完成
     */
    public void completeCounter(){
        mCount=0;
        mHander.removeCallbacks(mCounter);
        progressTextMain.setText("100");
        circleProgressView.setOnChangeListener(null);
        circleProgressView.showAppendAnimation(100);
    }

    /**
     * 关闭计时器
     */
    public void cancleCounter(){
        mViewModel.confirmBtn.setEnabled(true);
        btnConfigCancle.setEnabled(false);
        showMessage("",true);

        mCount=0;
        mHander.removeCallbacks(mCounter);
        progressTextMain.setText("0");
        circleProgressView.setOnChangeListener(null);
        circleProgressView.showAppendAnimation(0);
    }

    /**
     * 计时器
     */
    private Runnable mCounter=new Runnable() {
        @Override
        public void run() {
            int delay=300;
            if(mCount<30){
                mCount++;
            }else if(mCount<50){
                mCount++;
                delay=500;
            }else if(mCount<80){
                mCount++;
                delay=1000;
            }else if(mCount<90){
                mCount++;
                delay=3000;
            }else if(mCount<98){
                mCount++;
                delay=10000;
            }
            progressTextMain.setText(mCount + "");
            mHander.postDelayed(this, delay);
        }
    };

    /**
     * 消息提示
     * @param message
     * @param isSuccess
     */
    public void showMessage(String message,boolean isSuccess){
        if(isSuccess){
            mViewModel.messageView.setTextColor(Color.argb(255, 103, 194, 58));  // 绿色
        }else{
            mViewModel.messageView.setTextColor(Color.argb(255, 245, 108, 108));  //红色
        }
        mViewModel.messageView.setText(message);
        mViewModel.messageView.setVisibility(View.VISIBLE);
    }

}
