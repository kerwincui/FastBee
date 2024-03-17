package com.fastbee.data.service.impl;

import com.fastbee.common.constant.ScheduleConstants;
import com.fastbee.common.exception.job.TaskException;
import com.fastbee.iot.domain.DeviceJob;
import com.fastbee.iot.mapper.DeviceJobMapper;
import com.fastbee.iot.service.IDeviceJobService;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.iot.service.cache.IDeviceCache;
import com.fastbee.data.quartz.CronUtils;
import com.fastbee.data.quartz.ScheduleUtils;
import com.fastbee.quartz.domain.SysJob;
import com.fastbee.quartz.mapper.SysJobMapper;
import lombok.extern.slf4j.Slf4j;
import org.quartz.JobDataMap;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

/**
 * 定时任务调度信息 服务层
 * 
 * @author kerwincui
 */
@Service
@Slf4j
public class DeviceJobServiceImpl implements IDeviceJobService
{
    @Autowired
    private Scheduler scheduler;

    @Autowired
    private DeviceJobMapper jobMapper;

    @Autowired
    private SysJobMapper sysJobMapper;


    /**
     * 项目启动时，初始化定时器 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
     */
    @PostConstruct
    public void init() throws SchedulerException, TaskException
    {
        scheduler.clear();
        // 设备定时任务
        List<DeviceJob> jobList = jobMapper.selectJobAll();
        for (DeviceJob deviceJob : jobList)
        {
            ScheduleUtils.createScheduleJob(scheduler, deviceJob);
        }

        // 系统定时任务
        List<SysJob> sysJobList = sysJobMapper.selectJobAll();
        for (SysJob job : sysJobList)
        {
            com.fastbee.quartz.util.ScheduleUtils.createScheduleJob(scheduler, job);
        }
    }

    /**
     * 获取quartz调度器的计划任务列表
     * 
     * @param job 调度信息
     * @return
     */
    @Override
    public List<DeviceJob> selectJobList(DeviceJob job)
    {
        return jobMapper.selectJobList(job);
    }

    /**
     * 通过调度任务ID查询调度信息
     * 
     * @param jobId 调度任务ID
     * @return 调度任务对象信息
     */
    @Override
    public DeviceJob selectJobById(Long jobId)
    {
        return jobMapper.selectJobById(jobId);
    }

