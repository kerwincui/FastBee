/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
package com.kerwin.wumei.fragment.device;

import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.entity.DictData;
import com.kerwin.wumei.entity.IotDevice;
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
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.edittext.materialedittext.MaterialEditText;
import com.xuexiang.xui.widget.textview.supertextview.SuperButton;
import com.xuexiang.xui.widget.toast.XToast;
import com.xuexiang.xutil.net.JsonUtil;

import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;

import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;

@Page(name = "编辑设备")
public class DeviceEditFragment extends BaseFragment {

    @BindView(R.id.et_device_name)
    MaterialEditText et_device_name;
    @BindView(R.id.et_device_remark)
    MaterialEditText et_device_remark;
    @BindView(R.id.txt_device_num)
    TextView txt_device_num;
    @BindView(R.id.txt_device_category)
    TextView txt_device_category;
    @BindView(R.id.txt_firmware_version)
    TextView txt_firmware_version;
    @BindView(R.id.txt_create_time)
    TextView txt_create_time;
    @BindView(R.id.sp_device_temperature)
    SuperButton sp_device_temperature;
    @BindView(R.id.update_device_temp_icon)
    AppCompatImageView update_temp_icon;
    @BindView(R.id.sp_upgrade)
    SuperButton sp_upgrade;

    private Long deviceId=0L;
    private String deviceNum="";

    public DeviceEditFragment(Long device_id,String device_num){
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
        return R.layout.fragment_device_edit;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        getDevice(deviceId);
    }

    @SingleClick
    @OnClick({ R.id.btn_save,R.id.btn_cancle_edit,R.id.update_device_temp_icon,R.id.sp_upgrade})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btn_save:
                updateDevice(buildDevice());
                break;
            case R.id.btn_cancle_edit:
                popToBack();
                break;
            case R.id.update_device_temp_icon:
                getNewStatusData();
                update_temp_icon.setVisibility(View.GONE);
                break;
            case R.id.sp_upgrade:
                XToastUtils.success("固件已经是最新版本");
            default:
                break;
        }
    }


    /**
     * 构建设备数据
     */
    private IotDevice buildDevice(){
        IotDevice device=new IotDevice();
        device.setDeviceId(deviceId);
        device.setDeviceNum((String) txt_device_num.getText());
        device.setDeviceName(et_device_name.getEditValue());
        device.setRemark(et_device_remark.getEditValue());
        return device;
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
     * HTTP获取设备状态
     */
    private void getDeviceStatus(Long device_id){
        XHttp.get("/prod-api/system/status/new/"+device_id)
                .headers("Authorization","Bearer "+getToken())
                .execute(new SimpleCallBack<IotDeviceStatus>() {
                    @Override
                    public void onSuccess(IotDeviceStatus status) throws Throwable {
                        //更新温度
                        sp_device_temperature.setText(status.getDeviceTemperature()+"℃");
                        update_temp_icon.setVisibility(View.VISIBLE);
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
     * HTTP获取设备信息
     */
    private void getDevice(Long device_id){
        XHttp.get("/prod-api/system/device/"+device_id)
            .headers("Authorization","Bearer "+getToken())
            .execute(new SimpleCallBack<IotDevice>() {
                @Override
                public void onSuccess(IotDevice device) throws Throwable {
                    //绑定数据
                    Log.d("deviceName:",device.getDeviceName());
                    et_device_name.setText(device.getDeviceName());
                    et_device_remark.setText(device.getRemark());
                    txt_device_num.setText(device.getDeviceNum());
                    txt_device_category.setText(device.getCategoryName());
                    txt_firmware_version.setText("v"+device.getFirmwareVersion());
                    txt_create_time.setText(device.getCreateTime());
                    sp_device_temperature.setText(device.getDeviceTemp()+"℃");
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
     * HTTP更新设备信息
     */
    private void updateDevice(IotDevice device){
        if(!hasToken()) return;
        XHttp.put("/prod-api/system/device")
            .upJson(JsonUtil.toJson(device))
            .headers("Authorization","Bearer "+getToken())
            .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                @Override
                public void onSuccess(String response) throws Throwable {
                    Log.d("response:",response);
                    XToastUtils.success("数据保存成功");
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
