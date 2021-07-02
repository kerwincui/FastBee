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

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Color;
import android.os.Vibrator;
import android.util.Log;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.cardview.widget.CardView;
import androidx.fragment.app.FragmentActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.alibaba.android.vlayout.DelegateAdapter;
import com.alibaba.android.vlayout.VirtualLayoutManager;
import com.alibaba.android.vlayout.layout.StaggeredGridLayoutHelper;
import com.kerwin.wumei.R;
import com.kerwin.wumei.adapter.base.broccoli.BroccoliSimpleDelegateAdapter;
import com.kerwin.wumei.adapter.base.delegate.SimpleDelegateAdapter;
import com.kerwin.wumei.core.BaseFragment;
import com.kerwin.wumei.entity.IotCategory;
import com.kerwin.wumei.entity.IotDeviceStatus;
import com.kerwin.wumei.entity.vo.IotDeviceVo;
import com.kerwin.wumei.http.callback.TipRequestCallBack;
import com.kerwin.wumei.http.request.ListApiResult;
import com.kerwin.wumei.http.request.NoDataApiResult;
import com.kerwin.wumei.utils.XToastUtils;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.xuexiang.xhttp2.XHttp;
import com.xuexiang.xhttp2.callback.CallBackProxy;
import com.xuexiang.xhttp2.exception.ApiException;
import com.xuexiang.xpage.annotation.Page;
import com.xuexiang.xpage.base.XPageFragment;
import com.xuexiang.xpage.core.PageOption;
import com.xuexiang.xui.adapter.recyclerview.RecyclerViewHolder;
import com.xuexiang.xui.widget.actionbar.TitleBar;
import com.xuexiang.xui.widget.button.SwitchIconView;
import com.xuexiang.xutil.net.JsonUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import me.samlss.broccoli.Broccoli;

import static com.kerwin.wumei.utils.TokenUtils.clearToken;
import static com.kerwin.wumei.utils.TokenUtils.getToken;
import static com.kerwin.wumei.utils.TokenUtils.hasToken;

@Page(name = "设备")
public class SimpleTabFragment extends BaseFragment {
    private static final String TAG = "SimpleTabFragment";


    @BindView(R.id.recyclerView)
    RecyclerView recyclerView;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;

    private SimpleDelegateAdapter<IotDeviceVo> deviceAdapter;
    private List<IotDeviceVo> devices=new ArrayList<IotDeviceVo>() {};
    private int pageNum=1;
    private int pageSize=10;
    private Long groupId=0L;


    public static SimpleTabFragment newInstance(Long groupId) {
        SimpleTabFragment fragment = new SimpleTabFragment();
        fragment.groupId=groupId;
        return fragment;
    }

    /**
     * 布局的资源id
     *
     * @return
     */
    @Override
    protected int getLayoutId() {
        return R.layout.fragment_simple_tab;
    }

    /**
     * @return 返回为 null意为不需要导航栏
     */
    @Override
    protected TitleBar initTitle() {
        return null;
    }

