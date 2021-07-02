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

import android.graphics.Color;
import android.view.View;
import android.widget.TextView;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.core.webview.AgentWebActivity;
import com.kerwin.wumei.entity.bo.CaptureImage;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.CaptchaImageApiResult;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.button.switchbutton.SwitchButton;
import com.xuexiang.xui.widget.edittext.materialedittext.MaterialEditText;
import com.xuexiang.xui.widget.textview.supertextview.SuperButton;

import butterknife.BindView;
import butterknife.OnClick;

import static com.kerwin.wumei.utils.SettingUtils.getApIp;
import static com.kerwin.wumei.utils.SettingUtils.getIsHttps;
import static com.kerwin.wumei.utils.SettingUtils.getServeUrl;
import static com.kerwin.wumei.utils.SettingUtils.getServerPort;
import static com.kerwin.wumei.utils.SettingUtils.getServerip;
import static com.kerwin.wumei.utils.SettingUtils.setAccount;
import static com.kerwin.wumei.utils.SettingUtils.setApIp;
import static com.kerwin.wumei.utils.SettingUtils.setServeUrl;
import static com.kerwin.wumei.utils.TokenUtils.clearToken;


@Page(name = "用户信息")
public class SceneFragment extends BaseFragment {

    @BindView(R.id.btn_connect_test)
    SuperButton btn_connect_test;
    @BindView(R.id.btn_save_serve)
    SuperButton btn_save_serve;
    @BindView(R.id.txt_message)
    TextView txt_message;
    @BindView(R.id.et_serve)
    MaterialEditText et_serve_ip;
    @BindView(R.id.et_port)
    MaterialEditText et_port;
    @BindView(R.id.sb_https)
    SwitchButton sb_https;
    @BindView(R.id.et_ap_address)
    MaterialEditText et_ap_address;

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
        return R.layout.fragment_scene;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        et_serve_ip.setText(getServerip());
        et_port.setText(getServerPort());
        sb_https.setChecked(getIsHttps());
        et_ap_address.setText(getApIp());
    }

    @Override
    protected void initListeners() { }

    @SingleClick
    @OnClick({ R.id.btn_save_serve,R.id.btn_connect_test,R.id.btn_open_ap})
    public void onViewClicked(View view) {
        if(!et_port.validate()) return;
        if(et_serve_ip.getEditValue().length()==0)
        {
            showMessage("服务端地址不能为空",false);
            return;
        }

        switch (view.getId()) {
            case R.id.btn_save_serve:
                setServeUrl(et_serve_ip.getEditValue(),et_port.getEditValue(),sb_https.isChecked());
                clearToken();
                setAccount("","");
                showMessage("服务端地址信息存储成功，请重新启动APP！",true);
                break;
            case R.id.btn_connect_test:
                if(et_serve_ip.getEditValue().length()==0 ||et_port.getEditValue().length()==0) {
                    showMessage("地址和端口不能为空",false);
                }else {
                    getCatpureImage();
                }
                break;
            case R.id.btn_open_ap:
                if(et_ap_address.getEditValue()==null || et_ap_address.getEditValue().length()==0){
                    XToastUtils.error("AP的地址不能为空");
                }else {
                    AgentWebActivity.goWeb(getContext(), et_ap_address.getEditValue());
                    setApIp(et_ap_address.getEditValue());
                }
            default:
                break;
        }
    }

    private String buildServeString(){
        String address="http://";
        if(sb_https.isChecked()){
            address="https://";
        }
        return address+et_serve_ip.getEditValue()+":"+et_port.getEditValue();
    }


    /**
     * HTTP获取验证码(用于连接测试)
     */
    private void getCatpureImage(){
        XHttp.get(buildServeString() + "/prod-api/captchaImage")
                .execute(new CallBackProxy<CaptchaImageApiResult<CaptureImage>, CaptureImage>(new TipRequestCallBack<CaptureImage>() {
                    @Override
                    public void onSuccess(CaptureImage image) throws Throwable {
                        String uuid=image.getUuid();
                        showMessage("服务端连接成功",true);
                    }
                    @Override
                    public void onError(ApiException e) {
                        showMessage("服务端连接失败\n"+"连接地址:"+buildServeString()+"\n错误提示："+e.getMessage(),false);
                    }
                }){});
    }

    /**
     * 显示提示
     * @param message
     * @param isSuccess
     */
    private void showMessage(String message,boolean isSuccess){
        if(isSuccess){
            txt_message.setTextColor(Color.argb(255, 103, 194, 58));  // 绿色
        }else{
            txt_message.setTextColor(Color.argb(255, 245, 108, 108));  //红色
        }
        txt_message.setText(message);
        txt_message.setVisibility(View.VISIBLE);
    }

}