    /**
     * 暂停任务
     * 
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int pauseJob(DeviceJob job) throws SchedulerException
    {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
        int rows = jobMapper.updateJob(job);
        if (rows > 0)
        {
            scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 恢复任务
     * 
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int resumeJob(DeviceJob job) throws SchedulerException
    {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        job.setStatus(ScheduleConstants.Status.NORMAL.getValue());
        int rows = jobMapper.updateJob(job);
        if (rows > 0)
        {
            scheduler.resumeJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 删除任务后，所对应的trigger也将被删除
     * 
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteJob(DeviceJob job) throws SchedulerException
    {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        int rows = jobMapper.deleteJobById(jobId);
        if (rows > 0)
        {
            scheduler.deleteJob(ScheduleUtils.getJobKey(jobId, jobGroup));
        }
        return rows;
    }

    /**
     * 批量删除调度信息
     * 
     * @param jobIds 需要删除的任务ID
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteJobByIds(Long[] jobIds) throws SchedulerException
    {
        for (Long jobId : jobIds)
        {
            DeviceJob job = jobMapper.selectJobById(jobId);
            deleteJob(job);
        }
    }

    /**
     * 根据设备Ids批量删除调度信息
     *
     * @param deviceIds 需要删除数据的设备Ids
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteJobByDeviceIds(Long[] deviceIds) throws SchedulerException
    {
        // 查出所有job
        List<DeviceJob> deviceJobs=jobMapper.selectShortJobListByDeviceIds(deviceIds);
        // 批量删除job
        int rows=jobMapper.deleteJobByDeviceIds(deviceIds);
        // 批量删除调度器
        for(DeviceJob job:deviceJobs){
            scheduler.deleteJob(ScheduleUtils.getJobKey(job.getJobId(), job.getJobGroup()));
        }
    }

    /**
     * 根据告警Ids批量删除调度信息
     *
     * @param alertIds 需要删除数据的告警Ids
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteJobByAlertIds(Long[] alertIds) throws SchedulerException
    {
        // 查出所有job
        List<DeviceJob> deviceJobs=jobMapper.selectShortJobListByAlertIds(alertIds);
        // 批量删除job
        int rows=jobMapper.deleteJobByAlertIds(alertIds);
        // 批量删除调度器
        for(DeviceJob job:deviceJobs){
            scheduler.deleteJob(ScheduleUtils.getJobKey(job.getJobId(), job.getJobGroup()));
        }
    }

    /**
     * 根据场景联动Ids批量删除调度信息
     *
     * @param sceneIds 需要删除数据的场景Ids
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteJobBySceneIds(Long[] sceneIds) throws SchedulerException
    {
        // 查出所有job
        List<DeviceJob> deviceJobs=jobMapper.selectShortJobListBySceneIds(sceneIds);
        // 批量删除job
        int rows=jobMapper.deleteJobBySceneIds(sceneIds);
        // 批量删除调度器
        for(DeviceJob job:deviceJobs){
            scheduler.deleteJob(ScheduleUtils.getJobKey(job.getJobId(), job.getJobGroup()));
        }
    }

    /**
     * 任务调度状态修改
     * 
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int changeStatus(DeviceJob job) throws SchedulerException
    {
        int rows = 0;
        String status = job.getStatus();
        if (ScheduleConstants.Status.NORMAL.getValue().equals(status))
        {
            rows = resumeJob(job);
        }
        else if (ScheduleConstants.Status.PAUSE.getValue().equals(status))
        {
            rows = pauseJob(job);
        }
        return rows;
    }

    /**
     * 立即运行任务
     * 
     * @param job 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void run(DeviceJob job) throws SchedulerException
    {
        Long jobId = job.getJobId();
        String jobGroup = job.getJobGroup();
        DeviceJob properties = selectJobById(job.getJobId());
        // 参数
        JobDataMap dataMap = new JobDataMap();
        dataMap.put(ScheduleConstants.TASK_PROPERTIES, properties);
        scheduler.triggerJob(ScheduleUtils.getJobKey(jobId, jobGroup), dataMap);
    }

    /**
     * 新增任务
     * 
     * @param deviceJob 调度信息 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertJob(DeviceJob deviceJob) throws SchedulerException, TaskException
    {
        int rows = jobMapper.insertJob(deviceJob);
        if (rows > 0)
        {
            ScheduleUtils.createScheduleJob(scheduler, deviceJob);
        }
        return rows;
    }

    /**
     * 更新任务的时间表达式
     * 
     * @param deviceJob 调度信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateJob(DeviceJob deviceJob) throws SchedulerException, TaskException
    {
        DeviceJob properties = selectJobById(deviceJob.getJobId());
        int rows = jobMapper.updateJob(deviceJob);
        if (rows > 0)
        {
            updateSchedulerJob(deviceJob, properties.getJobGroup());
        }
        return rows;
    }

    /**
     * 更新任务
     * 
     * @param deviceJob 任务对象
     * @param jobGroup 任务组名
     */
    public void updateSchedulerJob(DeviceJob deviceJob, String jobGroup) throws SchedulerException, TaskException
    {
        Long jobId = deviceJob.getJobId();
        // 判断是否存在
        JobKey jobKey = ScheduleUtils.getJobKey(jobId, jobGroup);
        if (scheduler.checkExists(jobKey))
        {
            // 防止创建时存在数据问题 先移除，然后在执行创建操作
            scheduler.deleteJob(jobKey);
        }
        ScheduleUtils.createScheduleJob(scheduler, deviceJob);
    }

    /**
     * 校验cron表达式是否有效
     * 
     * @param cronExpression 表达式
     * @return 结果
     */
    @Override
    public boolean checkCronExpressionIsValid(String cronExpression)
    {
        return CronUtils.isValid(cronExpression);
    }
}
