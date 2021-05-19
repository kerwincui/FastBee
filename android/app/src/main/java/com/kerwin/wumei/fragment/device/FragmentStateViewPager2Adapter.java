package com.kerwin.wumei.fragment.device;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.viewpager2.adapter.FragmentStateAdapter;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

/**
 * @author xuexiang
 * @since 2020/5/21 1:27 AM
 */
public class FragmentStateViewPager2Adapter extends FragmentStateAdapter {

    private List<Fragment> mFragmentList = new ArrayList<>();

    private List<String> mTitleList = new ArrayList<>();

    private List<Long> mIds = new ArrayList<>();

    private AtomicLong mAtomicLong = new AtomicLong(0);

    public FragmentStateViewPager2Adapter(@NonNull Fragment fragment) {
        super(fragment);
    }

    @NonNull
    @Override
    public Fragment createFragment(int position) {
        return mFragmentList.get(position);
    }

    public FragmentStateViewPager2Adapter addFragment(Fragment fragment, String title) {
        if (fragment != null) {
            mFragmentList.add(fragment);
            mTitleList.add(title);
            mIds.add(getAtomicGeneratedId());
        }
        return this;
    }

    public FragmentStateViewPager2Adapter addFragment(int index, Fragment fragment, String title) {
        if (fragment != null && index >= 0 && index <= mFragmentList.size()) {
            mFragmentList.add(index, fragment);
            mTitleList.add(index, title);
            mIds.add(index, getAtomicGeneratedId());
        }
        return this;
    }

    public FragmentStateViewPager2Adapter removeFragment(int index) {
        if (index >= 0 && index < mFragmentList.size()) {
            mFragmentList.remove(index);
            mTitleList.remove(index);
            mIds.remove(index);
        }
        return this;
    }

    private long getAtomicGeneratedId() {
        return mAtomicLong.incrementAndGet();
    }

    @Override
    public int getItemCount() {
        return mFragmentList.size();
    }

    public void clear() {
        mFragmentList.clear();
        mTitleList.clear();
        mIds.clear();
        notifyDataSetChanged();
    }

    public CharSequence getPageTitle(int position) {
        return mTitleList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return mIds.get(position);
    }

    @Override
    public boolean containsItem(long itemId) {
        return mIds.contains(itemId);
    }
}
