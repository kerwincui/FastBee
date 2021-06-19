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

import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

import androidx.viewpager.widget.ViewPager;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.core.webview.AgentWebActivity;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.adapter.FragmentAdapter;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.grouplist.XUIGroupListView;
import com.xuexiang.xui.widget.tabbar.TabSegment;
import com.xuexiang.xutil.app.AppUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import butterknife.BindView;


@Page(name = "设备详情")
public class DeviceDetailFragment extends BaseFragment {
    @BindView(R.id.titlebar_min)
    TitleBar titleBarMin;
    @BindView(R.id.tabSegment)
    TabSegment tabSegment;
    @BindView(R.id.contentViewPager)
    ViewPager contentViewPager;

    @Override
    protected TitleBar initTitle() {
        return null;
    }

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_device_detail;
    }

    @Override
    protected void initViews() {
        titleBarMin.setLeftClickListener(v -> popToBack());

        Bundle arguments = getArguments();
        Long device_id = arguments.getLong("device_id");
        String device_num=arguments.getString("device_num");
        tabSegment.addTab(new TabSegment.Tab("设备"));
        tabSegment.addTab(new TabSegment.Tab("状态"));
        tabSegment.addTab(new TabSegment.Tab("配置"));

        FragmentAdapter<BaseFragment> adapter = new FragmentAdapter<>(getChildFragmentManager());
        adapter.addFragment(new DeviceEditFragment(device_id,device_num), "");
        adapter.addFragment(new DeviceStatusFragment(device_id,device_num), "");
        adapter.addFragment(new DeviceSetFragment(device_id,device_num), "");

        contentViewPager.setAdapter(adapter);
        contentViewPager.setCurrentItem(0, false);
        tabSegment.setupWithViewPager(contentViewPager, false);
        tabSegment.setMode(TabSegment.MODE_FIXED);
    }
}
