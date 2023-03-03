#include "common_api.h"
#include "time.h"
#include "osasys.h"

void RTC_GetDateTime(Date_UserDataStruct *pDate, Time_UserDataStruct *pTime)
{
	Tamp2UTC(time(NULL), pDate, pTime, 0);
}

static struct tm prvTM;
extern const uint32_t DayTable[2][12];
struct tm *__wrap_localtime (const time_t *_timer)
{
	Time_UserDataStruct Time;
	Date_UserDataStruct Date;
	uint64_t Sec;
	utc_timer_value_t *timeUtc = OsaSystemTimeReadUtc();
	if (_timer)
	{
		Sec = *_timer;
		Tamp2UTC(Sec + timeUtc->timeZone * 900, &Date, &Time, 0);
	}
	else
	{
		Tamp2UTC(timeUtc->UTCsecs + timeUtc->timeZone * 900, &Date, &Time, 0);
	}
	prvTM.tm_year = Date.Year - 1900;
	prvTM.tm_mon = Date.Mon - 1;
	prvTM.tm_mday = Date.Day;
	prvTM.tm_hour = Time.Hour;
	prvTM.tm_min = Time.Min;
	prvTM.tm_sec = Time.Sec;
	prvTM.tm_wday = Time.Week;
	prvTM.tm_yday = Date.Day - 1;
	prvTM.tm_yday += DayTable[IsLeapYear(Date.Year)][Date.Mon - 1];
	return &prvTM;
}

struct tm *__wrap_gmtime (const time_t *_timer)
{
	Time_UserDataStruct Time;
	Date_UserDataStruct Date;
	uint64_t Sec;
	if (_timer)
	{
		Sec = *_timer;
		Tamp2UTC(Sec, &Date, &Time, 0);
	}
	else
	{
		RTC_GetDateTime(&Date, &Time);
	}
	prvTM.tm_year = Date.Year - 1900;
	prvTM.tm_mon = Date.Mon - 1;
	prvTM.tm_mday = Date.Day;
	prvTM.tm_hour = Time.Hour;
	prvTM.tm_min = Time.Min;
	prvTM.tm_sec = Time.Sec;
	prvTM.tm_wday = Time.Week;
	prvTM.tm_yday = Date.Day - 1;
	prvTM.tm_yday += DayTable[IsLeapYear(Date.Year)][Date.Mon - 1];
	return &prvTM;
}

clock_t	   __wrap_clock (void)
{
	return GetSysTickMS()/1000;
}

time_t	   __wrap_time (time_t *_Time)
{
  utc_timer_value_t *timeUtc = OsaSystemTimeReadUtc();
  if (_Time != NULL) {
    *_Time = timeUtc->UTCsecs;
  }
  return timeUtc->UTCsecs;
}
