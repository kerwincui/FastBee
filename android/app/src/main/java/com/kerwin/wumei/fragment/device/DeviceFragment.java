package com.kerwin.wumei.fragment.device;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.widget.AppCompatImageView;
import androidx.viewpager2.widget.ViewPager2;

import com.google.android.material.tabs.TabLayout;
import com.google.android.material.tabs.TabLayoutMediator;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.R;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.adapter.simple.AdapterItem;
import com.xuexiang.xui.utils.WidgetUtils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.popupwindow.popup.XUISimplePopup;
import com.xuexiang.xutil.display.ViewUtils;

import butterknife.BindView;
import butterknife.OnClick;

import static com.google.android.material.tabs.TabLayout.MODE_SCROLLABLE;

@Page(name = "设备")
public class DeviceFragment extends BaseFragment implements TabLayout.OnTabSelectedListener{
    @BindView(R.id.tab_layout)
    TabLayout tabLayout;
    @BindView(R.id.view_pager)
    ViewPager2 viewPager;

    private boolean mIsShowNavigationView;
    private FragmentStateViewPager2Adapter mAdapter;

    /**
     * @return 返回为 null意为不需要导航栏
     */
    @Override
    protected TitleBar initTitle() {
//        mAdapter.addFragment(2, SimpleTabFragment.newInstance("动态加入"), "动态加入");
//        mAdapter.removeFragment(2);
//        mAdapter.notifyDataSetChanged();

         return null;
    }

    /**
     * 布局的资源id
     *
     * @return
     */
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_device;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        mAdapter = new FragmentStateViewPager2Adapter(this);
        tabLayout.setTabMode(MODE_SCROLLABLE);
        tabLayout.addOnTabSelectedListener(this);
        viewPager.setAdapter(mAdapter);
        // 设置缓存的数量
        viewPager.setOffscreenPageLimit(1);
        new TabLayoutMediator(tabLayout, viewPager, (tab, position) -> tab.setText(mAdapter.getPageTitle(position))).attach();

        // 动态加载选项卡内容
        for (String page : MultiPage.getPageNames()) {
            mAdapter.addFragment(SimpleTabFragment.newInstance(page), page);
        }
        mAdapter.notifyDataSetChanged();
        viewPager.setCurrentItem(0, false);
        WidgetUtils.setTabLayoutTextFont(tabLayout);
    }


    @Override
    public void onTabSelected(TabLayout.Tab tab) {
        XToastUtils.toast("选中了:" + tab.getText());
    }

    @Override
    public void onTabUnselected(TabLayout.Tab tab) {

    }

    @Override
    public void onTabReselected(TabLayout.Tab tab) {

    }
}
