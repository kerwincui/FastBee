/***************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ***************************************************************************/
package com.kerwin.wumei.fragment.device;

import android.Manifest;
import android.os.Build;
import android.os.Bundle;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.MyApp;
import com.kerwin.wumei.R;
import com.kerwin.wumei.activity.AddDeviceActivity;
import com.kerwin.wumei.activity.MainActivity;
import com.kerwin.wumei.adapter.entity.EspTouchViewModel;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.widget.spinner.materialspinner.MaterialSpinner;

import java.util.List;

import butterknife.BindView;


@Page(name = "设备信息")
public class AddDeviceTwoFragment extends BaseFragment {


    /**
     * 布局的资源id
     * @return
     */
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_add_device_two;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {

        Bundle arguments = getArguments();
        String mac = arguments.getString("device_mac");
        XToastUtils.toast("设备MAC:" + mac);


    }

    @Override
    protected void initListeners() {




    }

}
