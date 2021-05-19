package com.kerwin.wumei.fragment.device;

import android.content.Context;
import android.graphics.Point;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Vibrator;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.cardview.widget.CardView;
import androidx.core.content.ContextCompat;
import androidx.core.graphics.drawable.DrawableCompat;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.recyclerview.widget.RecyclerView;

import com.alibaba.android.vlayout.DelegateAdapter;
import com.alibaba.android.vlayout.LayoutHelper;
import com.alibaba.android.vlayout.VirtualLayoutManager;
import com.alibaba.android.vlayout.layout.GridLayoutHelper;
import com.alibaba.android.vlayout.layout.LinearLayoutHelper;
import com.alibaba.android.vlayout.layout.StaggeredGridLayoutHelper;
import com.alibaba.android.vlayout.layout.StickyLayoutHelper;
import com.kerwin.wumei.R;
import com.kerwin.wumei.adapter.base.broccoli.BroccoliSimpleDelegateAdapter;
import com.kerwin.wumei.adapter.base.delegate.SimpleDelegateAdapter;
import com.kerwin.wumei.adapter.base.delegate.SingleDelegateAdapter;
import com.kerwin.wumei.adapter.entity.NewInfo;
import com.kerwin.wumei.utils.DemoDataProvider;
import com.kerwin.wumei.utils.RandomUtils;
import com.kerwin.wumei.utils.Utils;
import com.kerwin.wumei.utils.XToastUtils;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.xuexiang.xrouter.annotation.AutoWired;
import com.xuexiang.xrouter.launcher.XRouter;
import com.xuexiang.xui.adapter.recyclerview.RecyclerViewHolder;
import com.xuexiang.xui.adapter.simple.AdapterItem;
import com.xuexiang.xui.widget.banner.widget.banner.SimpleImageBanner;
import com.xuexiang.xui.widget.button.SwitchIconView;
import com.xuexiang.xui.widget.imageview.ImageLoader;
import com.xuexiang.xui.widget.imageview.RadiusImageView;
import com.xuexiang.xui.widget.textview.supertextview.SuperButton;

import java.util.ArrayList;
import java.util.Collection;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.Unbinder;
import me.samlss.broccoli.Broccoli;

import static com.xuexiang.xui.utils.Utils.getScreenWidth;
import static com.xuexiang.xutil.display.DensityUtils.dip2px;

/**
 * @author xuexiang
 * @since 2020/4/21 12:24 AM
 */
public class SimpleTabFragment extends Fragment {
    private static final String TAG = "SimpleTabFragment";

    private static final String KEY_TITLE = "title";

//    @BindView(R.id.tv_title)
//    TextView tvTitle;
//    @BindView(R.id.tv_explain)
//    TextView tvExplain;

    @BindView(R.id.recyclerView)
    RecyclerView recyclerView;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
//    @BindView(R.id.item_card_view)
//    CardView itemCardView;

    private Unbinder mUnbinder;

    private SimpleDelegateAdapter<NewInfo> mNewsAdapter;

    @AutoWired(name = KEY_TITLE)
    String title;


    public static SimpleTabFragment newInstance(String title) {
        Bundle args = new Bundle();
        args.putString(KEY_TITLE, title);
        SimpleTabFragment fragment = new SimpleTabFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
        Log.e(TAG, "onAttach:" + title);
    }

    @Override
    public void onDetach() {
        super.onDetach();
        Log.e(TAG, "onDetach:" + title);
    }

    @Override
    public void onResume() {
        super.onResume();
        Log.e(TAG, "onResume:" + title);
    }

