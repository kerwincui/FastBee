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

import android.graphics.drawable.ColorDrawable;
import android.widget.TextView;

import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.R;
import com.kerwin.wumei.core.webview.AgentWebActivity;
import com.kerwin.wumei.fragment.AboutFragment;
import com.kerwin.wumei.fragment.FeedbackFragment;
import com.kerwin.wumei.fragment.MessageFragment;
import com.kerwin.wumei.fragment.SettingsFragment;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.NoDataApiResult;
import com.kerwin.wumei.utils.TokenUtils;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xpage.utils.Utils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.dialog.DialogLoader;
import com.xuexiang.xui.widget.grouplist.XUIGroupListView;
import com.xuexiang.xui.widget.imageview.RadiusImageView;
import com.xuexiang.xui.widget.textview.supertextview.SuperTextView;
import com.xuexiang.xutil.XUtil;
import com.xuexiang.xutil.app.AppUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import butterknife.BindView;

import static com.kerwin.wumei.utils.SettingUtils.getServerPort;
import static com.kerwin.wumei.utils.SettingUtils.getServerip;

@Page(anim = CoreAnim.none)
public class ProfileFragment extends BaseFragment implements SuperTextView.OnSuperTextViewClickListener {
    @BindView(R.id.riv_head_pic)
    RadiusImageView rivHeadPic;
    @BindView(R.id.menu_message)
    SuperTextView menuMessage;
    @BindView(R.id.menu_logout)
    SuperTextView menuLogout;
    @BindView(R.id.control_list)
    XUIGroupListView mControlGroupListView;
    @BindView(R.id.tv_copyright)
    TextView mCopyrightTextView;
    @BindView(R.id.menu_account)
    SuperTextView menuAccount;

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
        return R.layout.fragment_profile;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        if(getServerip()!=null && getServerip().length()>0){
            String address="http://"+getServerip();
            String control=address;
            String emqx=address+":18083";
            if(getServerPort()!=null && getServerPort().length()>0){
                control=address+":"+getServerPort();
            }

            String finalControl = control;
            String finalEmqx=emqx;
            XUIGroupListView.newSection(getContext())
                    .addItemView(mControlGroupListView.createItemView("打开管理控制台"), v -> AgentWebActivity.goWeb(getContext(), finalControl))
                    .addItemView(mControlGroupListView.createItemView("打开EMQX控制台"), v -> AgentWebActivity.goWeb(getContext(), finalEmqx))
                    .addItemView(mControlGroupListView.createItemView(getResources().getString(R.string.about_item_add_qq_group)), v -> AgentWebActivity.goWeb(getContext(), getString(R.string.url_add_qq_group)))
                    .addItemView(mControlGroupListView.createItemView("应用版本 - V" + AppUtils.getAppVersionName()), v -> XToastUtils.toast("官网下载最新版本"))
                    .addTo(mControlGroupListView);
        }else {
            XUIGroupListView.newSection(getContext())
                    .addItemView(mControlGroupListView.createItemView(getResources().getString(R.string.about_item_add_qq_group)), v -> AgentWebActivity.goWeb(getContext(), getString(R.string.url_add_qq_group)))
                    .addItemView(mControlGroupListView.createItemView("应用版本 - V" + AppUtils.getAppVersionName()), v -> XToastUtils.toast("官网下载最新版本"))
                    .addTo(mControlGroupListView);
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy", Locale.CHINA);
        String currentYear = dateFormat.format(new Date());
        mCopyrightTextView.setText(String.format(getResources().getString(R.string.about_copyright), currentYear));
    }

    @Override
    protected void initListeners() {
        menuMessage.setOnSuperTextViewClickListener(this);
        menuLogout.setOnSuperTextViewClickListener(this);
        menuAccount.setOnSuperTextViewClickListener(this);
    }

    /**
     * HTTP退出登录
     */
    private void logout(){
        XHttp.post("/prod-api/logout")
                .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String tokenResult) throws Throwable {
                        XToastUtils.success("登出成功" );
                    }
                    @Override
                    public void onError(ApiException e) {

                    }
                }){});
    }

    @SingleClick
    @Override
    public void onClick(SuperTextView view) {
        switch(view.getId()) {
            case R.id.menu_message:
                openNewPage(MessageFragment.class);
                break;
            case R.id.menu_account:
                openNewPage(AccountFragment.class);
                break;
            case R.id.menu_logout:
                DialogLoader.getInstance().showConfirmDialog(
                        getContext(),
                        getString(R.string.lab_logout_confirm),
                        getString(R.string.lab_yes),
                        (dialog, which) -> {
                            logout();
                            dialog.dismiss();
                            XUtil.getActivityLifecycleHelper().exit();
                            TokenUtils.handleLogoutSuccess();
                        },
                        getString(R.string.lab_no),
                        (dialog, which) -> dialog.dismiss()
                );
                break;
            default:
                break;
        }
    }
}
