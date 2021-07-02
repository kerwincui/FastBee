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

package com.kerwin.wumei.fragment;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import com.kerwin.wumei.activity.LoginActivity;
import com.kerwin.wumei.activity.MainActivity;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.R;
import com.kerwin.wumei.entity.IotGroup;
import com.kerwin.wumei.entity.bo.CaptureImage;
import com.kerwin.wumei.entity.User;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.CaptchaImageApiResult;
import com.kerwin.wumei.http.request.ListApiResult;
import com.kerwin.wumei.http.request.TokenApiResult;
import com.kerwin.wumei.http.request.UserInfoApiResult;
import com.kerwin.wumei.utils.MMKVUtils;
import com.kerwin.wumei.utils.SettingUtils;
import com.kerwin.wumei.utils.TokenUtils;
import com.kerwin.wumei.utils.Utils;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.utils.ResUtils;
import com.xuexiang.xui.utils.ThemeUtils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.button.roundbutton.RoundButton;
import com.xuexiang.xui.widget.edittext.materialedittext.MaterialEditText;
import com.xuexiang.xutil.app.ActivityUtils;

import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;

import static com.kerwin.wumei.utils.SettingUtils.getServeUrl;
import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;


/**
 * 登录页面
 *
 * @author xuexiang
 * @since 2019-11-17 22:15
 */
@Page(anim = CoreAnim.none)
public class LoginFragment extends BaseFragment {

    @BindView(R.id.et_phone_number)
    MaterialEditText etPhoneNumber;
    @BindView(R.id.et_password)
    MaterialEditText etPassword;
    @BindView(R.id.et_verify_code)
    MaterialEditText etVerifyCode;
    @BindView(R.id.iv_code)
    ImageView imgVertifyCode;
    @BindView(R.id.btn_clear)
    RoundButton btnClear;

    private String uuid="";
    private String token="";

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_login;
    }

    @Override
    protected TitleBar initTitle() {
        TitleBar titleBar = super.initTitle()
                .setImmersive(true);
        titleBar.setBackgroundColor(Color.TRANSPARENT);
        titleBar.setTitle("");
        titleBar.setLeftImageDrawable(ResUtils.getVectorDrawable(getContext(), R.drawable.ic_login_close));
        titleBar.setActionTextColor(ThemeUtils.resolveColor(getContext(), R.attr.colorAccent));
        titleBar.addAction(new TitleBar.TextAction(R.string.title_jump_login) {
            @Override
            public void performAction(View view) {
                clearToken();
                onLoginSuccess();
            }
        });
        return titleBar;
    }

    @Override
    protected void initViews() {
        //隐私政策弹窗
//        if (!SettingUtils.isAgreePrivacy()) {
//            Utils.showPrivacyDialog(getContext(), (dialog, which) -> {
//                dialog.dismiss();
//                SettingUtils.setIsAgreePrivacy(true);
//            });
//        }
        getCatpureImage();
        getLocalAccount();
    }

    @SingleClick
    @OnClick({ R.id.btn_login,R.id.iv_code,R.id.btn_clear})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.btn_clear:
                SettingUtils.clearPassword();
                etPassword.clear();
                break;
            case R.id.iv_code:
                getCatpureImage();
                break;
            case R.id.btn_login:
                    if(etPhoneNumber.getEditValue().length()==0 || etPassword.getEditValue().length()==0 || etVerifyCode.getEditValue().length()==0){
                        XToastUtils.error("请正确填写账号、密码和验证码");
                    }else {
                        loginByVerifyCode(etPhoneNumber.getEditValue(), etPassword.getEditValue(), etVerifyCode.getEditValue());
                    }
                break;
            default:
                break;
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

    /**
     * 登录成功的处理
     */
    private void onLoginSuccess() {
        TokenUtils.handleLoginSuccess(token);
        popToBack();
        ActivityUtils.startActivity(MainActivity.class);
    }

    /**
     * 获取本地存储的账号
     */
    private void getLocalAccount(){
        etPhoneNumber.setText(SettingUtils.getUserName());
        etPassword.setText(SettingUtils.getPassword());
    }

    /**
     * HTTP获取验证码
     */
    private void getCatpureImage(){
        XHttp.get("/prod-api/captchaImage")
                .execute(new CallBackProxy<CaptchaImageApiResult<CaptureImage>, CaptureImage>(new TipRequestCallBack<CaptureImage>() {
                    @Override
                    public void onSuccess(CaptureImage image) throws Throwable {
                        uuid=image.getUuid();
                        byte[] decode = Base64.decode(image.getImg(), Base64.DEFAULT);
                        Bitmap bitmap = BitmapFactory.decodeByteArray(decode, 0, decode.length);
                        imgVertifyCode.setImageBitmap(bitmap);
                    }
                    @Override
                    public void onError(ApiException e) {
                        XToastUtils.error(e.getMessage());
                    }
                }){});
    }

    /**
     * HTTP登录
     *
     * @param phoneNumber 手机号
     * @param verifyCode  验证码
     */
    private void loginByVerifyCode(String phoneNumber,String password, String verifyCode) {
        XHttp.post("/prod-api/login")
                .upJson("{\"username\":\""+phoneNumber+"\",\"password\":\""+password+"\",\"code\":\""+verifyCode+"\",\"uuid\":\""+uuid+"\"}")
                .execute(new CallBackProxy<TokenApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String tokenResult) throws Throwable {
                        SettingUtils.setAccount(etPhoneNumber.getEditValue(),etPassword.getEditValue());
                        token=tokenResult;
                        onLoginSuccess();
                    }
                    @Override
                    public void onError(ApiException e) {
                        clearToken();
                        XToastUtils.error(e.getMessage());
                    }
                }){});
    }




}

