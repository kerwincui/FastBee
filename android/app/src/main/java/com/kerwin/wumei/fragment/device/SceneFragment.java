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
import android.util.Log;
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
import static com.kerwin.wumei.utils.SettingUtils.getServerAddress;
import static com.kerwin.wumei.utils.SettingUtils.getServerPath;
import static com.kerwin.wumei.utils.SettingUtils.setAccount;
import static com.kerwin.wumei.utils.SettingUtils.setApIp;
import static com.kerwin.wumei.utils.SettingUtils.setServeAddress;
import static com.kerwin.wumei.utils.SettingUtils.setServePath;
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
    MaterialEditText et_serve_address;
    @BindView(R.id.et_path)
    MaterialEditText et_serve_path;
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
        et_serve_address.setText(getServerAddress());
        et_serve_path.setText(getServerPath());
        et_ap_address.setText(getApIp());
    }

    @Override
    protected void initListeners() { }

    @SingleClick
    @OnClick({ R.id.btn_save_serve,R.id.btn_connect_test,R.id.btn_open_ap})
    public void onViewClicked(View view) {
        if(et_serve_address.getEditValue().length()==0)
        {
            showMessage("接口地址不能为空",false);
            return;
        }

        switch (view.getId()) {
            case R.id.btn_save_serve:
                setServeAddress(et_serve_address.getEditValue());
                setServePath(et_serve_path.getEditValue());
                clearToken();
                setAccount("","");
                showMessage("服务端地址信息存储成功，请重新启动APP！",true);
                break;
            case R.id.btn_connect_test:
                    getCatpureImage();
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



    /**
     * HTTP获取验证码(用于连接测试)
     */
    private void getCatpureImage(){
        String address=et_serve_address.getEditValue();
        String path=et_serve_path.getEditValue();
        if(path==null || path.length()==0){
            Log.d("地址", address.substring(address.length()-1));
            if(address.substring(address.length()-1).equals("/")){
                address=address.substring(0,address.length()-1);
            }
        }
        String fullPath=address+path;
        XHttp.get(fullPath+ "/captchaImage")
                .execute(new CallBackProxy<CaptchaImageApiResult<CaptureImage>, CaptureImage>(new TipRequestCallBack<CaptureImage>() {
                    @Override
                    public void onSuccess(CaptureImage image) throws Throwable {
                        String uuid=image.getUuid();
                        showMessage("服务端连接成功",true);
                    }
                    @Override
                    public void onError(ApiException e) {
                        showMessage("服务端连接失败\n"+"地址:"+et_serve_address.getEditValue()+et_serve_path.getEditValue()+"\n错误提示："+e.getMessage(),false);
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
