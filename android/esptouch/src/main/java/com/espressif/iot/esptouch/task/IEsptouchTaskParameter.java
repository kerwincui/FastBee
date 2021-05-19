package com.espressif.iot.esptouch.task;

public interface IEsptouchTaskParameter {

    /**
     * get interval millisecond for guide code(the time between each guide code sending)
     *
     * @return interval millisecond for guide code(the time between each guide code sending)
     */
    long getIntervalGuideCodeMillisecond();

    /**
     * get interval millisecond for data code(the time between each data code sending)
     *
     * @return interval millisecond for data code(the time between each data code sending)
     */
    long getIntervalDataCodeMillisecond();

    /**
     * get timeout millisecond for guide code(the time how much the guide code sending)
     *
     * @return timeout millisecond for guide code(the time how much the guide code sending)
     */
    long getTimeoutGuideCodeMillisecond();

    /**
     * get timeout millisecond for data code(the time how much the data code sending)
     *
     * @return timeout millisecond for data code(the time how much the data code sending)
     */
    long getTimeoutDataCodeMillisecond();

    /**
     * get timeout millisecond for total code(guide code and data code altogether)
     *
     * @return timeout millisecond for total code(guide code and data code altogether)
     */
    long getTimeoutTotalCodeMillisecond();

    /**
     * get total repeat time for executing esptouch task
     *
     * @return total repeat time for executing esptouch task
     */
    int getTotalRepeatTime();

    /**
     * the length of the Esptouch result 1st byte is the total length of ssid and
     * password, the other 6 bytes are the device's bssid
     */

    /**
     * get esptouchResult length of one
     *
     * @return length of one
     */
    int getEsptouchResultOneLen();

    /**
     * get esptouchResult length of mac
     *
     * @return length of mac
     */
    int getEsptouchResultMacLen();

    /**
     * get esptouchResult length of ip
     *
     * @return length of ip
     */
    int getEsptouchResultIpLen();

    /**
     * get esptouchResult total length
     *
     * @return total length
     */
    int getEsptouchResultTotalLen();

    /**
     * get port for listening(used by server)
     *
     * @return port for listening(used by server)
     */
    int getPortListening();

    /**
     * get target hostname
     *
     * @return target hostame(used by client)
     */
    String getTargetHostname();

    /**
     * get target port
     *
     * @return target port(used by client)
     */
    int getTargetPort();

    /**
     * get millisecond for waiting udp receiving(receiving without sending)
     *
     * @return millisecond for waiting udp receiving(receiving without sending)
     */
    int getWaitUdpReceivingMillisecond();

    /**
     * get millisecond for waiting udp sending(sending including receiving)
     *
     * @return millisecond for waiting udep sending(sending including receiving)
     */
    int getWaitUdpSendingMillisecond();

    /**
     * get millisecond for waiting udp sending and receiving
     *
     * @return millisecond for waiting udp sending and receiving
     */
    int getWaitUdpTotalMillisecond();

    /**
     * set the millisecond for waiting udp sending and receiving
     *
     * @param waitUdpTotalMillisecond the millisecond for waiting udp sending and receiving
     */
    void setWaitUdpTotalMillisecond(int waitUdpTotalMillisecond);

    /**
     * get the threshold for how many correct broadcast should be received
     *
     * @return the threshold for how many correct broadcast should be received
     */
    int getThresholdSucBroadcastCount();

    /**
     * get the count of expect task results
     *
     * @return the count of expect task results
     */
    int getExpectTaskResultCount();

    /**
     * set the count of expect task results
     *
     * @param expectTaskResultCount the count of expect task results
     */
    void setExpectTaskResultCount(int expectTaskResultCount);

    /**
     * Set broadcast or multicast
     *
     * @param broadcast true is broadcast, false is multicast
     */
    void setBroadcast(boolean broadcast);
}
