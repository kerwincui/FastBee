/****************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ****************************************************************************/
package com.kerwin.wumei.fragment.device;

import android.util.Log;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.viewpager2.widget.ViewPager2;

import com.google.android.material.tabs.TabLayout;
import com.google.android.material.tabs.TabLayoutMediator;
import com.kerwin.wumei.activity.LoginActivity;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.R;
import com.kerwin.wumei.entity.DictData;
import com.kerwin.wumei.entity.IotCategory;
import com.kerwin.wumei.entity.IotDevice;
import com.kerwin.wumei.entity.IotDeviceSet;
import com.kerwin.wumei.entity.IotDeviceStatus;
import com.kerwin.wumei.entity.IotGroup;
import com.kerwin.wumei.fragment.LoginFragment;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.ListApiResult;
import com.kerwin.wumei.http.request.NoDataApiResult;
import com.kerwin.wumei.utils.XToastUtils;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.callback.SimpleCallBack;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xui.utils.WidgetUtils;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.toast.XToast;
import com.xuexiang.xutil.app.ActivityUtils;
import com.xuexiang.xutil.net.JsonUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;

import static com.google.android.material.tabs.TabLayout.MODE_SCROLLABLE;
import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;

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
        //获取分组列表
        getGroupList(this);
    }


    @Override
    public void onTabSelected(TabLayout.Tab tab) {

    }

    @Override
    public void onTabUnselected(TabLayout.Tab tab) {

    }

    @Override
    public void onTabReselected(TabLayout.Tab tab) {

    }

    /**
     * 初始化设备列表
     * @param listener
     * @param groupList
     */
    private void initDeviceListView(@NonNull TabLayout.OnTabSelectedListener listener,List<IotGroup> groupList){
        mAdapter = new FragmentStateViewPager2Adapter((Fragment) listener);
        tabLayout.setTabMode(MODE_SCROLLABLE);
        tabLayout.addOnTabSelectedListener(listener);
        viewPager.setAdapter(mAdapter);
        // 设置缓存的数量
        viewPager.setOffscreenPageLimit(10);
        new TabLayoutMediator(tabLayout, viewPager, (tab, position) -> tab.setText(mAdapter.getPageTitle(position))).attach();

        // 动态加载选项卡内容
        for (IotGroup group: groupList) {
            mAdapter.addFragment(SimpleTabFragment.newInstance(group.getGroupId()), group.getGroupName());
        }
        mAdapter.notifyDataSetChanged();
        viewPager.setCurrentItem(0, false);
        WidgetUtils.setTabLayoutTextFont(tabLayout);
    }

    /**
     * HTTP获取分组列表
     */
    private void getGroupList(@NonNull TabLayout.OnTabSelectedListener listener){
        XHttp.get("/prod-api/system/group/list?pageNum=1&pageSize=100")
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<ListApiResult<List<IotGroup>>, List<IotGroup>>(new TipRequestCallBack<List<IotGroup>>() {
                    @Override
                    public void onSuccess(List<IotGroup> list) throws Throwable {
                        List<IotGroup> groupList=list;
                        IotGroup iotGroup=new IotGroup();
                        iotGroup.setGroupId(0L);
                        iotGroup.setGroupName("全部");
                        iotGroup.setGroupOrder(0);
                        groupList.add(0,iotGroup);

                        initDeviceListView(listener,groupList);
                    }
                    @Override
                    public void onError(ApiException e) {
                        if(e.getCode()==401){
                            List<IotGroup> groupList=new ArrayList<IotGroup>();
                            IotGroup group=new IotGroup();
                            group.setGroupId(0L);
                            group.setGroupName("全部");
                            groupList.add(group);
                            initDeviceListView(listener,groupList);
                            XToastUtils.info("匿名登录状态，功能受限");
                            clearToken();
                        }else{
                            XToastUtils.error(e.getMessage());
                        }
                    }
                }){});
    }





    /**
     * HTTP获取触发源字典列表
     */
    private void getTriggerSourceDic(){
        XHttp.get("/prod-api/system/dict/data/type/iot_trigger_source")
                .headers("Authorization","Bearer "+getToken())
                .execute(new SimpleCallBack<List<DictData>>() {
                    @Override
                    public void onSuccess(List<DictData> response) {
                        Log.d("group name:",response.get(0).getDictLabel());
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

                });
    }


    /**
     * HTTP获取分组详情
     */
    private void getGroup(Long groupId){
        if(!hasToken()) return;
        XHttp.get("/prod-api/system/group/"+groupId)
                .headers("Authorization","Bearer "+getToken())
                .execute(new SimpleCallBack<IotGroup>(){
                    @Override
                    public void onSuccess(IotGroup response) throws Throwable {

                        Log.d("response:","response");
                        XToastUtils.info("response");
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
                });
    }

    /**
     * HTTP新增分组
     */
    private void addGroup(IotGroup group){
        if(!hasToken()) return;
        XHttp.post("/prod-api/system/group")
                .upJson(JsonUtil.toJson(group))
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String response) throws Throwable {

                        Log.d("response:","response");
                        XToastUtils.info("response");
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

    /**
     * HTTP编辑分组
     */
    private void editGroup(IotGroup group){
        if(!hasToken()) return;
        XHttp.put("/prod-api/system/group")
                .upJson(JsonUtil.toJson(group))
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String response) throws Throwable {
                        Log.d("response:","response");
                        XToastUtils.info("response");
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

    /**
     * HTTP删除分组
     */
    private void deleteGroup(Long groupId){
        if(!hasToken()) return;
        XHttp.delete("/prod-api/system/group/"+groupId)
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String response) throws Throwable {
                        Log.d("response:","response");
                        XToastUtils.info("response");
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
