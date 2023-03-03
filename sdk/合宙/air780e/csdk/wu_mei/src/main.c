/*
* 物美开发板
 */
#include "common_api.h"
#include "luat_rtos.h"
#include "luat_mobile.h"
#include "luat_mem.h"
#include "luat_debug.h"
#include "wuMeiMqtt.h"
#include "optocoupler.h"
#include "relay.h"
#include "wuMeiLed.h"

static volatile uint8_t g_isLinkUp = 0; // 注意变量多线程竞争 锁

static luat_rtos_semaphore_t net_semaphore_handle;

static void sms_event_cb(uint32_t event, void* param)
{
	LUAT_DEBUG_PRINT("短信event%d,%x", event, param);
}

void mobile_event_cb(LUAT_MOBILE_EVENT_E event, uint8_t index, uint8_t status)
{
	if (event == LUAT_MOBILE_EVENT_NETIF) 
	{
		LUAT_DEBUG_PRINT("internet工作状态变更为 %d", status);
		switch (status)
		{
		case LUAT_MOBILE_NETIF_LINK_ON:
			LUAT_DEBUG_PRINT("可以上网");
			g_isLinkUp = 1;
			//luat_rtos_semaphore_release(net_semaphore_handle);
			break;
		default:
			LUAT_DEBUG_PRINT("不能上网");
			g_isLinkUp = 0; //不能上网
			break;
		}
	}

}

static void printfImeiMuid()
{
	char imei[20] = { 0 };
	luat_mobile_get_imei(0, imei, sizeof(imei));
	LUAT_DEBUG_PRINT("IMEI %s", imei);
	char muid[64] = { 0 };
	luat_mobile_get_muid(muid, sizeof(muid));
	LUAT_DEBUG_PRINT("MUID %s", muid);
}
static void relayTest()
{
	for (int i = 0; i < 9; i++)
	{
		relayControl(i, 0);
	}
	for (int i = 0; i < 9; i++)
	{
		relayControl(i, 1);
		luat_rtos_task_sleep(1000);
	}
	for (int i = 0; i < 9; i++)
	{
		relayControl(i, 0);
		luat_rtos_task_sleep(1000);
	}
}
static void OptocouplerPool()
{
	static char nPinStatus[8] = { 0 };
	for (unsigned char i = 0; i < 8; i++)
	{
		if (nPinStatus[i] != getOptocoupler(i))
		{
			nPinStatus[i] = getOptocoupler(i);
			LUAT_DEBUG_PRINT("getOptocoupler(%d)=%d", i, nPinStatus[i]);
			//triggerPropertyPush();
		}
	}
}
static void wumei_task(void* param)
{
	luat_debug_set_fault_mode(LUAT_DEBUG_FAULT_RESET);
	//luat_rtos_semaphore_create(&net_semaphore_handle, 1);
	optocouplerInit(); // 光耦初始化
	relayInit(); // 继电器初始化
	ledInit();

	luat_mobile_set_sim_id(0);
	printfImeiMuid();
	luat_mobile_event_register_handler(mobile_event_cb);
	luat_mobile_set_period_work(90000, 10000, 8);

	printfImeiMuid();
	//relayTest();
	//luat_rtos_semaphore_take(net_semaphore_handle, LUAT_WAIT_FOREVER);
	extern void DuAesTest();
	for (;;)
	{
		while (g_isLinkUp == 0)
		{
			/*
			没有联网需要计数 
			超过一定值 开飞行
			关飞行 协议栈复位
			等有效机制
			*/
			LUAT_DEBUG_PRINT("当前状态不能上网1");
			ledControl(0, 0);
			luat_rtos_task_sleep(100);
			ledControl(0, 1);
			luat_rtos_task_sleep(100);
			LUAT_DEBUG_PRINT("当前状态不能上网2");
		}
		//LUAT_DEBUG_PRINT("B g_isLinkUp=%d", g_isLinkUp);
		wuMeiMqttConnectPool(g_isLinkUp);
		OptocouplerPool();
		ledControl(0, 1);
		luat_rtos_task_sleep(20); //根据情况调整这个值 避免太耗用CPU
		ledControl(0, 0);
		luat_rtos_task_sleep(20); //根据情况调整这个值 避免太耗用CPU
	}
}

static void wumei_task_init(void)
{
	luat_rtos_task_handle task_handle;
	luat_rtos_task_create(&task_handle, 20 * 1024, 80, "wumei", wumei_task, NULL, 0);
}

#include "luat_i2c.h"

#define I2C_ID                  0
#define AHT10_ADDRESS_ADR_LOW   0x38

#define AHT10_INIT              0xE1 //初始化命令
#define AHT10_MEASURE           0xAC //触发测量命令
#define AHT10_SOFT_RESET        0xBA
#define AHT10_STATE             0x71 //状态字.

static void hw_test_demo(void)
{
	LUAT_DEBUG_PRINT("hw_test_demo entry");
	optocouplerInit(); // 光耦初始化
	relayInit(); // 继电器初始化
	ledInit();
	uartInit();
	/*char soft_reset[] = { AHT10_SOFT_RESET };
	char init_cmd[] = { AHT10_INIT,0x08,0x00 };
	char measure_cmd[] = { AHT10_MEASURE, 0x33, 0x00 };
	char read_cmd[] = { AHT10_STATE };
	char recv_date[7] = { 0 };
	luat_i2c_setup(I2C_ID, 1);
	luat_rtos_task_sleep(40);
	luat_i2c_send(I2C_ID, AHT10_ADDRESS_ADR_LOW, soft_reset, 1, 1);
	luat_rtos_task_sleep(20);

	luat_i2c_recv(I2C_ID, AHT10_ADDRESS_ADR_LOW, recv_date, 1);

	if (recv_date[0] & (1 << 3) == 0)
	{
		luat_i2c_send(I2C_ID, AHT10_ADDRESS_ADR_LOW, init_cmd, 3, 1);
	}*/

	LUAT_DEBUG_PRINT("hw Init End");
	while (1)
	{
		ledControl(0, 0);
		for (int i = 0; i < 9; i++)
		{
			relayControl(i, 1);
		}
		luat_rtos_task_sleep(1000);
		//luat_i2c_send(I2C_ID, AHT10_ADDRESS_ADR_LOW, measure_cmd, 3, 1);
		ledControl(0, 1);
		for (int i = 0; i < 9; i++)
		{
			relayControl(i, 0);
		}
		luat_rtos_task_sleep(1000);
	
		/*luat_i2c_send(I2C_ID, AHT10_ADDRESS_ADR_LOW, read_cmd, 1, 1);
		luat_i2c_recv(I2C_ID, AHT10_ADDRESS_ADR_LOW, recv_date, 6);

		float cur_temp = ((recv_date[3] & 0xf) << 16 | recv_date[4] << 8 | recv_date[5]) * 200.0 / (1 << 20) - 50;
		LUAT_DEBUG_PRINT("temp: %f", cur_temp);*/
		OptocouplerPool();
		uartSend(1,"Uart1",sizeof("Uart1"));
		uartSend(2, "Uart2", sizeof("Uart2"));
	}
}

static void hw_test_task_init(void)
{
	luat_rtos_task_handle flymode_task_handle;
	luat_rtos_task_create(&flymode_task_handle, 2048, 20, "hwtest", hw_test_demo, NULL, NULL);
}

INIT_TASK_EXPORT(wumei_task_init, "1");

// 创建硬件测试线程
//INIT_TASK_EXPORT(hw_test_task_init, "1");