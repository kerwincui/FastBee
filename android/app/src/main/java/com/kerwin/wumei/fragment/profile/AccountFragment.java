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
package com.kerwin.wumei.fragment.profile;

import android.graphics.Color;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.entity.User;
import com.kerwin.wumei.entity.bo.CaptureImage;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.CaptchaImageApiResult;
import com.kerwin.wumei.http.request.UserInfoApiResult;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.utils.ResUtils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.button.switchbutton.SwitchButton;
import com.xuexiang.xui.widget.edittext.materialedittext.MaterialEditText;
import com.xuexiang.xui.widget.imageview.RadiusImageView;
import com.xuexiang.xui.widget.textview.supertextview.SuperButton;

import butterknife.BindView;
import butterknife.OnClick;

import static com.kerwin.wumei.utils.SettingUtils.getIsHttps;
import static com.kerwin.wumei.utils.SettingUtils.getServerPort;
import static com.kerwin.wumei.utils.SettingUtils.getServerip;
import static com.kerwin.wumei.utils.SettingUtils.setServeUrl;
import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;


@Page(name = "账户信息")
public class AccountFragment extends BaseFragment {
    @BindView(R.id.titlebar_min)
    TitleBar titleBarMin;

    @BindView(R.id.txt_user_name)
    TextView txt_user_name;
    @BindView(R.id.txt_nick_name)
    TextView txt_nick_name;
    @BindView(R.id.txt_email)
    TextView txt_email;
    @BindView(R.id.txt_phone_num)
    TextView txt_phone_num;
    @BindView(R.id.txt_create_time)
    TextView txt_create_time;
    @BindView(R.id.txt_remark)
    TextView txt_remark;

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
        return R.layout.fragment_account;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        titleBarMin.setLeftClickListener(v -> popToBack());
        getUserInfo();
    }

    @Override
    protected void initListeners() { }

    @SingleClick
    @OnClick({ R.id.btn_confirm})
    public void onViewClicked(View view) {
        popToBack();
    }

    /**
     * HTTP获取用户信息
     */
    private void getUserInfo(){
        if(!hasToken()) return;
        XHttp.get("/prod-api/getInfo")
            .headers("Authorization","Bearer "+getToken())
            .execute(new CallBackProxy<UserInfoApiResult<User>, User>(new TipRequestCallBack<User>() {
                @Override
                public void onSuccess(User user) throws Throwable {
                    txt_user_name.setText(user.getUserName());
                    txt_nick_name.setText(user.getNickName());
                    txt_email.setText(user.getEmail());
                    txt_phone_num.setText(user.getPhonenumber());
                    txt_remark.setText(user.getRemark());
                    txt_create_time.setText(user.getCreateTime());
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
