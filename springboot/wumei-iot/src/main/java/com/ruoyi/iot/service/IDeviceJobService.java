package com.ruoyi.iot.service;

import com.ruoyi.common.exception.job.TaskException;
import com.ruoyi.iot.domain.DeviceJob;
import org.quartz.SchedulerException;

import java.util.List;

/**
 * 定时任务调度信息信息 服务层
 * 
 * @author kerwincui
 */
public interface IDeviceJobService
{
    /**
     * 获取quartz调度器的计划任务
     * 
     * @param job 调度信息
     * @return 调度任务集合
     */
    public List<DeviceJob> selectJobList(DeviceJob job);

    /**
     * 通过调度任务ID查询调度信息
     * 
     * @param jobId 调度任务ID
     * @return 调度任务对象信息
     */
    public DeviceJob selectJobById(Long jobId);

    /**
     * 暂停任务
     * 
     * @param job 调度信息
     * @return 结果
     */
    public int pauseJob(DeviceJob job) throws SchedulerException;

    /**
     * 恢复任务
     * 
     * @param job 调度信息
     * @return 结果
     */
    public int resumeJob(DeviceJob job) throws SchedulerException;

    /**
     * 删除任务后，所对应的trigger也将被删除
     * 
     * @param job 调度信息
     * @return 结果
     */
    public int deleteJob(DeviceJob job) throws SchedulerException;

    /**
     * 批量删除调度信息
     * 
     * @param jobIds 需要删除的任务ID
     * @return 结果
     */
    public void deleteJobByIds(Long[] jobIds) throws SchedulerException;

    /**
     * 根据设备Ids批量删除调度信息
     *
     * @param deviceIds 需要删除数据的设备Ids
     * @return 结果
     */
    public void deleteJobByDeviceIds(Long[] deviceIds) throws SchedulerException;

    /**
     * 任务调度状态修改
     * 
     * @param job 调度信息
     * @return 结果
     */
    public int changeStatus(DeviceJob job) throws SchedulerException;

    /**
     * 立即运行任务
     * 
     * @param job 调度信息
     * @return 结果
     */
    public void run(DeviceJob job) throws SchedulerException;

    /**
     * 新增任务
     * 
     * @param job 调度信息
     * @return 结果
     */
    public int insertJob(DeviceJob job) throws SchedulerException, TaskException;

    /**
     * 更新任务
     * 
     * @param job 调度信息
     * @return 结果
     */
    public int updateJob(DeviceJob job) throws SchedulerException, TaskException;

    /**
     * 校验cron表达式是否有效
     * 
     * @param cronExpression 表达式
     * @return 结果
     */
    public boolean checkCronExpressionIsValid(String cronExpression);
}