    @Override
    public void onStop() {
        super.onStop();
        Log.e(TAG, "onStop:" + title);
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        XRouter.getInstance().inject(this);
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_simple_tab, container, false);
        mUnbinder = ButterKnife.bind(this, view);
        initView();
        return view;
    }

    private void initView() {
//        int randomNumber = RandomUtils.getRandom(10, 100);
//        Log.e(TAG, "initView, random number:" + randomNumber + ", " + title);
//        tvTitle.setText(String.format("这个是%s页面的内容", title));
//        tvExplain.setText(String.format("这个是页面随机生成的数字:%d", randomNumber));


        VirtualLayoutManager virtualLayoutManager = new VirtualLayoutManager(getContext());
        recyclerView.setLayoutManager(virtualLayoutManager);
        RecyclerView.RecycledViewPool viewPool = new RecyclerView.RecycledViewPool();
        recyclerView.setRecycledViewPool(viewPool);
        viewPool.setMaxRecycledViews(0, 10);

        //顶部按钮
//        SingleDelegateAdapter buttonAdapter = new SingleDelegateAdapter(R.layout.adapter_button_top_item) {
//            @Override
//            public void onBindViewHolder(@NonNull RecyclerViewHolder holder, int position) {
//                SuperButton superButton = holder.findViewById(R.id.device_item_all_open);
//            }
//        };

        // 设备
        FragmentActivity activity=this.getActivity();
        mNewsAdapter = new BroccoliSimpleDelegateAdapter<NewInfo>(R.layout.adapter_device_card_view_list_item, new StaggeredGridLayoutHelper(2,0), DemoDataProvider.getEmptyNewInfo()) {
            @Override
            protected void onBindData(RecyclerViewHolder holder, NewInfo model, int position) {

                //设置item宽度，适配屏幕分辨率
//                CardView view=holder.findViewById(R.id.device_item_card_view);
//                int widthPixels = getScreenWidth(activity);
//                int space=dip2px(40); //间隙=左边距+右边距+中间间隔
//                ViewGroup.LayoutParams cardViewParams=view.getLayoutParams();
//                cardViewParams.width=(widthPixels-space)/2;

                //设置开关按钮
                SwitchIconView switchIconView=holder.findViewById(R.id.device_item_switch_button);
                holder.click(R.id.device_item_switch_button, v -> {
                    Vibrator vibrator = (Vibrator) activity.getSystemService(activity.VIBRATOR_SERVICE);
                    vibrator.vibrate(100);
                    switchIconView.switchState();
                });

                AppCompatImageView stateView=holder.findViewById(R.id.device_item_state_icon);
                stateView.setImageDrawable(getResources().getDrawable((R.drawable.state_a)));


                if (model != null) {
//                    holder.text(R.id.tv_user_name, model.getUserName());
//                    holder.text(R.id.tv_tag, model.getTag());
//                    holder.text(R.id.tv_title, model.getTitle());
//                    holder.text(R.id.tv_summary, model.getSummary());
//                    holder.text(R.id.tv_praise, model.getPraise() == 0 ? "点赞" : String.valueOf(model.getPraise()));
//                    holder.text(R.id.tv_comment, model.getComment() == 0 ? "评论" : String.valueOf(model.getComment()));
//                    holder.text(R.id.tv_read, "阅读量 " + model.getRead());
//                    holder.image(R.id.iv_image, model.getImageUrl());
//
//                    holder.click(R.id.card_view, v -> Utils.goWeb(getContext(), model.getDetailUrl()));
                }
            }

            @Override
            protected void onBindBroccoli(RecyclerViewHolder holder, Broccoli broccoli) {
//                broccoli.addPlaceholders(
//                        holder.findView(R.id.device_item_title),
//                        holder.findView(R.id.device_item_title_icon),
//                        holder.findView(R.id.device_item_time),
//                        holder.findView(R.id.device_item_time_icon),
//                        holder.findView(R.id.device_item_temperature),
//                        holder.findView(R.id.device_item_humidity),
//                        holder.findView(R.id.device_item_wifi),
//                        holder.findView(R.id.device_item_wifi_icon),
//                        holder.findView(R.id.device_item_state),
//                        holder.findView(R.id.device_item_state_icon),
//                        holder.findView(R.id.device_item_switch_button)
//                );
            }
        };

        DelegateAdapter delegateAdapter = new DelegateAdapter(virtualLayoutManager);
        delegateAdapter.addAdapter(mNewsAdapter);
        recyclerView.setAdapter(delegateAdapter);


        //下拉刷新
        refreshLayout.setOnRefreshListener(refreshLayout -> {
            // TODO: 2020-02-25 这里只是模拟了网络请求
            refreshLayout.getLayout().postDelayed(() -> {
                mNewsAdapter.refresh(DemoDataProvider.getDemoNewInfos());
                refreshLayout.finishRefresh();
            }, 1000);
        });
        //上拉加载
        refreshLayout.setOnLoadMoreListener(refreshLayout -> {
            // TODO: 2020-02-25 这里只是模拟了网络请求
            refreshLayout.getLayout().postDelayed(() -> {
                mNewsAdapter.loadMore(DemoDataProvider.getDemoNewInfos());
                refreshLayout.finishLoadMore();
            }, 1000);
        });
        refreshLayout.autoRefresh();//第一次进入触发自动刷新，演示效果
    }


    @Override
    public void onDestroyView() {
        if (mUnbinder != null) {
            mUnbinder.unbind();
        }
        super.onDestroyView();
        Log.e(TAG, "onDestroyView:" + title);

    }
}
