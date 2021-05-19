package com.kerwin.wumei.fragment.device;

import android.Manifest;
import android.os.Build;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.util.Log;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import androidx.appcompat.widget.AppCompatImageView;

import com.kerwin.wumei.MyApp;
import com.kerwin.wumei.R;
import com.kerwin.wumei.activity.MainActivity;
import com.kerwin.wumei.adapter.entity.EspTouchViewModel;
import com.kerwin.wumei.core.BaseFragment;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.spinner.materialspinner.MaterialSpinner;

import java.util.List;

import butterknife.BindView;


@Page(anim = CoreAnim.none)
public class SceneFragment extends BaseFragment {

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
        return R.layout.fragment_scene;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() { }

    @Override
    protected void initListeners() { }

}
