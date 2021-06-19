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

import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.CompoundButton;
import android.widget.FrameLayout;
import android.widget.Spinner;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.entity.DictData;
import com.kerwin.wumei.entity.IotDeviceStatus;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.NoDataApiResult;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.rxutil2.rxjava.RxJavaUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.callback.SimpleCallBack;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.utils.WidgetUtils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.button.switchbutton.SwitchButton;
import com.xuexiang.xui.widget.dialog.MiniLoadingDialog;
import com.xuexiang.xui.widget.picker.XSeekBar;
import com.xuexiang.xui.widget.textview.supertextview.SuperButton;
import com.xuexiang.xutil.net.JsonUtil;

import java.util.ArrayList;
import java.util.List;
import butterknife.BindView;
import butterknife.OnClick;

import static android.R.layout.simple_spinner_item;
import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;

@Page(name = "编辑设备状态")
public class DeviceStatusFragment extends BaseFragment implements CompoundButton.OnCheckedChangeListener {

    @BindView(R.id.sb_relay)
    SwitchButton sb_relay;
    @BindView(R.id.sb_light)
    SwitchButton sb_light;
    @BindView(R.id.spinner_light_mode)
    Spinner spinner_light_mode;
    @BindView(R.id.xsb_fade_interval)
    XSeekBar xsb_fade_interval;
    @BindView(R.id.xsb_fade_time)
    XSeekBar xsb_fade_time;
    @BindView(R.id.xsb_brightness)
    XSeekBar xsb_brightness;
    @BindView(R.id.xsb_red)
    XSeekBar xsb_red;
    @BindView(R.id.xsb_green)
    XSeekBar xsb_green;
    @BindView(R.id.xsb_blue)
    XSeekBar xsb_blue;
    @BindView(R.id.sp_temperature)
    SuperButton sp_temperature;
    @BindView(R.id.sp_humidity)
    SuperButton sp_humidity;
    @BindView(R.id.frame_layout_loading_status)
    FrameLayout frame_layout_loading_status;

    private Long deviceId=0L;
    private String deviceNum="";
    private List<DictData> lightModeList;
    private String[] lightModeStrings;

    public DeviceStatusFragment(Long device_id,String device_num){
        deviceId=device_id;
        deviceNum=device_num;
    }

    /**
     * @return 返回为 null意为不需要导航栏
     */
    @Override
    protected TitleBar initTitle() {
        return null;
    }

