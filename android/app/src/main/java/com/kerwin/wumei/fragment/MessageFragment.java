package com.kerwin.wumei.fragment;

import android.view.View;
import android.widget.TextView;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.core.webview.AgentWebActivity;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.grouplist.XUIGroupListView;
import com.xuexiang.xutil.app.AppUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import butterknife.BindView;


@Page(name = "消息")
public class MessageFragment extends BaseFragment {

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_message;
    }

    @Override
    protected TitleBar initTitle() {
        com.xuexiang.xui.widget.actionbar.TitleBar titleBar = super.initTitle();
        titleBar.setCenterClickListener(new View.OnClickListener() {
            @SingleClick
            @Override
            public void onClick(View view) {

            }
        });
        titleBar.addAction(new com.xuexiang.xui.widget.actionbar.TitleBar.TextAction("菜单") {
            @SingleClick
            @Override
            public void performAction(View view) {

            }
        });
        return titleBar;
    }

    @Override
    protected void initViews() {

    }
}
