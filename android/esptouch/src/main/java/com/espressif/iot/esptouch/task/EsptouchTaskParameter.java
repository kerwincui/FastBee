package com.espressif.iot.esptouch.task;

public class EsptouchTaskParameter implements IEsptouchTaskParameter {

    private static int _datagramCount = 0;
    private long mIntervalGuideCodeMillisecond;
    private long mIntervalDataCodeMillisecond;
    private long mTimeoutGuideCodeMillisecond;
    private long mTimeoutDataCodeMillisecond;
    private int mTotalRepeatTime;
    private int mEsptouchResultOneLen;
    private int mEsptouchResultMacLen;
    private int mEsptouchResultIpLen;
    private int mEsptouchResultTotalLen;
    private int mPortListening;
    private int mTargetPort;
    private int mWaitUdpReceivingMilliseond;
    private int mWaitUdpSendingMillisecond;
    private int mThresholdSucBroadcastCount;
    private int mExpectTaskResultCount;
    private boolean mBroadcast = true;

    public EsptouchTaskParameter() {
        mIntervalGuideCodeMillisecond = 8;
        mIntervalDataCodeMillisecond = 8;
        mTimeoutGuideCodeMillisecond = 2000;
        mTimeoutDataCodeMillisecond = 4000;
        mTotalRepeatTime = 1;
        mEsptouchResultOneLen = 1;
        mEsptouchResultMacLen = 6;
        mEsptouchResultIpLen = 4;
        mEsptouchResultTotalLen = 1 + 6 + 4;
        mPortListening = 18266;
        mTargetPort = 7001;
        mWaitUdpReceivingMilliseond = 15000;
        mWaitUdpSendingMillisecond = 45000;
        mThresholdSucBroadcastCount = 1;
        mExpectTaskResultCount = 1;
    }

    // the range of the result should be 1-100
    private static int __getNextDatagramCount() {
        return 1 + (_datagramCount++) % 100;
    }

    @Override
    public long getIntervalGuideCodeMillisecond() {
        return mIntervalGuideCodeMillisecond;
    }

    @Override
    public long getIntervalDataCodeMillisecond() {
        return mIntervalDataCodeMillisecond;
    }

    @Override
    public long getTimeoutGuideCodeMillisecond() {
        return mTimeoutGuideCodeMillisecond;
    }

    @Override
    public long getTimeoutDataCodeMillisecond() {
        return mTimeoutDataCodeMillisecond;
    }

    @Override
    public long getTimeoutTotalCodeMillisecond() {
        return mTimeoutGuideCodeMillisecond + mTimeoutDataCodeMillisecond;
    }

    @Override
    public int getTotalRepeatTime() {
        return mTotalRepeatTime;
    }

    @Override
    public int getEsptouchResultOneLen() {
        return mEsptouchResultOneLen;
    }

    @Override
    public int getEsptouchResultMacLen() {
        return mEsptouchResultMacLen;
    }

    @Override
    public int getEsptouchResultIpLen() {
        return mEsptouchResultIpLen;
    }

    @Override
    public int getEsptouchResultTotalLen() {
        return mEsptouchResultTotalLen;
    }

    @Override
    public int getPortListening() {
        return mPortListening;
    }

    // target hostname is : 234.1.1.1, 234.2.2.2, 234.3.3.3 to 234.100.100.100
    @Override
    public String getTargetHostname() {
        if (mBroadcast) {
            return "255.255.255.255";
        } else {
            int count = __getNextDatagramCount();
            return "234." + count + "." + count + "." + count;
        }
    }

    @Override
    public int getTargetPort() {
        return mTargetPort;
    }

    @Override
    public int getWaitUdpReceivingMillisecond() {
        return mWaitUdpReceivingMilliseond;
    }

    @Override
    public int getWaitUdpSendingMillisecond() {
        return mWaitUdpSendingMillisecond;
    }

    @Override
    public int getWaitUdpTotalMillisecond() {
        return mWaitUdpReceivingMilliseond + mWaitUdpSendingMillisecond;
    }

    @Override
    public void setWaitUdpTotalMillisecond(int waitUdpTotalMillisecond) {
        if (waitUdpTotalMillisecond < mWaitUdpReceivingMilliseond
                + getTimeoutTotalCodeMillisecond()) {
            // if it happen, even one turn about sending udp broadcast can't be
            // completed
            throw new IllegalArgumentException(
                    "waitUdpTotalMillisecod is invalid, "
                            + "it is less than mWaitUdpReceivingMilliseond + getTimeoutTotalCodeMillisecond()");
        }
        mWaitUdpSendingMillisecond = waitUdpTotalMillisecond
                - mWaitUdpReceivingMilliseond;
    }

    @Override
    public int getThresholdSucBroadcastCount() {
        return mThresholdSucBroadcastCount;
    }

    @Override
    public int getExpectTaskResultCount() {
        return this.mExpectTaskResultCount;
    }

    @Override
    public void setExpectTaskResultCount(int expectTaskResultCount) {
        this.mExpectTaskResultCount = expectTaskResultCount;
    }

    @Override
    public void setBroadcast(boolean broadcast) {
        mBroadcast = broadcast;
    }
}
