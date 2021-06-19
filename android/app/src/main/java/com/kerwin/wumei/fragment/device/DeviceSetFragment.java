/***************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ***************************************************************************/
package com.kerwin.wumei.fragment.device;

import android.util.Log;
import android.view.View;
import android.widget.Spinner;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.entity.DictData;
import com.kerwin.wumei.entity.IotDevice;
import com.kerwin.wumei.entity.IotDeviceSet;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.ListApiResult;
import com.kerwin.wumei.http.request.NoDataApiResult;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.callback.SimpleCallBack;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.utils.WidgetUtils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.button.switchbutton.SwitchButton;
import com.xuexiang.xui.widget.picker.XSeekBar;
import com.xuexiang.xutil.net.JsonUtil;
import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;

import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;

@Page(name = "编辑设备配置")
public class DeviceSetFragment extends BaseFragment {

    @BindView(R.id.sb_radar)
    SwitchButton sb_radar;
    @BindView(R.id.sb_alarm)
    SwitchButton sb_alarm;
    @BindView(R.id.sb_rf_control)
    SwitchButton sb_rf_control;
    @BindView(R.id.sb_rf_learn)
    SwitchButton sb_rf_learn;
    @BindView(R.id.sb_rf_clear)
    SwitchButton sb_rf_clear;
    @BindView(R.id.sb_reset)
    SwitchButton sb_reset;
    @BindView(R.id.sb_open_ap)
    SwitchButton sb_open_ap;

    @BindView(R.id.spinner_rf_func_one)
    Spinner spinner_rf_func_one;
    @BindView(R.id.spinner_rf_func_two)
    Spinner spinner_rf_func_two;
    @BindView(R.id.spinner_rf_func_three)
    Spinner spinner_rf_func_three;
    @BindView(R.id.spinner_rf_func_four)
    Spinner spinner_rf_func_four;

    @BindView(R.id.xsb_radar_interval)
    XSeekBar xsb_radar_interval;

    private Long deviceId=0L;
    private String deviceNum="";
    private List<DictData> rfFunctionList;
    private String[] rfFunctionStrings;

    public DeviceSetFragment(Long device_id,String device_num){
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
        return R.layout.fragment_device_set;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        getRFFunctionDic();

    }

    @SingleClick
    @OnClick({ R.id.btn_apply_set,R.id.btn_cancle_set})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btn_apply_set:
                updateDeviceSet(buildDeviceSet());
                break;
            case R.id.btn_cancle_set:
                popToBack();
            default:
                break;
        }
    }

    /**
     * 构建设备配置数据
     */
    private IotDeviceSet buildDeviceSet(){
        IotDeviceSet deviceSet=new IotDeviceSet();
        deviceSet.setDeviceId(deviceId);
        deviceSet.setDeviceNum(deviceNum);
        deviceSet.setIsHost(0); //不托管
        deviceSet.setIsRadar(sb_radar.isChecked()==true?1:0);
        deviceSet.setIsAlarm(sb_alarm.isChecked()==true?1:0);
        deviceSet.setIsRfLearn(sb_rf_learn.isChecked()==true?1:0);
        deviceSet.setIsRfClear(sb_rf_clear.isChecked()==true?1:0);
        deviceSet.setIsAp(sb_open_ap.isChecked()==true?1:0);
        deviceSet.setIsReset(sb_reset.isChecked()==true?1:0);
        deviceSet.setIsRfControl(sb_rf_control.isChecked()==true?1:0);
        deviceSet.setRadarInterval(xsb_radar_interval.getSelectedNumber());
        deviceSet.setRfOneFunc(getValueByDicString(spinner_rf_func_one.getSelectedItem().toString()));
        deviceSet.setRfTwoFunc(getValueByDicString(spinner_rf_func_two.getSelectedItem().toString()));
        deviceSet.setRfThreeFunc(getValueByDicString(spinner_rf_func_three.getSelectedItem().toString()));
        deviceSet.setRfFourFunc(getValueByDicString(spinner_rf_func_four.getSelectedItem().toString()));
        return deviceSet;
    }

    /**
     * 根据字典标签获取字典值
     * @param label
     * @return
     */
    private int getValueByDicString(String label){
        for(DictData dict:rfFunctionList){
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
        for(int i=0;i<rfFunctionList.size();i++)
        {
            if(rfFunctionList.get(i).getDictValue()==value){
                return i;
            }
        }
        return 0;
    }

    /**
     * HTTP获取遥控按键功能字典列表
     */
    private void getRFFunctionDic(){
        XHttp.get("/prod-api/system/dict/data/type/rf_function")
            .headers("Authorization","Bearer "+getToken())
            .execute(new SimpleCallBack<List<DictData>>() {
                @Override
                public void onSuccess(List<DictData> list) {
                    //绑定数据
                    rfFunctionList=list;
                    rfFunctionStrings=new String[rfFunctionList.size()];
                    for(int i=0;i<rfFunctionList.size();i++){
                        rfFunctionStrings[i]=rfFunctionList.get(i).getDictLabel();
                    }
                    WidgetUtils.initSpinnerStyle(spinner_rf_func_one, rfFunctionStrings);
                    WidgetUtils.initSpinnerStyle(spinner_rf_func_two, rfFunctionStrings);
                    WidgetUtils.initSpinnerStyle(spinner_rf_func_three, rfFunctionStrings);
                    WidgetUtils.initSpinnerStyle(spinner_rf_func_four, rfFunctionStrings);
                    //获取设备配置
                    getDeviceSet(deviceId);
                }
                @Override
                public void onError(ApiException e) {

                }

            });
    }

    /**
     * HTTP获取设备配置
     */
    private void getDeviceSet(Long device_id){
        XHttp.get("/prod-api/system/set/new/"+device_id)
            .headers("Authorization","Bearer "+getToken())
                .execute(new SimpleCallBack<IotDeviceSet>() {
                @Override
                public void onSuccess(IotDeviceSet set) throws Throwable {
                    //绑定数据
                    Log.d("device num:",set.getDeviceNum());
                    sb_radar.setChecked(set.getIsRadar()==1);
                    sb_alarm.setChecked(set.getIsAlarm()==1);
                    sb_rf_control.setChecked(set.getIsRfControl()==1);
                    xsb_radar_interval.setDefaultValue(set.getRadarInterval());
                    spinner_rf_func_one.setSelection(getIndexByDicValue(set.getRfOneFunc()));
                    spinner_rf_func_two.setSelection(getIndexByDicValue(set.getRfTwoFunc()));
                    spinner_rf_func_three.setSelection(getIndexByDicValue(set.getRfThreeFunc()));
                    spinner_rf_func_four.setSelection(getIndexByDicValue(set.getRfFourFunc()));
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
     * HTTP更新设备配置
     */
    private void updateDeviceSet(IotDeviceSet deviceSet){
        if(!hasToken()) return;
        XHttp.put("/prod-api/system/set")
            .upJson(JsonUtil.toJson(deviceSet))
            .headers("Authorization","Bearer "+getToken())
            .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                @Override
                public void onSuccess(String response) throws Throwable {
                    Log.d("response:",response);
                    XToastUtils.success("设备配置更新成功");
                    sb_reset.setChecked(false);
                    sb_open_ap.setChecked(false);
                    sb_rf_clear.setChecked(false);
                    sb_rf_learn.setChecked(false);
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
