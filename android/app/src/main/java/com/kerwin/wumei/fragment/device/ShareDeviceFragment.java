package com.kerwin.wumei.fragment.device;

import com.kerwin.wumei.R;
import com.kerwin.wumei.core.BaseFragment;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.widget.actionbar.TitleBar;

@Page(name = "分享设备")
public class ShareDeviceFragment extends BaseFragment {

    /**
     * 布局的资源id
     *
     * @return
     */
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_share_device;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {

    }
}
