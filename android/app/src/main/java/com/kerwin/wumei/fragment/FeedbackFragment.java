package com.kerwin.wumei.fragment;

import android.widget.TextView;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.core.webview.AgentWebActivity;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.widget.grouplist.XUIGroupListView;
import com.xuexiang.xutil.app.AppUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import butterknife.BindView;

@Page(name = "意见反馈")
public class FeedbackFragment extends BaseFragment {

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_feedback;
    }

    @Override
    protected void initViews() {

    }
}