    /**
     * 布局的资源id
     *
     * @return
     */
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_device_status;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        getLightModeDic();

    }

    /**
     * 初始化监听
     */
    @Override
    protected void initListeners() {

    }

    @Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
        XToastUtils.toast("isChecked：" + isChecked);
    }

    @SingleClick
    @OnClick({ R.id.btn_apply_status,R.id.btn_cancle_status,R.id.frame_layout_loading_status})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btn_apply_status:
                updateDeviceStatus(buildDeviceStatus());
                break;
            case R.id.btn_cancle_status:
                popToBack();
                break;
            case R.id.frame_layout_loading_status:
                getNewStatusData();
                frame_layout_loading_status.setVisibility(View.INVISIBLE);
                break;
            default:
                break;
        }
    }

    /**
     * 构建设备状态数据
     */
    private IotDeviceStatus buildDeviceStatus(){
        IotDeviceStatus deviceStatus=new IotDeviceStatus();
        deviceStatus.setDeviceId(deviceId);
        deviceStatus.setDeviceNum(deviceNum);
        deviceStatus.setRelayStatus(sb_relay.isChecked()==true?1:0);
        deviceStatus.setLightStatus(sb_light.isChecked()==true?1:0);
        deviceStatus.setLightMode(getValueByDicString(spinner_light_mode.getSelectedItem().toString()));
        deviceStatus.setLightInterval(xsb_fade_interval.getSelectedNumber());
        deviceStatus.setFadeTime(xsb_fade_time.getSelectedNumber());
        deviceStatus.setBrightness(xsb_brightness.getSelectedNumber());
        deviceStatus.setRed(xsb_red.getSelectedNumber());
        deviceStatus.setBlue(xsb_blue.getSelectedNumber());
        deviceStatus.setGreen(xsb_green.getSelectedNumber());
        deviceStatus.setTriggerSource(1); //0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时
        return deviceStatus;
    }

    /**
     * 根据字典标签获取字典值
     */
    private int getValueByDicString(String label){
        for(DictData dict:lightModeList){
            if(dict.getDictLabel().equals(label)){
                return dict.getDictValue();
            }
        }
        return 0;
    }

    /**
     * 根据字典值获取索引
     */
    private int getIndexByDicValue(int value){
        for(int i=0;i<lightModeList.size();i++)
        {
            if(lightModeList.get(i).getDictValue()==value){
                return i;
            }
        }
        return 0;
    }

    /**
     * HTTP获取最新设备信息
     */
    private void getNewStatusData(){
        XHttp.get("/prod-api/system/status/getStatus/"+deviceNum)
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String response) {
                        getDeviceStatus(deviceId);
                    }
                    @Override
                    public void onError(ApiException e) {
                        if(e.getCode()==401){
                            XToastUtils.info("匿名登录状态，功能受限");
                            clearToken();
                        }else{
                            XToastUtils.error(e.getMessage());
                        }
                    }
                }){});
    }

    /**
     * HTTP获取灯模式字典列表
     */
    private void getLightModeDic(){
        XHttp.get("/prod-api/system/dict/data/type/light_mode")
            .headers("Authorization","Bearer "+getToken())
            .execute(new SimpleCallBack<List<DictData>>() {
                @Override
                public void onSuccess(List<DictData> list) {
                    lightModeList=list;
                    lightModeStrings=new String[lightModeList.size()];
                    for (int i=0;i<lightModeList.size();i++) {
                        lightModeStrings[i]=lightModeList.get(i).getDictLabel();
                    }
                    WidgetUtils.initSpinnerStyle(spinner_light_mode, lightModeStrings);
                    //获取设备状态
                    getDeviceStatus(deviceId);
                }
                @Override
                public void onError(ApiException e) {

                }

            });
    }

    /**
     * HTTP获取设备状态
     */
    private void getDeviceStatus(Long device_id){
        XHttp.get("/prod-api/system/status/new/"+device_id)
            .headers("Authorization","Bearer "+getToken())
                .execute(new SimpleCallBack<IotDeviceStatus>() {
                @Override
                public void onSuccess(IotDeviceStatus status) throws Throwable {
                    //绑定数据
                    Log.d("device num:",status.getDeviceNum());
                    sb_relay.setChecked(status.getRelayStatus()==1);
                    sb_light.setChecked(status.getLightStatus()==1);
                    xsb_fade_interval.setDefaultValue(status.getLightInterval());
                    xsb_fade_time.setDefaultValue(status.getFadeTime());
                    xsb_red.setDefaultValue(status.getRed());
                    xsb_green.setDefaultValue(status.getGreen());
                    xsb_blue.setDefaultValue(status.getBlue());
                    xsb_blue.setDefaultValue(status.getBrightness());
                    sp_temperature.setText(status.getAirTemperature()+"℃");
                    sp_humidity.setText(status.getAirHumidity()+"RH%");
                    spinner_light_mode.setSelection(getIndexByDicValue(status.getLightMode()));
                    frame_layout_loading_status.setVisibility(View.VISIBLE);
                }
                @Override
                public void onError(ApiException e) {
                    if(e.getCode()==401){
                        XToastUtils.info("匿名登录状态，功能受限");
                        clearToken();
                    }else{
                        XToastUtils.error(e.getMessage());
                    }
                }
            });
    }

    /**
     * HTTP更新设备状态
     */
    private void updateDeviceStatus(IotDeviceStatus deviceStatus){
        if(!hasToken()) return;
        XHttp.put("/prod-api/system/status")
            .upJson(JsonUtil.toJson(deviceStatus))
            .headers("Authorization","Bearer "+getToken())
            .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                @Override
                public void onSuccess(String response) throws Throwable {
                    Log.d("response:",response);
                    XToastUtils.success("设备状态更新成功");
                }
                @Override
                public void onError(ApiException e) {
                    if(e.getCode()==401){
                        XToastUtils.info("匿名登录状态，功能受限");
                        clearToken();
                    }else{
                        XToastUtils.error(e.getMessage());
                    }

                }
            }){});
    }
}
