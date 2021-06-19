/*
 * Copyright (C) 2021 xuexiangjys(xuexiangjys@163.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.kerwin.wumei.activity;

import android.Manifest;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.PackageManager;
import android.location.LocationManager;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.widget.Toolbar;
import androidx.core.location.LocationManagerCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.viewpager.widget.ViewPager;

import com.kerwin.wumei.entity.User;
import com.kerwin.wumei.fragment.profile.AccountFragment;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.UserInfoApiResult;
import com.kerwin.wumei.utils.sdkinit.XUpdateInit;

import com.espressif.iot.esptouch.EsptouchTask;
import com.espressif.iot.esptouch.IEsptouchResult;
import com.espressif.iot.esptouch.IEsptouchTask;
import com.espressif.iot.esptouch.util.ByteUtil;
import com.espressif.iot.esptouch.util.TouchNetUtil;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationView;
import com.kerwin.wumei.R;
import com.kerwin.wumei.adapter.entity.EspTouchViewModel;
import com.kerwin.wumei.core.BaseActivity;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.fragment.AboutFragment;
import com.kerwin.wumei.fragment.FeedbackFragment;
import com.kerwin.wumei.fragment.MessageFragment;
import com.kerwin.wumei.fragment.SettingsFragment;
import com.kerwin.wumei.fragment.device.AddDeviceFragment;
import com.kerwin.wumei.fragment.device.GroupFragment;
import com.kerwin.wumei.fragment.device.SceneFragment;
import com.kerwin.wumei.fragment.device.ShareDeviceFragment;
import com.kerwin.wumei.fragment.news.HomePageFragment;
import com.kerwin.wumei.fragment.news.NewsFragment;
import com.kerwin.wumei.fragment.profile.ProfileFragment;
import com.kerwin.wumei.fragment.device.DeviceFragment;
import com.kerwin.wumei.utils.NetUtils;
import com.kerwin.wumei.utils.Utils;
import com.kerwin.wumei.utils.XToastUtils;
import com.kerwin.wumei.widget.GuideTipsDialog;
import com.xuexiang.xaop.annotation.SingleClick;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.core.PageOption;
import com.xuexiang.xpage.enums.CoreAnim;
import com.xuexiang.xui.adapter.FragmentAdapter;
import com.xuexiang.xui.adapter.simple.AdapterItem;
import com.xuexiang.xui.utils.ResUtils;
import com.xuexiang.xui.utils.ThemeUtils;
import com.xuexiang.xui.widget.imageview.RadiusImageView;
import com.xuexiang.xui.widget.popupwindow.popup.XUISimplePopup;
import com.xuexiang.xutil.XUtil;
import com.xuexiang.xutil.common.ClickUtils;
import com.xuexiang.xutil.common.CollectionUtils;
import com.xuexiang.xutil.display.Colors;

import java.lang.ref.WeakReference;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import butterknife.BindView;

import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;

public class MainActivity extends BaseActivity implements View.OnClickListener, ViewPager.OnPageChangeListener, BottomNavigationView.OnNavigationItemSelectedListener, ClickUtils.OnClick2ExitListener, Toolbar.OnMenuItemClickListener {

    @BindView(R.id.toolbar)
    Toolbar toolbar;
    @BindView(R.id.view_pager)
    ViewPager viewPager;
    /**
     * 底部导航栏
     */
    @BindView(R.id.bottom_navigation)
    BottomNavigationView bottomNavigation;
    /**
     * 侧边栏
     */
    @BindView(R.id.nav_view)
    NavigationView navView;
    @BindView(R.id.drawer_layout)
    DrawerLayout drawerLayout;

    private String[] mTitles;

    @Override
    protected int getLayoutId() {
        return R.layout.activity_main;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initViews();
//        initData();
        initListeners();
    }

    @Override
    protected boolean isSupportSlideBack() {
        return true;
    }

    private void initViews() {
        mTitles = ResUtils.getStringArray(R.array.home_titles);
        toolbar.setTitle(mTitles[0]);
        toolbar.inflateMenu(R.menu.menu_main);
        toolbar.setOnMenuItemClickListener(this);
        initHeader();

        //主页内容填充
        BaseFragment[] fragments = new BaseFragment[]{
                new DeviceFragment(),
                new SceneFragment(),
                new HomePageFragment(),
                new ProfileFragment(),
        };
        FragmentAdapter<BaseFragment> adapter = new FragmentAdapter<>(getSupportFragmentManager(), fragments);
        viewPager.setOffscreenPageLimit(mTitles.length - 1);
        viewPager.setAdapter(adapter);

        //显示提示
//        GuideTipsDialog.showTips(this);
    }

    private void initData() {
        GuideTipsDialog.showTips(this);
        XUpdateInit.checkUpdate(this, false);
    }

    /**
     * 侧边栏头部
     */
    private void initHeader() {
        navView.setItemIconTintList(null);
        View headerView = navView.getHeaderView(0);
        LinearLayout navHeader = headerView.findViewById(R.id.nav_header);
        RadiusImageView ivAvatar = headerView.findViewById(R.id.iv_avatar);
        TextView tvAvatar = headerView.findViewById(R.id.tv_avatar);
        TextView tvSign = headerView.findViewById(R.id.tv_sign);

        if (Utils.isColorDark(ThemeUtils.resolveColor(this, R.attr.colorAccent))) {
            tvAvatar.setTextColor(Colors.WHITE);
            tvSign.setTextColor(Colors.WHITE);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                ivAvatar.setImageTintList(ResUtils.getColors(R.color.xui_config_color_white));
            }
        } else {
            tvAvatar.setTextColor(ThemeUtils.resolveColor(this, R.attr.xui_config_color_title_text));
            tvSign.setTextColor(ThemeUtils.resolveColor(this, R.attr.xui_config_color_explain_text));
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                ivAvatar.setImageTintList(ResUtils.getColors(R.color.xui_config_color_gray_3));
            }
        }

        // 绑定数据
        ivAvatar.setImageResource(R.drawable.ic_default_head);
        tvAvatar.setText("匿名用户");
        tvSign.setText("物美智能点亮智慧生活...");
        getUserInfo(tvAvatar,tvSign );
        navHeader.setOnClickListener(this);
    }

    protected void initListeners() {
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(this, drawerLayout, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();

        //侧边栏点击事件
        navView.setNavigationItemSelectedListener(menuItem -> {

                switch (menuItem.getItemId()) {
                    case R.id.nav_add_device:
                        PageOption.to(AddDeviceFragment.class) //跳转的fragment
                                .setAnim(CoreAnim.slide) //页面转场动画
                                .setRequestCode(100) //请求码，用于返回结果
                                .setAddToBackStack(true) //是否加入堆栈
                                .setNewActivity(true, AddDeviceActivity.class) //是否使用新的Activity打开
                                .open(this); //打开页面进行跳转
                        break;
                    case R.id.nav_about:
                        openNewPage(AboutFragment.class);
                        break;
                    case R.id.nav_serve_config:
                        drawerLayout.closeDrawers();
                        toolbar.setTitle(menuItem.getTitle());
                        viewPager.setCurrentItem(1, false);
                        break;
                    case R.id.nav_message:
                        openNewPage(MessageFragment.class);
                        break;
                    default:
                        XToastUtils.toast("点击了:" + menuItem.getTitle());
                        break;
                }
            return true;
        });

        //主页事件监听
        viewPager.addOnPageChangeListener(this);
        bottomNavigation.setOnNavigationItemSelectedListener(this);
    }




    @Override
    public boolean onMenuItemClick(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.add_device:
                PageOption.to(AddDeviceFragment.class) //跳转的fragment
                        .setAnim(CoreAnim.slide) //页面转场动画
                        .setRequestCode(100) //请求码，用于返回结果
                        .setAddToBackStack(true) //是否加入堆栈
                        .setNewActivity(true, AddDeviceActivity.class) //是否使用新的Activity打开
                        .open(this); //打开页面进行跳转
                break;
            default:
                break;
        }
        return false;
    }

    @SingleClick
    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.nav_header:
                openNewPage(AccountFragment.class);
                break;
            default:
                break;
        }
    }

    //=============ViewPager===================//

    @Override
    public void onPageScrolled(int i, float v, int i1) {

    }

    @Override
    public void onPageSelected(int position) {
        MenuItem item = bottomNavigation.getMenu().getItem(position);
        toolbar.setTitle(item.getTitle());
        item.setChecked(true);
    }

    @Override
    public void onPageScrollStateChanged(int i) {

    }

    //================Navigation================//

    /**
     * 底部导航栏点击事件
     *
     * @param menuItem
     * @return
     */
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
        int index = CollectionUtils.arrayIndexOf(mTitles, menuItem.getTitle());
        if (index != -1) {
            toolbar.setTitle(menuItem.getTitle());
            viewPager.setCurrentItem(index, false);
            return true;
        }
        return false;
    }


    /**
     * 菜单、返回键响应
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            ClickUtils.exitBy2Click(2000, this);
        }
        return true;
    }

    @Override
    public void onRetry() {
        XToastUtils.toast("再按一次退出程序");
    }

    @Override
    public void onExit() {
        XUtil.exitApp();
    }

    /**
     * HTTP获取用户信息
     */
    private void getUserInfo(TextView avatar,TextView sign){
        if(!hasToken()) return;
        XHttp.get("/prod-api/getInfo")
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<UserInfoApiResult<User>, User>(new TipRequestCallBack<User>() {
                    @Override
                    public void onSuccess(User user) throws Throwable {
                        Log.d("user:",user.getNickName());
                        if(user.getNickName()!=null && user.getNickName().length()!=0)
                        {
                            avatar.setText(user.getNickName());
                        }else{
                            avatar.setText(user.getUserName());
                        }
                        sign.setText("物美智能开源项目(wumei-smart)");
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
