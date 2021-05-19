package com.kerwin.wumei.fragment.profile;

import android.graphics.drawable.ColorDrawable;

import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.R;
import com.kerwin.wumei.fragment.AboutFragment;
import com.kerwin.wumei.fragment.FeedbackFragment;
import com.kerwin.wumei.fragment.MessageFragment;
import com.kerwin.wumei.fragment.SettingsFragment;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xpage.utils.Utils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.imageview.RadiusImageView;
import com.xuexiang.xui.widget.textview.supertextview.SuperTextView;

import butterknife.BindView;

@Page(anim = CoreAnim.none)
public class ProfileFragment extends BaseFragment implements SuperTextView.OnSuperTextViewClickListener {
    @BindView(R.id.riv_head_pic)
    RadiusImageView rivHeadPic;
    @BindView(R.id.menu_settings)
    SuperTextView menuSettings;
    @BindView(R.id.menu_about)
    SuperTextView menuAbout;
    @BindView(R.id.menu_feedback)
    SuperTextView menuFeedback;
    @BindView(R.id.menu_message)
    SuperTextView menuMessage;

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

    }

    @Override
    protected void initListeners() {
        menuSettings.setOnSuperTextViewClickListener(this);
        menuAbout.setOnSuperTextViewClickListener(this);
        menuFeedback.setOnSuperTextViewClickListener(this);
        menuMessage.setOnSuperTextViewClickListener(this);
    }

    @SingleClick
    @Override
    public void onClick(SuperTextView view) {
        switch(view.getId()) {
            case R.id.menu_settings:
                openNewPage(SettingsFragment.class);
                break;
            case R.id.menu_about:
                openNewPage(AboutFragment.class);
                break;
            case R.id.menu_message:
                openNewPage(MessageFragment.class);
                break;
            case R.id.menu_feedback:
                openNewPage(FeedbackFragment.class);
                break;
            default:
                break;
        }
    }
}