    /**
     * 初始化控件
     */
    @Override
    protected void initViews() {
        initView();
        //Http获取设备列表
        getDeviceList();
    }

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
        Log.e(TAG, "onAttach:" + groupId);
    }

    @Override
    public void onDetach() {
        super.onDetach();
        Log.e(TAG, "onDetach:" + groupId);
    }

    @Override
    public void onResume() {
        super.onResume();
        Log.e(TAG, "onResume:" + groupId);
    }

    @Override
    public void onStop() {
        super.onStop();
        Log.e(TAG, "onStop:" + groupId);
    }


    private void initView() {

        VirtualLayoutManager virtualLayoutManager = new VirtualLayoutManager(getContext());
        recyclerView.setLayoutManager(virtualLayoutManager);
        RecyclerView.RecycledViewPool viewPool = new RecyclerView.RecycledViewPool();
        recyclerView.setRecycledViewPool(viewPool);
        viewPool.setMaxRecycledViews(0, 10);

        // 设备
        FragmentActivity activity=this.getActivity();
        XPageFragment fragment= this;
        deviceAdapter = new BroccoliSimpleDelegateAdapter<IotDeviceVo>(R.layout.adapter_device_card_view_list_item, new StaggeredGridLayoutHelper(2,0), devices) {
            @SuppressLint("ResourceType")
            @Override
            protected void onBindData(RecyclerViewHolder holder, IotDeviceVo device, int position) {
                if (device == null) {return;}

                //设置item宽度，适配屏幕分辨率
//                CardView view=holder.findViewById(R.id.device_item_card_view);
//                int widthPixels = getScreenWidth(activity);
//                int space=dip2px(40); //间隙=左边距+右边距+中间间隔
//                ViewGroup.LayoutParams cardViewParams=view.getLayoutParams();
//                cardViewParams.width=(widthPixels-space)/2;

                holder.text(R.id.device_item_title, device.getDeviceName());
                holder.text(R.id.device_item_temp, device.getDeviceTemperature()+"℃");
                holder.text(R.id.device_item_category, device.getCategoryName());

                //状态图标
                SwitchIconView radarView=holder.findViewById(R.id.device_item_radar_icon);
                SwitchIconView alarmView=holder.findViewById(R.id.device_item_alarm_icon);
                SwitchIconView switchIconView=holder.findViewById(R.id.device_item_switch_button);
                SwitchIconView lightIconView=holder.findViewById(R.id.device_item_light_button);
                radarView.setIconEnabled(device.getIsRadar()==1 && device.getIsOnline()==1?true:false);
                alarmView.setIconEnabled(device.getIsAlarm()==1 && device.getIsOnline()==1?true:false);
                switchIconView.setIconEnabled(device.getRelayStatus()==1 && device.getIsOnline()==1?true:false);
                lightIconView.setIconEnabled(device.getLightStatus()==1 && device.getIsOnline()==1?true:false);

                //显示网络信号：wifi信号强度(信号极好4格[-55—— 0]，信号好3格[-70—— -55），信号一般2格[-85—— -70），信号差1格[-100—— -85）)
                AppCompatImageView wifiView=holder.findViewById(R.id.device_item_wifi_icon);
                if(device.getIsOnline()==1 && device.getRssi()>=-55){
                    wifiView.setImageDrawable(getResources().getDrawable((R.drawable.wifi_4)));
                }else if(device.getIsOnline()==1 && device.getRssi()>=70){
                    wifiView.setImageDrawable(getResources().getDrawable((R.drawable.wifi_3)));
                }else if(device.getIsOnline()==1 && device.getRssi()>=-85){
                    wifiView.setImageDrawable(getResources().getDrawable((R.drawable.wifi_2)));
                }else if(device.getIsOnline()==1 && device.getRssi()>=-100){
                    wifiView.setImageDrawable(getResources().getDrawable((R.drawable.wifi_1)));
                }else{
                    wifiView.setImageDrawable(getResources().getDrawable((R.drawable.wifi_0)));
                }

                //其他文字、标题和图片
                FrameLayout flTitle=holder.findViewById(R.id.device_item_fl_title);
                if(device.getIsOnline()==1){
                    holder.text(R.id.device_item_wifi, "在线");
                    flTitle.setBackgroundColor(Color.argb(255, 63, 208, 173));
                }else{
                    holder.text(R.id.device_item_wifi, "离线");
                    flTitle.setBackgroundColor(Color.argb(255, 220, 220, 220));
                    //显示图标
                    AppCompatImageView categoryIcon=holder.findViewById(R.id.device_item_category_icon);
                    AppCompatImageView temp=holder.findViewById(R.id.device_item_temp_icon);
                    categoryIcon.setColorFilter(Color.parseColor("#909399"));
                    temp.setColorFilter(Color.parseColor("#909399"));
                }

                holder.click(R.id.device_item_light_button, v -> {
                    if(device.getIsOnline()==0) return;
                    //震动
                    Vibrator vibrator = (Vibrator) activity.getSystemService(activity.VIBRATOR_SERVICE);
                    vibrator.vibrate(100);
                    // 更新灯状态
                    updateDeviceStatus(
                            buildDeviceLightStatus(device.getDeviceId(), device.getDeviceNum(),lightIconView.isIconEnabled()==true?0:1)
                            , lightIconView);
                });
                holder.click(R.id.device_item_switch_button, v -> {
                    if(device.getIsOnline()==0) return;
                    //震动
                    Vibrator vibrator = (Vibrator) activity.getSystemService(activity.VIBRATOR_SERVICE);
                    vibrator.vibrate(100);
                    // 更新继电器状态
                    updateDeviceStatus(
                            buildDeviceRelayStatus(device.getDeviceId(),device.getDeviceNum(),switchIconView.isIconEnabled()==true?0:1)
                            , switchIconView);
                });
                holder.click(R.id.device_item_card_view, v -> {

                    PageOption.to(DeviceDetailFragment.class) //跳转的fragment
                            .setAddToBackStack(true) //是否加入堆栈
                            .putLong("device_id", device.getDeviceId()) //传递的参数
                            .putString("device_num",device.getDeviceNum())
                            .setNewActivity(true)
                            .open(fragment); //打开页面进行跳转

                });

            }

            @Override
            protected void onBindBroccoli(RecyclerViewHolder holder, Broccoli broccoli) {
                broccoli.addPlaceholders(
                        holder.findView(R.id.device_item_title),
                        holder.findView(R.id.update_device_temp_icon),
                        holder.findView(R.id.device_item_category),
                        holder.findView(R.id.device_item_category_icon),
                        holder.findView(R.id.device_item_wifi),
                        holder.findView(R.id.device_item_wifi_icon),
                        holder.findView(R.id.device_item_temp),
                        holder.findView(R.id.device_item_temp_icon),
                        holder.findView(R.id.device_item_alarm_icon),
                        holder.findView(R.id.device_item_alarm),
                        holder.findView(R.id.device_item_radar),
                        holder.findView(R.id.device_item_radar_icon),
                        holder.findView(R.id.device_item_switch_button),
                        holder.findView(R.id.device_item_light_button)
                );
            }
        };

        DelegateAdapter delegateAdapter = new DelegateAdapter(virtualLayoutManager);
        delegateAdapter.addAdapter(deviceAdapter);
        recyclerView.setAdapter(delegateAdapter);

        //下拉刷新
        refreshLayout.setOnRefreshListener(refreshLayout -> {
            refreshLayout.getLayout().postDelayed(() -> {
                pageNum=1;
                getDeviceList();
            }, 1000);
        });
        //上拉加载
        refreshLayout.setOnLoadMoreListener(refreshLayout -> {
            refreshLayout.getLayout().postDelayed(() -> {
                pageNum=pageNum+1;
                getDeviceList();
            }, 1000);
        });
//        refreshLayout.autoRefresh();//第一次进入触发自动刷新
    }

    /**
     * 构建设备状态数据
     */
    private IotDeviceStatus buildDeviceLightStatus(Long deviceId,String deviceNum,int lightStatus){
        IotDeviceStatus deviceStatus=new IotDeviceStatus();
        deviceStatus.setDeviceId(deviceId);
        deviceStatus.setDeviceNum(deviceNum);
        deviceStatus.setLightStatus(lightStatus);
        deviceStatus.setTriggerSource(1); //0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时
        return deviceStatus;
    }

    /**
     * 构建设备状态数据
     */
    private IotDeviceStatus buildDeviceRelayStatus(Long deviceId,String deviceNum,int relayStatus){
        IotDeviceStatus deviceStatus=new IotDeviceStatus();
        deviceStatus.setDeviceId(deviceId);
        deviceStatus.setDeviceNum(deviceNum);
        deviceStatus.setRelayStatus(relayStatus);
        deviceStatus.setTriggerSource(1); //0-无、1-按键、2.手机、3-浏览器、4-射频遥控、5-雷达、6-报警、7-定时
        return deviceStatus;
    }

    /**
     * HTTP更新设备状态
     */
    private void updateDeviceStatus(IotDeviceStatus deviceStatus,SwitchIconView iconView){
        if(!hasToken()) return;
        XHttp.put("/prod-api/system/status")
                .upJson(JsonUtil.toJson(deviceStatus))
                .headers("Authorization","Bearer "+getToken())
                .execute(new CallBackProxy<NoDataApiResult<String>, String>(new TipRequestCallBack<String>() {
                    @Override
                    public void onSuccess(String response) throws Throwable {
                        Log.d("response:",response);
                        iconView.switchState(true);
                        XToastUtils.success("设备状态更新成功");
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
     * HTTP获取设备列表
     */
    private void getDeviceList(){
        XHttp.get("/prod-api/system/device/list?"+"pageNum="+pageNum+"&pageSize="+pageSize+"&groupId="+groupId)
            .headers("Authorization","Bearer "+getToken())
            .execute(new CallBackProxy<ListApiResult<List<IotDeviceVo>>, List<IotDeviceVo>>(new TipRequestCallBack<List<IotDeviceVo>>() {
                @Override
                public void onSuccess(List<IotDeviceVo> list) throws Throwable {
                    if(pageNum==1) {
                        deviceAdapter.refresh(list);
                        refreshLayout.finishRefresh();
                    }else {
                        deviceAdapter.loadMore(list);
                        refreshLayout.finishLoadMore();
                    }
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
     * HTTP获取分类列表
     */
    private void getCategoryList(){
        XHttp.get("/prod-api/system/category/list?pageNum=1&pageSize=100")
            .headers("Authorization","Bearer "+getToken())
            .execute(new CallBackProxy<ListApiResult<List<IotCategory>>, List<IotCategory>>(new TipRequestCallBack<List<IotCategory>>() {
                @Override
                public void onSuccess(List<IotCategory> list) throws Throwable {

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
